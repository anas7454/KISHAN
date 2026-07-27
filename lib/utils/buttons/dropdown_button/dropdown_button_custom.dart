// ignore_for_file: must_be_immutable

import 'package:constructo/utils/common/focus_utils.dart';
import 'package:constructo/utils/textfield/textfield_new.dart';
import 'package:constructo/utils/textfield/textfield_utils.dart';
import 'package:constructo/utils/theme/app_colors.dart';
import 'package:constructo/utils/theme/sizes/app_sizes.dart';
import 'package:constructo/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'dropdown_model.dart';
import 'package:dropdown_search/dropdown_search.dart';

class DropDownCustom extends StatefulWidget {
  final ValueChanged<DropdownModel?>? onChanged;
  final Rx<DropdownModel>? dropdownValue;
  final List<DropdownModel> dropdownList;
  final String? inputHeaderName;
  final String? hintText;

  final String? prefixImage;
  final String? validatorText;
  bool validateEnable;
  Color? fillColor;
  bool borderRemove;
  final double? containerHeight;
  final bool? isDanse;
  final bool? showSearchBox;
  TextStyle? inputHeaderNameStyle;
  TextStyle? hinttextStyle;
  TextStyle? labelStyle;

  final String? Function(DropdownModel)? onSubleblegetFuntion;

  final EnumTextfieldUIDesign textfieldUIDesign;
  DropDownCustom({
    super.key,
    this.onChanged,
    this.onSubleblegetFuntion,
    required this.dropdownValue,
    required this.dropdownList,
    this.inputHeaderName,
    this.validatorText,
    this.validateEnable = true,
    this.hintText,
    this.prefixImage,
    this.fillColor,

    this.containerHeight,
    this.isDanse,
    this.showSearchBox,
    this.borderRemove = false,
    this.inputHeaderNameStyle,
    this.hinttextStyle,

    this.labelStyle,
    this.textfieldUIDesign = EnumTextfieldUIDesign.none,
  });

  @override
  State<DropDownCustom> createState() => _DropDownCustomState();
}

class _DropDownCustomState extends State<DropDownCustom> {
  bool validatorTextEmpty = true;

