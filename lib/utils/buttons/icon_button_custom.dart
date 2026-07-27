import 'package:constructo/utils/images/cache_network/asset_icon_widget.dart';
import 'package:constructo/utils/theme/app_colors.dart';
import 'package:constructo/utils/theme/sizes/container_const_funtions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconButtonCustom extends StatelessWidget {
  final VoidCallback? onPressed;

  /// Icon size. Button size can be controlled independently with
  /// [buttonSize], [width], and [height].
  final double? size;
  final double? buttonSize;
  final double? width;
  final double? height;
  final double? margin;
  final double? borderRadius;
  final double? iconWidth;
  final double? iconHeight;
  final String? imageAsset;
  final IconData? iconData;
  final Widget? child;
  final Color? color;
  final Color? backgroundColor;
  final Color? splashColor;
  final BoxBorder? border;
  final bool isDisable;
  final bool isCircle;

  const IconButtonCustom({
    super.key,
    this.onPressed,
    this.size,
    this.buttonSize,
    this.width,
    this.height,
    this.margin,
    this.borderRadius,
    this.iconWidth,
    this.iconHeight,
    this.imageAsset,
    this.color,
    this.backgroundColor,
    this.splashColor,
    this.border,
    this.iconData,
    this.child,
    this.isDisable = false,
    this.isCircle = false,
  });

  @override
  Widget build(BuildContext context) {
    final double iconSize = size ?? 26.sp;
    final bool hasFixedButtonSize =
        buttonSize != null || width != null || height != null;
    final double contentMargin =
        margin ?? (hasFixedButtonSize ? 0 : iconSize / 3);
    final double resolvedWidth =
        width ?? buttonSize ?? iconSize + (contentMargin * 2);
    final double resolvedHeight =
        height ?? buttonSize ?? iconSize + (contentMargin * 2);
    final BorderRadius resolvedBorderRadius = BorderRadius.circular(
      borderRadius ?? (isCircle ? resolvedWidth / 2 : 0),
    );

    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOut,
      width: resolvedWidth,
      height: resolvedHeight,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.transparent,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        border: border,
        borderRadius: isCircle ? null : resolvedBorderRadius,
      ),
      child: Material(
        color: Colors.transparent,
        shape: isCircle
            ? const CircleBorder()
            : RoundedRectangleBorder(borderRadius: resolvedBorderRadius),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: isDisable ? null : onPressed,
          borderRadius: isCircle ? null : resolvedBorderRadius,
          customBorder: isCircle ? const CircleBorder() : null,
          splashColor: splashColor ?? AppColors.splashColorBlack,
          child: Padding(
            padding: EdgeInsets.all(contentMargin),
            child: Center(child: _buildIcon(iconSize)),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(double iconSize) {
    final Color? resolvedColor = isDisable ? AppColors.disable : color;

    if (imageAsset != null) {
      return SizedBox(
        width: iconWidth ?? iconSize,
        height: iconHeight ?? iconSize,
        child: Image.asset(
          imageAsset!,
          color: resolvedColor,
          errorBuilder: (context, error, stackTrace) =>
              const Icon(Icons.error, color: Colors.red),
        ),
      );
    }
    if (iconData != null) {
      return Icon(iconData, size: iconSize, color: resolvedColor);
    }
    return child ?? const SizedBox.shrink();
  }
}

// for appbar rounded border icon with white bg
Widget iconButtonCustomRounded(
  String path, {
  VoidCallback? onPressed,
  double? iconSize,
}) {
  return IconButtonCustom(
    onPressed: onPressed,
    buttonSize: 40.rh,
    isCircle: true,
    border: borderCustomColorE6E6E6(),
    backgroundColor: AppColors.white,
    child: assetImageWidget(path, size: iconSize ?? 15.rh),
  );
}

Widget clearTextfildeIconBtn({required VoidCallback onTap}) {
  return IconButtonCustom(
    onPressed: () {
      onTap();
    },
    size: 22.rh,
    margin: 5.rh,
    iconData: Icons.clear,
    color: AppColors.iconColor,
  );
}

Widget clearIconBtn({required VoidCallback onTap}) {
  return IconButtonCustom(
    onPressed: onTap,
    child: Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      padding: EdgeInsets.all(3.rh),
      child: Icon(Icons.clear, size: 18.rh, color: AppColors.primary),
    ),
  );
}

class CircularIconButton extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onTap;
  final double? size;
  final double? iconSize;
  final Color backgroundColor;

  const CircularIconButton({
    super.key,
    required this.imagePath,
    this.onTap,
    this.size,
    this.iconSize,
    this.backgroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size ?? 30.rh,
      height: size ?? 30.rh,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Material(
        color: Colors.transparent,
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(size ?? 30.rh),
          splashColor: AppColors.splashColorBlack,
          child: Center(
            child: SizedBox(
              width: iconSize ?? 16.rh,
              height: iconSize ?? 16.rh,
              child: Image.asset(imagePath),
            ),
          ),
        ),
      ),
    );
  }
}
