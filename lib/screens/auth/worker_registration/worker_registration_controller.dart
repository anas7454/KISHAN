import 'dart:convert';
import 'dart:io';

import 'package:constructo_worker/networking/api/endpoints/location_api_services.dart';
import 'package:constructo_worker/networking/api/endpoints/worker_kyc_api_services.dart';
import 'package:constructo_worker/networking/api/endpoints/skills_api_services.dart';
import 'package:constructo_worker/networking/dialogs/api_error_show_dialogs.dart';
import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:constructo_worker/networking/helper_methods/multipart_image.dart';
import 'package:constructo_worker/networking/user/controllers/user_controller.dart';
import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/routes/route_arguments.dart';
import 'package:constructo_worker/screens/auth/worker_registration/worker_kyc_status_model.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:constructo_worker/utils/toast/custom_tost_for_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class WorkerRegistrationController extends GetxController {
  final RxInt currentStep = 1.obs;
  final RxBool isLoading = false.obs;
  final int totalSteps = 8;
  final ImagePicker _picker = ImagePicker();
  final RxBool isPreviewMode = false.obs;
  final RxString kycStatus = 'NOT_STARTED'.obs;
  late final bool isCorrectionMode;
  final RxInt completedKycSections = 0.obs;
  final RxInt totalKycSections = 8.obs;
  final RxList<WorkerKycSectionStatus> kycProgressSections =
      <WorkerKycSectionStatus>[].obs;
  final RxBool isKycStatusLoading = false.obs;
  final RxString kycStatusError = ''.obs;
  final RxBool hasLoadedKycStatus = false.obs;
  bool _isReviewDataLoading = false;
  bool _hasLoadedReviewData = false;

  @override
  void onInit() {
    super.onInit();
    final int? requestedInitialStep = RouteArguments.get<int>('initialStep');
    isPreviewMode.value = RouteArguments.getOrDefault<bool>(
      'previewMode',
      false,
    );
    currentStep.value = requestedInitialStep ?? 1;
    kycStatus.value = RouteArguments.getOrDefault<String>(
      'kycStatus',
      'NOT_STARTED',
    );
    isCorrectionMode = kycStatus.value.toUpperCase() == 'REJECTED';
    completedKycSections.value = RouteArguments.getOrDefault<int>(
      'completedSections',
      0,
    );
    totalKycSections.value = RouteArguments.getOrDefault<int>(
      'totalSections',
      8,
    );
    final dynamic routeArgs = Get.arguments;
    final dynamic rawSections = routeArgs is Map
        ? routeArgs['kycSections']
        : null;
    if (rawSections is List) {
      kycProgressSections.assignAll(
        rawSections.whereType<Map>().map(WorkerKycSectionStatus.fromMap),
      );
    }
    if (!isPreviewMode.value &&
        requestedInitialStep == null &&
        kycProgressSections.isNotEmpty) {
      final WorkerKycSectionStatus? nextSection = kycProgressSections
          .firstWhereOrNull(
            (section) => !section.isCompleted && section.canOpen,
          );
      if (nextSection != null) {
        currentStep.value = localStepForKycKey(nextSection.stepKey);
      }
    }
    if (isPreviewMode.value) {
      currentStep.value = RouteArguments.getOrDefault<int>('previewStep', 1);
      loadPreviewData();
    } else if (isCorrectionMode) {
      // A rejected section is an isolated correction flow. Load its saved
      // values, allow re-upload, and do not advance through onboarding steps.
      loadPreviewData();
    } else {
      if (currentStep.value != 8) loadSkills();
      if (kycProgressSections.isEmpty) refreshKycProgress(navigate: true);
      if (currentStep.value == 8) loadReviewData();
    }
  }

  Future<bool> refreshKycProgress({bool navigate = false}) async {
    isKycStatusLoading.value = true;
    kycStatusError.value = '';
    final Map response = await WorkerKycApiServices.getWorkerKycStatus();
    isKycStatusLoading.value = false;
    hasLoadedKycStatus.value = true;
    if (!apiResponseSuccess(response)) {
      kycStatusError.value = apiPeramString(
        response['message'] ?? response['msg'],
        initialValue: 'Unable to load KYC progress',
      );
      return false;
    }
    final WorkerKycStatusModel result = WorkerKycStatusModel.fromResponse(
      response,
    );
    debugPrint(
      '[KYC_FLOW] status=${result.status}, '
      'completed=${result.completedSections}/${result.totalSections}, '
      'nextStep=${result.nextStepKey}, '
      'missingDocuments=${result.missingDocuments}, navigate=$navigate',
    );
    debugPrint(
      '[KYC_FLOW] sections=${result.sections.map((section) => '${section.stepKey}:${section.isCompleted}').join(', ')}',
    );
    kycStatus.value = result.status;
    completedKycSections.value = result.completedSections;
    totalKycSections.value = result.totalSections == 0
        ? 8
        : result.totalSections;
    kycProgressSections.assignAll(result.sections);

    if (result.status == 'APPROVED') {
      await AppRoutes.bottomNavBarScreen();
      return true;
    }
    if (result.status == 'UNDER_REVIEW') {
      await AppRoutes.workerVerificationStatusRootScreen();
      return true;
    }
    if (navigate && result.nextStepKey.isNotEmpty) {
      currentStep.value = localStepForKycKey(result.nextStepKey);
      if (currentStep.value == 8) await loadReviewData();
    }
    return true;
  }

  void openKycProgressSection(WorkerKycSectionStatus section) {
    if (!section.canOpen) return;
    currentStep.value = localStepForKycKey(section.stepKey);
  }

  void closeApp() {
    SystemNavigator.pop();
  }

  Future<void> loadPreviewData() async {
    isLoading.value = true;
    final Map response = switch (currentStep.value) {
      1 => await WorkerKycApiServices.getPersonalInfo(),
      2 => await WorkerKycApiServices.getBankInfo(),
      3 => await WorkerKycApiServices.getIdentityDocuments(),
      4 || 5 => await WorkerKycApiServices.getLiveSelfie(),
      6 => await WorkerKycApiServices.getSkillsExperience(),
      7 => await WorkerKycApiServices.getAvailability(),
      _ => <String, dynamic>{},
    };
    isLoading.value = false;
    if (!apiResponseSuccess(response)) {
      await showdialogApiError(respMap: response);
      return;
    }
    _fillFieldsForStep(currentStep.value, apiPeramMap(response['data']));
    if (currentStep.value == 6) await loadSkills();
  }

  Future<void> loadReviewData() async {
    if (_isReviewDataLoading || _hasLoadedReviewData) return;
    _isReviewDataLoading = true;
    isLoading.value = true;
    try {
      final List<Map> responses = await Future.wait(<Future<Map>>[
        WorkerKycApiServices.getPersonalInfo(),
        WorkerKycApiServices.getBankInfo(),
        WorkerKycApiServices.getIdentityDocuments(),
        WorkerKycApiServices.getLiveSelfie(),
        WorkerKycApiServices.getSkillsExperience(),
        WorkerKycApiServices.getAvailability(),
      ]);

      const List<int> steps = <int>[1, 2, 3, 5, 6, 7];
      for (int index = 0; index < responses.length; index++) {
        final Map response = responses[index];
        if (apiResponseSuccess(response)) {
          _fillFieldsForStep(steps[index], apiPeramMap(response['data']));
        }
      }
      await loadSkills();
      _syncSelectedServiceNames();
      _hasLoadedReviewData = true;
    } finally {
      _isReviewDataLoading = false;
      isLoading.value = false;
    }
  }

  void _fillFieldsForStep(int step, Map data) {
    final bool isReuploading =
        !isPreviewMode.value && kycStatus.value.toUpperCase() == 'REJECTED';
    String fieldValue(dynamic value) {
      final String text = apiPeramString(value);
      const Set<String> placeholderValues = <String>{
        'enter',
        'select',
        'enter full name',
        'enter pincode',
        'enter plot no.',
        'enter full address',
      };
      return placeholderValues.contains(text.toLowerCase()) ? '' : text;
    }

    switch (step) {
      case 1:
        fullNameController.text = fieldValue(data['fullName']);
        final DateTime? dob = DateTime.tryParse(
          fieldValue(data['dateOfBirth']),
        );
        dobController.text = dob == null
            ? fieldValue(data['dateOfBirth'])
            : DateFormat('dd/MM/yyyy').format(dob);
        selectedGender.value = fieldValue(data['gender']);
        selectedLanguage.value = fieldValue(data['language']);
        languageController.text = fieldValue(data['language']);
        houseNoController.text = fieldValue(data['addressLine1']);
        fullAddressController.text = fieldValue(data['addressLine2']);
        stateController.text = fieldValue(data['state']);
        cityController.text = fieldValue(data['city']);
        pincodeController.text = fieldValue(data['pincode']);
        addressProofPath.value = isReuploading
            ? ''
            : apiPeramString(data['addressProof']);
      case 2:
        accountHolderNameController.text = apiPeramString(
          data['bankAccountName'],
          initialValue: apiPeramString(data['accountHolderName']),
        );
        accountNumberController.text = apiPeramString(
          data['bankAccountNumber'],
        );
        confirmAccountNumberController.text = accountNumberController.text;
        ifscCodeController.text = apiPeramString(data['bankIfscCode']);
        branchNameController.text = apiPeramString(data['branchName']);
        passbookProofPath.value = isReuploading
            ? ''
            : apiPeramString(data['bankPassbook']);
      case 3:
        idFrontPath.value = isReuploading
            ? ''
            : apiPeramString(data['identityFront']);
        idBackPath.value = isReuploading
            ? ''
            : apiPeramString(data['identityBack']);
        panCardPath.value = isReuploading
            ? ''
            : apiPeramString(data['panCard']);
        policeCertPath.value = isReuploading
            ? ''
            : apiPeramString(data['policeCertificate']);
      case 4:
      case 5:
        liveSelfiePath.value = isReuploading
            ? ''
            : apiPeramString(data['liveSelfie']);
      case 6:
        final Map skill = apiPeramMap(data['skill']);
        selectedSkillId.value = apiPeramString(skill['id'] ?? data['skillId']);
        selectedSkillCategory.value = apiPeramString(
          data['skillCategory'] ?? skill['name'],
          initialValue: apiPeramString(data['skillName']),
        );
        final dynamic rawSavedServices =
            data['selectedSkillServiceIds'] ??
            data['skillServiceIds'] ??
            data['serviceIds'] ??
            data['services'];
        List savedServices = <dynamic>[];
        if (rawSavedServices is String && rawSavedServices.isNotEmpty) {
          try {
            savedServices = apiPeramList(jsonDecode(rawSavedServices));
          } catch (_) {
            savedServices = <dynamic>[];
          }
        } else {
          savedServices = apiPeramList(rawSavedServices);
        }
        selectedServiceIds.assignAll(
          savedServices
              .map(
                (service) => service is Map
                    ? apiPeramString(service['id'] ?? service['serviceId'])
                    : apiPeramString(service),
              )
              .where((id) => id.isNotEmpty),
        );
        experienceYearsController.text = apiPeramString(
          data['experienceYears'],
        );
        previousCompanyController.text = apiPeramString(
          data['previousCompany'],
        );
        dailyWageController.text = apiPeramString(data['dailyWageExpectation']);
        workDescriptionController.text = apiPeramString(data['description']);
        itiCertPath.value = isReuploading
            ? ''
            : apiPeramString(data['itiCertificate']);
        nsdcCertPath.value = isReuploading
            ? ''
            : apiPeramString(data['nsdcCertificate']);
        govtCertPath.value = isReuploading
            ? ''
            : apiPeramString(data['govtCertificate']);
        otherCertPath.value = isReuploading
            ? ''
            : apiPeramString(data['otherCertificate']);
      case 7:
        final String mode = apiPeramString(data['availabilityMode']);
        workTypeController.text = switch (mode) {
          'PART_TIME' => 'Part Time',
          'FLEXIBLE' => 'Both (Flexible)',
          _ => 'Full Time',
        };
        immediateJoiningController.text = apiPeramBool(data['immediateJoining'])
            ? 'Yes (Immediate)'
            : 'No';
        workingRadiusController.text =
            '${apiPeramString(data['workingRadiusKm'])} km';
    }
  }

  void _syncSelectedServiceNames() {
    selectedServicesController.text = skillServices
        .where((service) => selectedServiceIds.contains(service['id']))
        .map((service) => service['name'] ?? '')
        .where((name) => name.isNotEmpty)
        .join(', ');
  }

  // Step 1: Personal Info
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final RxString selectedGender = 'Male'.obs;
  final RxString selectedLanguage = ''.obs;
  final TextEditingController languageController = TextEditingController();
  final TextEditingController houseNoController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final RxList<Map<String, String>> states = <Map<String, String>>[].obs;
  final RxList<Map<String, String>> cities = <Map<String, String>>[].obs;
  final RxString selectedStateId = ''.obs;
  final RxBool isStatesLoading = false.obs;
  final RxBool isCitiesLoading = false.obs;
  final TextEditingController fullAddressController = TextEditingController();
  final RxString addressProofPath = ''.obs;

  // Step 2: Bank Info
  final TextEditingController accountHolderNameController =
      TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController confirmAccountNumberController =
      TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController branchNameController = TextEditingController();
  final RxString passbookProofPath = ''.obs;

  // Step 3: Document's Upload
  final RxString idFrontPath = ''.obs;
  final RxString idBackPath = ''.obs;
  final RxString panCardPath = ''.obs;
  final RxString policeCertPath = ''.obs;

  // Step 4 & 5: Live Selfie Verification
  final RxString liveSelfiePath = ''.obs;

  // Step 6: Skills & Experience / Certificate Info
  final RxString selectedSkillCategory = 'Mason'.obs;
  final RxString selectedSkillId = ''.obs;
  final RxList<Map<String, String>> skillCategories =
      <Map<String, String>>[].obs;
  final RxList<Map<String, String>> skillServices = <Map<String, String>>[].obs;
  final RxSet<String> selectedServiceIds = <String>{}.obs;
  final RxBool isSkillsLoading = false.obs;
  final RxBool isSkillServicesLoading = false.obs;
  int _servicesRequest = 0;
  final TextEditingController experienceYearsController =
      TextEditingController();
  final TextEditingController previousCompanyController =
      TextEditingController();
  final TextEditingController dailyWageController = TextEditingController();
  final TextEditingController workDescriptionController =
      TextEditingController();
  final TextEditingController selectedServicesController =
      TextEditingController();
  final RxString itiCertPath = ''.obs;
  final RxString nsdcCertPath = ''.obs;
  final RxString govtCertPath = ''.obs;
  final RxString otherCertPath = ''.obs;

  Future<void> setSkillCategory(Map<String, String> skill) async {
    final String id = skill['id'] ?? '';
    if (id.isEmpty || selectedSkillId.value == id) return;
    selectedSkillId.value = id;
    selectedSkillCategory.value = skill['name'] ?? '';
    selectedServiceIds.clear();
    selectedServicesController.clear();
    await loadSkillServices(id);
  }

  Future<void> loadSkills() async {
    if (isSkillsLoading.value) return;
    isSkillsLoading.value = true;
    final Map response = await SkillsApiServices.getSkills();
    isSkillsLoading.value = false;
    if (!apiResponseSuccess(response)) return;

    final dynamic rawData = response['data'];
    final List skills = rawData is List
        ? rawData
        : apiPeramList(
            rawData is Map
                ? rawData['skills'] ?? rawData['items'] ?? rawData['data']
                : null,
          );
    skillCategories.assignAll(
      skills
          .whereType<Map>()
          .map((skill) {
            return <String, String>{
              'id': apiPeramString(
                skill['id'] ?? skill['skillId'] ?? skill['_id'],
              ),
              'name': apiPeramString(
                skill['name'] ?? skill['skillName'] ?? skill['title'],
                initialValue: 'Skill',
              ),
              'image': apiPeramString(skill['image'] ?? skill['icon']),
            };
          })
          .where((skill) => skill['id']!.isNotEmpty),
    );
    if (skillCategories.isEmpty) return;

    final Map<String, String>? saved = skillCategories.firstWhereOrNull(
      (skill) => skill['id'] == selectedSkillId.value,
    );
    final Map<String, String> active = saved ?? skillCategories.first;
    selectedSkillId.value = active['id']!;
    selectedSkillCategory.value = active['name']!;
    await loadSkillServices(active['id']!);
  }

  Future<void> loadSkillServices(String skillId) async {
    final int request = ++_servicesRequest;
    isSkillServicesLoading.value = true;
    skillServices.clear();
    final Map response = await SkillsApiServices.getServices(skillId);
    if (request != _servicesRequest) return;
    isSkillServicesLoading.value = false;
    if (!apiResponseSuccess(response)) return;

    final dynamic rawData = response['data'];
    final List services = rawData is List
        ? rawData
        : apiPeramList(
            rawData is Map
                ? rawData['services'] ?? rawData['items'] ?? rawData['data']
                : null,
          );
    skillServices.assignAll(
      services
          .whereType<Map>()
          .map((service) {
            return <String, String>{
              'id': apiPeramString(
                service['id'] ?? service['serviceId'] ?? service['_id'],
              ),
              'name': apiPeramString(
                service['name'] ?? service['serviceName'] ?? service['title'],
                initialValue: 'Service',
              ),
            };
          })
          .where((service) => service['id']!.isNotEmpty),
    );
  }

  void toggleSkillService(String serviceId) {
    if (selectedServiceIds.contains(serviceId)) {
      selectedServiceIds.remove(serviceId);
    } else {
      selectedServiceIds.add(serviceId);
    }
    selectedServicesController.text = skillServices
        .where((service) => selectedServiceIds.contains(service['id']))
        .map((service) => service['name']!)
        .join(', ');
  }

  void openSkillServicesBottomSheet() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (skillServices.isEmpty || isSkillServicesLoading.value) return;
    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(maxHeight: Get.height * 0.72),
        padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 14.rh),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.rr),
            topRight: Radius.circular(24.rr),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36.rw,
                height: 4.rh,
                decoration: BoxDecoration(
                  color: AppColors.colorC4C4C4,
                  borderRadius: BorderRadius.circular(2.rr),
                ),
              ),
            ),
            sizedboxHeight(14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Select Services',
                  style: AppTextStyles.ts18w700color000000(),
                ),
                IconButton(
                  onPressed: () => Get.back<void>(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
            Text(
              'You can select multiple services',
              style: AppTextStyles.ts12w500color808080(),
            ),
            sizedboxHeight(14),
            Flexible(
              child: Obx(
                () => ListView.separated(
                  shrinkWrap: true,
                  itemCount: skillServices.length,
                  separatorBuilder: (_, _) => sizedboxHeight(8),
                  itemBuilder: (_, index) {
                    final service = skillServices[index];
                    final id = service['id']!;
                    final selected = selectedServiceIds.contains(id);
                    return InkWell(
                      onTap: () => toggleSkillService(id),
                      borderRadius: BorderRadius.circular(10.rr),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.rw,
                          vertical: 12.rh,
                        ),
                        decoration: BoxDecoration(
                          color: selected
                              ? AppColors.yellowBg
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(10.rr),
                          border: Border.all(
                            color: selected
                                ? AppColors.primary
                                : AppColors.borderDBDBDB,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                service['name']!,
                                style: AppTextStyles.ts14w600colorBlack(),
                              ),
                            ),
                            Icon(
                              selected
                                  ? Icons.check_circle_rounded
                                  : Icons.radio_button_unchecked_rounded,
                              color: selected
                                  ? AppColors.primary
                                  : AppColors.color7D7D7D,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // Step 7: Availability
  final TextEditingController workTypeController = TextEditingController();
  final TextEditingController immediateJoiningController =
      TextEditingController();
  final TextEditingController workingRadiusController = TextEditingController(
    text: "10 km",
  );

  // Step 8: Review All Details Expandable Sections Tracker
  final RxSet<int> expandedSections = <int>{}.obs;

  void toggleSectionExpanded(int index) {
    if (expandedSections.contains(index)) {
      expandedSections.remove(index);
    } else {
      expandedSections.add(index);
    }
  }

  final RxInt returnToStep = 0.obs;

  void goToStep(int step, {bool isFromReview = false}) {
    if (step >= 1 && step <= totalSteps) {
      if (isFromReview) {
        returnToStep.value = currentStep.value;
      }
      currentStep.value = step;
    }
  }

  // Open Full Time / Part Time Selection BottomSheet (Matching Language BottomSheet design)
  void openWorkTypeBottomSheet() {
    FocusManager.instance.primaryFocus?.unfocus();
    final List<Map<String, String>> options = [
      {
        'title': 'Full Time',
        'subtitle': 'Complete daily 8-10 hours work shift',
        'code': 'FT',
      },
      {
        'title': 'Part Time',
        'subtitle': 'Flexible 4-5 hours daily work schedule',
        'code': 'PT',
      },
      {
        'title': 'Both (Flexible)',
        'subtitle': 'Open for both full time & part time projects',
        'code': 'FL',
      },
    ];

    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(maxHeight: Get.height * 0.80),
        padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 14.rh),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.rr),
            topRight: Radius.circular(24.rr),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Drag Handle Pill
            Center(
              child: Container(
                width: 36.rw,
                height: 4.rh,
                decoration: BoxDecoration(
                  color: AppColors.colorC4C4C4,
                  borderRadius: BorderRadius.circular(2.rr),
                ),
              ),
            ),
            sizedboxHeight(14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Work Type",
                      style: AppTextStyles.ts18w700color000000(),
                    ),
                    sizedboxHeight(2),
                    Text(
                      "Choose your preferred work schedule",
                      style: AppTextStyles.ts12w500color808080(),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Get.back<void>(),
                  child: Container(
                    padding: EdgeInsets.all(6.rw),
                    decoration: BoxDecoration(
                      color: AppColors.colorF5F5F5,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 18.rsp,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
            sizedboxHeight(16),
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: options.map((item) {
                    final String optTitle = item['title']!;
                    final bool isSelected = workTypeController.text == optTitle;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.rh),
                      child: GestureDetector(
                        onTap: () {
                          workTypeController.text = optTitle;
                          Get.back<void>();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.rw,
                            vertical: 12.rh,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.yellowBg
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(10.rr),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.borderE6E6E6,
                              width: isSelected ? 1.5.rsp : 1.rsp,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 34.rw,
                                height: 34.rw,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.primary.withValues(
                                          alpha: 0.12,
                                        ),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  item['code']!,
                                  style: AppTextStyles.ts12w600color000000()
                                      .copyWith(
                                        color: isSelected
                                            ? AppColors.black
                                            : AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11.5.rsp,
                                      ),
                                ),
                              ),
                              sizedboxWidth(12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      optTitle,
                                      style: AppTextStyles.ts14w600colorBlack()
                                          .copyWith(
                                            fontWeight: isSelected
                                                ? FontWeight.w700
                                                : FontWeight.w600,
                                          ),
                                    ),
                                    sizedboxHeight(2),
                                    Text(
                                      item['subtitle']!,
                                      style:
                                          AppTextStyles.ts12w500color808080(),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.primary,
                                  size: 22.rsp,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            sizedboxHeight(10),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // Open Immediate Joining Selection BottomSheet (Matching Language BottomSheet design)
  void openImmediateJoiningBottomSheet() {
    FocusManager.instance.primaryFocus?.unfocus();
    final List<Map<String, String>> options = [
      {
        'title': 'Yes (Immediate)',
        'subtitle': 'Ready to start work right away',
        'code': 'IM',
      },
      {
        'title': 'Within 1 Week',
        'subtitle': 'Available to join within 7 days',
        'code': '1W',
      },
      {
        'title': 'Within 2 Weeks',
        'subtitle': 'Available to join within 14 days',
        'code': '2W',
      },
      {
        'title': 'Negotiable',
        'subtitle': 'Joining date based on project requirements',
        'code': 'NG',
      },
    ];

    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(maxHeight: Get.height * 0.80),
        padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 14.rh),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.rr),
            topRight: Radius.circular(24.rr),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Drag Handle Pill
            Center(
              child: Container(
                width: 36.rw,
                height: 4.rh,
                decoration: BoxDecoration(
                  color: AppColors.colorC4C4C4,
                  borderRadius: BorderRadius.circular(2.rr),
                ),
              ),
            ),
            sizedboxHeight(14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Immediate Joining",
                      style: AppTextStyles.ts18w700color000000(),
                    ),
                    sizedboxHeight(2),
                    Text(
                      "Select your joining timeline",
                      style: AppTextStyles.ts12w500color808080(),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Get.back<void>(),
                  child: Container(
                    padding: EdgeInsets.all(6.rw),
                    decoration: BoxDecoration(
                      color: AppColors.colorF5F5F5,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 18.rsp,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
            sizedboxHeight(16),
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: options.map((item) {
                    final String optTitle = item['title']!;
                    final bool isSelected =
                        immediateJoiningController.text == optTitle;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.rh),
                      child: GestureDetector(
                        onTap: () {
                          immediateJoiningController.text = optTitle;
                          Get.back<void>();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.rw,
                            vertical: 12.rh,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.yellowBg
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(10.rr),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.borderE6E6E6,
                              width: isSelected ? 1.5.rsp : 1.rsp,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 34.rw,
                                height: 34.rw,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.primary.withValues(
                                          alpha: 0.12,
                                        ),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  item['code']!,
                                  style: AppTextStyles.ts12w600color000000()
                                      .copyWith(
                                        color: isSelected
                                            ? AppColors.black
                                            : AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11.5.rsp,
                                      ),
                                ),
                              ),
                              sizedboxWidth(12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      optTitle,
                                      style: AppTextStyles.ts14w600colorBlack()
                                          .copyWith(
                                            fontWeight: isSelected
                                                ? FontWeight.w700
                                                : FontWeight.w600,
                                          ),
                                    ),
                                    sizedboxHeight(2),
                                    Text(
                                      item['subtitle']!,
                                      style:
                                          AppTextStyles.ts12w500color808080(),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.primary,
                                  size: 22.rsp,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            sizedboxHeight(10),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // Open Preferred Working Radius Selection BottomSheet (Matching Language BottomSheet design)
  void openWorkingRadiusBottomSheet() {
    FocusManager.instance.primaryFocus?.unfocus();
    final List<Map<String, String>> options = [
      {
        'title': '5 km',
        'subtitle': 'Within 5 km distance from current location',
        'code': '05',
      },
      {
        'title': '10 km',
        'subtitle': 'Within 10 km distance from current location',
        'code': '10',
      },
      {
        'title': '15 km',
        'subtitle': 'Within 15 km distance from current location',
        'code': '15',
      },
      {
        'title': '20 km',
        'subtitle': 'Within 20 km distance from current location',
        'code': '20',
      },
      {
        'title': '25+ km',
        'subtitle': 'Any location across entire city area',
        'code': '25+',
      },
    ];

    Get.bottomSheet(
      Container(
        constraints: BoxConstraints(maxHeight: Get.height * 0.80),
        padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 14.rh),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.rr),
            topRight: Radius.circular(24.rr),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Drag Handle Pill
            Center(
              child: Container(
                width: 36.rw,
                height: 4.rh,
                decoration: BoxDecoration(
                  color: AppColors.colorC4C4C4,
                  borderRadius: BorderRadius.circular(2.rr),
                ),
              ),
            ),
            sizedboxHeight(14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Preferred Working Radius",
                      style: AppTextStyles.ts18w700color000000(),
                    ),
                    sizedboxHeight(2),
                    Text(
                      "Select maximum distance for work requests",
                      style: AppTextStyles.ts12w500color808080(),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Get.back<void>(),
                  child: Container(
                    padding: EdgeInsets.all(6.rw),
                    decoration: BoxDecoration(
                      color: AppColors.colorF5F5F5,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 18.rsp,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
            sizedboxHeight(16),
            Flexible(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: options.map((item) {
                    final String optTitle = item['title']!;
                    final bool isSelected =
                        workingRadiusController.text == optTitle;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.rh),
                      child: GestureDetector(
                        onTap: () {
                          workingRadiusController.text = optTitle;
                          Get.back<void>();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 14.rw,
                            vertical: 12.rh,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.yellowBg
                                : AppColors.white,
                            borderRadius: BorderRadius.circular(10.rr),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.borderE6E6E6,
                              width: isSelected ? 1.5.rsp : 1.rsp,
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 34.rw,
                                height: 34.rw,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.primary.withValues(
                                          alpha: 0.12,
                                        ),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  item['code']!,
                                  style: AppTextStyles.ts12w600color000000()
                                      .copyWith(
                                        color: isSelected
                                            ? AppColors.black
                                            : AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 11.5.rsp,
                                      ),
                                ),
                              ),
                              sizedboxWidth(12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      optTitle,
                                      style: AppTextStyles.ts14w600colorBlack()
                                          .copyWith(
                                            fontWeight: isSelected
                                                ? FontWeight.w700
                                                : FontWeight.w600,
                                          ),
                                    ),
                                    sizedboxHeight(2),
                                    Text(
                                      item['subtitle']!,
                                      style:
                                          AppTextStyles.ts12w500color808080(),
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle_rounded,
                                  color: AppColors.primary,
                                  size: 22.rsp,
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            sizedboxHeight(10),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Future<void> captureLiveSelfie() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final XFile? photo = await _picker.pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.front,
      imageQuality: 85,
    );
    if (photo != null) {
      liveSelfiePath.value = photo.path;
      if (currentStep.value == 4) {
        currentStep.value = 5;
      }
    }
  }

  void removeLiveSelfie() {
    liveSelfiePath.value = '';
    if (currentStep.value == 5) {
      currentStep.value = 4;
    }
  }

  final List<String> availableLanguages = [
    'English',
    'Hindi (हिंदी)',
    'Bengali (বাংলা)',
    'Telugu (తెలుగు)',
    'Marathi (मराठी)',
    'Tamil (தமிழ்)',
    'Urdu (اردو)',
    'Gujarati (ગુજરાતી)',
    'Kannada (కన్నడ)',
    'Odia (ଓଡ଼ିଆ)',
    'Malayalam (മലയാളം)',
    'Punjabi (ਪੰਜਾਬੀ)',
  ];

  void setGender(String gender) {
    selectedGender.value = gender;
  }

  void setLanguage(String language) {
    selectedLanguage.value = language;
    languageController.text = language;
  }

  // Pick Date of Birth Calendar
  Future<void> pickDateOfBirth(BuildContext context) async {
    FocusManager.instance.primaryFocus?.unfocus();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: AppColors.black,
              surface: AppColors.white,
              onSurface: AppColors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      dobController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }
  }

  List _locationItems(Map response, String key) {
    final dynamic rawData = response['data'];
    if (rawData is List) return rawData;
    if (rawData is Map) {
      return apiPeramList(rawData[key] ?? rawData['items'] ?? rawData['data']);
    }
    return const [];
  }

  Future<bool> loadStates() async {
    if (isStatesLoading.value) return false;
    isStatesLoading.value = true;
    final Map response = await LocationApiServices.getStates();
    isStatesLoading.value = false;
    if (!apiResponseSuccess(response)) {
      showSnakBarBottomCustomRed(
        apiPeramString(
          response['message'] ?? response['msg'],
          initialValue: 'Unable to load states',
        ),
      );
      return false;
    }
    states.assignAll(
      _locationItems(response, 'states')
          .whereType<Map>()
          .map(
            (item) => <String, String>{
              'id': apiPeramString(
                item['id'] ?? item['stateId'] ?? item['_id'],
              ),
              'name': apiPeramString(
                item['name'] ?? item['stateName'] ?? item['title'],
              ),
            },
          )
          .where((item) => item['id']!.isNotEmpty && item['name']!.isNotEmpty),
    );
    return true;
  }

  Future<bool> loadCities(String stateId) async {
    if (stateId.isEmpty || isCitiesLoading.value) return false;
    isCitiesLoading.value = true;
    final Map response = await LocationApiServices.getCities(stateId);
    isCitiesLoading.value = false;
    if (!apiResponseSuccess(response)) {
      showSnakBarBottomCustomRed(
        apiPeramString(
          response['message'] ?? response['msg'],
          initialValue: 'Unable to load cities',
        ),
      );
      return false;
    }
    cities.assignAll(
      _locationItems(response, 'cities')
          .whereType<Map>()
          .map(
            (item) => <String, String>{
              'id': apiPeramString(item['id'] ?? item['cityId'] ?? item['_id']),
              'name': apiPeramString(
                item['name'] ?? item['cityName'] ?? item['title'],
              ),
            },
          )
          .where((item) => item['name']!.isNotEmpty),
    );
    return true;
  }

  // Open State Selection BottomSheet
  Future<void> openStateBottomSheet() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (states.isEmpty && !await loadStates()) return;
    final RxString searchRx = ''.obs;

    Get.bottomSheet(
      Container(
        height: 500.rh,
        padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 12.rh),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.rr),
            topRight: Radius.circular(24.rr),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36.rw,
                height: 4.rh,
                decoration: BoxDecoration(
                  color: AppColors.colorC4C4C4,
                  borderRadius: BorderRadius.circular(2.rr),
                ),
              ),
            ),
            sizedboxHeight(14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select State",
                      style: AppTextStyles.ts18w700color000000(),
                    ),
                    sizedboxHeight(2),
                    Text(
                      "Choose your current state",
                      style: AppTextStyles.ts12w500color808080(),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Get.back<void>(),
                  child: Container(
                    padding: EdgeInsets.all(6.rw),
                    decoration: BoxDecoration(
                      color: AppColors.colorF5F5F5,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 18.rsp,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
            sizedboxHeight(14),
            Container(
              height: 42.rh,
              padding: EdgeInsets.symmetric(horizontal: 12.rw),
              decoration: BoxDecoration(
                color: AppColors.colorF5F5F5,
                borderRadius: BorderRadius.circular(10.rr),
                border: Border.all(color: AppColors.borderE6E6E6, width: 1.rsp),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    color: AppColors.color7D7D7D,
                    size: 20.rsp,
                  ),
                  sizedboxWidth(8),
                  Expanded(
                    child: TextField(
                      onChanged: (val) => searchRx.value = val,
                      style: AppTextStyles.ts14w400color000000(),
                      decoration: InputDecoration(
                        hintText: "Search state...",
                        hintStyle: AppTextStyles.ts14w500color7D7D7D(),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            sizedboxHeight(14),
            Expanded(
              child: Obx(() {
                final query = searchRx.value.toLowerCase().trim();
                final filtered = states
                    .where(
                      (state) =>
                          (state['name'] ?? '').toLowerCase().contains(query),
                    )
                    .toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      "No states found",
                      style: AppTextStyles.ts14w500color7D7D7D(),
                    ),
                  );
                }

                return ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  itemCount: filtered.length,
                  separatorBuilder: (context, index) => sizedboxHeight(8),
                  itemBuilder: (context, index) {
                    final state = filtered[index];
                    final stateName = state['name'] ?? '';
                    final bool isSelected = stateController.text == stateName;
                    final String stateCode = stateName.length >= 2
                        ? stateName.substring(0, 2).toUpperCase()
                        : 'ST';

                    return GestureDetector(
                      onTap: () {
                        selectedStateId.value = state['id'] ?? '';
                        stateController.text = stateName;
                        cityController.clear();
                        cities.clear();
                        Get.back<void>();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.rw,
                          vertical: 10.rh,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.yellowBg
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(10.rr),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.borderE6E6E6,
                            width: isSelected ? 1.5.rsp : 1.rsp,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32.rw,
                              height: 32.rw,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.primary.withValues(alpha: 0.12),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                stateCode,
                                style: AppTextStyles.ts12w600color000000()
                                    .copyWith(
                                      color: isSelected
                                          ? AppColors.black
                                          : AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11.rsp,
                                    ),
                              ),
                            ),
                            sizedboxWidth(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    stateName,
                                    style: AppTextStyles.ts14w600colorBlack()
                                        .copyWith(
                                          fontWeight: isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w600,
                                        ),
                                  ),
                                  Text(
                                    "State",
                                    style: AppTextStyles.ts12w500color808080(),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.primary,
                                size: 22.rsp,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // Open City Selection BottomSheet
  Future<void> openCityBottomSheet() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (stateController.text.trim().isEmpty) {
      showSnakBarBottomCustomRed('Please select a state first');
      return;
    }
    if (selectedStateId.value.isEmpty) {
      if (states.isEmpty && !await loadStates()) return;
      final Map<String, String>? selected = states.firstWhereOrNull(
        (state) =>
            (state['name'] ?? '').toLowerCase() ==
            stateController.text.trim().toLowerCase(),
      );
      selectedStateId.value = selected?['id'] ?? '';
    }
    if (selectedStateId.value.isEmpty) {
      showSnakBarBottomCustomRed('Please select the state again');
      return;
    }
    if (cities.isEmpty && !await loadCities(selectedStateId.value)) return;
    final RxString searchRx = ''.obs;

    Get.bottomSheet(
      Container(
        height: 500.rh,
        padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 12.rh),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.rr),
            topRight: Radius.circular(24.rr),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 36.rw,
                height: 4.rh,
                decoration: BoxDecoration(
                  color: AppColors.colorC4C4C4,
                  borderRadius: BorderRadius.circular(2.rr),
                ),
              ),
            ),
            sizedboxHeight(14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select City",
                      style: AppTextStyles.ts18w700color000000(),
                    ),
                    sizedboxHeight(2),
                    Text(
                      "Choose your current city",
                      style: AppTextStyles.ts12w500color808080(),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Get.back<void>(),
                  child: Container(
                    padding: EdgeInsets.all(6.rw),
                    decoration: BoxDecoration(
                      color: AppColors.colorF5F5F5,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 18.rsp,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
            sizedboxHeight(14),
            Container(
              height: 42.rh,
              padding: EdgeInsets.symmetric(horizontal: 12.rw),
              decoration: BoxDecoration(
                color: AppColors.colorF5F5F5,
                borderRadius: BorderRadius.circular(10.rr),
                border: Border.all(color: AppColors.borderE6E6E6, width: 1.rsp),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    color: AppColors.color7D7D7D,
                    size: 20.rsp,
                  ),
                  sizedboxWidth(8),
                  Expanded(
                    child: TextField(
                      onChanged: (val) => searchRx.value = val,
                      style: AppTextStyles.ts14w400color000000(),
                      decoration: InputDecoration(
                        hintText: "Search city...",
                        hintStyle: AppTextStyles.ts14w500color7D7D7D(),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            sizedboxHeight(14),
            Expanded(
              child: Obx(() {
                final query = searchRx.value.toLowerCase().trim();
                final filtered = cities
                    .where(
                      (city) =>
                          (city['name'] ?? '').toLowerCase().contains(query),
                    )
                    .toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text(
                      "No cities found",
                      style: AppTextStyles.ts14w500color7D7D7D(),
                    ),
                  );
                }

                return ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  itemCount: filtered.length,
                  separatorBuilder: (context, index) => sizedboxHeight(8),
                  itemBuilder: (context, index) {
                    final cityName = filtered[index]['name'] ?? '';
                    final bool isSelected = cityController.text == cityName;
                    final String cityCode = cityName.length >= 2
                        ? cityName.substring(0, 2).toUpperCase()
                        : 'CT';

                    return GestureDetector(
                      onTap: () {
                        cityController.text = cityName;
                        Get.back<void>();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.rw,
                          vertical: 10.rh,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.yellowBg
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(10.rr),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.borderE6E6E6,
                            width: isSelected ? 1.5.rsp : 1.rsp,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32.rw,
                              height: 32.rw,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.primary.withValues(alpha: 0.12),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                cityCode,
                                style: AppTextStyles.ts12w600color000000()
                                    .copyWith(
                                      color: isSelected
                                          ? AppColors.black
                                          : AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11.rsp,
                                    ),
                              ),
                            ),
                            sizedboxWidth(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cityName,
                                    style: AppTextStyles.ts14w600colorBlack()
                                        .copyWith(
                                          fontWeight: isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w600,
                                        ),
                                  ),
                                  Text(
                                    stateController.text.isNotEmpty
                                        ? stateController.text
                                        : "City",
                                    style: AppTextStyles.ts12w500color808080(),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.primary,
                                size: 22.rsp,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // Open Language Selection BottomSheet (Enhanced Modern Design)
  void openLanguageBottomSheet() {
    FocusManager.instance.primaryFocus?.unfocus();
    final RxString searchRx = ''.obs;

    final List<Map<String, String>> languagesData = [
      {'name': 'English', 'native': 'English', 'code': 'EN'},
      {'name': 'Hindi', 'native': 'हिंदी', 'code': 'HI'},
      {'name': 'Bengali', 'native': 'বাংলা', 'code': 'BN'},
      {'name': 'Telugu', 'native': 'తెలుగు', 'code': 'TE'},
      {'name': 'Marathi', 'native': 'मराठी', 'code': 'MR'},
      {'name': 'Tamil', 'native': 'தமிழ்', 'code': 'TA'},
      {'name': 'Urdu', 'native': 'اردو', 'code': 'UR'},
      {'name': 'Gujarati', 'native': 'ગુજરાતી', 'code': 'GU'},
      {'name': 'Kannada', 'native': 'కన్నడ', 'code': 'KN'},
      {'name': 'Odia', 'native': 'ଓଡ଼ିଆ', 'code': 'OR'},
      {'name': 'Malayalam', 'native': 'മലയാളം', 'code': 'ML'},
      {'name': 'Punjabi', 'native': 'ਪੰਜਾਬੀ', 'code': 'PA'},
    ];

    Get.bottomSheet(
      Container(
        height: 520.rh,
        padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 12.rh),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.rr),
            topRight: Radius.circular(24.rr),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Drag Handle Pill
            Center(
              child: Container(
                width: 36.rw,
                height: 4.rh,
                decoration: BoxDecoration(
                  color: AppColors.colorC4C4C4,
                  borderRadius: BorderRadius.circular(2.rr),
                ),
              ),
            ),
            sizedboxHeight(14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Select Language",
                      style: AppTextStyles.ts18w700color000000(),
                    ),
                    sizedboxHeight(2),
                    Text(
                      "Choose your preferred language",
                      style: AppTextStyles.ts12w500color808080(),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Get.back<void>(),
                  child: Container(
                    padding: EdgeInsets.all(6.rw),
                    decoration: BoxDecoration(
                      color: AppColors.colorF5F5F5,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 18.rsp,
                      color: AppColors.black,
                    ),
                  ),
                ),
              ],
            ),
            sizedboxHeight(14),
            // Search Input Field
            Container(
              height: 42.rh,
              padding: EdgeInsets.symmetric(horizontal: 12.rw),
              decoration: BoxDecoration(
                color: AppColors.colorF5F5F5,
                borderRadius: BorderRadius.circular(10.rr),
                border: Border.all(color: AppColors.borderE6E6E6, width: 1.rsp),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.search_rounded,
                    color: AppColors.color7D7D7D,
                    size: 20.rsp,
                  ),
                  sizedboxWidth(8),
                  Expanded(
                    child: TextField(
                      onChanged: (val) => searchRx.value = val,
                      style: AppTextStyles.ts14w400color000000(),
                      decoration: InputDecoration(
                        hintText: "Search language...",
                        hintStyle: AppTextStyles.ts14w500color7D7D7D(),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            sizedboxHeight(14),
            Expanded(
              child: Obx(() {
                final query = searchRx.value.toLowerCase().trim();
                final filteredList = languagesData.where((item) {
                  final name = item['name']!.toLowerCase();
                  final native = item['native']!.toLowerCase();
                  return name.contains(query) || native.contains(query);
                }).toList();

                if (filteredList.isEmpty) {
                  return Center(
                    child: Text(
                      "No languages found",
                      style: AppTextStyles.ts14w500color7D7D7D(),
                    ),
                  );
                }

                return ListView.separated(
                  physics: const ClampingScrollPhysics(),
                  itemCount: filteredList.length,
                  separatorBuilder: (context, index) => sizedboxHeight(8),
                  itemBuilder: (context, index) {
                    final item = filteredList[index];
                    final String displayString =
                        "${item['name']} (${item['native']})";
                    final bool isSelected = selectedLanguage.value.startsWith(
                      item['name']!,
                    );

                    return GestureDetector(
                      onTap: () {
                        setLanguage(displayString);
                        Get.back<void>();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 14.rw,
                          vertical: 10.rh,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.yellowBg
                              : AppColors.white,
                          borderRadius: BorderRadius.circular(10.rr),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.borderE6E6E6,
                            width: isSelected ? 1.5.rsp : 1.rsp,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 32.rw,
                              height: 32.rw,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.primary.withValues(alpha: 0.12),
                                shape: BoxShape.circle,
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                item['code']!,
                                style: AppTextStyles.ts12w600color000000()
                                    .copyWith(
                                      color: isSelected
                                          ? AppColors.black
                                          : AppColors.primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 11.rsp,
                                    ),
                              ),
                            ),
                            sizedboxWidth(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['name']!,
                                    style: AppTextStyles.ts14w600colorBlack()
                                        .copyWith(
                                          fontWeight: isSelected
                                              ? FontWeight.w700
                                              : FontWeight.w600,
                                        ),
                                  ),
                                  Text(
                                    item['native']!,
                                    style: AppTextStyles.ts12w500color808080(),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              Icon(
                                Icons.check_circle_rounded,
                                color: AppColors.primary,
                                size: 22.rsp,
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  // Pick Image via Camera or Gallery (Matching uploaded bottom sheet design)
  void pickImageOrDocument(RxString targetRxPath) {
    FocusManager.instance.primaryFocus?.unfocus();
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 20.rw, vertical: 12.rh),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.rr),
            topRight: Radius.circular(24.rr),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Drag Handle Pill
              Center(
                child: Container(
                  width: 36.rw,
                  height: 4.rh,
                  decoration: BoxDecoration(
                    color: AppColors.colorC4C4C4,
                    borderRadius: BorderRadius.circular(2.rr),
                  ),
                ),
              ),
              sizedboxHeight(14),
              Text(
                "Upload Photo",
                textAlign: TextAlign.center,
                style: AppTextStyles.ts16w600color000000().copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              sizedboxHeight(20),
              Row(
                children: [
                  // Camera Option Card
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Get.back<void>();
                        final XFile? photo = await _picker.pickImage(
                          source: ImageSource.camera,
                          imageQuality: 85,
                        );
                        if (photo != null) {
                          targetRxPath.value = photo.path;
                        }
                      },
                      child: Container(
                        height: 100.rh,
                        decoration: BoxDecoration(
                          color: AppColors.colorF5F5F5,
                          borderRadius: BorderRadius.circular(16.rr),
                          border: Border.all(
                            color: AppColors.borderE6E6E6,
                            width: 1.rsp,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt_rounded,
                              size: 32.rsp,
                              color: AppColors.primary,
                            ),
                            sizedboxHeight(8),
                            Text(
                              "Camera",
                              style: AppTextStyles.ts14w600colorBlack()
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  sizedboxWidth(16),
                  // Gallery Option Card
                  Expanded(
                    child: GestureDetector(
                      onTap: () async {
                        Get.back<void>();
                        final XFile? image = await _picker.pickImage(
                          source: ImageSource.gallery,
                          imageQuality: 85,
                        );
                        if (image != null) {
                          targetRxPath.value = image.path;
                        }
                      },
                      child: Container(
                        height: 100.rh,
                        decoration: BoxDecoration(
                          color: AppColors.colorF5F5F5,
                          borderRadius: BorderRadius.circular(16.rr),
                          border: Border.all(
                            color: AppColors.borderE6E6E6,
                            width: 1.rsp,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo_library_rounded,
                              size: 32.rsp,
                              color: AppColors.primary,
                            ),
                            sizedboxHeight(8),
                            Text(
                              "Gallery",
                              style: AppTextStyles.ts14w600colorBlack()
                                  .copyWith(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              sizedboxHeight(10),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  // Full-Screen Image Viewer Dialog (Fills the entire screen with zoom & pan)
  void showDocumentPreviewDialog({
    required String title,
    required String fileName,
    VoidCallback? onReupload,
    VoidCallback? onRemove,
  }) {
    FocusManager.instance.primaryFocus?.unfocus();
    final bool canEdit =
        !isPreviewMode.value &&
        kycStatus.value.toUpperCase() != 'UNDER_REVIEW' &&
        kycStatus.value.toUpperCase() != 'APPROVED';
    final VoidCallback? effectiveReupload = canEdit ? onReupload : null;
    final VoidCallback? effectiveRemove = canEdit ? onRemove : null;

    final bool isFileExist = fileName.isNotEmpty && File(fileName).existsSync();
    final bool isNetworkImage =
        fileName.startsWith('http://') || fileName.startsWith('https://');

    Get.dialog<void>(
      Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Stack(
            children: [
              // Full Screen Interactive Image View with Zoom & Pan
              Center(
                child: isFileExist || isNetworkImage
                    ? InteractiveViewer(
                        panEnabled: true,
                        minScale: 0.5,
                        maxScale: 4.0,
                        child: isNetworkImage
                            ? Image.network(
                                fileName,
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                              )
                            : Image.file(
                                File(fileName),
                                fit: BoxFit.contain,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image_not_supported_rounded,
                            size: 64.rsp,
                            color: Colors.white70,
                          ),
                          sizedboxHeight(12),
                          Text(
                            "No Image Available",
                            style: AppTextStyles.ts16w600color000000().copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
              ),
              // Top Floating Bar with Title & Close Icon
              Positioned(
                top: 10.rh,
                left: 16.rw,
                right: 16.rw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.ts16w600color000000().copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.rsp,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.back<void>(),
                      child: Container(
                        padding: EdgeInsets.all(8.rw),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.white,
                          size: 22.rsp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (effectiveReupload != null || effectiveRemove != null)
                Positioned(
                  left: 16.rw,
                  right: 16.rw,
                  bottom: 20.rh,
                  child: Row(
                    children: [
                      if (effectiveRemove != null)
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Get.back<void>();
                              effectiveRemove();
                            },
                            icon: const Icon(Icons.delete_outline_rounded),
                            label: const Text('Remove'),
                          ),
                        ),
                      if (effectiveRemove != null && effectiveReupload != null)
                        sizedboxWidth(10),
                      if (effectiveReupload != null)
                        Expanded(
                          child: FilledButton.icon(
                            onPressed: () {
                              Get.back<void>();
                              effectiveReupload();
                            },
                            icon: const Icon(Icons.upload_rounded),
                            label: const Text('Change'),
                          ),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
      useSafeArea: false,
    );
  }

  bool validateStep1PersonalInfo() {
    final String fullName = fullNameController.text.trim();
    if (fullName.isEmpty) {
      showCustomWidthSnackBar(
        "Please enter full name",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (fullName.length < 4) {
      showCustomWidthSnackBar(
        "Full Name must contain at least 4 characters",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (dobController.text.trim().isEmpty) {
      showCustomWidthSnackBar(
        "Please select Date of Birth",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (languageController.text.trim().isEmpty) {
      showCustomWidthSnackBar(
        "Please select Language",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (stateController.text.trim().isEmpty) {
      showCustomWidthSnackBar(
        "Please select State",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (cityController.text.trim().isEmpty) {
      showCustomWidthSnackBar(
        "Please select City",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (fullAddressController.text.trim().isEmpty) {
      showCustomWidthSnackBar(
        "Please enter Full Address",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }

    bool isUploaded(String path) =>
        path.isNotEmpty &&
        path != 'proof.pdf' &&
        path != 'front.pdf' &&
        path != 'certificate.pdf';

    if (!isUploaded(addressProofPath.value)) {
      showCustomWidthSnackBar(
        "Please upload Address Proof",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }

    return true;
  }

  bool validateStep2BankInfo() {
    final String holderName = accountHolderNameController.text.trim();
    final String accountNumber = accountNumberController.text.trim();
    final String confirmAccountNumber = confirmAccountNumberController.text
        .trim();
    final String ifscCode = ifscCodeController.text.trim().toUpperCase();
    ifscCodeController.text = ifscCode;
    final String branchName = branchNameController.text.trim();

    if (holderName.isEmpty) {
      showCustomWidthSnackBar(
        "Please enter Account Holder Name",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (holderName.length < 4) {
      showCustomWidthSnackBar(
        "Account Holder Name must contain at least 4 characters",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (accountNumber.isEmpty) {
      showCustomWidthSnackBar(
        "Please enter Account Number",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (accountNumber.length < 9 || accountNumber.length > 18) {
      showCustomWidthSnackBar(
        "Indian bank account numbers must be between 9 to 18 digits",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (confirmAccountNumber.isEmpty) {
      showCustomWidthSnackBar(
        "Please confirm Account Number",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (accountNumber != confirmAccountNumber) {
      showCustomWidthSnackBar(
        "Account Numbers do not match",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (ifscCode.isEmpty) {
      showCustomWidthSnackBar(
        "Please enter IFSC Code",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (ifscCode.length != 11) {
      showCustomWidthSnackBar(
        "IFSC Code must be exactly 11 characters (e.g. SBIN0001234)",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    final RegExp ifscRegex = RegExp(r'^[A-Z]{4}0[A-Z0-9]{6}$');
    if (!ifscRegex.hasMatch(ifscCode)) {
      showCustomWidthSnackBar(
        "Invalid Indian IFSC Code (5th character must be 0)",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (branchName.isEmpty) {
      showCustomWidthSnackBar(
        "Please enter Branch Name",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }

    bool isUploaded(String path) =>
        path.isNotEmpty &&
        path != 'proof.pdf' &&
        path != 'front.pdf' &&
        path != 'certificate.pdf';

    if (!isUploaded(passbookProofPath.value)) {
      showCustomWidthSnackBar(
        "Please upload Bank Passbook / Cheque Proof",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }

    return true;
  }

  bool validateStep3DocumentsUpload() {
    bool isUploaded(String path) =>
        path.isNotEmpty &&
        path != 'proof.pdf' &&
        path != 'front.pdf' &&
        path != 'certificate.pdf';

    if (!isUploaded(idFrontPath.value)) {
      showCustomWidthSnackBar(
        "Please upload Identity Verification (Front)",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (!isUploaded(idBackPath.value)) {
      showCustomWidthSnackBar(
        "Please upload Identity Verification (Back)",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (!isUploaded(panCardPath.value)) {
      showCustomWidthSnackBar(
        "Please upload PAN Card",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (!isUploaded(policeCertPath.value)) {
      showCustomWidthSnackBar(
        "Please upload Police Certificate",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    return true;
  }

  bool validateStep6SkillsExperience() {
    if (selectedSkillId.value.isEmpty) {
      showCustomWidthSnackBar(
        "Please select a skill",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (skillServices.isNotEmpty && selectedServiceIds.isEmpty) {
      showCustomWidthSnackBar(
        "Please select at least one service",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (experienceYearsController.text.trim().isEmpty) {
      showCustomWidthSnackBar(
        "Please enter Years of Experience",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (dailyWageController.text.trim().isEmpty) {
      showCustomWidthSnackBar(
        "Please enter Daily Wage Expectation",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    return true;
  }

  bool _isLocalUpload(String path) {
    final String value = path.trim();
    if (value.isEmpty ||
        value.startsWith('http://') ||
        value.startsWith('https://')) {
      return false;
    }
    return File(value).existsSync();
  }

  Future<dynamic> _getFileOrUrlPayload(String path) async {
    final String trimmed = path.trim();
    if (trimmed.isEmpty) return null;
    if (_isLocalUpload(trimmed)) {
      return await getMultipartFileFromXFile(XFile(trimmed));
    }
    if (trimmed.startsWith('http://') ||
        trimmed.startsWith('https://') ||
        trimmed.startsWith('/uploads/') ||
        trimmed.startsWith('uploads/')) {
      return trimmed;
    }
    return null;
  }

  Future<Map<String, dynamic>> _getIdentityDocPayloadMap() async {
    final Map<String, dynamic> payload = <String, dynamic>{};

    final dynamic f1 = await _getFileOrUrlPayload(idFrontPath.value);
    if (f1 != null) {
      payload['identityFront'] = f1;
    }

    final dynamic b1 = await _getFileOrUrlPayload(idBackPath.value);
    if (b1 != null) {
      payload['identityBack'] = b1;
    }

    final dynamic p1 = await _getFileOrUrlPayload(panCardPath.value);
    if (p1 != null) {
      payload['panCard'] = p1;
    }

    final dynamic pc1 = await _getFileOrUrlPayload(policeCertPath.value);
    if (pc1 != null) {
      payload['policeCertificate'] = pc1;
    }

    return payload;
  }

  Future<bool> _sendCurrentStep() async {
    if (isPreviewMode.value ||
        kycStatus.value.toUpperCase() == 'UNDER_REVIEW' ||
        kycStatus.value.toUpperCase() == 'APPROVED') {
      return true;
    }

    final user = Get.find<UserController>().userData.value;
    Map response;

    switch (currentStep.value) {
      case 1:
        final dob = DateFormat('dd/MM/yyyy').parse(dobController.text.trim());
        final dynamic addressProofVal = await _getFileOrUrlPayload(
          addressProofPath.value,
        );
        response = await WorkerKycApiServices.personalInfo({
          'fullName': fullNameController.text.trim(),
          'dateOfBirth': DateFormat('yyyy-MM-dd').format(dob),
          'gender': selectedGender.value,
          'language': languageController.text.trim().split(' ').first,
          'addressLine1': houseNoController.text.trim(),
          'addressLine2': fullAddressController.text.trim(),
          'state': stateController.text.trim(),
          'city': cityController.text.trim(),
          'pincode': pincodeController.text.trim(),
          if (user.mobile.isNotEmpty) 'phone': user.mobile,
          if (user.email.isNotEmpty) 'email': user.email,
          'addressProof': ?addressProofVal,
        });
      case 2:
        final dynamic passbookVal = await _getFileOrUrlPayload(
          passbookProofPath.value,
        );
        response = await WorkerKycApiServices.bankInfo({
          'bankAccountName': accountHolderNameController.text.trim(),
          'bankAccountNumber': accountNumberController.text.trim(),
          'bankIfscCode': ifscCodeController.text.trim(),
          'branchName': branchNameController.text.trim(),
          'bankPassbook': ?passbookVal,
        });
      case 3:
        final Map<String, dynamic> idDocMap = await _getIdentityDocPayloadMap();
        response = await WorkerKycApiServices.identityDocuments(idDocMap);
      case 5:
        final dynamic liveSelfieVal = await _getFileOrUrlPayload(
          liveSelfiePath.value,
        );
        response = await WorkerKycApiServices.liveSelfie({
          'liveSelfie': ?liveSelfieVal,
        });
      case 6:
        final dynamic itiCertVal = await _getFileOrUrlPayload(
          itiCertPath.value,
        );
        final dynamic nsdcCertVal = await _getFileOrUrlPayload(
          nsdcCertPath.value,
        );
        final dynamic govtCertVal = await _getFileOrUrlPayload(
          govtCertPath.value,
        );
        final dynamic otherCertVal = await _getFileOrUrlPayload(
          otherCertPath.value,
        );
        response = await WorkerKycApiServices.skillsExperience({
          // Keep both deployed and newer API field names for compatibility.
          'skillId': selectedSkillId.value,
          'skillCategory': selectedSkillCategory.value,
          'skillServiceIds': jsonEncode(selectedServiceIds.toList()),
          'selectedSkillServiceIds': jsonEncode(selectedServiceIds.toList()),
          'experienceYears': experienceYearsController.text.trim(),
          'previousCompany': previousCompanyController.text.trim(),
          'dailyWageExpectation': dailyWageController.text.trim(),
          'description': workDescriptionController.text.trim(),
          'itiCertificate': ?itiCertVal,
          'nsdcCertificate': ?nsdcCertVal,
          'govtCertificate': ?govtCertVal,
          'otherCertificate': ?otherCertVal,
        });
      case 7:
        response = await WorkerKycApiServices.availability({
          'availabilityMode': switch (workTypeController.text) {
            'Part Time' => 'PART_TIME',
            'Both (Flexible)' => 'FLEXIBLE',
            _ => 'FULL_TIME',
          },
          'immediateJoining':
              immediateJoiningController.text == 'Yes (Immediate)',
          'workingRadiusKm':
              int.tryParse(
                workingRadiusController.text.replaceAll(RegExp(r'[^0-9]'), ''),
              ) ??
              10,
        });
      case 8:
        response = await WorkerKycApiServices.submit();
        if (!apiResponseSuccess(response)) {
          final String msg = apiPeramString(
            response['message'] ?? response['msg'],
          ).toUpperCase();
          if (msg.contains('AADHAAR_CARD') || msg.contains('PAN_CARD')) {
            Map<String, dynamic> idDocMap = await _getIdentityDocPayloadMap();

            if (idDocMap.isEmpty) {
              final Map idDocResp =
                  await WorkerKycApiServices.getIdentityDocuments();
              if (apiResponseSuccess(idDocResp)) {
                _fillFieldsForStep(3, apiPeramMap(idDocResp['data']));
                idDocMap = await _getIdentityDocPayloadMap();
              }
            }

            if (idDocMap.isNotEmpty) {
              await WorkerKycApiServices.identityDocuments(idDocMap);
              response = await WorkerKycApiServices.submit();
            }
          } else if (msg.contains('ADDRESS_PROOF')) {
            dynamic addressProofVal = await _getFileOrUrlPayload(
              addressProofPath.value,
            );
            if (addressProofVal == null) {
              final Map personalInfoResp =
                  await WorkerKycApiServices.getPersonalInfo();
              if (apiResponseSuccess(personalInfoResp)) {
                _fillFieldsForStep(1, apiPeramMap(personalInfoResp['data']));
                addressProofVal = await _getFileOrUrlPayload(
                  addressProofPath.value,
                );
              }
            }
            if (addressProofVal != null) {
              DateTime dob;
              try {
                dob = DateFormat('dd/MM/yyyy').parse(dobController.text.trim());
              } catch (_) {
                dob = DateTime(2000, 1, 1);
              }
              await WorkerKycApiServices.personalInfo({
                'fullName': fullNameController.text.trim(),
                'dateOfBirth': DateFormat('yyyy-MM-dd').format(dob),
                'gender': selectedGender.value,
                'language': languageController.text.trim().split(' ').first,
                'addressLine1': houseNoController.text.trim(),
                'addressLine2': fullAddressController.text.trim(),
                'state': stateController.text.trim(),
                'city': cityController.text.trim(),
                'pincode': pincodeController.text.trim(),
                if (user.mobile.isNotEmpty) 'phone': user.mobile,
                if (user.email.isNotEmpty) 'email': user.email,
                'addressProof': addressProofVal,
              });
              response = await WorkerKycApiServices.submit();
            }
          }
        }
      default:
        return true;
    }

    debugPrint(
      '[KYC_FLOW] PUT step=${currentStep.value}, '
      'success=${apiResponseSuccess(response)}, response=$response',
    );
    if (apiResponseSuccess(response)) return true;

    if (currentStep.value == 8) {
      final String message = apiPeramString(
        response['message'] ?? response['msg'],
      ).toUpperCase();
      if (message.contains('ALREADY UNDER REVIEW') ||
          message.contains('ALREADY_UNDER_REVIEW') ||
          message.contains('ALREADY SUBMITTED') ||
          message.contains('UNDER REVIEW') ||
          message.contains('UNDER_REVIEW')) {
        return true;
      }
      await showdialogApiError(respMap: response);
      if (message.contains('AADHAAR_CARD') || message.contains('PAN_CARD')) {
        currentStep.value = 3;
      } else if (message.contains('LIVE_SELFIE')) {
        currentStep.value = 4;
      } else if (message.contains('DAILYWAGEEXPECTATION')) {
        currentStep.value = 6;
      }
      debugPrint(
        '[KYC_FLOW] Submit incomplete; opened missing-data step='
        '${currentStep.value}',
      );
    } else {
      await showdialogApiError(respMap: response);
    }
    return false;
  }

  Future<void> nextStep() async {
    if (isLoading.value) return;
    final int submittedStep = currentStep.value;
    debugPrint('[KYC_FLOW] Continue clicked on step=$submittedStep');
    if (currentStep.value == 1) {
      if (!validateStep1PersonalInfo()) {
        return;
      }
    } else if (currentStep.value == 2) {
      if (!validateStep2BankInfo()) {
        return;
      }
    } else if (currentStep.value == 3) {
      if (!validateStep3DocumentsUpload()) {
        return;
      }
    } else if (currentStep.value == 6) {
      if (!validateStep6SkillsExperience()) {
        return;
      }
    }

    isLoading.value = true;
    final bool success = await _sendCurrentStep();
    isLoading.value = false;
    if (!success) return;

    if (isCorrectionMode && submittedStep != 4 && submittedStep != 8) {
      currentStep.value = 8;
      _hasLoadedReviewData = false;
      await loadReviewData();
      return;
    }

    if (isCorrectionMode && submittedStep == 8) {
      await AppRoutes.workerVerificationStatusRootScreen();
      return;
    }

    if (returnToStep.value > 0) {
      currentStep.value = returnToStep.value;
      returnToStep.value = 0;
      return;
    }

    // Live selfie uses a local capture step followed by its upload/preview step.
    if (currentStep.value == 4) {
      currentStep.value = 5;
      return;
    }
    await refreshKycProgress(navigate: true);

    // During active onboarding, always open the next screen in sequence. The
    // backend status can lag briefly and otherwise skip or reopen local steps.
    if (kycStatus.value != 'APPROVED' && kycStatus.value != 'UNDER_REVIEW') {
      final int? expectedNextStep = switch (submittedStep) {
        1 => 2,
        2 => 3,
        3 => 4,
        5 => 6,
        6 => 7,
        7 => 8,
        _ => null,
      };
      if (expectedNextStep != null) {
        currentStep.value = expectedNextStep;
      }
    }
    if (currentStep.value == 8) {
      await loadReviewData();
    }
    debugPrint(
      '[KYC_FLOW] submittedStep=$submittedStep, '
      'openedStep=${currentStep.value}, status=${kycStatus.value}',
    );
  }

  void previousStep() {
    if (returnToStep.value > 0) {
      currentStep.value = returnToStep.value;
      returnToStep.value = 0;
      return;
    }

    if (currentStep.value > 1 && currentStep.value < 9) {
      currentStep.value--;
    } else if (currentStep.value == 9) {
      AppRoutes.bottomNavBarScreen();
    } else {
      Get.back<void>();
    }
  }

  void saveAsDraft() {
    Get.snackbar(
      "Draft Saved",
      "Your progress for Step ${currentStep.value} of $totalSteps has been saved.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black.withValues(alpha: 0.8),
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
    );
  }

  void applyPoliceVerificationThroughPlatform() {
    Get.snackbar(
      "Police Verification",
      "Verification application initiated through platform.",
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black.withValues(alpha: 0.8),
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
    );
  }

  @override
  void onClose() {
    fullNameController.dispose();
    dobController.dispose();
    languageController.dispose();
    houseNoController.dispose();
    pincodeController.dispose();
    stateController.dispose();
    cityController.dispose();
    fullAddressController.dispose();
    accountHolderNameController.dispose();
    accountNumberController.dispose();
    confirmAccountNumberController.dispose();
    ifscCodeController.dispose();
    branchNameController.dispose();
    experienceYearsController.dispose();
    previousCompanyController.dispose();
    dailyWageController.dispose();
    workDescriptionController.dispose();
    selectedServicesController.dispose();
    super.onClose();
  }
}
