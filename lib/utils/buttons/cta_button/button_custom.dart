import 'package:constructo_worker/networking/extensions/api_helper.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/app_sizes.dart';
import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final VoidCallback? onPressed;
  final String? name;
  final Widget? nameWidget;
  final EnumButtonType? btnType;
  final bool isLoading;
  final double? borderRadiusDouble;
  final double? width;
  final bool flexibleWidth;
  final bool isSuffix;
  final double? height;
  final double? borderWidth;
  final Color? btnColor;
  final Color? borderColor;
  final Color? textColor;
  final String? imageAsset;
  final double? imageAssetSize;
  final Color? imageAssetColor;
  final double? btnMinmumWidth;
  final double? elevation;
  final double? fontsize;
  final double? horizontalPadding;
  final FontWeight? fontWeight;
  final TextStyle? style;
  final List<BoxShadow>? boxShadow;
  final Gradient? gredient;

  const Button({
    super.key,
    this.name,
    this.nameWidget,
    this.btnType,
    this.onPressed,
    this.boxShadow,
    this.borderRadiusDouble,
    this.borderWidth,
    this.width,
    this.height,
    this.btnColor,
    this.borderColor,
    this.textColor,
    this.imageAsset,
    this.imageAssetSize,
    this.isSuffix = false,
    this.elevation,
    this.style,
    this.fontsize,
    this.fontWeight,
    this.horizontalPadding,
    this.btnMinmumWidth,
    this.imageAssetColor,
    this.isLoading = false,
    this.flexibleWidth = false,
    this.gredient,
  });

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    final double buttonHeight = widget.height ?? 44.rh;
    final double? buttonWidth = widget.flexibleWidth
        ? null
        : (widget.width ?? AppSizes.screenWidth);
    final bool isDisabled =
        widget.btnType == EnumButtonType.disable || widget.isLoading;
    final double resolvedElevation = _getElevation();

    return Material(
      elevation: resolvedElevation,
      color: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: _getBorderRadius()),
      child: Container(
        height: buttonHeight,
        width: buttonWidth,
        decoration: BoxDecoration(
          boxShadow: isDisabled || _isOutline || resolvedElevation == 0
              ? null
              : (widget.boxShadow ?? boxShadowDefault()),
          borderRadius: _getBorderRadius(),
          color: widget.gredient == null ? _getBtnColor(isDisabled) : null,
          gradient: widget.gredient,
          border: _isOutline
              ? borderCustomDefault(
                  color: _getBorderColor().withValues(
                    alpha: isDisabled ? 0.5 : null,
                  ),
                  width: widget.borderWidth ?? AppSizes.borderThikness1Sp,
                )
              : null,
        ),
        child: MaterialButton(
          splashColor: AppColors.splashColorBlack,
          padding: EdgeInsets.symmetric(
            horizontal: widget.horizontalPadding ?? 10.rw,
          ),
          shape: RoundedRectangleBorder(borderRadius: _getBorderRadius()),
          onPressed: isDisabled ? null : widget.onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.isLoading) ...{
                _buttonLoadingCircularProgress(buttonHeight, isDisabled),
              },
              if (widget.imageAsset != null && widget.isSuffix == false) ...{
                _prefixImage(),
                sizedboxWidth(8),
              },
              _btnNameText(context, widget.name, isDisabled),
              if (widget.imageAsset != null && widget.isSuffix == true) ...{
                sizedboxWidth(8),
                _prefixImage(),
              },
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonLoadingCircularProgress(double buttonHeight, bool isDisabled) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: buttonHeight / 2.4,
          height: buttonHeight / 2.4,
          child: CircularProgressIndicator(
            color: _getBtnTextColor(isDisabled),
            strokeWidth: 2.rh,
          ),
        ),
        sizedboxWidth(10),
      ],
    );
  }

  Widget _btnNameText(BuildContext context, String? btnName, bool isDisabled) {
    return widget.nameWidget ??
        Text(
          "${apiPeramNameString(btnName)}${(widget.isLoading && btnName != null) ? "..." : ""}"
              .trim(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style:
              widget.style ??
              AppTextStyles.buttonTextStyle(context).copyWith(
                fontSize: widget.fontsize,
                fontWeight: _getFontWeight(),
                color: _getBtnTextColor(isDisabled),
              ),
        );
  }

  Widget _prefixImage() {
    final double imageSize =
        widget.imageAssetSize ?? (_isAuthOutline ? 18.rh : 16.rh);

    return SizedBox(
      width: imageSize,
      height: imageSize,
      child: Image.asset(
        widget.imageAsset ?? "",
        color: widget.imageAssetColor,
      ),
    );
  }

  // Explicit widget properties always override the selected button preset.
  bool get _isOutline =>
      widget.btnType == EnumButtonType.outline ||
      widget.btnType == EnumButtonType.outlineAuth;

  bool get _isAuthOutline => widget.btnType == EnumButtonType.outlineAuth;

  double _getElevation() {
    if (widget.elevation != null) return widget.elevation!;
    if (_isOutline) return 0;
    if (widget.width != null && widget.width! < getWidth(0.6)) return 0;
    return AppSizes.elevetionBtn;
  }

  Color _getBtnColor(bool isDisabled) {
    final Color color =
        widget.btnColor ??
        (_isAuthOutline
            ? AppColors.fillTextfiled
            : _isOutline
            ? Colors.transparent
            : AppColors.ctaBtnColor);

    return color.withValues(alpha: isDisabled ? 0.65 : null);
  }

  Color _getBorderColor() {
    return widget.borderColor ??
        (_isAuthOutline ? AppColors.borderF0F0F0 : AppColors.outlineBtnBorder);
  }

  BorderRadius _getBorderRadius() {
    return borderRadiusDefault(
      widget.borderRadiusDouble ??
          (_isAuthOutline
              ? AppSizes.borderRadiusTextField
              : AppSizes.borderRadiusBtn),
    );
  }

  FontWeight? _getFontWeight() {
    return widget.fontWeight ?? (_isAuthOutline ? FontWeight.w500 : null);
  }

  Color _getBtnTextColor(bool isDisabled) {
    final Color color =
        widget.textColor ??
        (_isOutline
            ? AppColors.outlineBtnTextColor
            : AppColors.cteBtnTextColor);

    return color.withValues(alpha: isDisabled ? 0.7 : null);
  }
}

enum EnumButtonType {
  outline,

  /// Auth outline preset: filled background, auth border/radius, medium text,
  /// 18px asset icon and zero elevation.
  outlineAuth,
  disable,
}
