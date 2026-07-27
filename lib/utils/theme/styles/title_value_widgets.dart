import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';

import 'package:flutter/material.dart';

// title value sapce btween widget
Widget titleValueRowSpaceBtweenWidget(String title, String value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(title, style: AppTextStyles.ts12w400color000000()),
      Text(value, style: AppTextStyles.ts12w600color000000()),
    ],
  );
}

//  topText (dark) bottomText (light) column
Widget valueTitleColumnWidget(String topText, String bottomText) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(topText, style: AppTextStyles.ts14w700colorBlack()),
      Text(bottomText, style: AppTextStyles.ts12w400color000000()),
    ],
  );
}

//  topText (dark) bottomText (light) column
Widget valueTitleColumnWidget2(
  String topText,
  String bottomText, {
  String bottomText2 = "",
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(topText, style: AppTextStyles.ts12w400color000000()),
      Row(
        children: [
          Text(bottomText, style: AppTextStyles.ts14w700colorBlack()),
          bottomText2 == ""
              ? Container()
              : Text(bottomText2, style: AppTextStyles.ts10w600colorBlack()),
        ],
      ),
    ],
  );
}
