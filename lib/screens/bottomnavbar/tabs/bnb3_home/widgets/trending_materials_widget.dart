import 'package:constructo/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_controller.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_model.dart';
import 'package:constructo/screens/bottomnavbar/tabs/common_widgets/viewall_heading_widget.dart';
import 'package:constructo/utils/images/cache_network/cachenetwork_image.dart';
import 'package:constructo/utils/theme/app_colors.dart';
import 'package:constructo/utils/theme/decorations/border_utils.dart';
import 'package:constructo/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

mixin TrendingMaterialsWidget {
  static Widget content(Bnb3HomeController controller) {
    return horzListWithHeading(
      title: 'Trending Materials',
      height: 196.rh,
      itemCount: controller.materials.length,
      itemBuilder: (index) => card(controller.materials[index]),
    );
  }

  static Widget card(HomeMaterialModel material) {
    return Container(
      width: 162.rw,
      padding: EdgeInsets.only(
        left: 4.rw,
        right: 4.rw,
        top: 4.rh,
        bottom: 0.rh,
      ),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: getWidth(),
            height: 109.rh,
            child: Stack(
              children: [
                Positioned.fill(
                  child: clipRRectCustom(
                    material.image,
                    boxfit: BoxFit.contain,
                    containerColor: AppColors.colorF3F3F3,
                    borderR: 10.rr,
                    errorIconTop: Icon(
                      Icons.inventory_2,
                      size: 42.rsp,
                      color: AppColors.colorBFBFBF,
                    ),
                  ),
                ),
                Positioned(
                  left: 6.rw,
                  top: 6.rh,
                  child: _chip('In Stock', AppColors.colorGreenChip, true),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 6.rh,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => Container(
                        width: 7.rh,
                        height: 7.rh,
                        margin: EdgeInsets.symmetric(horizontal: 2.rw),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: index == 0
                              ? AppColors.primary
                              : AppColors.white.withValues(alpha: .75),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          sizedboxHeight(4),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.rw),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _chip(material.category, AppColors.colorF5F5F5, false),

                  Text(
                    material.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.ts12w600color000000(),
                  ),

                  Text(
                    material.detail,
                    style: AppTextStyles.ts12w500color808080(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _chip(String text, Color color, bool whiteText) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 4.rh),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(whiteText ? 100 : 5.rr),
        border: whiteText ? null : borderCustomborderBlack05(),
      ),
      child: Text(
        text,
        style: AppTextStyles.ts10w500colorBlack().copyWith(
          color: whiteText ? AppColors.white : null,
        ),
      ),
    );
  }

  // static TextStyle _text(double size, FontWeight weight, [Color? color]) {
  //   return TextStyle(
  //     fontFamily: 'Lufga',
  //     fontSize: size.rsp,
  //     fontWeight: weight,
  //     color: color ?? AppColors.black,
  //   );
  // }
}
