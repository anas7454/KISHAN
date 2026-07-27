// ignore_for_file: must_be_immutable
import 'package:constructo/utils/common/focus_utils.dart';
import 'package:constructo/utils/theme/app_colors.dart';
import 'package:constructo/utils/theme/sizes/app_sizes.dart';
import 'package:constructo/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'dropdown_model.dart';

class DropDownMultiSelectCustom extends StatefulWidget {
  final ValueChanged<List<DropdownModel>>? onChanged;
  final RxList<DropdownModel> dropdownValues;
  final List<DropdownModel> dropdownList;
  final String? label;
  final String? hintText;
  final String? prefixImage;
  final String? validatorText;
  final Color? fillColor;
  final double? containerHeight;
  final bool? isDanse;
  final bool? showSearchBox;
  final double? containerWidth;
  final String? Function(DropdownModel)? onSubleblegetFuntion;
  final bool isDisabled;
  final String? inputHeaderName;

  TextStyle? inputHeaderNameStyle;

  TextStyle? labelStyle;

  DropDownMultiSelectCustom({
    super.key,
    this.onChanged,
    this.onSubleblegetFuntion,
    required this.dropdownValues,
    required this.dropdownList,
    this.label,
    this.validatorText,
    this.hintText,
    this.prefixImage,
    this.fillColor,
    this.containerHeight,
    this.isDanse,
    this.showSearchBox,
    this.containerWidth,
    this.isDisabled = false,

    this.inputHeaderName,
    this.inputHeaderNameStyle,
    this.labelStyle,
  });

  @override
  State<DropDownMultiSelectCustom> createState() =>
      _DropDownMultiSelectCustomState();
}

class _DropDownMultiSelectCustomState extends State<DropDownMultiSelectCustom> {
  bool validatorTextEmpty = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
          Obx(
            () => Material(
              color: Colors.transparent,
              borderRadius: borderRadiusDefault(),
              child: DropdownSearch<DropdownModel>.multiSelection(
                enabled: !widget.isDisabled,
                selectedItems: widget.dropdownValues.toList(),
                clickProps: ClickProps(),
                compareFn: (item1, item2) => item1 == item2,
                validator: (List<DropdownModel>? val) {
                  if (widget.validatorText == null) return null;

                  if (val == null || val.isEmpty) {
                    setState(() {
                      validatorTextEmpty = false;
                    });
                    return widget.validatorText ??
                        "${widget.label} is Required";
                  }
                  setState(() {
                    validatorTextEmpty = true;
                  });
                  return null;
                },
                items: (filter, infiniteScrollProps) =>
                    widget.dropdownList.map((e) => e).toList(),
                itemAsString: (DropdownModel item) => item.name ?? "",
                // चिप्स को कस्टमाइज़ करने के लिए dropdownBuilder
                dropdownBuilder: (context, selectedItems) {
                  if (selectedItems.isEmpty) {
                    return Container();
                  }
                  return Wrap(
                    spacing: 8.0,
                    runSpacing: 6.0,
                    children: selectedItems.map((item) {
                      return Chip(
                        backgroundColor: AppColors
                            .chipBgColor, // DropdownModel में कलर प्रॉपर्टी का उपयोग करें
                        shape: roundedRectangleBorderDefault(),
                        label: Text(
                          item.name.toString(),
                          style: AppTextStyles.textFiledLabelStyle(),
                        ),
                        deleteIcon: Icon(
                          Icons.close,
                          color: AppColors.color322651,
                        ), // क्रॉस बटन का कलर

                        onDeleted: () {
                          widget.dropdownValues.remove(
                            item,
                          ); // चयनित आइटम को हटाएँ
                          widget.onChanged?.call(
                            widget.dropdownValues.toList(),
                          );
                        },
                      );
                    }).toList(),
                  );
                },

                popupProps: MultiSelectionPopupProps.menu(
                  showSearchBox: widget.showSearchBox ?? false,
                  fit: FlexFit.loose,
                  showSelectedItems: true,

                  // checkBoxProps: CheckBoxProps(
                  //   position: CheckBoxPosition.start, // ✅ LEFT SIDE
                  //   activeColor: AppColors.primary,
                  // ),
                  menuProps: MenuProps(
                    // positionCallback: (buttonRect, overlayRect) {
                    //   return RelativeRect.fromLTRB(
                    //     10,
                    //     buttonRect.constraints.minHeight + 10,
                    //     10,
                    //     kBottomNavigationBarHeight + 20,
                    //   );
                    // },
                    elevation: 0, // Remove elevation
                    align: MenuAlign.bottomCenter,
                    margin: EdgeInsets.only(top: 10.rh, bottom: 50.rh),
                    // margin: EdgeInsets.only(bottom: kBottomNavigationBarHeight + 20),
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
                  itemBuilder: (context1, item, isDisabled, isSelected) {
                    final index = widget.dropdownList.indexOf(item);
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
                              //         widget.onSubleblegetFuntion!(item) ?? "",
                              //         style: AppTextStyles.ts12w400colorTextSecondry(context),
                              //       ),
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
                  // isHovering: true,
                  decoration: InputDecoration(
                    // hoverColor: AppColors.appUiColorsModel(context).hoverColor,
                    // constraints: BoxConstraints(maxWidth: widget.containerWidth ?? AppSizes.sizeGetWidth()),
                    prefixIconConstraints: BoxConstraints(maxWidth: 40.rw),
                    prefixIcon: widget.prefixImage == null
                        ? null
                        : Container(
                            margin: EdgeInsets.only(left: 10.rw, right: 10.rw),
                            child: Image.asset(widget.prefixImage ?? ''),
                          ),

                    // Borders same as AllInputDesign
                    border: borderInputDefault(),
                    focusedBorder: borderInputDefault(color: AppColors.primary),
                    errorBorder: borderInputDefault(color: Colors.red),
                    focusedErrorBorder: borderInputDefault(color: Colors.red),
                    enabledBorder: borderInputDefault(),
                    disabledBorder: borderInputDefault(
                      color: AppColors.disable,
                    ),

                    filled: true,
                    // fillColor: widget.fillColor ?? AppColors.appUiColorsModel(context).cardBg,
                    fillColor: Colors.transparent,
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    // Hint & Label
                    label: Text(
                      widget.label ?? "",
                      style: AppTextStyles.textFiledLabelStyle(),
                    ),
                    hintText: widget.hintText ?? "Select ${widget.label ?? ''}",
                    hintStyle: AppTextStyles.textFiledHintStyle(),
                    errorStyle: AppTextStyles.textFiledErrorTextStyle(),
                    // Padding
                    contentPadding: EdgeInsets.only(left: 10.w, right: 10.w),
                  ),
                ),
                onSelected: (List<DropdownModel> values) async {
                  if (values.isEmpty) return;
                  widget.dropdownValues.assignAll(values); // ✅ RxList update
                  widget.onChanged?.call(values);
                  removeFocusTwo();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Widget modelsWidget() {
//   return Column(
//     children: [
//       _resetBtnRow("Brand", "Model", onTap: () {}),
//       sizedboxHeight(5),
//       DropDownMultiSelectCustom(
//         // label: "Store Type",
//         // validatorText: "Please select a Store Type",
//         dropdownValues: RxList([]),
//         hintText: "Please Select",
//         label: "Please Select",
//         dropdownList: [
//           DropdownModel(name: "ab", value: "ab"),
//           DropdownModel(name: "pq", value: "pq"),
//         ],
//       ),
//     ],
//   );
// }
