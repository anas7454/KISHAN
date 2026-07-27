// ignore_for_file: avoid_print, prefer_const_constructors
import 'package:constructo/networking/core/dio_api.dart';
import 'package:constructo/networking/user/controllers/user_controller.dart';
import 'package:constructo/utils/common/debug_utils.dart';
import 'package:constructo/utils/common/focus_utils.dart';
import 'package:constructo/utils/internet_connectivity_service/connectivity_service.dart';
import 'package:constructo/utils/toast/toast.dart';
import 'package:get/instance_manager.dart';
import 'package:dio/dio.dart';

enum EnumApiType { get, post, put, patch, delete }

String getApiName(EnumApiType apiType) {
  switch (apiType) {
    case EnumApiType.get:
      return "GET";
    case EnumApiType.post:
      return "POST";
    case EnumApiType.put:
      return "PUT";
    case EnumApiType.delete:
      return "DELETE";
    case EnumApiType.patch:
      return "PATCH";
  }
}

class AppApiServices {
  static final UserController _authController = Get.find();

  // 🔹 API Base URL
  static String apiBaseURL = DioAPI.apiBaseURL; // apna base URL daalo
  // static String apiBaseURL2 = DioAPI.apiBaseURL2; // apna base URL daalo

  // 🔹 Dio instance
  static Dio? _dio;
  static Dio getDioInstance() {
    _dio ??= Dio(
      BaseOptions(
        baseUrl: apiBaseURL,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        responseType: ResponseType.json,
      ),
    );
    return _dio!;
  }

  // static Dio? _dio2;
  // static Dio getDioInstance2() {
  //   _dio2 ??= Dio(
  //     BaseOptions(
  //       baseUrl: apiBaseURL2,
  //       connectTimeout: const Duration(seconds: 15),
  //       receiveTimeout: const Duration(seconds: 15),
  //       responseType: ResponseType.json,
  //     ),
  //   );
  //   return _dio2!;
  // }

  // -------------------- Session Expire Handle --------------------
  //  401 - unauthrize
  static Future<void> isSesssionExpired(
    Response res,
    String printApiPath,
  ) async {
    bool isSessionExpire = false;

    if ((res.statusCode == 403 || res.statusCode == 401) &&
        isSessionExpire == false) {
      isSessionExpire = true;
      printDebugCustom(
        'jwt token ==>${_authController.userData.value.jwtToken}',
      );
      printDebugCustom("Session Expire -->$printApiPath");

      showToastError("Session Expire code ${res.statusCode}");
      _authController.logout(showToastMsg: 'Session Expired', isApiCall: false);
      await Future.delayed(Duration(seconds: 100));
      isSessionExpire = false;
    }
  }

  // -------------------- Common API Request --------------------
  static Future<Map> apiRequest(
    String path, {
    EnumApiType apiType = EnumApiType.get,
    Map<String, dynamic>? queryParameter,
    dynamic perms, // Map<String, dynamic> or formdata
    CancelToken? cancelToken,
    bool isPrint = true,
    bool isbaseurl2Use = false,
    bool removeFocus = true,
    bool checkInternet = true,
  }) async {
    if (removeFocus) {
      removeFocusTwo();
    }

    Map res = {
      "success": false,
      "statusCode": 444,
      "msg": "Something went wrong, please try again later!!.",
    };
    try {
      // 1. check internet
      if (checkInternet) {
        final bool isOnline =
            await ConnectivityService.checkInternetConnection();
        if (isOnline == false) {
          return {
            "success": false,
            "msg": "Please check your internet connection and try again later.",
          };
        }
      }
      // 2. get dio instance
      final Dio dio = getDioInstance();
      await Future.delayed(Duration(milliseconds: 50));

      // 3. api request
      Response? response;
      Map<String, dynamic> header = {
        // "authorization": _authController.userData.value.jwtToken, // carosa
        "Authorization": "Bearer ${_authController.userData.value.jwtToken}",
        "Content-Type": "application/json",
      }; //  "Content-Type": perms is FormData ? "multipart/form-data"  : "application/json",
      Options basicOptions = Options(
        headers: header,
        responseType: ResponseType.json,
        validateStatus: (int? status) {
          return true;
        },
        // sendTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      );

      if (apiType == EnumApiType.get) {
        response = await dio.get(
          path,
          queryParameters: queryParameter,
          data: perms,
          options: basicOptions,
          cancelToken: cancelToken,
        );
      } else if (apiType == EnumApiType.post) {
        response = await dio.post(
          path,
          queryParameters: queryParameter,
          data: perms,
          options: basicOptions,
          cancelToken: cancelToken,
        );
      } else if (apiType == EnumApiType.put) {
        response = await dio.put(
          path,
          data: perms,
          queryParameters: queryParameter,
          options: basicOptions,
          cancelToken: cancelToken,
        );
      } else if (apiType == EnumApiType.patch) {
        response = await dio.patch(
          path,
          data: perms,
          queryParameters: queryParameter,
          options: basicOptions,
          cancelToken: cancelToken,
        );
      } else if (apiType == EnumApiType.delete) {
        response = await dio.delete(
          path,
          queryParameters: queryParameter,
          data: perms,
          options: basicOptions,
          cancelToken: cancelToken,
        );
      }

      String apiTypeString = getApiName(apiType);
      if (response == null) {
        String printApiPath =
            // 'statusCode -> ${response.statusCode} ,  $apiTypeString api path ===> $apiBaseURL$path, peram ==> $perms, queryParameter ==> $queryParameter,header =>$header';
            'ERROR: $apiTypeString api  ===> $apiBaseURL$path peram ==> $perms, queryParameter ==> $queryParameter ';
        printDebugCustomRed(printApiPath);
        return res;
      }
      String printApiPath =
          // 'statusCode -> ${response.statusCode} ,  $apiTypeString api path ===> $apiBaseURL$path, peram ==> $perms, queryParameter ==> $queryParameter,header =>$header';
          '$apiTypeString api  ===> $apiBaseURL$path statusCode -> ${response.statusCode} ,  peram ==> $perms, queryParameter ==> $queryParameter ,response ===> ${response.data}';
      await isSesssionExpired(response, printApiPath);

      if (isPrint) {
        printDebugCustom(
          '$apiTypeString jwt token ==>${_authController.userData.value.jwtToken}',
        );
        printDebugCustom(printApiPath);
        // printDebugCustom("response ===> ${response.data}");
      } else {
        printDebugCustom('$apiTypeString api path ===> $apiBaseURL$path');
      }

      res = response.data;
      res["statusCode"] = response.statusCode;
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout) {
        print('Connection timeout: ${e.message}');
      } else if (e.type == DioExceptionType.receiveTimeout) {
        print('Receive timeout: ${e.message}');
      } else if (e.type == DioExceptionType.connectionError) {
        print('Connection error: ${e.message}');
      } else {
        print('Unhandled Dio error: ${e.message}');
      }

      print('api error: ${e.message}');
      return res;
    } catch (e) {
      print('Unexpected error: $e');
    }

    return res;
  }
}
