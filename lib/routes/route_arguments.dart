import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';
import 'package:get/get.dart';

class RouteArguments {
  static Map? get _arguments {
    final dynamic arguments = Get.arguments;
    return arguments is Map ? arguments : null;
  }

  static bool get hasArguments => _arguments != null;

  static T? _get<T>(String key) {
    final dynamic value = _arguments?[key];
    return value is T ? value : null;
  }

  static T? get<T>(String key) => _get<T>(key);

  static T getOrDefault<T>(String key, T defaultValue) =>
      _get<T>(key) ?? defaultValue;

  static List<T> getList<T>(String key) {
    final dynamic value = _arguments?[key];
    if (value is! List) return <T>[];
    return value.whereType<T>().toList(growable: false);
  }

  static Map<String, dynamic> getMap(String key) =>
      Map<String, dynamic>.from(apiPeramMap(_get<Map>(key)));
}
