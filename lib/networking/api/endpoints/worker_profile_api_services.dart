import 'package:constructo_worker/networking/api/app_api_services.dart';

class WorkerProfileApiServices {
  static Future<Map> getProfile() {
    return AppApiServices.apiRequest('/api/workers/profile');
  }
}
