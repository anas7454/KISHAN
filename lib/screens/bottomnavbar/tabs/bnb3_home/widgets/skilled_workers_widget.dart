import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb3_home/bnb3_home_model.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/common_widgets/label_widget.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/common_widgets/viewall_heading_widget.dart';
import 'package:constructo_worker/utils/images/cache_network/asset_icon_widget.dart';
import 'package:constructo_worker/utils/images/cache_network/cachenetwork_image.dart';
import 'package:constructo_worker/utils/images/image_utility/dummy_images_utility.dart';
import 'package:constructo_worker/utils/images/image_utility/icon_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/decorations/border_radius_utils.dart';
import 'package:constructo_worker/utils/theme/decorations/decoration_utils.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:constructo_worker/utils/theme/widgets/container_widgets.dart';
import 'package:flutter/material.dart';

mixin SkilledWorkersWidget {
  static Widget content(Bnb3HomeController controller) {
    return horzListWithHeading(
      title: 'Skilled Workers',
      height: 183.rh,
      itemCount: controller.workers.length,
      itemBuilder: (index) => card(controller.workers[index]),
    );
  }

  static Widget card(HomeWorkerModel worker) {
    return Container(
      width: 153.rw,
      // padding: EdgeInsets.all(11.rw),
      decoration: cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sizedboxHeight(10),
          Align(
            child: Container(
              width: 95.rh,
              height: 95.rh,
              padding: EdgeInsets.all(1.rh),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary),
                color: Colors.grey.withValues(alpha: 0.2),
              ),
              child: clipRRectCustom(
                // worker.image,
                DummyImagesUtility.workerprofile,
                errorIconTop: Icon(Icons.person),
              ),
            ),
          ),
          // sizedboxHeight(10),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.rw),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          worker.name,
                          maxLines: 1,
                          style: AppTextStyles.ts16w600color000000(),
                        ),
                      ),
                      LabelWidget(
                        text: '${worker.rating}',
                        backgroundColor: AppColors.yellowBg,
                        foregroundColor: AppColors.black,
                        iconAsset: IconUtility.star,
                        iconSize: 10.rw,
                        iconSpacing: 3.rw,
                      ),
                    ],
                  ),
                  Text(
                    worker.trade,
                    style: AppTextStyles.ts12w400color474747(),
                  ),

                  Row(
                    children: [
                      assetImageWidget(IconUtility.bluecheck, size: 11.rh),
                      sizedboxWidth(5),
                      Text(
                        'Verified Workers',
                        style: AppTextStyles.ts12w400color000000().copyWith(
                          color: AppColors.color00ABE4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
