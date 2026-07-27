import 'package:constructo/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_controller.dart';
import 'package:constructo/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_model.dart';
import 'package:constructo/screens/bottomnavbar/tabs/common_widgets/viewall_heading_widget.dart';
import 'package:constructo/utils/images/cache_network/cachenetwork_image.dart';
import 'package:constructo/utils/images/image_utility/dummy_images_utility.dart';
import 'package:constructo/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

mixin MaterialCategoriesWidget {
  // horz list view all heading
  static Widget content(Bnb3HomeController controller) {
    return horzListWithHeading(
      title: 'Materials Categories',
      height: 87.rh,
      itemCount: controller.categories.length,

      itemBuilder: (index) =>
          MaterialCategoriesWidget.card(controller.categories[index]),
    );
  }

  static Widget card(HomeCategoryModel category) {
    return Container(
      width: 94.rw,
      padding: EdgeInsets.symmetric(vertical: 8.rh),
      decoration: cardDecoration(radius: 8.rr, boxshadow: false),
      child: Column(
        children: [
          // clipRRectCustom(category.image),
          clipRRectCustom(
            DummyImagesUtility.cement,
            width: 62.rw,
            height: 43.rh,
          ),

          Expanded(
            child: Center(
              child: Text(
                category.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.ts14w500colorBlack(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
