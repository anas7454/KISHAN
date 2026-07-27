import 'package:constructo_worker/utils/buttons/icon_button_custom.dart';
import 'package:constructo_worker/utils/images/image_utility/common_icons_utility.dart';
import 'package:constructo_worker/utils/images/image_utility/icon_utility.dart';
import 'package:constructo_worker/utils/textfield/textfield_new.dart';
import 'package:constructo_worker/utils/textfield/textfield_utils.dart';
import 'package:constructo_worker/utils/textfield/validations.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/app_sizes.dart';
import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

class CommonTextFields {
  // phone number textfield
  static Widget phoneTextField({
    required TextEditingController phoneController,

    ValueChanged<String>? onFieldSubmitted,
  }) {
    return AllInputDesign(
      controller: phoneController,
      textInputAction: TextInputAction.done,
      onFieldSubmitted: onFieldSubmitted,

      hintText: "Enter Phone",
      inputHeaderName: "Mobile Number",
      validator: validateInadiaMobile,
      maxLength: 10,
      counterText: "",
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: 5.rw),
        child: Image.asset(CommonIconsUtility.phone),
      ),
      textfieldType: EnumTextfieldType.onlydigit,
    );
  }

  // search text field
  static Widget searchTextfieldhome({
    String? hintText,
    bool? readOnly,
    bool? borderRemove,
    VoidCallback? onTap,
    double? elevation,
    ValueChanged<String>? onChanged,
    TextEditingController? textEditingController,
    Color? fillColor,
    VoidCallback? onFilterTap,
  }) {
    return AllInputDesign(
      controller: textEditingController,
      onTap: onTap,
      onChanged: onChanged,
      elevation: elevation,
      // enabled: false,
      clearTextIcon: false,
      fillColor: fillColor ?? AppColors.white,
      disableBorderColor: AppColors.borderECEDF1,

      hinttextStyle: AppTextStyles.ts10w500color6B7080(),
      prefixIcon: Padding(
        padding: EdgeInsets.only(left: 5.rw),
        child: Center(
          child: Image.asset(
            IconUtility.homeSearch,
            width: 20.rh,
            height: 20.rh,
            errorBuilder: (_, _, _) =>
                Icon(Icons.search, size: 21.rh, color: AppColors.iconColor),
          ),
        ),
      ),
      suffixIcon: Container(
        decoration: const BoxDecoration(
          border: Border(left: BorderSide(color: AppColors.colorEEEEEE)),
        ),
        child: IconButtonCustom(
          onPressed: onFilterTap,
          buttonSize: 44.rh,
          child: Image.asset(
            CommonIconsUtility.homeFilter,
            width: 20.rh,
            height: 20.rh,
            errorBuilder: (_, _, _) =>
                Icon(Icons.tune, size: 20.rh, color: AppColors.iconColor),
          ),
        ),
      ),
      // prefixIconConstraints: BoxConstraints(
      //   minWidth: 42.rw,
      //   minHeight: 46.rh,
      //   maxWidth: 42.rw,
      //   maxHeight: 46.rh,
      // ),
      suffixIconConstraints: BoxConstraints(
        minWidth: 46.rw,
        minHeight: 46.rh,
        maxWidth: 46.rw,
        maxHeight: 46.rh,
      ),
      borderRemove: borderRemove ?? false,
      readOnly: readOnly ?? false,
      hintText: hintText ?? "Search materials, skilled workers, etc",
      textInputAction: TextInputAction.search,
    );
  }

  static Widget registrationCarNumberTextField(
    TextEditingController carNumberController, {
    String? inputHeaderName,
  }) {
    return AllInputDesign(
      controller: carNumberController,
      inputHeaderName: inputHeaderName,
      inputHeaderNameStyle: AppTextStyles.ts12w400color000000(),
      validator: validateCarRegNumber,
      carformatorText: true,
      hintText: "DL 12 AA 1234",
      maxLength: 13,
      counterText: "",
      onChanged: (val) {
        if (val.length == 13) {
          FocusManager.instance.primaryFocus?.unfocus(); // keyboard close
        }
      },
      // textfieldType: EnumTextfieldType.digitAndCharecter,
      prefixIcon: Container(
        decoration: BoxDecoration(
          // color: AppColors.color0059A3,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(AppSizes.borderRadiusTextField),
            bottomLeft: Radius.circular(AppSizes.borderRadiusTextField),
          ),
        ),
        // padding: EdgeInsets.only(left: 5.rw),
        // width: 40.rh,
        height: 48.rh,

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 15.rh,
              height: 15.rh,
              // child: Image.asset(ImageUtility.flag),
            ),
            sizedboxHeight(2),
            Text("IND", style: AppTextStyles.ts10w500colorFFFFFF()),
          ],
        ),
      ),

      prefixIconConstraints: TextfieldUtils.prefixIconConstraints46width(),
    );
  }
}
