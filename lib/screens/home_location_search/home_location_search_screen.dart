import 'package:constructo_worker/screens/home_location_search/home_location_search_controller.dart';
import 'package:constructo_worker/networking/user/models/user_location_model.dart';
import 'package:constructo_worker/utils/appbars/appbar_custom.dart';
import 'package:constructo_worker/utils/buttons/dropdown_button/dropdown_search_widget.dart';
import 'package:constructo_worker/utils/images/cache_network/asset_icon_widget.dart';
import 'package:constructo_worker/utils/images/image_utility/common_icons_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/app_sizes.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeLocationSearchScreen extends StatelessWidget {
  HomeLocationSearchScreen({super.key});

  final HomeLocationSearchController controller =
      Get.find<HomeLocationSearchController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: appBarCustom(title: 'Select Location'),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horzontalSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sizedboxHeight(15),
              Obx(
                () => DropDownSearchFieldCustom(
                  hint: 'Search city, area or address',
                  fillColor: AppColors.white,
                  textEditingController: controller.searchTextController,
                  dropdownValue: controller.selectedSearchPlace.value,
                  onSuggestions: controller.getLocationListByAutoComplete,
                  onSuggestionSelected: controller.onSuggestionSelected,
                ),
              ),
              SizedBox(height: 14.rh),
              Obx(
                () => _currentLocationButton(
                  controller.isCurrentLocationLoading.value,
                ),
              ),
              SizedBox(height: 18.rh),
              _currentLocationPreview(),
              const Spacer(),
              Obx(
                () => controller.isLocationDetailLoading.value
                    ? _updatingLocation()
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _currentLocationButton(bool isLoading) {
    return InkWell(
      onTap: isLoading ? null : controller.useDeviceCurrentLocation,
      borderRadius: BorderRadius.circular(10.rr),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.rw, vertical: 13.rh),
        decoration: BoxDecoration(
          color: AppColors.yellowBg,
          borderRadius: BorderRadius.circular(10.rr),
          border: Border.all(color: AppColors.homeCardBorder),
        ),
        child: Row(
          children: [
            isLoading
                ? SizedBox(
                    width: 20.rh,
                    height: 20.rh,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.primary,
                    ),
                  )
                : Icon(
                    Icons.my_location_rounded,
                    color: AppColors.primary,
                    size: 21.rh,
                  ),
            SizedBox(width: 10.rw),
            Text(
              isLoading ? 'Fetching current location...' : 'Use my location',
              style: _text(13, FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _currentLocationPreview() {
    return Obx(() {
      final UserLocationModel location =
          controller.globalController.userLocation.value;
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(14.rw),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.rr),
          border: Border.all(color: AppColors.borderE6E6E6),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                assetImageWidget(
                  CommonIconsUtility.location,
                  color: AppColors.primary,
                  size: 9.rh,
                ),
                sizedboxWidth(5),
                Text('Current app location', style: _text(11, FontWeight.w600)),
              ],
            ),
            SizedBox(height: 5.rh),
            Text(
              location.displayAddress,
              style: _text(12, FontWeight.w400, AppColors.color7D7D7D),
            ),
          ],
        ),
      );
    });
  }

  Widget _updatingLocation() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 12.rh),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.rr),
        border: Border.all(color: AppColors.borderE6E6E6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 18.rh,
            height: 18.rh,
            child: const CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 10.rw),
          Text('Updating location...', style: _text(12, FontWeight.w600)),
        ],
      ),
    );
  }

  TextStyle _text(double size, FontWeight weight, [Color? color]) {
    return TextStyle(
      fontFamily: 'Lufga',
      fontSize: size.rsp,
      fontWeight: weight,
      color: color ?? AppColors.black,
    );
  }
}
