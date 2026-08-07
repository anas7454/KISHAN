import 'package:constructo_worker/networking/helper_methods/api_get_helper.dart';

String getRespMessageFromApi(
  dynamic resp, {
  String? initialValue,
  bool isDataShow = false,
  String msg = "",
}) {
  try {
    if (msg != "") {
      return msg;
    }
    String dataString = "";

    if (resp.containsKey("data") && isDataShow == true) {
      dataString = apiPeramString(resp["data"]);

      if (dataString == "{}" ||
          dataString == "[]" ||
          dataString.toLowerCase() == "null") {
        dataString = "";
      }
    }
    if (resp.containsKey("msg")) {
      return apiPeramString(resp["msg"]) + dataString;
    } else if (resp.containsKey("message")) {
      return apiPeramString(resp["message"]) + dataString;
    } else if (resp.containsKey("error")) {
      return apiPeramString(resp["error"]) + dataString;
    }
    return initialValue ?? resp.toString();
  } catch (e) {
    return initialValue ?? resp.toString();
  }
}
