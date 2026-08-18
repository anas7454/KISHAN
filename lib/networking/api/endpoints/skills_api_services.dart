import 'package:constructo_worker/networking/api/app_api_services.dart';

class SkillsApiServices {
  static Future<Map> getSkills() {
    return AppApiServices.apiRequest('/api/skills');
  }

  static Future<Map> getServices(String skillId) {
    return AppApiServices.apiRequest('/api/skills/$skillId/services');
  }
}