  @override
  Widget build(BuildContext context) {
    switch (widget.textfieldUIDesign) {
      // for profile screen textfields
      case EnumTextfieldUIDesign.profile:
        widget.inputHeaderNameStyle = AppTextStyles.ts10w600colorBlack();
        widget.hinttextStyle = AppTextStyles.ts10w500colorblackop2();
        widget.labelStyle = AppTextStyles.ts10w500colorBlack();
        // widget.prefixIconConstraints = TextfieldUtils.prefixIconConstraints20width();
        break;
      case EnumTextfieldUIDesign.applyloan:
        widget.inputHeaderNameStyle = AppTextStyles.ts12w600color000000();
        widget.hinttextStyle = AppTextStyles.ts12w500color808080op50();
        widget.labelStyle = AppTextStyles.ts12w500colorBlack();
        // widget.prefixIconConstraints = TextfieldUtils.prefixIconConstraints20width();

        break;
      case EnumTextfieldUIDesign.refurnishment:
        widget.inputHeaderNameStyle = AppTextStyles.ts12w600color000000();
        widget.hinttextStyle = AppTextStyles.ts12w500color808080op50();
        widget.labelStyle = AppTextStyles.ts12w500colorBlack();
        // widget.prefixIconConstraints = TextfieldUtils.prefixIconConstraints20width();

        widget.fillColor = AppColors.colorFCFCFC;
        widget.borderRemove = true;

        break;
      default:
    }
    return Obx(
      () => Theme(
        data: ThemeData(splashColor: Colors.transparent),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.inputHeaderName != null) ...{
              Text(
                widget.inputHeaderName ?? "",
                style:
                    widget.inputHeaderNameStyle ??
                    AppTextStyles.textfieldInputHeaderStyle(),
              ),
              sizedboxHeight(8),
            },
            // ignore: avoid_unnecessary_containers
            Container(
              // margin: EdgeInsets.only(bottom: validatorTextEmpty ? 25.h : 10.h),
              // height: isDanse == true ? null : (containerHeight ?? 75.h),
              child: DropdownSearch<DropdownModel>(
                selectedItem: widget.dropdownValue?.value.value == null
                    ? null
                    : widget.dropdownValue?.value,
                compareFn: (item1, item2) => item1 == item2,
                validator: (DropdownModel? val) {
                  if (widget.validateEnable == false) {
                    return null;
                  }

                  if (val?.name == null || val?.value == null) {
                    setState(() {
                      validatorTextEmpty = false;
                    });
                    return widget.validatorText ??
                        "${widget.inputHeaderName} is Required";
                  }
                  setState(() {
                    validatorTextEmpty = true;
                  });

                  return null;
                },
                items: (filter, infiniteScrollProps) =>
                    widget.dropdownList.map((DropdownModel dropdownModel) {
                      return dropdownModel;
                    }).toList(),

                itemAsString: (DropdownModel item) {
                  return item.name ?? "";
                },
                dropdownBuilder: (context, selectedItem) {
                  return Text(
                    selectedItem?.name ?? "",
                    style:
                        widget.labelStyle ??
                        AppTextStyles.textFiledLabelStyle(),
                  );
                },

                popupProps: PopupProps.menu(
                  showSearchBox: widget.showSearchBox ?? false,
                  fit: FlexFit.loose,
                  menuProps: MenuProps(
                    elevation: 0, // Remove elevation
                    align: MenuAlign.bottomCenter,
                    margin: EdgeInsets.only(top: 10.rh),

                    backgroundColor: widget.fillColor ?? AppColors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: AppColors.primary,
                        width: AppSizes.borderThikness1Sp,
                      ),
                      borderRadius: borderRadiusDefault(
                        AppSizes.borderRadiusTextField,
                      ),
                    ),
                  ),

                  itemBuilder: (context, item, isDisabled, isSelected) {
                    final index = widget.dropdownList.indexOf(item);
                    // final isLastItem = index == 2; // Check for last index
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            // vertical: widget.onSubleblegetFuntion == null ? 15.h : 10.h,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              sizedboxHeight(12),
                              Text(
                                item.name.toString(),
                                style:
                                    widget.labelStyle ??
                                    AppTextStyles.textFiledLabelStyle(),
                              ),
                              // widget.onSubleblegetFuntion == null
                              //     ? Container()
                              //     : Text(
                              //         widget.onSubleblegetFuntion!(item) ??
                              //             "",
                              //         style: StyleUtility.textFiledHintStyle()
                              //             .copyWith(fontSize: 12.sp)),
                            ],
                          ),
                        ),
                        index + 1 == widget.dropdownList.length
                            ? Container(height: 12.rh)
                            : Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                ).copyWith(top: 12.rh),
                                child: dividerCustom(verticalMargin: 0),
                              ),
                      ],
                    );
                  },
                ),
                suffixProps: DropdownSuffixProps(
                  dropdownButtonProps: DropdownButtonProps(
                    iconClosed: Icon(
                      Icons.expand_more,
                      color: validatorTextEmpty
                          ? AppColors.hintText
                          : Colors.red,
                    ),
                    iconOpened: Icon(
                      Icons.keyboard_arrow_up,
                      color: validatorTextEmpty
                          ? AppColors.primary
                          : Colors.red,
                    ),
                  ),
                ),
                decoratorProps: DropDownDecoratorProps(
                  decoration: InputDecoration(
                    // labelText: widget.dropdownValue?.value.value == null ? null : widget.dropdownValue!.value.name,
                    // labelStyle: widget.labelStyle ?? AppTextStyles.textFiledLabelStyle(),
                    prefixIconConstraints:
                        TextfieldUtils.prefixIconConstraints35width(),
                    prefixIcon: widget.prefixImage == null
                        ? null
                        : Container(
                            margin: EdgeInsets.only(left: 10.w, right: 10.w),
                            child: Image.asset(widget.prefixImage ?? ''),
                          ),
                    enabledBorder: borderInputDefault(
                      color: widget.borderRemove ? Colors.white : null,
                    ),

                    // OutlineInputBorder(
                    //   borderSide: BorderSide(
                    //       color:
                    //           ColorUtility.colorGrey97999ATextFieldHintText,
                    //       width: 1.h),
                    // ),
                    border: borderInputDefault(
                      color: widget.borderRemove ? Colors.white : null,
                    ),
                    focusedBorder: borderInputDefault(color: AppColors.primary),
                    errorBorder: borderInputDefault(color: Colors.red),
                    focusedErrorBorder: borderInputDefault(color: Colors.red),
                    filled: true,
                    fillColor: widget.fillColor ?? AppColors.white,

                    hintText: widget.hintText ?? "Select",
                    hintStyle:
                        widget.hinttextStyle ??
                        AppTextStyles.textFiledHintStyle(),
                    contentPadding: EdgeInsets.only(left: 10.w, right: 10.w),
                    // EdgeInsets.symmetric(vertical: 7.h, horizontal: 10.w)
                    //     .copyWith(top: 15.h),
                  ),
                ),
                onSelected: (val) async {
                  if (val == null) return;
                  widget.dropdownValue?.value = val;
                  if (widget.onChanged != null) {
                    widget.onChanged!(val);
                  }
                  removeFocusTwo();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
