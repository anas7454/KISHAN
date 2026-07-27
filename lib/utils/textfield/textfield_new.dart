// ignore_for_file: prefer_typing_uninitialized_variables, prefer_const_constructors, must_be_immutable, sized_box_for_whitespace
import 'package:constructo_worker/utils/buttons/icon_button_custom.dart';
import 'package:constructo_worker/utils/common/debug_utils.dart';
import 'package:constructo_worker/utils/textfield/textfield_textformator.dart';
import 'package:constructo_worker/utils/textfield/textfield_utils.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/app_sizes.dart';
import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AllInputDesign extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final TextEditingController? controller;
  final String? inputHeaderName;
  final String? inputHeaderSubtitle;
  final double? containerHeight;
  final double? containerWidth;
  final bool? isDanse;
  final bool isTextAreaType;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final String? label;
  final bool isAstricShow;
  final String? prefixText;
  final Widget? prefixIcon;
  Color? fillColor;
  final bool? enabled;
  final bool? readOnly;
  final String? hintText;
  final String? helperText;
  final TextInputAction? textInputAction;
  final TextStyle? prefixStyle;
  TextStyle? inputHeaderNameStyle;
  final String? Function(String?)? validator;
  final String? errorText;
  final FocusNode? focusNode;
  TextInputType? keyBoardType;
  List<TextInputFormatter>? inputFormatterData;
  final FormFieldSetter<String>? onSaved;
  final bool? obsecureText;
  final Widget? suffixIcon;
  final String? prefixIamgeAsset;
  final int? maxLength;
  final String? counterText;
  final Color? cursorColor;
  final Color? borderColor;
  final Color? disableBorderColor;

  final VoidCallback? onEditingComplete;
  final TextCapitalization? textCapitalization;
  final int? maxLines;
  final int? minLines;
  final double? elevation;
  // final TextStyle? inputHeaderTextStyle;
  // final Color? inputHeaderColor;
  TextStyle? hinttextStyle;
  final bool? autoFocus;
  TextStyle? labelStyle;
  final EdgeInsets? contentPadding;
  final String? suffixText;
  final Widget? suffix;
  double? leftConentPadding;
  double? bottomConentPadding;
  double? rightConnetntpading;
  double? borderRadius;

  bool isVerticalSpaceRemove;
  final bool isExpand;
  final bool clearTextIcon;
  final bool removeLable;
  bool borderRemove;
  final bool carformatorText;
  final bool formateCurrency;
  final BoxConstraints? suffixIconConstraints;
  BoxConstraints? prefixIconConstraints;
  // final bool isOnlyBottomBorderTypeTextfield;
  final EnumTextfieldType textfieldType;
  final EnumTextfieldUIDesign textfieldUIDesign;
  final ValueChanged<String>? onFieldSubmitted;
  AllInputDesign({
    super.key,
    this.focusNode,
    this.onTap,
    this.label,
    this.inputHeaderName,
    this.inputHeaderSubtitle,
    this.isAstricShow = false,
    this.containerHeight,
    this.containerWidth,
    this.isDanse,
    this.isTextAreaType = false,
    this.isExpand = false,
    this.clearTextIcon = false,
    this.removeLable = false,
    this.controller,
    this.floatingLabelBehavior,
    this.cursorColor,
    this.borderColor,
    this.disableBorderColor,
    this.prefixIamgeAsset,
    this.textInputAction,
    this.enabled,
    this.readOnly,
    this.prefixText,
    this.prefixIcon,
    this.fillColor,
    this.borderRadius,
    this.formateCurrency = false,
    this.prefixStyle,
    this.inputHeaderNameStyle,
    this.keyBoardType,
    this.obsecureText,
    this.suffixIcon,
    this.hintText,
    this.helperText,
    this.inputFormatterData,
    this.validator,
    this.onSaved,
    this.errorText,
    this.rightConnetntpading,
    this.onChanged,
    this.maxLength,
    this.counterText,

    this.onEditingComplete,
    this.textCapitalization,
    this.maxLines,
    this.minLines,
    this.elevation,
    // this.inputHeaderTextStyle,
    // this.inputHeaderColor,
    this.autoFocus,
    this.hinttextStyle,
    this.labelStyle,
    this.contentPadding,
    this.suffixText,
    this.suffix,
    this.leftConentPadding,
    this.bottomConentPadding,
    this.isVerticalSpaceRemove = false,
    this.borderRemove = false,
    this.carformatorText = false,
    this.suffixIconConstraints,
    this.prefixIconConstraints,
    // this.isOnlyBottomBorderTypeTextfield = false,
    this.textfieldType = EnumTextfieldType.text,
    this.textfieldUIDesign = EnumTextfieldUIDesign.none,
    this.onFieldSubmitted,
  });

  @override
  State<AllInputDesign> createState() => _AllInputDesignState();
}

