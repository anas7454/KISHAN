import 'package:constructo_worker/networking/api/app_api_services.dart';
import 'package:dio/dio.dart';

class WorkerKycApiServices {
  static Future<Map> _putFormData(String path, Map<String, dynamic> data) {
    return AppApiServices.apiRequest(
      path,
      apiType: EnumApiType.put,
      perms: FormData.fromMap(data),
    );
  }

  static Future<Map> personalInfo(Map<String, dynamic> data) =>
      _putFormData('/api/workers/kyc/personal-info', data);

  static Future<Map> bankInfo(Map<String, dynamic> data) =>
      _putFormData('/api/workers/kyc/bank-info', data);

  static Future<Map> identityDocuments(Map<String, dynamic> data) =>
      _putFormData('/api/workers/kyc/identity-documents', data);

  static Future<Map> liveSelfie(Map<String, dynamic> data) =>
      _putFormData('/api/workers/kyc/live-selfie', data);

  static Future<Map> skillsExperience(Map<String, dynamic> data) =>
      _putFormData('/api/workers/kyc/skills-experience', data);

  static Future<Map> availability(Map<String, dynamic> data) {
    return AppApiServices.apiRequest(
      '/api/workers/kyc/availability',
      apiType: EnumApiType.put,
      perms: data,
    );
  }

  static Future<Map> submit() {
    return AppApiServices.apiRequest(
      '/api/workers/kyc/submit',
      apiType: EnumApiType.post,
    );
  }

  static Future<Map> getPersonalInfo() {
    return AppApiServices.apiRequest('/api/workers/kyc/personal-info');
  }

  static Future<Map> getBankInfo() {
    return AppApiServices.apiRequest('/api/workers/kyc/bank-info');
  }

  static Future<Map> getIdentityDocuments() {
    return AppApiServices.apiRequest('/api/workers/kyc/identity-documents');
  }

  static Future<Map> getLiveSelfie() {
    return AppApiServices.apiRequest('/api/workers/kyc/live-selfie');
  }

  static Future<Map> getSkillsExperience() {
    return AppApiServices.apiRequest('/api/workers/kyc/skills-experience');
  }

  static Future<Map> getAvailability() {
    return AppApiServices.apiRequest('/api/workers/kyc/availability');
  }

  static Future<Map> getSectionStatus(String section) {
    return AppApiServices.apiRequest(
      '/api/workers/kyc/status',
      queryParameter: <String, dynamic>{'section': section},
    );
  }
}
