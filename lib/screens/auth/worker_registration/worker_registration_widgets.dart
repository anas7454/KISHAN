import 'dart:io';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:constructo_worker/screens/auth/worker_registration/worker_registration_controller.dart';
import 'package:constructo_worker/utils/buttons/back_button_custom.dart';
import 'package:constructo_worker/utils/buttons/cta_button/button_custom.dart';
import 'package:constructo_worker/utils/buttons/icon_button_custom.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:constructo_worker/utils/theme/widgets/divider_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

part 'steps/step1_personal_info_widgets.dart';
part 'steps/step2_bank_info_widgets.dart';
part 'steps/step3_documents_upload_widgets.dart';
part 'steps/step4_live_selfie_widgets.dart';
part 'steps/step5_live_selfie_widgets.dart';
part 'steps/step6_skills_experience_widgets.dart';
part 'steps/step7_availability_widgets.dart';
part 'steps/step8_review_widgets.dart';
part 'steps/step9_registration_complete_widgets.dart';

mixin WorkerRegistrationWidgets {
  // Common Step App Bar
  PreferredSizeWidget stepHeader({
    required String title,
    required int currentStep,
    required VoidCallback onBack,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(66.rh),
      child: AppBar(
        toolbarHeight: 66.rh,
        backgroundColor: AppColors.yellowBg,
        surfaceTintColor: AppColors.yellowBg,
        elevation: 0,
        centerTitle: false,
        leadingWidth: 44.rw,
        leading: Padding(
          padding: EdgeInsets.only(left: 12.rw),
          child: Center(
            child: BackButtonCustom(
              onTap: onBack,
            ),
          ),
        ),
        titleSpacing: 4.rw,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.ts18w700color000000().copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            sizedboxHeight(2),
            Text(
              "Step $currentStep of 8",
              style: AppTextStyles.ts12w500color808080(),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1.rsp),
          child: Container(
            height: 1.rsp,
            color: AppColors.homeCardBorder, // #FFEF9E 1px bottom border
          ),
        ),
      ),
    );
  }

  // Common Bottom Action Buttons (Figma Specs: Frame 34636 & 34638, Height: 40px, Radius: 100px, Gap: 8px, SaveDraft: #FFCC00 10%)
  Widget stepBottomButtons({
    required VoidCallback onContinue,
    required VoidCallback onSaveDraft,
    bool isContinueEnabled = true,
    String continueButtonText = "Continue",
    bool showSaveDraft = true,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 12.rh),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            offset: Offset(0, -13.rh),
            blurRadius: 17.rr,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Button(
            name: continueButtonText,
            onPressed: isContinueEnabled ? onContinue : () {},
            btnColor: isContinueEnabled ? AppColors.black : const Color(0xff8D8D8D),
            textColor: AppColors.white,
            height: 40.rh,
            borderRadiusDouble: 100.rh,
            fontWeight: FontWeight.w600,
            fontsize: 14.rsp,
          ),
          if (showSaveDraft) ...[
            sizedboxHeight(8),
            Button(
              name: "Save as Draft",
              onPressed: onSaveDraft,
              btnColor: AppColors.primary.withValues(alpha: 0.10), // #FFCC00 10%
              textColor: AppColors.black,
              height: 40.rh,
              borderRadiusDouble: 100.rh,
              fontWeight: FontWeight.w600,
              fontsize: 14.rsp,
              elevation: 0,
            ),
          ],
        ],
      ),
    );
  }

  // Common White Section Card Container (Figma Frame Specs: 8px radius, 1px #DBDBDB border, 12px padding, 12px gap)
  Widget sectionCard({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.rw),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.rr),
        border: Border.all(color: AppColors.borderDBDBDB, width: 1.rsp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.ts16w600color000000().copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          sizedboxHeight(12),
          ...children,
        ],
      ),
    );
  }

  // Reusable Input Field with Label (Figma Specs: Height: 44px, Radius: 10px, Border: 1px #D7D7D7, Padding: 9px 10px, Gap: 7px, LinearGradient background)
  Widget inputLabelField({
    required String label,
    required String hintText,
    TextEditingController? controller,
    Widget? suffixIcon,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.words,
    List<TextInputFormatter>? inputFormatters,
    int? maxLength,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.ts14w600colorBlack().copyWith(
            fontSize: 13.rsp,
            fontWeight: FontWeight.w600,
          ),
        ),
        sizedboxHeight(7),
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 44.rh,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 9.rh),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(51, 51, 51, 0.03),
                  Color.fromRGBO(0, 0, 0, 0.03),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x2EFFFFFF), // #FFFFFF 18% opacity
                  offset: Offset(0, 3.rh),
                  blurRadius: 4.rr,
                  spreadRadius: 0,
                ),
              ],
              borderRadius: BorderRadius.circular(10.rr),
              border: Border.all(color: AppColors.borderTextfiled, width: 1.rsp), // #D7D7D7
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    readOnly: readOnly,
                    onTap: onTap,
                    keyboardType: keyboardType,
                    textCapitalization: textCapitalization,
                    inputFormatters: inputFormatters,
                    maxLength: maxLength,
                    style: AppTextStyles.ts14w400color000000(),
                    decoration: InputDecoration(
                      hintText: hintText,
                      hintStyle: AppTextStyles.ts14w500color7D7D7D(),
                      border: InputBorder.none,
                      counterText: "",
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                ?suffixIcon,
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Reusable File Upload Field (Figma Specs: Group 8857, Width: 81px, Height: 29px, Fill: 0%, Border: 1px #FFBC07 40%)
  Widget uploadFileField({
    required String label,
    required String fileName,
    VoidCallback? onUpload,
    VoidCallback? onView,
    String defaultPlaceholder = 'proof.pdf',
  }) {
    final bool isUploaded = fileName.isNotEmpty &&
        fileName != 'proof.pdf' &&
        fileName != 'front.pdf' &&
        fileName != 'certificate.pdf';

    final String shortFileName = isUploaded
        ? fileName.split('/').last.split('\\').last
        : defaultPlaceholder;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.ts14w600colorBlack().copyWith(
            fontSize: 13.rsp,
            fontWeight: FontWeight.w600,
          ),
        ),
        sizedboxHeight(7),
        GestureDetector(
          onTap: isUploaded ? null : onUpload,
          child: Container(
            height: 44.rh,
            width: double.infinity,
            padding: EdgeInsets.only(left: 10.rw, right: 8.rw),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(51, 51, 51, 0.03),
                  Color.fromRGBO(0, 0, 0, 0.03),
                ],
              ),
              borderRadius: BorderRadius.circular(10.rr),
              border: Border.all(
                color: isUploaded ? AppColors.primary : AppColors.borderTextfiled,
                width: 1.rsp,
              ),
            ),
            child: Row(
              children: [
                if (isUploaded) ...[
                  Icon(
                    Icons.check_circle_rounded,
                    color: AppColors.primary,
                    size: 18.rsp,
                  ),
                  sizedboxWidth(6),
                ],
                Expanded(
                  child: Text(
                    shortFileName,
                    style: AppTextStyles.ts14w500color7D7D7D().copyWith(
                      color: isUploaded ? AppColors.black : AppColors.color7D7D7D,
                      fontWeight: isUploaded ? FontWeight.w600 : FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                sizedboxWidth(8),
                if (!isUploaded)
                  InkWell(
                    onTap: onUpload,
                    borderRadius: BorderRadius.circular(15.rr),
                    child: Container(
                      width: 81.rw,
                      height: 29.rh,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(15.rr),
                        border: Border.all(
                          color: AppColors.colorFFBC07.withValues(alpha: 0.40),
                          width: 1.rsp,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.camera_alt_rounded,
                            size: 14.rsp,
                            color: AppColors.colorFFBC07,
                          ),
                          sizedboxWidth(4),
                          Text(
                            "Upload",
                            style: AppTextStyles.ts12w600color000000().copyWith(
                              color: AppColors.colorFFBC07,
                              fontWeight: FontWeight.w600,
                              fontSize: 12.rsp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  InkWell(
                    onTap: onView,
                    borderRadius: BorderRadius.circular(15.rr),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 4.rh),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12.rr),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.visibility_rounded,
                            size: 15.rsp,
                            color: AppColors.black,
                          ),
                          sizedboxWidth(4),
                          Text(
                            "View",
                            style: AppTextStyles.ts12w600color000000().copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 12.rsp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Reusable Gender Radio Selector (Figma Specs: Frame 2147227007, Radius: 4px, Height: 32px, Border: 1px #D7D7D7, Padding: 6px 8px, Gap: 2px)
  Widget genderRadioSelector(WorkerRegistrationController controller) {
    final List<String> genders = ['Male', 'Female', 'Other'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Gender",
          style: AppTextStyles.ts14w600colorBlack().copyWith(
            fontSize: 13.rsp,
            fontWeight: FontWeight.w600,
          ),
        ),
        sizedboxHeight(6),
        Obx(() {
          return Row(
            children: genders.map((gender) {
              final bool isSelected = controller.selectedGender.value == gender;
              return Expanded(
                child: GestureDetector(
                  onTap: () => controller.setGender(gender),
                  child: Container(
                    height: 32.rh,
                    margin: EdgeInsets.only(right: gender != 'Other' ? 8.rw : 0),
                    padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 6.rh),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(4.rr),
                      border: Border.all(
                        color: isSelected ? AppColors.primary : AppColors.borderTextfiled, // #D7D7D7
                        width: 1.rsp,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 14.rw,
                          height: 14.rw,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected ? AppColors.primary : AppColors.colorBFBFBF,
                              width: 1.2.rsp,
                            ),
                          ),
                          child: isSelected
                              ? Center(
                                  child: Icon(
                                    Icons.check_rounded,
                                    size: 9.rsp,
                                    color: AppColors.primary,
                                  ),
                                )
                              : null,
                        ),
                        sizedboxWidth(2), // 2px gap per Figma specs
                        Text(
                          gender,
                          style: AppTextStyles.ts12w500colorBlack().copyWith(
                            color: isSelected ? AppColors.primary : AppColors.black,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          );
        }),
      ],
    );
  }

  // Step 1: Personal Info
}

// Custom Painter for Corner Brackets around Face Frame
class CornerBracketsPainter extends CustomPainter {
  final Color color;
  final double bracketLength;
  final double strokeWidth;

  CornerBracketsPainter({
    required this.color,
    this.bracketLength = 36.0,
    this.strokeWidth = 2.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double l = bracketLength;

    // Top-Left
    canvas.drawPath(
      Path()
        ..moveTo(0, l)
        ..lineTo(0, 0)
        ..lineTo(l, 0),
      paint,
    );

    // Top-Right
    canvas.drawPath(
      Path()
        ..moveTo(size.width - l, 0)
        ..lineTo(size.width, 0)
        ..lineTo(size.width, l),
      paint,
    );

    // Bottom-Left
    canvas.drawPath(
      Path()
        ..moveTo(0, size.height - l)
        ..lineTo(0, size.height)
        ..lineTo(l, size.height),
      paint,
    );

    // Bottom-Right
    canvas.drawPath(
      Path()
        ..moveTo(size.width - l, size.height)
        ..lineTo(size.width, size.height)
        ..lineTo(size.width, size.height - l),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Custom Painter for Green Dotted Circle Border (Step 5)
class DottedCircleBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dotRadius;
  final double spacing;

  DottedCircleBorderPainter({
    required this.color,
    this.strokeWidth = 3.0,
    this.dotRadius = 2.5,
    this.spacing = 5.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - strokeWidth;
    final circumference = 2 * pi * radius;
    final totalDots = (circumference / (dotRadius * 2 + spacing)).floor();

    for (int i = 0; i < totalDots; i++) {
      final angle = (2 * pi / totalDots) * i;
      final x = center.dx + radius * cos(angle);
      final y = center.dy + radius * sin(angle);
      canvas.drawCircle(Offset(x, y), dotRadius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Custom Painter for Dotted Vertical Dividers between guidelines
class DottedVerticalDividerPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashLength;
  final double dashGap;

  DottedVerticalDividerPainter({
    required this.color,
    this.strokeWidth = 1.0,
    this.dashLength = 2.0,
    this.dashGap = 3.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    double startY = 0;
    while (startY < size.height) {
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, startY + dashLength),
        paint,
      );
      startY += dashLength + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
