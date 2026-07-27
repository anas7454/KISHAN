import 'package:constructo/utils/common/debug_utils.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

Future<dio.MultipartFile?> getMultipartFileFromXFile(XFile? file) async {
  if (file == null || (file.path.isEmpty && file.name.isEmpty)) return null;
  printDebugCustom("file path-->${file.path}");
  final mimeType =
      lookupMimeType(file.path.isNotEmpty ? file.path : file.name) ??
      'image/jpeg';
  final splitMime = mimeType.contains('/')
      ? mimeType.split('/')
      : ['image', 'jpeg'];
  final safeFileName = file.name.isNotEmpty
      ? file.name
      : 'file_${DateTime.now().millisecondsSinceEpoch}.jpg';

  if (kIsWeb) {
    final bytes = await file.readAsBytes();
    return dio.MultipartFile.fromBytes(
      bytes,
      filename: safeFileName,
      contentType: MediaType(splitMime[0], splitMime[1]),
    );
  } else {
    return await dio.MultipartFile.fromFile(
      file.path,
      filename: safeFileName,
      contentType: MediaType(splitMime[0], splitMime[1]),
    );
  }
}

// Future<List<dio.MultipartFile>> convertRxListToMultipart(
//   RxList<Rx<VerifyUnVerifyModel>> list,
// ) async {
//   printDebugCustom("list-->$list");

//   List<dio.MultipartFile> files = [];

//   // 1️⃣ Pehle verified images
//   for (var item in list) {
//     final path = item.value.imgXFile;

//     // 🚫 Skip network images
//     if (isNetworkImage(path.path)) continue;

//     if (item.value.isVerify.value == true) {
//       final multipartFile = await getMultipartFileFromXFile(path);
//       if (multipartFile != null) {
//         files.add(multipartFile);
//       }
//     }
//   }

//   // 2️⃣ Phir unverified images
//   for (var item in list) {
//     final path = item.value.imgXFile;

//     // 🚫 Skip network images
//     if (isNetworkImage(path.path)) continue;

//     if (item.value.isVerify.value == false) {
//       final multipartFile = await getMultipartFileFromXFile(path);
//       if (multipartFile != null) {
//         files.add(multipartFile);
//       }
//     }
//   }

//   return files;
// }

// -------------------------
