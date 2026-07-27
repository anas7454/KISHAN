import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextButtonCustom extends StatelessWidget {
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final double? fontSize;
  final Color? textColor;
  final String btnName;
  final bool isDanse;
  final bool isUnderline;
  final Color? borderColor;
  final Color? splashColor;
  final double borderRadius;
  final double horizontalPadding;
  final double verticalPadding;

  const TextButtonCustom({
    super.key,
    this.onPressed,
    this.textStyle,
    this.fontSize,
    this.textColor,
    this.isDanse = false,
    this.isUnderline = false,
    required this.btnName,
    this.borderColor,
    this.splashColor,
    this.borderRadius = 4,
    this.horizontalPadding = 3,
    this.verticalPadding = 2,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: borderColor ?? Colors.transparent),
          borderRadius: BorderRadius.circular(borderRadius.rh),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: isDanse ? 5.w : horizontalPadding.w,
          vertical: isDanse ? 4.h : verticalPadding.h,
        ),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        overlayColor:
            splashColor ??
            textColor?.withValues(alpha: 0.16) ??
            AppColors.black.withValues(alpha: 0.16),
      ),
      child: Text(
        btnName,
        style:
            (textStyle ??
                    (isUnderline
                        ? AppTextStyles.ts14w600colorBlack()
                        : AppTextStyles.ts14w500color7D7D7D()))
                .copyWith(
                  fontSize: fontSize,
                  color: textColor,
                  decoration: isUnderline ? TextDecoration.underline : null,
                  decorationColor: isUnderline ? textColor : null,
                ),
      ),
    );
  }
}

Widget testButton({
  required VoidCallback onPressed,
  String btnName = "TEST BUTTON",
}) {
  return kDebugMode
      ? TextButtonCustom(onPressed: onPressed, btnName: btnName)
      : Container();
}
