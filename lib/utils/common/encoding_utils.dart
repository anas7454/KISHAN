import 'dart:convert';

String base64StringEncode(String str) {
  final bytes = utf8.encode(str);
  return base64.encode(bytes);
}

String mapToBase64(Map<String, dynamic> map) {
  final jsonString = json.encode(map);
  final jsonBytes = utf8.encode(jsonString);
  return base64.encode(jsonBytes);
}
