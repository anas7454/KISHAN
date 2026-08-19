import 'package:constructo_worker/networking/api/app_api_services.dart';

class AuthApiServices {
  static Future<Map> logout() {
    return AppApiServices.apiRequest(
      '/api/auth/logout',
      apiType: EnumApiType.post,
    );
  }

  static Future<Map> sendOtpLogin(Map<String, dynamic> rawData) async {
    const path = "/api/auth/custom/send-otp?role=WORKER";
    return AppApiServices.apiRequest(
      path,
      apiType: EnumApiType.post,
      perms: rawData,
    );
  }

  static Future<Map> verifyOtpLogin(Map<String, dynamic> data) async {
    const path = "/api/auth/custom/verify-otp";
    return AppApiServices.apiRequest(
      path,
      apiType: EnumApiType.post,
      perms: data,
    );
  }

  static Future<Map> resendOtpLogin(String identifier) {
    const String path = '/api/auth/custom/resend-otp';
    return AppApiServices.apiRequest(
      path,
      apiType: EnumApiType.post,
      perms: <String, dynamic>{'identifier': identifier},
    );
  }

  static Future<Map> signupSendOtp(String email) async {
    final Map<String, dynamic> rawData = {"email": email};
    const path = "/v1/auth/signup/email/send-otp";
    return AppApiServices.apiRequest(
      path,
      apiType: EnumApiType.post,
      perms: rawData,
    );
  }

  static Future<Map> signupverifyotp(String email, String otp) async {
    final Map<String, dynamic> rawData = {"email": email, "otp": otp};
    const path = "/v1/auth/signup/email/verify-otp";
    return AppApiServices.apiRequest(
      path,
      apiType: EnumApiType.post,
      perms: rawData,
    );
  }

  static Future<Map> signupApi(Map<String, dynamic> data) async {
    const path = "/v1/auth/signup/email/create-user";
    return AppApiServices.apiRequest(
      path,
      apiType: EnumApiType.put,
      perms: data,
    );
  }

  static Future<Map> google(Map<String, dynamic> data) async {
    const path = "/v1/auth/google";
    return AppApiServices.apiRequest(
      path,
      apiType: EnumApiType.post,
      perms: data,
    );
  }

  static Future<Map> apple(Map<String, dynamic> data) async {
    const path = "/v1/auth/apple";
    return AppApiServices.apiRequest(
      path,
      apiType: EnumApiType.post,
      perms: data,
    );
  }

  static Future<Map> accountDelete() async {
    const path = "/v1/auth/delete-account";
    return AppApiServices.apiRequest(path, apiType: EnumApiType.delete);
  }
}
