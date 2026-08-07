import 'package:constructo_worker/utils/common/debug_utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

Future<dio.MultipartFile?> getMultipartFileFromXFile(XFile? file) async {
  if (file == null || (file.path.isEmpty && file.name.isEmpty)) return null;
  printDebugCustom('file path-->${file.path}');
  final String mimeType =
      lookupMimeType(file.path.isNotEmpty ? file.path : file.name) ??
      'image/jpeg';
  final List<String> splitMime = mimeType.contains('/')
      ? mimeType.split('/')
      : ['image', 'jpeg'];
  final String safeFileName = file.name.isNotEmpty
      ? file.name
      : 'file_${DateTime.now().millisecondsSinceEpoch}.jpg';

  if (kIsWeb) {
    return dio.MultipartFile.fromBytes(
      await file.readAsBytes(),
      filename: safeFileName,
      contentType: MediaType(splitMime[0], splitMime[1]),
    );
  }
  return dio.MultipartFile.fromFile(
    file.path,
    filename: safeFileName,
    contentType: MediaType(splitMime[0], splitMime[1]),
  );
}
