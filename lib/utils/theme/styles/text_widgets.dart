import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

Widget headingWidget25w700Auth(String text) {
  return Text(text, style: AppTextStyles.ts25w700color000000());
}

Widget textWidget23w600Heading(String text) {
  return Text(text, style: AppTextStyles.ts23w600color000000ClashDisplay());
}

Widget textWidget20w600Heading(String text) {
  return Text(text, style: AppTextStyles.ts20w600color000000ClashDisplay());
}

Widget textWidget25w600Heading(String text) {
  return Text(text, style: AppTextStyles.ts25w600color000000ClashDisplay());
}

Widget bodyTextWidget14w400Auth(String text) {
  return Text(text, style: AppTextStyles.ts12_8w400colorBFBFBF());
}

Widget tw14w700RichTextHomeScreen(
  String text1,
  String text2, {
  String text3 = "",
  bool removeSpaceBwText1and2 = false,
  bool removeSpaceBwText2and3 = false,
}) {
  return RichText(
    textAlign: TextAlign.start,
    text: TextSpan(
      children: [
        TextSpan(
          text: removeSpaceBwText1and2 ? text1 : "$text1 ",
          style: AppTextStyles.ts14w700colorBlack().copyWith(
            color: AppColors.primary,
          ),
        ),
        TextSpan(
          text: text2,
          style: AppTextStyles.ts14w700colorBlack().copyWith(
            color: AppColors.secondry,
          ),
        ),
        if (text3 != "") ...{
          TextSpan(
            text: removeSpaceBwText2and3 ? text3 : " $text3",
            style: AppTextStyles.ts14w700colorBlack().copyWith(
              color: AppColors.primary,
            ),
          ),
        },
      ],
    ),
  );
}

Widget tw14w700RichTextDetailScreen(String text1, String text2, String text3) {
  return RichText(
    textAlign: TextAlign.start,
    text: TextSpan(
      children: [
        TextSpan(
          text: text1,
          style: AppTextStyles.ts14w700colorBlack().copyWith(
            color: AppColors.primary,
          ),
        ),
        TextSpan(
          text: text2,
          style: AppTextStyles.ts14w700colorBlack().copyWith(
            color: AppColors.secondry,
          ),
        ),
        TextSpan(
          text: text3,
          style: AppTextStyles.ts14w700colorBlack().copyWith(
            color: AppColors.primary,
          ),
        ),
      ],
    ),
  );
}

Widget tw14w700TextHomeScreen(String text1) {
  return RichText(
    textAlign: TextAlign.start,
    text: TextSpan(
      children: [
        TextSpan(
          text: "$text1 ",
          style: AppTextStyles.ts14w700colorBlack().copyWith(
            color: AppColors.primaryLight0C3E8B,
          ),
        ),
      ],
    ),
  );
}

Widget textWidgetHeadingAuth() {
  return RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: "Start your Journey with ",
          style: AppTextStyles.ts25w700color000000(),
        ),
        TextSpan(
          text: "Bhar",
          style: AppTextStyles.ts25w700color000000().copyWith(
            color: AppColors.primary,
          ),
        ),
        TextSpan(
          text: "osa",
          style: AppTextStyles.ts25w700color000000().copyWith(
            color: AppColors.secondry,
          ),
        ),
      ],
    ),
  );
}
