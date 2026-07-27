import 'package:constructo/utils/images/cache_network/asset_icon_widget.dart';
import 'package:constructo/utils/theme/app_colors.dart';
import 'package:constructo/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

class LabelWidget extends StatelessWidget {
  final String text;
  final Color? backgroundColor;
  final Color foregroundColor;
  final IconData? iconData;
  final String? iconAsset;
  final Color? iconColor;
  final double? iconSize;
  final double? iconSpacing;

  const LabelWidget({
    super.key,
    required this.text,
    this.backgroundColor = AppColors.colorGreenChip,
    this.foregroundColor = AppColors.white,
    this.iconData,
    this.iconAsset,
    this.iconColor,
    this.iconSize,
    this.iconSpacing,
  }) : assert(iconData == null || iconAsset == null);

  @override
  Widget build(BuildContext context) {
    final bool hasIcon = iconData != null || iconAsset != null;
    final double resolvedIconSize = iconSize ?? 12.rsp;

    return Container(
      height: 18.rh,
      padding: EdgeInsets.symmetric(horizontal: 6.rw),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4.rr),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasIcon) ...[
            iconAsset != null
                ? assetImageWidget(
                    iconAsset!,
                    size: resolvedIconSize,
                    color: iconColor,
                  )
                : Icon(
                    iconData,
                    size: resolvedIconSize,
                    color: iconColor ?? foregroundColor,
                  ),
            SizedBox(width: iconSpacing ?? 2.rw),
          ],
          Text(
            text,
            style: AppTextStyles.ts11w400colorwhite().copyWith(
              color: foregroundColor,
              fontWeight: hasIcon ? FontWeight.w500 : null,
              height: 1.1,
            ),
          ),
        ],
      ),
    );
  }
}
