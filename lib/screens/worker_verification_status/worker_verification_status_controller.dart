import 'package:constructo_worker/networking/api/endpoints/worker_kyc_api_services.dart';
import 'package:constructo_worker/networking/api/endpoints/worker_profile_api_services.dart';
import 'package:constructo_worker/networking/core/dio_api.dart';
import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:constructo_worker/networking/user/controllers/global_controller.dart';
import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/screens/auth/worker_registration/worker_kyc_status_model.dart';
import 'package:constructo_worker/utils/navigation/double_back_to_exit.dart';
import 'package:constructo_worker/utils/toast/toast.dart';
import 'package:constructo_worker/utils/url_launchar_methods.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkerVerificationStatusController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();
  final DoubleBackToExit _doubleBackToExit = DoubleBackToExit();
  late final bool isDocumentsView;

  final RxString workerName = ''.obs;
  final RxString workerRole = ''.obs;
  final RxString workerExperience = ''.obs;
  final RxString workerProfileImage = ''.obs;
  final RxBool isLoading = true.obs;
  final RxBool isUnderReview = true.obs;
  final RxString overallKycStatus = 'PENDING'.obs;
  final RxList<Map<String, dynamic>> kycSections = <Map<String, dynamic>>[].obs;
  final RxList<String> kycStatuses = <String>[].obs;
  final RxList<String> kycRemarks = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    final dynamic arguments = Get.arguments;
    isDocumentsView = arguments is Map && arguments['documentsView'] == true;
    fetchKycData();
  }

  Future<void> fetchKycData() async {
    isLoading.value = true;
    try {
      await fetchKycStatuses();
      if (overallKycStatus.value == 'NOT_AVAILABLE') {
        await fetchWorkerProfile();
        return;
      }
      await Future.wait<void>([
        fetchWorkerProfile(),
        fetchKycDocuments(),
      ]);
      _updateSectionStatusesFromDocuments();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchWorkerProfile() async {
    final Map response = await WorkerProfileApiServices.getProfile();
    if (!apiResponseSuccess(response)) return;
    final Map rawData = apiPeramMap(response['data']);
    final Map responseData = rawData.isEmpty ? response : rawData;
    final Map nested = apiPeramMap(
      responseData['worker'] ??
          responseData['workerProfile'] ??
          responseData['profile'] ??
          responseData['user'],
    );
    final Map data = nested.isEmpty ? responseData : nested;
    final Map skill = apiPeramMap(data['skill']);
    final List skills = apiPeramList(data['skills']);
    final Map firstSkill = skills.isNotEmpty && skills.first is Map
        ? apiPeramMap(skills.first)
        : <String, dynamic>{};
    final String firstName = apiPeramString(data['firstName']);
    final String lastName = apiPeramString(data['lastName']);
    workerName.value = apiPeramString(
      data['name'] ?? data['fullName'],
      initialValue: '$firstName $lastName'.trim(),
    );
    workerRole.value = apiPeramString(
      data['skillCategory'] ?? skill['name'] ?? firstSkill['name'],
    );
    final String experience = apiPeramString(
      data['experienceYears'] ?? data['experience'],
    );
    workerExperience.value = experience.isEmpty
        ? ''
        : '$experience Years Experience';
    workerProfileImage.value = apiPeramString(
      data['profileImage'] ?? data['selfieImage'],
    );
    final String profileKycStatus = apiPeramString(
      data['kycStatus'],
    ).toUpperCase();
    if (profileKycStatus.isNotEmpty &&
        overallKycStatus.value == 'NOT_AVAILABLE') {
      overallKycStatus.value = profileKycStatus;
      isUnderReview.value = profileKycStatus != 'APPROVED';
    }
  }

  Future<void> fetchKycDocuments() async {
    final List<Future<Map> Function()> requests = <Future<Map> Function()>[
      WorkerKycApiServices.getPersonalInfo,
      WorkerKycApiServices.getBankInfo,
      WorkerKycApiServices.getIdentityDocuments,
      WorkerKycApiServices.getLiveSelfie,
      WorkerKycApiServices.getSkillsExperience,
      WorkerKycApiServices.getAvailability,
    ];
    final List<Map> responses = <Map>[];
    for (final Future<Map> Function() request in requests) {
      responses.add(await request());
    }
    kycSections.assignAll(
      responses.map(
        (response) => apiResponseSuccess(response)
            ? Map<String, dynamic>.from(apiPeramMap(response['data']))
            : <String, dynamic>{},
      ),
    );
  }

  Future<void> fetchKycStatuses() async {
    const List<String> sectionKeys = <String>[
      'PERSONAL_INFO',
      'BANK_INFO',
      'IDENTITY_DOCUMENTS',
      'LIVE_SELFIE',
      'SKILLS_EXPERIENCE',
      'AVAILABILITY',
    ];
    final Map overallResponse = await WorkerKycApiServices.getWorkerKycStatus();
    if (!apiResponseSuccess(overallResponse)) {
      overallKycStatus.value = 'NOT_AVAILABLE';
      kycStatuses.assignAll(List<String>.filled(6, 'NOT_AVAILABLE'));
      kycRemarks.assignAll(List<String>.filled(6, ''));
      return;
    }

    final WorkerKycStatusModel kyc = WorkerKycStatusModel.fromResponse(
      overallResponse,
    );
    final String overallStatus = kyc.status;
    overallKycStatus.value = overallStatus;
    isUnderReview.value = overallStatus != 'APPROVED';

    kycStatuses.assignAll(
      sectionKeys.map((key) {
        final WorkerKycSectionStatus? section = kyc.sections
            .firstWhereOrNull((item) => item.stepKey == key);
        if (section != null) {
          if (section.status.isNotEmpty) return section.status;
          return section.isCompleted ? 'COMPLETED' : 'PENDING';
        }
        if (overallStatus == 'APPROVED') return 'APPROVED';
        if (overallStatus == 'UNDER_REVIEW') return 'UNDER_REVIEW';
        return 'PENDING';
      }),
    );
    kycRemarks.assignAll(
      sectionKeys.map(
        (key) =>
            kyc.sections
                .firstWhereOrNull((item) => item.stepKey == key)
                ?.remark ??
            '',
      ),
    );

    if (overallStatus == 'APPROVED' && !isDocumentsView) {
      await AppRoutes.bottomNavBarScreen();
    }
  }

  void _updateSectionStatusesFromDocuments() {
    if (kycSections.length < 6) return;

    final List<String> extractedRemarks = List<String>.filled(6, '');
    final List<String> extractedStatuses = List<String>.filled(6, '');

    for (int i = 0; i < kycSections.length && i < 6; i++) {
      final Map<String, dynamic> data = kycSections[i];
      if (data.isEmpty) continue;

      final Map verification = apiPeramMap(data['verification']);
      final String remark = apiPeramString(
        verification['remark'] ?? data['rejectionReason'] ?? data['remark'],
      );
      final String status = apiPeramString(
        verification['status'] ?? data['kycStatus'] ?? data['status'],
      ).toUpperCase();

      extractedRemarks[i] = remark;
      extractedStatuses[i] = status;
    }

    for (int i = 0; i < kycSections.length && i < 6; i++) {
      final Map<String, dynamic> data = kycSections[i];
      final String remark = extractedRemarks[i];
      final String statusFromDoc = extractedStatuses[i];

      final Map verification = data.isNotEmpty ? apiPeramMap(data['verification']) : {};
      final String specificVerificationStatus = apiPeramString(verification['status']).toUpperCase();

      if (specificVerificationStatus == 'UNDER_REVIEW' || statusFromDoc == 'UNDER_REVIEW') {
        kycStatuses[i] = 'UNDER_REVIEW';
        kycRemarks[i] = '';
      } else if (specificVerificationStatus == 'APPROVED' || specificVerificationStatus == 'VERIFIED' || statusFromDoc == 'APPROVED' || statusFromDoc == 'VERIFIED') {
        kycStatuses[i] = 'APPROVED';
        kycRemarks[i] = '';
      } else if (remark.isNotEmpty) {
        kycStatuses[i] = 'REJECTED';
        kycRemarks[i] = remark;
      } else if (overallKycStatus.value == 'UNDER_REVIEW') {
        kycStatuses[i] = data.isNotEmpty ? 'UNDER_REVIEW' : 'PENDING';
        kycRemarks[i] = '';
      } else if (overallKycStatus.value == 'APPROVED') {
        kycStatuses[i] = 'APPROVED';
        kycRemarks[i] = '';
      } else {
        kycStatuses[i] = data.isNotEmpty ? 'UNDER_REVIEW' : 'PENDING';
        kycRemarks[i] = '';
      }
    }
    kycStatuses.refresh();
    kycRemarks.refresh();
  }

  Future<void> openKycSection(int sectionIndex, int step) async {
    if (sectionStatus(sectionIndex) == 'REJECTED') {
      await AppRoutes.resumeWorkerRegistrationScreen(
        step: step,
        status: 'REJECTED',
        completedSections: 0,
        totalSections: 8,
        sections: const <Map<String, dynamic>>[],
      );
      return;
    }
    await AppRoutes.workerRegistrationPreviewScreen(step);
  }

  String sectionStatus(int index) {
    return index >= 0 && index < kycStatuses.length
        ? kycStatuses[index]
        : 'PENDING';
  }

  String sectionRemark(int index) {
    return index >= 0 && index < kycRemarks.length ? kycRemarks[index] : '';
  }

  Map<String, dynamic> sectionData(int index) {
    return index >= 0 && index < kycSections.length
        ? kycSections[index]
        : <String, dynamic>{};
  }

  Future<void> ensureSectionDataLoaded() async {
    if (kycSections.isEmpty) await fetchKycDocuments();
  }

  Future<void> previewKycDocument(
    int sectionIndex, {
    int documentIndex = 0,
  }) async {
    if (kycSections.isEmpty) await fetchKycDocuments();
    if (sectionIndex < 0 || sectionIndex >= kycSections.length) return;

    final List<String> urls = <String>[];
    _collectDocumentUrls(kycSections[sectionIndex], urls);
    if (urls.isEmpty) {
      showToastError('No uploaded document available');
      return;
    }

    final int safeIndex = documentIndex < urls.length ? documentIndex : 0;
    final String documentPath = urls[safeIndex];
    final String documentUrl = documentPath.startsWith('http')
        ? documentPath
        : '${DioAPI.baseURL}/${documentPath.replaceFirst(RegExp(r'^/'), '')}';
    final String cleanUrl = documentUrl.split('?').first.toLowerCase();
    final bool isImage = <String>[
      '.jpg',
      '.jpeg',
      '.png',
      '.webp',
    ].any(cleanUrl.endsWith);
    if (isImage) {
      showImageViewer(
        Get.context!,
        NetworkImage(documentUrl),
        useSafeArea: true,
        swipeDismissible: true,
        doubleTapZoomable: true,
      );
      return;
    }
    await UrlLaunchMethods.launchStringINAppOrBrowser(documentUrl);
  }

  void _collectDocumentUrls(dynamic value, List<String> urls) {
    if (value is Map) {
      for (final dynamic nestedValue in value.values) {
        _collectDocumentUrls(nestedValue, urls);
      }
      return;
    }
    if (value is List) {
      for (final dynamic nestedValue in value) {
        _collectDocumentUrls(nestedValue, urls);
      }
      return;
    }

    final String path = apiPeramString(value);
    if (path.startsWith('http://') ||
        path.startsWith('https://') ||
        path.startsWith('/uploads/') ||
        path.startsWith('uploads/')) {
      urls.add(path);
    }
  }

  Future<void> refreshStatus() async {
    await Future.wait<void>([
      globalController.fetchUserLocation(refresh: true),
      fetchKycData(),
    ]);
  }

  Future<void> onBackPressed() async {
    if (Get.key.currentState?.canPop() ?? false) {
      Get.back<void>();
      return;
    }
    await _doubleBackToExit.handle();
  }
}
