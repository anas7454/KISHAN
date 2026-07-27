import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb1_workers/bnb1_workers_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb1_workers/bnb1_workers_model.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/common_widgets/label_widget.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/common_widgets/viewall_heading_widget.dart';
import 'package:constructo_worker/utils/images/cache_network/asset_icon_widget.dart';
import 'package:constructo_worker/utils/images/cache_network/cachenetwork_image.dart';
import 'package:constructo_worker/utils/images/image_utility/common_icons_utility.dart';
import 'package:constructo_worker/utils/images/image_utility/icon_utility.dart';
import 'package:constructo_worker/utils/textfield/textfield_widgets.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:constructo_worker/utils/toast/no_data_found.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin Bnb1WorkersWidgets {
  Widget workersHeader() {
    return Column(
      children: [
        Container(
          color: AppColors.yellowBg,
          padding: EdgeInsets.fromLTRB(12.rw, 28.rh, 12.rw, 14.rh),
          child: SafeArea(
            bottom: false,
            child: CommonTextFields.searchTextfieldhome(
              hintText: 'Search skilled workers, etc',
              fillColor: AppColors.white,
              onFilterTap: () {},
            ),
          ),
        ),
        dividerCustom(color: AppColors.homeCardBorder),
      ],
    );
  }

  Widget workerCategories(Bnb1WorkersController controller) {
    return SizedBox(
      height: 30.rh,
      child: Obx(() {
        final String selectedCategory = controller.selectedCategory.value;
        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 12.rw),
          scrollDirection: Axis.horizontal,
          itemCount: controller.categories.length,
          physics: bouncingScrollPhysicsEffect(),
          separatorBuilder: (_, _) => SizedBox(width: 10.rw),
          itemBuilder: (_, index) {
            final String category = controller.categories[index];
            final bool selected = selectedCategory == category;
            return InkWell(
              onTap: () => controller.selectCategory(category),
              borderRadius: BorderRadius.circular(9.rr),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: EdgeInsets.symmetric(horizontal: 14.rw),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primary.withValues(alpha: .12)
                      : AppColors.white,
                  borderRadius: BorderRadius.circular(9.rr),
                  border: borderCustomDefault(
                    color: selected
                        ? AppColors.primary
                        : AppColors.borderE9E9E9,
                  ),
                ),
                child: Text(
                  category,
                  style: AppTextStyles.ts11w500colorblack(),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget workersGrid(Bnb1WorkersController controller) {
    return Obx(() {
      final List<Bnb1WorkerModel> workers = controller.filteredWorkers;
      if (workers.isEmpty) {
        return noDataFound(text: 'No workers found');
      }

      return GridView.builder(
        padding: EdgeInsets.fromLTRB(12.rw, 4.rh, 12.rw, 20.rh),
        itemCount: workers.length,
        physics: bouncingScrollPhysicsEffect(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.rw,
          mainAxisSpacing: 18.rh,
          mainAxisExtent: 228.rh,
        ),
        itemBuilder: (_, index) => workerCard(workers[index]),
      );
    });
  }

  Widget workerCard(Bnb1WorkerModel worker) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: cardDecoration(radius: 8, boxshadow: false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 126.rh,
            child: Stack(
              fit: StackFit.expand,
              children: [
                clipRRectCustom(
                  worker.image,
                  width: getWidth(),
                  height: 126.rh,
                  boxfit: BoxFit.cover,
                  containerColor: AppColors.colorF3F3F3,
                  errorIconTop: const Icon(Icons.engineering),
                ),
                Positioned(
                  left: 7.rw,
                  top: 7.rh,
                  child: LabelWidget(
                    text: '${worker.rating}',
                    iconData: Icons.star,
                  ),
                ),
                Positioned(
                  left: 7.rw,
                  bottom: 7.rh,
                  child: LabelWidget(
                    text: worker.availability,
                    backgroundColor: AppColors.black,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(9.rw, 0.rh, 9.rw, 0.rh),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              worker.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.ts16w600color000000(),
                            ),
                          ),
                          if (worker.verified) ...[
                            SizedBox(width: 4.rw),
                            assetImageWidget(
                              IconUtility.bluecheck,
                              size: 14.rsp,
                              fallback: Icons.verified,
                              color: AppColors.color00ABE4,
                            ),
                          ],
                        ],
                      ),
                      Text(
                        worker.category,
                        maxLines: 1,
                        style: AppTextStyles.ts12w400color474747(),
                      ),
                    ],
                  ),

                  Row(
                    children: [
                      Text(
                        worker.experience,
                        style: AppTextStyles.ts12w400color474747(),
                      ),
                      SizedBox(width: 4.rw),
                      Flexible(
                        child: Text(
                          worker.price,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.ts11w500color474747(),
                        ),
                      ),
                      Text(" /day", style: AppTextStyles.ts12w400color474747()),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      assetImageWidget(CommonIconsUtility.location, size: 9.rh),
                      SizedBox(width: 3.rw),
                      Expanded(
                        child: Text(
                          worker.location,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.ts12w400color474747(),
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
