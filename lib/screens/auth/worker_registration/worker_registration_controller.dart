import 'dart:io';

import 'package:constructo_worker/networking/api/endpoints/worker_kyc_api_services.dart';
import 'package:constructo_worker/networking/dialogs/api_error_show_dialogs.dart';
import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:constructo_worker/networking/helper_methods/multipart_image.dart';
import 'package:constructo_worker/networking/user/controllers/user_controller.dart';
import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/routes/route_arguments.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_controller.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:constructo_worker/utils/toast/custom_tost_for_mobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class WorkerRegistrationController extends GetxController {
  final RxInt currentStep = 1.obs;
  final RxBool isLoading = false.obs;
  final int totalSteps = 8;
  final ImagePicker _picker = ImagePicker();
  final RxBool isPreviewMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isPreviewMode.value = RouteArguments.getOrDefault<bool>(
      'previewMode',
      false,
    );
    if (isPreviewMode.value) {
      currentStep.value = RouteArguments.getOrDefault<int>(
        'previewStep',
        1,
      );
      loadPreviewData();
    }
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
    _fillPreviewFields(apiPeramMap(response['data']));
  }

  void _fillPreviewFields(Map data) {
    switch (currentStep.value) {
      case 1:
        fullNameController.text = apiPeramString(data['fullName']);
        final DateTime? dob = DateTime.tryParse(apiPeramString(data['dateOfBirth']));
        dobController.text = dob == null
            ? apiPeramString(data['dateOfBirth'])
            : DateFormat('dd/MM/yyyy').format(dob);
        selectedGender.value = apiPeramString(data['gender']);
        selectedLanguage.value = apiPeramString(data['language']);
        languageController.text = apiPeramString(data['language']);
        houseNoController.text = apiPeramString(data['addressLine1']);
        fullAddressController.text = apiPeramString(data['addressLine2']);
        stateController.text = apiPeramString(data['state']);
        cityController.text = apiPeramString(data['city']);
        pincodeController.text = apiPeramString(data['pincode']);
        addressProofPath.value = apiPeramString(data['addressProof']);
      case 2:
        accountHolderNameController.text = apiPeramString(
          data['bankAccountName'],
          initialValue: apiPeramString(data['accountHolderName']),
        );
        accountNumberController.text = apiPeramString(data['bankAccountNumber']);
        confirmAccountNumberController.text = accountNumberController.text;
        ifscCodeController.text = apiPeramString(data['bankIfscCode']);
        branchNameController.text = apiPeramString(data['branchName']);
        passbookProofPath.value = apiPeramString(data['bankPassbook']);
      case 3:
        idFrontPath.value = apiPeramString(data['identityFront']);
        idBackPath.value = apiPeramString(data['identityBack']);
        panCardPath.value = apiPeramString(data['panCard']);
        policeCertPath.value = apiPeramString(data['policeCertificate']);
      case 4:
      case 5:
        liveSelfiePath.value = apiPeramString(data['liveSelfie']);
      case 6:
        final Map skill = apiPeramMap(data['skill']);
        selectedSkillCategory.value = apiPeramString(
          skill['name'],
          initialValue: apiPeramString(data['skillName']),
        );
        experienceYearsController.text = apiPeramString(data['experienceYears']);
        previousCompanyController.text = apiPeramString(data['previousCompany']);
        dailyWageController.text = apiPeramString(data['dailyWageExpectation']);
        itiCertPath.value = apiPeramString(data['itiCertificate']);
        nsdcCertPath.value = apiPeramString(data['nsdcCertificate']);
        govtCertPath.value = apiPeramString(data['govtCertificate']);
        otherCertPath.value = apiPeramString(data['otherCertificate']);
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
  final TextEditingController fullAddressController = TextEditingController();
  final RxString addressProofPath = 'proof.pdf'.obs;

  // Step 2: Bank Info
  final TextEditingController accountHolderNameController = TextEditingController();
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController confirmAccountNumberController = TextEditingController();
  final TextEditingController ifscCodeController = TextEditingController();
  final TextEditingController branchNameController = TextEditingController();
  final RxString passbookProofPath = 'proof.pdf'.obs;

  // Step 3: Document's Upload
  final RxString idFrontPath = 'front.pdf'.obs;
  final RxString idBackPath = 'front.pdf'.obs;
  final RxString panCardPath = 'front.pdf'.obs;
  final RxString policeCertPath = 'certificate.pdf'.obs;

  // Step 4 & 5: Live Selfie Verification
  final RxString liveSelfiePath = ''.obs;

  // Step 6: Skills & Experience / Certificate Info
  final RxString selectedSkillCategory = 'Mason'.obs;
  final TextEditingController experienceYearsController = TextEditingController();
  final TextEditingController previousCompanyController = TextEditingController();
  final TextEditingController dailyWageController = TextEditingController();
  final RxString itiCertPath = 'certificate.pdf'.obs;
  final RxString nsdcCertPath = 'certificate.pdf'.obs;
  final RxString govtCertPath = 'certificate.pdf'.obs;
  final RxString otherCertPath = 'certificate.pdf'.obs;

  void setSkillCategory(String category) {
    selectedSkillCategory.value = category;
  }

  // Step 7: Availability
  final TextEditingController workTypeController = TextEditingController();
  final TextEditingController immediateJoiningController = TextEditingController();
  final TextEditingController workingRadiusController = TextEditingController(text: "10 km");

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
                    child: Icon(Icons.close_rounded, size: 18.rsp, color: AppColors.black),
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
                          padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 12.rh),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.yellowBg : AppColors.white,
                            borderRadius: BorderRadius.circular(10.rr),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.borderE6E6E6,
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
                                      : AppColors.primary.withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  item['code']!,
                                  style: AppTextStyles.ts12w600color000000().copyWith(
                                    color: isSelected ? AppColors.black : AppColors.primary,
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
                                      style: AppTextStyles.ts14w600colorBlack().copyWith(
                                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                      ),
                                    ),
                                    sizedboxHeight(2),
                                    Text(
                                      item['subtitle']!,
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
                    child: Icon(Icons.close_rounded, size: 18.rsp, color: AppColors.black),
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
                    final bool isSelected = immediateJoiningController.text == optTitle;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.rh),
                      child: GestureDetector(
                        onTap: () {
                          immediateJoiningController.text = optTitle;
                          Get.back<void>();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 12.rh),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.yellowBg : AppColors.white,
                            borderRadius: BorderRadius.circular(10.rr),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.borderE6E6E6,
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
                                      : AppColors.primary.withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  item['code']!,
                                  style: AppTextStyles.ts12w600color000000().copyWith(
                                    color: isSelected ? AppColors.black : AppColors.primary,
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
                                      style: AppTextStyles.ts14w600colorBlack().copyWith(
                                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                      ),
                                    ),
                                    sizedboxHeight(2),
                                    Text(
                                      item['subtitle']!,
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
                    child: Icon(Icons.close_rounded, size: 18.rsp, color: AppColors.black),
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
                    final bool isSelected = workingRadiusController.text == optTitle;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 10.rh),
                      child: GestureDetector(
                        onTap: () {
                          workingRadiusController.text = optTitle;
                          Get.back<void>();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 12.rh),
                          decoration: BoxDecoration(
                            color: isSelected ? AppColors.yellowBg : AppColors.white,
                            borderRadius: BorderRadius.circular(10.rr),
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.borderE6E6E6,
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
                                      : AppColors.primary.withValues(alpha: 0.12),
                                  shape: BoxShape.circle,
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  item['code']!,
                                  style: AppTextStyles.ts12w600color000000().copyWith(
                                    color: isSelected ? AppColors.black : AppColors.primary,
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
                                      style: AppTextStyles.ts14w600colorBlack().copyWith(
                                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                      ),
                                    ),
                                    sizedboxHeight(2),
                                    Text(
                                      item['subtitle']!,
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

  // Open State Selection BottomSheet
  void openStateBottomSheet() {
    FocusManager.instance.primaryFocus?.unfocus();
    final RxString searchRx = ''.obs;

    final List<String> statesList = [
      'Andhra Pradesh',
      'Arunachal Pradesh',
      'Assam',
      'Bihar',
      'Chhattisgarh',
      'Goa',
      'Gujarat',
      'Haryana',
      'Himachal Pradesh',
      'Jharkhand',
      'Karnataka',
      'Kerala',
      'Madhya Pradesh',
      'Maharashtra',
      'Manipur',
      'Meghalaya',
      'Mizoram',
      'Nagaland',
      'Odisha',
      'Punjab',
      'Rajasthan',
      'Sikkim',
      'Tamil Nadu',
      'Telangana',
      'Tripura',
      'Uttar Pradesh',
      'Uttarakhand',
      'West Bengal',
      'Delhi (NCR)',
    ];

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
                    child: Icon(Icons.close_rounded, size: 18.rsp, color: AppColors.black),
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
                  Icon(Icons.search_rounded, color: AppColors.color7D7D7D, size: 20.rsp),
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
                final filtered = statesList.where((s) => s.toLowerCase().contains(query)).toList();

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
                    final stateName = filtered[index];
                    final bool isSelected = stateController.text == stateName;
                    final String stateCode = stateName.length >= 2 ? stateName.substring(0, 2).toUpperCase() : 'ST';

                    return GestureDetector(
                      onTap: () {
                        stateController.text = stateName;
                        Get.back<void>();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 10.rh),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.yellowBg : AppColors.white,
                          borderRadius: BorderRadius.circular(10.rr),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.borderE6E6E6,
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
                                style: AppTextStyles.ts12w600color000000().copyWith(
                                  color: isSelected ? AppColors.black : AppColors.primary,
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
                                    style: AppTextStyles.ts14w600colorBlack().copyWith(
                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
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
  void openCityBottomSheet() {
    FocusManager.instance.primaryFocus?.unfocus();
    final RxString searchRx = ''.obs;

    final List<String> citiesList = [
      'Mumbai',
      'Delhi',
      'Bangalore',
      'Hyderabad',
      'Ahmedabad',
      'Chennai',
      'Kolkata',
      'Surat',
      'Pune',
      'Jaipur',
      'Lucknow',
      'Kanpur',
      'Nagpur',
      'Indore',
      'Thane',
      'Bhopal',
      'Visakhapatnam',
      'Patna',
      'Vadodara',
      'Ghaziabad',
      'Ludhiana',
      'Agra',
      'Nashik',
      'Noida',
      'Faridabad',
      'Rajkot',
      'Varanasi',
      'Srinagar',
      'Aurangabad',
      'Dhanbad',
      'Amritsar',
      'Navi Mumbai',
      'Allahabad',
      'Ranchi',
      'Howrah',
      'Coimbatore',
      'Jabalpur',
      'Gwalior',
      'Vijayawada',
      'Jodhpur',
      'Madurai',
      'Raipur',
      'Kota',
      'Guwahati',
      'Chandigarh',
      'Solapur',
      'Bareilly',
      'Moradabad',
      'Mysore',
      'Gurgaon',
      'Aligarh',
      'Jalandhar',
    ];

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
                    child: Icon(Icons.close_rounded, size: 18.rsp, color: AppColors.black),
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
                  Icon(Icons.search_rounded, color: AppColors.color7D7D7D, size: 20.rsp),
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
                final filtered = citiesList.where((c) => c.toLowerCase().contains(query)).toList();

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
                    final cityName = filtered[index];
                    final bool isSelected = cityController.text == cityName;
                    final String cityCode = cityName.length >= 2 ? cityName.substring(0, 2).toUpperCase() : 'CT';

                    return GestureDetector(
                      onTap: () {
                        cityController.text = cityName;
                        Get.back<void>();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 10.rh),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.yellowBg : AppColors.white,
                          borderRadius: BorderRadius.circular(10.rr),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.borderE6E6E6,
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
                                style: AppTextStyles.ts12w600color000000().copyWith(
                                  color: isSelected ? AppColors.black : AppColors.primary,
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
                                    style: AppTextStyles.ts14w600colorBlack().copyWith(
                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    stateController.text.isNotEmpty ? stateController.text : "City",
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
                    child: Icon(Icons.close_rounded, size: 18.rsp, color: AppColors.black),
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
                  Icon(Icons.search_rounded, color: AppColors.color7D7D7D, size: 20.rsp),
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
                    final String displayString = "${item['name']} (${item['native']})";
                    final bool isSelected = selectedLanguage.value.startsWith(item['name']!);

                    return GestureDetector(
                      onTap: () {
                        setLanguage(displayString);
                        Get.back<void>();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 10.rh),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.yellowBg : AppColors.white,
                          borderRadius: BorderRadius.circular(10.rr),
                          border: Border.all(
                            color: isSelected ? AppColors.primary : AppColors.borderE6E6E6,
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
                                style: AppTextStyles.ts12w600color000000().copyWith(
                                  color: isSelected ? AppColors.black : AppColors.primary,
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
                                    style: AppTextStyles.ts14w600colorBlack().copyWith(
                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
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
                          border: Border.all(color: AppColors.borderE6E6E6, width: 1.rsp),
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
                              style: AppTextStyles.ts14w600colorBlack().copyWith(
                                fontWeight: FontWeight.w600,
                              ),
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
                          border: Border.all(color: AppColors.borderE6E6E6, width: 1.rsp),
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
                              style: AppTextStyles.ts14w600colorBlack().copyWith(
                                fontWeight: FontWeight.w600,
                              ),
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
  }) {
    FocusManager.instance.primaryFocus?.unfocus();
    final bool isFileExist = fileName.isNotEmpty && File(fileName).existsSync();
    final bool isNetworkImage = fileName.startsWith('http://') ||
        fileName.startsWith('https://');

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
    final String confirmAccountNumber = confirmAccountNumberController.text.trim();
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
    if (experienceYearsController.text.trim().isEmpty) {
      showCustomWidthSnackBar(
        "Please enter Years of Experience",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (previousCompanyController.text.trim().isEmpty) {
      showCustomWidthSnackBar(
        "Please enter Previous Company",
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

    bool isUploaded(String path) =>
        path.isNotEmpty &&
        path != 'proof.pdf' &&
        path != 'front.pdf' &&
        path != 'certificate.pdf';

    if (!isUploaded(itiCertPath.value)) {
      showCustomWidthSnackBar(
        "Please upload ITI Certificate",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (!isUploaded(nsdcCertPath.value)) {
      showCustomWidthSnackBar(
        "Please upload NSDC Certificate",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (!isUploaded(govtCertPath.value)) {
      showCustomWidthSnackBar(
        "Please upload Government Certificate",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }
    if (!isUploaded(otherCertPath.value)) {
      showCustomWidthSnackBar(
        "Please upload Other Certificates",
        customWidth: 340.rw,
        bgColor: Colors.redAccent,
      );
      return false;
    }

    return true;
  }

  Future<bool> _sendCurrentStep() async {
    final user = Get.find<UserController>().userData.value;
    final Map response;

    switch (currentStep.value) {
      case 1:
        final dob = DateFormat('dd/MM/yyyy').parse(dobController.text.trim());
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
          'addressProof': await getMultipartFileFromXFile(XFile(addressProofPath.value)),
        });
      case 2:
        response = await WorkerKycApiServices.bankInfo({
          'bankAccountName': accountHolderNameController.text.trim(),
          'bankAccountNumber': accountNumberController.text.trim(),
          'bankIfscCode': ifscCodeController.text.trim(),
          'bankPassbook': await getMultipartFileFromXFile(XFile(passbookProofPath.value)),
        });
      case 3:
        response = await WorkerKycApiServices.identityDocuments({
          'identityFront': await getMultipartFileFromXFile(XFile(idFrontPath.value)),
          'identityBack': await getMultipartFileFromXFile(XFile(idBackPath.value)),
          'panCard': await getMultipartFileFromXFile(XFile(panCardPath.value)),
          'policeCertificate': await getMultipartFileFromXFile(XFile(policeCertPath.value)),
        });
      case 5:
        response = await WorkerKycApiServices.liveSelfie({
          'liveSelfie': await getMultipartFileFromXFile(XFile(liveSelfiePath.value)),
        });
      case 6:
        response = await WorkerKycApiServices.skillsExperience({
          'skillId': '68cffb64-7914-4569-9a0d-726f7578bcfd',
          'experienceYears': experienceYearsController.text.trim(),
          'previousCompany': previousCompanyController.text.trim(),
          'dailyWageExpectation': dailyWageController.text.trim(),
          'itiCertificate': await getMultipartFileFromXFile(XFile(itiCertPath.value)),
          'nsdcCertificate': await getMultipartFileFromXFile(XFile(nsdcCertPath.value)),
          'govtCertificate': await getMultipartFileFromXFile(XFile(govtCertPath.value)),
          'otherCertificate': await getMultipartFileFromXFile(XFile(otherCertPath.value)),
        });
      case 7:
        response = await WorkerKycApiServices.availability({
          'availabilityMode': switch (workTypeController.text) {
            'Part Time' => 'PART_TIME',
            'Both (Flexible)' => 'FLEXIBLE',
            _ => 'FULL_TIME',
          },
          'immediateJoining': immediateJoiningController.text == 'Yes (Immediate)',
          'workingRadiusKm': int.tryParse(
                workingRadiusController.text.replaceAll(RegExp(r'[^0-9]'), ''),
              ) ??
              10,
        });
      case 8:
        response = await WorkerKycApiServices.submit();
      default:
        return true;
    }

    if (apiResponseSuccess(response)) return true;
    await showdialogApiError(respMap: response);
    return false;
  }

  Future<void> nextStep() async {
    if (isLoading.value) return;
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

    if (returnToStep.value > 0) {
      currentStep.value = returnToStep.value;
      returnToStep.value = 0;
      return;
    }

    if (currentStep.value < 9) {
      currentStep.value++;
    } else {
      // Set to Under Review state to show the newly built pending screen
      Get.put(Bnb3HomeController()).isUnderReview.value = true;
      AppRoutes.bottomNavBarScreen();
    }
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
    super.onClose();
  }
}
