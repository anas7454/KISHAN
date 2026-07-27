import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_controller.dart';
import 'package:constructo_worker/utils/buttons/icon_button_custom.dart';
import 'package:constructo_worker/utils/images/cache_network/asset_icon_widget.dart';
import 'package:constructo_worker/utils/images/image_utility/common_icons_utility.dart';
import 'package:constructo_worker/utils/images/image_utility/icon_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/decorations/border_utils.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

mixin HomeAppbar {
  static Widget content(Bnb3HomeController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: InkWell(
            onTap: AppRoutes.homeLocationSearchScreen,
            borderRadius: BorderRadius.circular(8.rr),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Location', style: AppTextStyles.ts14w600colorBlack()),
                SizedBox(height: 2.rh),
                Obx(() {
                  final location =
                      controller.globalController.userLocation.value;
                  final loading =
                      controller.globalController.isLocationLoading.value;
                  return Row(
                    children: [
                      assetImageWidget(CommonIconsUtility.location, size: 9.rh),
                      SizedBox(width: 3.rw),
                      Flexible(
                        child: Text(
                          loading
                              ? 'Finding your location...'
                              : location.displayAddress,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.ts10w400color7D7D7D(),
                        ),
                      ),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 15.rsp,
                        color: AppColors.color7D7D7D,
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
        ),
        iconButtonCustomRounded(CommonIconsUtility.homeCart, onPressed: () {}),
        SizedBox(width: 10.rw),
        iconButtonCustomRounded(
          CommonIconsUtility.notification,

          onPressed: () {},
        ),
      ],
    );
  }
}
