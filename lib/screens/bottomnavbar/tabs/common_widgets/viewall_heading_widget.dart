import 'package:constructo/utils/buttons/text_button_custom.dart';
import 'package:constructo/utils/theme/app_colors.dart';
import 'package:constructo/utils/theme/decorations/border_utils.dart';
import 'package:constructo/utils/theme/decorations/decoration_utils.dart';
import 'package:constructo/utils/theme/sizes/layout_utils.dart';
import 'package:constructo/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

// viewall heading + horzontal listview builder

Widget horzListWithHeading({
  required String title,
  required double height,
  required int itemCount,
  required Widget Function(int index) itemBuilder,
}) {
  return Column(
    children: [
      ViewAllButtonRowWidget(title: title, onViewAll: () {}),
      SizedBox(height: 6.rh),
      SizedBox(
        height: height + 10.rh,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: itemCount,
          physics: bouncingScrollPhysicsEffect(),

          separatorBuilder: (_, _) => SizedBox(width: 10.rw),
          itemBuilder: (_, index) => Container(
            margin: EdgeInsets.only(bottom: 10.rh),
            child: itemBuilder(index),
          ),
        ),
      ),
    ],
  );
}

BoxDecoration cardDecoration({double radius = 12, bool boxshadow = true}) =>
    BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(radius.rr),
      border: borderCustomColorE6E6E6(),
      boxShadow: boxshadow ? boxShadowCard() : null,
    );

// view all row
class ViewAllButtonRowWidget extends StatelessWidget {
  final String title;
  final VoidCallback onViewAll;

  const ViewAllButtonRowWidget({
    super.key,
    required this.title,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.ts14w500colorBlack()),
        TextButtonCustom(
          btnName: "View All",
          onPressed: onViewAll,
          horizontalPadding: 12.rw,
          textStyle: AppTextStyles.ts11w400colorPrimary(),
        ),
      ],
    );
  }
}
