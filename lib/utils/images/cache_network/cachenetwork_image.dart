import 'package:cached_network_image/cached_network_image.dart';
import 'package:constructo/networking/core/dio_api.dart';
import 'package:constructo/utils/common/debug_utils.dart';
import 'package:constructo/utils/theme/sizes/responsive_size_utils.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum _ImageSourceType { asset, network, invalid }

_ImageSourceType _detectImageSource(String source) {
  final String imageSource = source.trim();

  if (imageSource.isEmpty ||
      imageSource.toLowerCase() == 'null' ||
      imageSource == 'No Image Found') {
    return _ImageSourceType.invalid;
  }

  final Uri? uri = Uri.tryParse(imageSource);
  if (uri != null &&
      (uri.scheme == 'http' || uri.scheme == 'https') &&
      uri.host.isNotEmpty) {
    return _ImageSourceType.network;
  }

  return _ImageSourceType.asset;
}

Widget clipRRectCustom(
  String imageUrl, {
  double? width,
  double? height,
  double? isCircleWidth,
  BoxBorder? border,
  double? borderR,
  Color? containerColor,
  EdgeInsets? containerpadding,
  BoxFit? boxfit,
  Icon? errorIconTop,
  String? errorImgasset,
  Color? errorImgassetColor,
  String? placeholder,
  // String? loaderImgAsset,
  bool ontap = false,
  bool isProfileType = false,
  // bool isBorder = false,
}) {
  final String imageSource = imageUrl.trim();
  final _ImageSourceType imageSourceType = _detectImageSource(imageSource);
  double borderRadius =
      borderR ?? (isCircleWidth != null ? (isCircleWidth / 2) : 0);

  height = height ?? 100.rh;
  width = width ?? 100.rh;
  // printDebugCustom("image imageUrl----->$imageUrl");
  if (isProfileType) {
    // double borderThikness = ((isCircleWidth != null && isCircleWidth < 51.rh) || (width < 51.rh)) ? 1.5.rh : 2.rh;
    // border = borderProfileBold(context, borderThikness);
    // errorImgasset = AppAssetsImages.dummyuserboy;
    boxfit = BoxFit.fill;
  }
  boxfit =
      boxfit ??
      ((isCircleWidth != null && isCircleWidth < 101.rh) || (width < 101.rh)
          ? BoxFit.fill
          : boxfit);
  // boxfit = boxfit ?? BoxFit.contain;

  // printDebugCustom("imageUrl-->$imageUrl");
  return ClipRRect(
    borderRadius: BorderRadius.circular(borderRadius),
    child: Container(
      height: isCircleWidth ?? height,
      width: isCircleWidth ?? width,
      padding: containerpadding,
      decoration: BoxDecoration(
        border: border,
        color: containerColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: IgnorePointer(
        ignoring: !ontap,
        child: GestureDetector(
          onTap: () {
            if (ontap && imageSourceType != _ImageSourceType.invalid) {
              showImageViewer(
                Get.context!,
                imageSourceType == _ImageSourceType.network
                    ? NetworkImage(imageSource)
                    : AssetImage(imageSource),
                useSafeArea: true,
                swipeDismissible: true,
                doubleTapZoomable: true,
              );
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: imageSourceType == _ImageSourceType.asset
                ? Image.asset(
                    imageSource,
                    fit: boxfit,
                    errorBuilder: (_, _, _) =>
                        errorIconTop ??
                        (errorImgasset == null || errorImgasset.isEmpty
                            ? const Icon(Icons.error, color: Colors.red)
                            : Image.asset(
                                errorImgasset,
                                color: errorImgassetColor,
                                fit: boxfit ?? BoxFit.contain,
                              )),
                  )
                : cachedNetworkImageCustom(
                    imageSource,
                    boxfit: boxfit,
                    errorIconTop: errorIconTop,
                    errorImgasset: errorImgasset ?? "",
                    errorImgassetColor: errorImgassetColor,
                    placeholder: placeholder,
                    width: width,
                    height: height,
                    isCircleWidth: isCircleWidth,
                  ),
          ),
        ),
      ),
    ),
  );
}

Widget cachedNetworkImageCustom(
  String imgUrl, {
  String errorImgasset = '',
  Color? errorImgassetColor,
  Icon? errorIconTop,
  BoxFit? boxfit,
  IconData? errorIcon,
  String? placeholder,
  double? width,
  double? height,
  double? isCircleWidth,
  VoidCallback? onTap,
}) {
  // printDebugCustom("imgUrl imgUrl->$imgUrl");
  return imgUrl == '' ||
          imgUrl == 'null' ||
          imgUrl == 'No Image Found' ||
          imgUrl == DioAPI.imageBaseURL ||
          !imgUrl.contains('.')
      ? errorIconTop ??
            (errorImgasset == ''
                ? const Icon(Icons.error, color: Colors.red)
                : Image.asset(
                    errorImgasset,
                    color: errorImgassetColor,
                    fit: boxfit ?? BoxFit.contain,
                  ))
      : InkWell(
          onTap: onTap,
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            placeholder: (context, url) =>
                placeholder != null && placeholder.isNotEmpty
                ? Image.asset(
                    placeholder,
                    color: errorImgassetColor,
                    fit: boxfit ?? BoxFit.contain,
                    width: isCircleWidth ?? width,
                    height: isCircleWidth ?? height,
                  )
                : Container(),

            //Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) {
              printDebugCustom(
                "cache network image errror ->$error , imgUrl ->$imgUrl",
              );
              return errorImgasset == ''
                  // ignore: prefer_const_constructors
                  ? Icon(
                      errorIcon ?? Icons.error_outline_sharp,
                      color: Colors.red,
                    )
                  : Image.asset(
                      errorImgasset,
                      color: errorImgassetColor,
                      fit: boxfit ?? BoxFit.contain,
                    );
            },
            fit: boxfit ?? BoxFit.contain,
            // 🔥 IMPORTANT – white flash fix
            fadeInDuration: Duration.zero,
            fadeOutDuration: Duration.zero,
            //           cacheManager: CacheManager(
            //   Config(
            //     'carImageCache',
            //     stalePeriod: const Duration(days: 7),
            //     maxNrOfCacheObjects: 200,
            //   ),
            // ),
            // ✅ smooth placeholder
            // placeholder: (context, url) => Container(
            //   width: width,
            //   height: height,
            //   color: Colors.black, // ya Colors.grey.shade200
            // ),
          ),
        );
}

// image perview screen

// class ImagePriviewScreen extends StatelessWidget {
//   const ImagePriviewScreen({super.key, required this.imgUrl});

//   final String imgUrl;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: appbarCustomTitleBackBtn("Image Privew"),

//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,

//         children: [cachedNetworkImageCustom(imgUrl, width: getWidth(), height: 250.rh)],
//       ),
//     );
//   }
// }
