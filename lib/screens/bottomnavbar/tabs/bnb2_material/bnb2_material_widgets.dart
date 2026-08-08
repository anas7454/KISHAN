import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/screens/bottomnavbar/tabs/bnb2_material/bnb2_material_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/widgets/request_card_widget.dart';
import 'package:constructo_worker/utils/images/cache_network/asset_icon_widget.dart';
import 'package:constructo_worker/utils/images/image_utility/common_icons_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin Bnb2MaterialWidgets {
  // Top Location Header
  Widget requestsHeader(BuildContext context, Bnb2MaterialController controller, {String title = 'Requests'}) {
    return Container(
      color: AppColors.yellowBg,
      padding: EdgeInsets.only(
        left: 16.rw,
        right: 16.rw,
        top: MediaQuery.paddingOf(context).top + 8.rh,
        bottom: 12.rh,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: InkWell(
              onTap: AppRoutes.homeLocationSearchScreen,
              borderRadius: BorderRadius.circular(8.rr),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Location',
                    style: AppTextStyles.ts14w600colorBlack().copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.rh),
                  Obx(() {
                    final location = controller.globalController.userLocation.value;
                    final loading = controller.globalController.isLocationLoading.value;
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        assetImageWidget(CommonIconsUtility.location, size: 10.rh),
                        SizedBox(width: 4.rw),
                        Flexible(
                          child: Text(
                            loading ? 'Finding your location...' : (location.displayAddress.isNotEmpty ? location.displayAddress : 'Patna Bihar, 245768'),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.ts10w400color7D7D7D().copyWith(
                              fontSize: 11.rsp,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 16.rsp,
                          color: AppColors.color7D7D7D,
                        ),
                      ],
                    );
                  }),
                ],
              ),
            ),
          ),
          // Wallet / Passbook button
          Container(
            width: 36.rw,
            height: 36.rh,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderE6E6E6, width: 1.rsp),
            ),
            child: Icon(
              Icons.account_balance_wallet_outlined,
              color: AppColors.black,
              size: 19.rsp,
            ),
          ),
          sizedboxWidth(8),
          // Notification button
          Container(
            width: 36.rw,
            height: 36.rh,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderE6E6E6, width: 1.rsp),
            ),
            child: Icon(
              Icons.notifications_none_rounded,
              color: AppColors.black,
              size: 20.rsp,
            ),
          ),
        ],
      ),
    );
  }

  // Filter Tabs Row
  Widget filterTabsRow(Bnb2MaterialController controller, {bool showAll = true}) {
    return Obx(() {
      final currentFilter = controller.selectedFilter.value;
      if (showAll) {
        // Requests tab: All, New, Accepted, Rejected
        return Row(
          children: [
            Expanded(child: _filterPill(controller, "All", RequestFilterTab.all, currentFilter == RequestFilterTab.all)),
            sizedboxWidth(8),
            Expanded(child: _filterPill(controller, "New", RequestFilterTab.newReq, currentFilter == RequestFilterTab.newReq)),
            sizedboxWidth(8),
            Expanded(child: _filterPill(controller, "Accepted", RequestFilterTab.accepted, currentFilter == RequestFilterTab.accepted)),
            sizedboxWidth(8),
            Expanded(child: _filterPill(controller, "Rejected", RequestFilterTab.rejected, currentFilter == RequestFilterTab.rejected)),
          ],
        );
      } else {
        // My Work tab: Accepted, Rejected only
        return Row(
          children: [
            Expanded(child: _filterPill(controller, "Accepted", RequestFilterTab.accepted, currentFilter == RequestFilterTab.accepted)),
            sizedboxWidth(8),
            Expanded(child: _filterPill(controller, "Rejected", RequestFilterTab.rejected, currentFilter == RequestFilterTab.rejected)),
          ],
        );
      }
    });
  }

  Widget _filterPill(
    Bnb2MaterialController controller,
    String label,
    RequestFilterTab tab,
    bool isSelected,
  ) {
    return InkWell(
      onTap: () => controller.changeFilter(tab),
      borderRadius: BorderRadius.circular(8.rr),
      child: Container(
        height: 30.rh,
        alignment: Alignment.center,
        padding: EdgeInsets.only(
          top: 8.rh,
          right: 10.rw,
          bottom: 8.rh,
          left: 10.rw,
        ),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xffFEFCFA) : AppColors.white,
          borderRadius: BorderRadius.circular(8.rr),
          border: Border.all(
            color: isSelected ? const Color(0xffFFCC00) : const Color(0xffE6E6E6),
            width: 1.rsp,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            label,
            style: AppTextStyles.ts12w500colorBlack().copyWith(
              fontSize: 11.5.rsp,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              color: isSelected ? const Color(0xffFFCC00) : const Color(0xff333333),
            ),
          ),
        ),
      ),
    );
  }

  // Requests List
  Widget requestsList(Bnb2MaterialController controller) {
    return Obx(() {
      final requests = controller.filteredRequests;
      if (requests.isEmpty) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 40.rh),
          child: Center(
            child: Text(
              "No requests found",
              style: AppTextStyles.ts14w600colorBlack().copyWith(
                color: AppColors.color7D7D7D,
              ),
            ),
          ),
        );
      }
      return Column(
        children: requests.map((item) {
          return workerRequestCard(
            title: item.title,
            requestId: item.requestId,
            date: item.date,
            startDate: item.startDate,
            amount: item.amount,
            address: item.address,
            status: item.status,
            onTap: () => AppRoutes.requestDetailsScreen(),
            onAccept: () {
              Get.snackbar("Request Accepted", "Accepted ${item.title}");
            },
            onReject: () {
              Get.snackbar("Request Rejected", "Rejected ${item.title}");
            },
            onViewMap: () {},
          );
        }).toList(),
      );
    });
  }
}
