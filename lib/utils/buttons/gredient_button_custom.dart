import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

class GradientButtonWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final double? height;
  final double? horizontalPadding;
  final BorderRadius? borderRadius;
  final TextStyle? textStyle;
  final String? backgroundImage;

  const GradientButtonWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.height,
    this.horizontalPadding,
    this.borderRadius,
    this.textStyle,
    this.backgroundImage,
  });

  @override
  Widget build(BuildContext context) {
    final BorderRadius radius = borderRadius ?? BorderRadius.circular(19.rh);

    return Container(
      height: height ?? 39.rh,
      decoration: BoxDecoration(
        // image: decorationImageCustom(
        //   backgroundImage ?? ImageGredients.buttongredintbg,
        // ),
        borderRadius: radius,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: radius,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding ?? 30.rw,
            ),
            alignment: Alignment.center,
            child: Text(
              title,
              style: textStyle ?? AppTextStyles.ts12w600colorFFFFFF(),
            ),
          ),
        ),
      ),
    );
  }
}
