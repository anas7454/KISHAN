// ignore_for_file: must_be_immutable
import 'package:constructo/utils/buttons/dropdown_button/dropdown_model.dart';
import 'package:constructo/utils/theme/app_colors.dart';
import 'package:constructo/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPopupMenuButton extends StatelessWidget {
  /// Any button widget

  /// Titles list (dynamic / changeable)
  final List<DropdownModel> titles;
  Rx<DropdownModel> seletcedItem;
  double? btnWidth;

  /// Selected index callback
  final ValueChanged<int> onSelected;

  final Offset offset;
  final Color? color;
  final ShapeBorder? shape;

  CustomPopupMenuButton({
    super.key,

    required this.titles,
    required this.seletcedItem,
    required this.onSelected,
    this.offset = Offset.zero,
    this.color,
    this.shape,
    this.btnWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => PopupMenuButton<int>(
        // offset: offset,
        // color: color,
        // shape: shape,
        offset: offset,
        // elevation: 4,
        color: Colors.white,
        menuPadding: EdgeInsets.symmetric(vertical: 0),
        padding: EdgeInsets.all(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.rr),
        ),
        onSelected: (index) {
          seletcedItem.value = titles[index];
          onSelected(index);
        },

        itemBuilder: (context) {
          return List.generate(titles.length, (index) {
            final bool isSelected = titles.any((e) => e == seletcedItem.value);

            return PopupMenuItem<int>(
              value: index,
              padding: EdgeInsets.zero,
              height: 0,
              child: Column(
                children: [
                  InkWell(
                    splashColor: Colors.blue.withValues(alpha: 0.15),
                    highlightColor: Colors.blue.withValues(alpha: 0.08),
                    onTap: () {
                      Navigator.pop(context);
                      seletcedItem.value = titles[index];
                      onSelected(index);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                      ).copyWith(top: 10.rh, bottom: 10.rh),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors
                                  .scafoldBg // selected bg
                            : Colors.transparent,
                        borderRadius: BorderRadius.vertical(
                          top: index == 0
                              ? const Radius.circular(10)
                              : Radius.zero,
                          bottom: index == titles.length - 1
                              ? const Radius.circular(10)
                              : Radius.zero,
                        ),
                      ),
                      child: Text(
                        titles[index].name ?? "-",
                        style: AppTextStyles.ts12w600color000000(),
                        //  TextStyle(
                        //   fontSize: 13,
                        //   fontWeight: FontWeight.w500,
                        //   color: isSelected ? Colors.blue : Colors.black87,
                        // ),
                      ),
                    ),
                  ),

                  /// Divider (except last item)
                  if (index != titles.length - 1)
                    Divider(
                      height: 1,
                      color: AppColors.colorEEEEEE,
                      thickness: 0.6,
                    ),
                ],
              ),
            );
          });
        },

        /// Button UI
        child: Container(
          width: btnWidth,
          padding: EdgeInsets.symmetric(horizontal: 10.rw, vertical: 5.rh),
          decoration: BoxDecoration(
            border: borderCustomColorE6E6E6(),
            borderRadius: borderRadiusDefault(5.rr),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                seletcedItem.value.name ?? "-",
                style: AppTextStyles.ts12w600color000000(),
              ),
              sizedboxWidth(6),
              // SizedBox(
              //   width: 10.rh,
              //   height: 7.rh,
              //   child: Image.asset(ImageUtility.filterarrowdown),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
