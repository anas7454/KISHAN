import 'package:constructo_worker/networking/api/app_api_services.dart';

class LocationApiServices {
  static Future<Map> getStates() {
    return AppApiServices.apiRequest('/api/locations/states');
  }

  static Future<Map> getCities(String stateId) {
    return AppApiServices.apiRequest('/api/locations/states/$stateId/cities');
  }

  static Future<Map> locationAutocomplete(Map<String, dynamic> rawData) async {
    const String path = "/location-autocomplete";
    return AppApiServices.apiRequest(
      path,
      apiType: EnumApiType.post,
      perms: rawData,
      removeFocus: false,
    );
  }

  static Future<Map> locationDetail(Map<String, dynamic> rawData) async {
    const String path = "/location-detail";
    return AppApiServices.apiRequest(
      path,
      apiType: EnumApiType.post,
      perms: rawData,
      removeFocus: false,
    );
  }
}
