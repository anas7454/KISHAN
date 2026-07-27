import 'package:constructo/routes/app_routes.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_controller.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb3_home/widgets/home_appbar.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb3_home/widgets/material_categories_widget.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb3_home/widgets/quick_categories_widget.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb3_home/widgets/trending_materials_widget.dart';
import 'package:constructo/utils/buttons/cta_button/button_custom.dart';
import 'package:constructo/utils/buttons/icon_button_custom.dart';
import 'package:constructo/utils/images/cache_network/asset_icon_widget.dart';
import 'package:constructo/utils/images/image_utility/background_images_utility.dart';
import 'package:constructo/utils/images/image_utility/icon_utility.dart';
import 'package:constructo/utils/images/image_utility/image_utility.dart';
import 'package:constructo/utils/textfield/textfield_widgets.dart';
import 'package:constructo/utils/theme/app_colors.dart';
import 'package:constructo/utils/theme/sizes/app_sizes.dart';
import 'package:constructo/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widgets/skilled_workers_widget.dart';

mixin Bnb3HomeWidgets {
  Widget homeHeader(BuildContext context, Bnb3HomeController controller) {
    const List services = [
      ('Materials', IconUtility.homeMaterials),
      ('Workers', IconUtility.homeWorkers),
      ('Bulk Orders', IconUtility.homeBulkOrders),
      ('Vendors', IconUtility.homeVendors),
    ];

    return SizedBox(
      height: 216.rh + 41.rh,
      // color: AppColors.primaryLight0C3E8B,
      child: Stack(
        alignment: AlignmentGeometry.bottomEnd,
        children: [
          Column(
            children: [
              Container(
                width: getWidth(),
                height: 216.rh,
                decoration: BoxDecoration(color: AppColors.yellowBg),
              ),
              dividerCustom(color: AppColors.homeCardBorder),
            ],
          ),

          SafeArea(
            bottom: false,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 12.rw,
              ).copyWith(top: 10.rh),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // SizedBox(height: 12.rh),
                  HomeAppbar.content(controller),
                  // SizedBox(height: 14.rh),
                  CommonTextFields.searchTextfieldhome(
                    hintText: 'Search materials, skilled workers, etc',
                    fillColor: AppColors.white,
                    onChanged: (value) {},
                  ),

                  // SizedBox(height: 20.rh),
                  QuickCategoriesWidget.content(services),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget offerBanner() {
    return Container(
      width: getWidth(),
      height: 170.rh,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        image: decorationImageCustom(BackgroundImagesUtility.homeserivebooking),
        borderRadius: borderRadius15(),
        border: borderCustomDefault(),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15.rw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.rw, vertical: 4.rh),
              decoration: BoxDecoration(
                color: AppColors.white,
                border: Border.all(color: AppColors.borderE6E6E6),
                borderRadius: BorderRadius.circular(4.rr),
              ),
              child: Text(
                'Promo: FIRT20',
                style: AppTextStyles.ts8w500colorBlack(),
              ),
            ),
            SizedBox(height: 8.rh),
            SizedBox(
              width: 230.rw,
              child: Text(
                'Get 20% OFF on Your\nFirst Service Booking',
                style: AppTextStyles.ts18w700color000000(),
              ),
            ),
            SizedBox(height: 5.rh),
            Text(
              'Save more on premium construction materials.',
              style: AppTextStyles.ts9w400color5C5C5C().copyWith(
                fontSize: 8.rsp,
              ),
            ),
            sizedboxHeight(10),
            Button(
              name: 'Book Now',
              flexibleWidth: true,
              width: 75.rw,
              height: 24.rh,
              horizontalPadding: 2.rw,
              borderRadiusDouble: 5.rr,
              fontsize: 10.rsp,
              fontWeight: FontWeight.w500,

              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
