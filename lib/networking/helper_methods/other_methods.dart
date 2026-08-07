import 'dart:convert';

String base64StringEncode(String str) => base64.encode(utf8.encode(str));

String mapToBase64(Map<String, dynamic> map) =>
    base64.encode(utf8.encode(json.encode(map)));
