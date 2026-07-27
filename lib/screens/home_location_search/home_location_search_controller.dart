import 'package:constructo_worker/networking/api/endpoints/location_api_services.dart';
import 'package:constructo_worker/networking/extensions/api_helper.dart';
import 'package:constructo_worker/networking/user/controllers/global_controller.dart';
import 'package:constructo_worker/networking/user/models/user_location_model.dart';
import 'package:constructo_worker/utils/buttons/dropdown_button/dropdown_model.dart';
import 'package:constructo_worker/utils/location/user_location_service.dart';
import 'package:constructo_worker/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeLocationSearchController extends GetxController {
  final GlobalController globalController = Get.find<GlobalController>();
  final TextEditingController searchTextController = TextEditingController();
  final RxList<DropdownModel> searchPlaceList = <DropdownModel>[].obs;
  final Rx<DropdownModel> selectedSearchPlace = DropdownModel().obs;
  final RxBool isLocationDetailLoading = false.obs;
  final RxBool isCurrentLocationLoading = false.obs;
  final RxString searchQuery = ''.obs;

  Future<List<DropdownModel>> getLocationListByAutoComplete(
    String searchText,
  ) async {
    final String query = searchText.trim();
    if (query.isEmpty) {
      searchPlaceList.clear();
      return <DropdownModel>[];
    }
    if (searchQuery.value == query && searchPlaceList.isNotEmpty) {
      return searchPlaceList;
    }

    searchQuery.value = query;
    final Map response = await LocationApiServices.locationAutocomplete({
      'searchText': query,
    });
    final List<DropdownModel> places = <DropdownModel>[];
    if (apiPeramBool(response['success'])) {
      places.addAll(
        apiPeramList(response['data']).map(
          (data) => DropdownModel(
            name: apiPeramString(data['description']),
            value: apiPeramString(data['placeId']),
          ),
        ),
      );
    }
    searchPlaceList.assignAll(places);
    return searchPlaceList;
  }

  Future<void> onSuggestionSelected(DropdownModel? place) async {
    if (place == null) {
      selectedSearchPlace.value = DropdownModel();
      return;
    }
    final String placeId = apiPeramString(place.value);
    if (placeId.isEmpty) return;

    selectedSearchPlace.value = place;
    searchTextController.text = apiPeramString(place.name);
    await _updateLocationByPlaceId(placeId);
  }

  Future<void> _updateLocationByPlaceId(String placeId) async {
    isLocationDetailLoading.value = true;
    try {
      final Map response = await LocationApiServices.locationDetail({
        'placeId': placeId,
      });
      if (apiPeramBool(response['success'])) {
        final UserLocationModel location = UserLocationModel.fromMap(
          apiPeramMap(response['data']),
        );
        if (location.isValid) {
          await _saveLocationAndClose(location);
          return;
        }
      }
      showToastError('Unable to select this location');
    } catch (_) {
      showToastError('Unable to select this location');
    } finally {
      isLocationDetailLoading.value = false;
    }
  }

  Future<void> useDeviceCurrentLocation() async {
    isCurrentLocationLoading.value = true;
    try {
      final String? permissionMessage =
          await UserLocationService.permissionError();
      if (permissionMessage != null) {
        showToastError(permissionMessage);
        return;
      }

      final UserLocationModel location = await UserLocationService.current();
      if (location.isValid) {
        await _saveLocationAndClose(location);
      } else {
        showToastError(
          apiPeramString(
            location.errorMessage,
            initialValue: 'Location not available',
          ),
        );
      }
    } catch (_) {
      showToastError('Location not available');
    } finally {
      isCurrentLocationLoading.value = false;
    }
  }

  Future<void> _saveLocationAndClose(UserLocationModel location) async {
    await globalController.saveUserLocation(location);
    showToastSuccess('Location updated');
    Get.back(result: location);
  }

  @override
  void onClose() {
    searchTextController.dispose();
    super.onClose();
  }
}