class _AllInputDesignState extends State<AllInputDesign> {
  bool isSuffixIconshow = false;

  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.textfieldUIDesign) {
      // for profile screen textfields
      case EnumTextfieldUIDesign.profile:
        widget.inputHeaderNameStyle = AppTextStyles.ts10w600colorBlack();
        widget.hinttextStyle = AppTextStyles.ts10w500colorblackop2();
        widget.labelStyle = AppTextStyles.ts10w500colorBlack();
        widget.prefixIconConstraints =
            TextfieldUtils.prefixIconConstraints20width();
        break;
      case EnumTextfieldUIDesign.applyloan:
        widget.inputHeaderNameStyle = AppTextStyles.ts12w600color000000();
        widget.hinttextStyle = AppTextStyles.ts12w500color808080op50();
        widget.labelStyle = AppTextStyles.ts12w500colorBlack();
        widget.prefixIconConstraints =
            TextfieldUtils.prefixIconConstraints20width();

        break;
      case EnumTextfieldUIDesign.refurnishment:
        widget.inputHeaderNameStyle = AppTextStyles.ts12w600color000000();
        widget.hinttextStyle = AppTextStyles.ts12w500color808080op50();
        widget.labelStyle = AppTextStyles.ts12w500colorBlack();
        widget.prefixIconConstraints =
            TextfieldUtils.prefixIconConstraints20width();

        widget.fillColor = AppColors.colorFCFCFC;
        widget.borderRemove = true;

        break;
      default:
    }

    switch (widget.textfieldType) {
      case EnumTextfieldType.onlydigit:
        widget.keyBoardType = TextInputType.phone;
        widget.inputFormatterData = [FilteringTextInputFormatter.digitsOnly];
        break;
      // case EnumTextfieldType.onlydigit:
      //   widget.keyBoardType = TextInputType.number;
      //   widget.inputFormatterData = widget.formateCurrency == true
      //       ? [] // 👈 digitsOnly nahi lagana
      //       : [FilteringTextInputFormatter.digitsOnly];
      //   break;
      case EnumTextfieldType.onlyCharecter:
        // Sirf alphabets aur space allow karega
        widget.inputFormatterData = [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z ]')),
        ];
        break;
      case EnumTextfieldType.charecterAndSpecileCrecter:
        // Sirf alphabets aur space allow karega
        widget.inputFormatterData = [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z @&]')),
        ];
        break;
      case EnumTextfieldType.number2decimal:
        widget.keyBoardType = TextInputType.numberWithOptions(decimal: true);
        // Only numbers with up to 3 decimal places allowed (e.g. 200, 200.20)
        widget.inputFormatterData = [
          FilteringTextInputFormatter.allow(RegExp(r'^[0-9]*\.?[0-9]{0,3}')),
        ];
        break;
      case EnumTextfieldType.digitAndCharecter:
        // widget.keyBoardType = TextInputType.numberWithOptions(decimal: true);
        // abc ABC 123
        widget.inputFormatterData = [
          FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9]')),
        ];
        break;
      // case EnumTextfieldType.indianNumber:
      //   widget.keyBoardType = TextInputType.number;
      //   widget.inputFormatterData = [FilteringTextInputFormatter.digitsOnly, IndianNumberFormatter()];
      //   break;
      default:
    }

    // 🔥 AUTO CAPITAL FIX
    if (widget.carformatorText == true) {
      widget.inputFormatterData ??= [];
      widget.inputFormatterData!.add(UpperCaseTextFormatter());
      widget.inputFormatterData!.add(CarNumberFormatter());
    }
    if (widget.formateCurrency == true) {
      widget.inputFormatterData ??= [];
      widget.inputFormatterData!.add(IndianNumberFormatter());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.inputHeaderName != null)
          Padding(
            padding: EdgeInsets.only(bottom: 8.rh),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: widget.inputHeaderName!,
                    style:
                        widget.inputHeaderNameStyle ??
                        AppTextStyles.textfieldInputHeaderStyle(),
                  ),
                  if (widget.inputHeaderSubtitle != null)
                    TextSpan(
                      text: " ${widget.inputHeaderSubtitle}",
                      style: AppTextStyles.ts12w400color474747(),
                    ),
                ],
              ),
            ),

            // Row(
            //   children: [
            //     Text(
            //       widget.inputHeaderName!,
            //       style: widget.inputHeaderNameStyle ?? AppTextStyles.textfieldInputHeaderStyle(),
            //     ),
            //     if (widget.inputHeaderSubtitle != null)
            //       Expanded(child: Text(widget.inputHeaderSubtitle!, style: AppTextStyles.ts12w400color808080())),
            //   ],
            // ),
          ),
        Material(
          color: Colors.transparent,
          elevation: widget.elevation ?? 0.0,

          // borderRadius:borderInputDefault(
          //         color: widget.borderRemove ? Colors.white : null,
          //         borderRadius: widget.borderRadius,
          //       ),
          borderRadius: borderRadiusDefault(
            widget.borderRadius ?? AppSizes.borderRadiusTextField,
          ),
          child: Container(
            // color: Colors.amber,
            // height: widget.isExpand == true
            //     ? null
            //     : (widget.isDanse != null && widget.isDanse == true
            //           ? null
            //           : (widget.containerHeight ?? (widget.isTextAreaType ? 150.rh : 75.rh))),
            height: widget.containerHeight,
            width: widget.containerWidth ?? getWidth(),
            // constraints: BoxConstraints(
            //   minWidth: ResponsiveUiUtils.btnMinmumWidth, // ✅ Button ki minimum width 350 set
            // ),
            child: TextFormField(
              onTap: widget.onTap,
              // enabled: widget.onTap != null ? false : widget.enabled,
              enabled: widget.enabled,
              readOnly: widget.readOnly ?? false,

              textAlignVertical: TextAlignVertical.center,
              minLines: widget.maxLines ?? (widget.isTextAreaType ? 5 : 1),
              maxLines: widget.maxLines ?? (widget.isTextAreaType ? 5 : 1),
              autofocus: widget.autoFocus ?? false,
              // focusNode: widget.focusNode ?? FocusNode(canRequestFocus: false), // false se back krne pr focus remove issue aayega
              focusNode: _focusNode,
              style: widget.labelStyle ?? AppTextStyles.textFiledLabelStyle(),
              textCapitalization:
                  widget.textCapitalization ?? TextCapitalization.none,
              // cursorColor: widget.cursorColor ?? ColorUtility.colorTextFieldInputHederText,
              // cursorErrorColor: ,
              cursorHeight: 15.rh,
              onSaved: widget.onSaved,
              onEditingComplete: widget.onEditingComplete,
              keyboardType: widget.keyBoardType,
              validator: widget.validator,
              controller: widget.controller,
              maxLength: widget.maxLength,

              inputFormatters: widget.inputFormatterData,
              obscureText: widget.obsecureText ?? false,
              onChanged: (String val) {
                widget.onChanged?.call(val);

                setState(() {
                  isSuffixIconshow =
                      (widget.controller?.text.trim().isEmpty ?? true)
                      ? false
                      : true;
                  printDebugCustom(
                    "isSuffixIconshow == true && widget.clearTextIcon == true",
                  );
                  printDebugCustom(
                    "isSuffixIconshow-> $isSuffixIconshow , ${widget.clearTextIcon}",
                  );
                });
              },
              textInputAction:
                  widget.textInputAction ??
                  (widget.isTextAreaType
                      ? TextInputAction.newline
                      : TextInputAction.next),
              onFieldSubmitted: widget.onFieldSubmitted,
              decoration: InputDecoration(
                // alignLabelWithHint: true, // ✅ Required for vertical center
                // label: widget.removeLable == true
                //     ? null
                //     : RichText(
                //         text: TextSpan(
                //           text: widget.label,
                //           style: AppTextStyles.textFiledLabelStyle(),
                //           children: [
                //             widget.isAstricShow == false
                //                 ? TextSpan(text: '')
                //                 : TextSpan(
                //                     text: '*',
                //                     style: GoogleFonts.montserrat(color: Colors.red),
                //                   ),
                //           ],
                //         ),
                //       ),
                contentPadding:
                    widget.contentPadding ??
                    EdgeInsets.only(
                      left: 10.rw,
                      right: widget.rightConnetntpading ?? 10.rw,
                      top: 8.rh,
                      bottom: widget.bottomConentPadding ?? 8.rh,
                    ),

                counterText: widget.counterText,
                filled: true,

                fillColor: widget.fillColor ?? AppColors.fillTextfiled,
                hintText:
                    widget.hintText ??
                    (widget.label == null ? null : "Enter ${widget.label}"),
                helperText: widget.helperText,
                // helperStyle: AppTextStyles.ts12w400colorTextPrimary(context),
                hintStyle: (widget.hinttextStyle != null)
                    ? widget.hinttextStyle
                    : AppTextStyles.textFiledHintStyle(),
                // floatingLabelBehavior: widget.floatingLabelBehavior ?? FloatingLabelBehavior.auto,
                floatingLabelBehavior:
                    widget.floatingLabelBehavior ?? FloatingLabelBehavior.never,

                suffix: widget.suffix,

                suffixIcon:
                    widget.suffixIcon ??
                    (isSuffixIconshow == true && widget.clearTextIcon == true
                        ? IconButtonCustom(
                            onPressed: () {
                              // widget.controller?.clear();
                              // setState(() {
                              //   isSuffixIconshow = (widget.controller?.text.trim().isEmpty ?? true) ? false : true;
                              // });
                              widget.controller?.clear();

                              // 🔥 manually notify parent
                              widget.onChanged?.call('');

                              setState(() {
                                isSuffixIconshow = false;
                              });
                            },
                            size: 18.rh,
                            margin: 0.rh,
                            iconData: Icons.clear,
                            color: AppColors.iconColor,
                          )
                        : null),
                suffixIconConstraints: widget.clearTextIcon == true
                    ? BoxConstraints(
                        minWidth: 30, // default 48
                        minHeight: 30,
                        maxWidth: 30,
                        maxHeight: 30,
                      )
                    : widget.suffixIconConstraints ??
                          BoxConstraints(
                            minWidth: 30, // default 48
                            minHeight: 24,
                            maxWidth: 30,
                            maxHeight: 24,
                          ),
                prefixIconConstraints:
                    widget.prefixIconConstraints ??
                    TextfieldUtils.prefixIconConstraints35width(),
                prefixIcon:
                    widget.prefixIcon ??
                    (widget.prefixText != null
                        ? SizedBox(
                            // width: SizeUtility.sizeW60,
                            width: 60.rw,
                            child: Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 22.rh,
                                    child: Center(
                                      child: Text(
                                        widget.prefixText!,

                                        style:
                                            widget.prefixStyle ??
                                            AppTextStyles.textFiledHintStyle(),
                                      ),
                                    ),
                                  ),
                                ),
                                // dividerVerticalCustom(context, height: 20.rh),
                                // sizedboxWidth(5),
                              ],
                            ),
                          )
                        : null),

                prefixStyle:
                    widget.prefixStyle ?? AppTextStyles.textFiledHintStyle(),
                errorText: widget.errorText,
                errorStyle: AppTextStyles.textFiledErrorTextStyle(),
                // border
                border: borderInputDefault(
                  color: widget.borderRemove
                      ? Colors.white
                      : widget.borderColor,
                  borderRadius: widget.borderRadius,
                ),
                enabledBorder: borderInputDefault(
                  color: widget.borderRemove
                      ? Colors.white
                      : widget.borderColor,
                  borderRadius: widget.borderRadius,
                ),
                disabledBorder: borderInputDefault(
                  color: widget.borderRemove
                      ? Colors.white
                      : widget.disableBorderColor,
                  borderRadius: widget.borderRadius,
                ),

                focusedBorder: borderInputDefault(
                  color: AppColors.primary,
                  borderRadius: widget.borderRadius,
                ),

                errorBorder: borderInputDefault(
                  color: Colors.red,
                  borderRadius: widget.borderRadius,
                ),
                focusedErrorBorder: borderInputDefault(
                  color: Colors.red,
                  borderRadius: widget.borderRadius,
                ),

                // -----------
              ),
            ),
          ),
        ),
      ],
    );
  }
}

enum EnumTextfieldType {
  number2decimal,
  onlydigit,
  // indianNumber,
  text,
  onlyCharecter,
  charecterAndSpecileCrecter,
  digitAndCharecter,
  email,
}

enum EnumTextfieldUIDesign { none, profile, applyloan, refurnishment }
