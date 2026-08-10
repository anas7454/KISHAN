import 'package:constructo_worker/networking/api/endpoints/worker_kyc_api_services.dart';
import 'package:constructo_worker/networking/core/dio_api.dart';
import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:constructo_worker/networking/user/controllers/global_controller.dart';
import 'package:constructo_worker/utils/toast/toast.dart';
import 'package:constructo_worker/utils/url_launchar_methods.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkerVerificationStatusController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();

  final RxString workerName = "Ravi Kumar".obs;
  final RxString workerRole = "Mason".obs;
  final RxString workerExperience = "4 Years Experience".obs;
  final RxBool isUnderReview = true.obs;
  final RxList<Map<String, dynamic>> kycSections =
      <Map<String, dynamic>>[].obs;
  final RxList<String> kycStatuses = <String>[].obs;
  final RxList<String> kycRemarks = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchKycData();
  }

  Future<void> fetchKycData() async {
    await Future.wait<void>([
      fetchKycDocuments(),
      fetchKycStatuses(),
    ]);
  }

  Future<void> fetchKycDocuments() async {
    final List<Map> responses = await Future.wait<Map>([
      WorkerKycApiServices.getPersonalInfo(),
      WorkerKycApiServices.getBankInfo(),
      WorkerKycApiServices.getIdentityDocuments(),
      WorkerKycApiServices.getLiveSelfie(),
      WorkerKycApiServices.getSkillsExperience(),
      WorkerKycApiServices.getAvailability(),
    ]);
    kycSections.assignAll(
      responses.map(
        (response) => apiResponseSuccess(response)
            ? Map<String, dynamic>.from(apiPeramMap(response['data']))
            : <String, dynamic>{},
      ),
    );
  }

  Future<void> fetchKycStatuses() async {
    const List<String> sections = <String>[
      'personal-info',
      'bank-info',
      'identity-documents',
      'live-selfie',
      'skills-experience',
      'availability',
    ];
    final List<Map> responses = await Future.wait<Map>(
      sections.map(WorkerKycApiServices.getSectionStatus),
    );
    kycStatuses.assignAll(responses.map(_statusFromResponse));
    kycRemarks.assignAll(responses.map(_remarkFromResponse));
  }

  String _statusFromResponse(Map response) {
    if (!apiResponseSuccess(response)) return 'NOT_AVAILABLE';
    final dynamic responseData = response['data'];
    final dynamic rawStatus = responseData is Map
        ? responseData['status'] ??
            responseData['kycStatus'] ??
            responseData['sectionStatus']
        : responseData;
    final String status = apiPeramString(rawStatus).toUpperCase();
    return status.isEmpty ? 'PENDING' : status;
  }

  String sectionStatus(int index) {
    return index >= 0 && index < kycStatuses.length
        ? kycStatuses[index]
        : 'PENDING';
  }

  String sectionRemark(int index) {
    return index >= 0 && index < kycRemarks.length
        ? kycRemarks[index]
        : '';
  }

  Map<String, dynamic> sectionData(int index) {
    return index >= 0 && index < kycSections.length
        ? kycSections[index]
        : <String, dynamic>{};
  }

  Future<void> ensureSectionDataLoaded() async {
    if (kycSections.isEmpty) await fetchKycDocuments();
  }

  String _remarkFromResponse(Map response) {
    if (!apiResponseSuccess(response) || response['data'] is! Map) return '';
    return apiPeramString((response['data'] as Map)['remark']);
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
    final bool isImage = <String>['.jpg', '.jpeg', '.png', '.webp']
        .any(cleanUrl.endsWith);
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
}
