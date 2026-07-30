import 'package:get/get.dart';

class Bnb5MyProfileController extends GetxController {
  final RxBool isFaceIdEnabled = false.obs;

  void toggleFaceId(bool value) {
    isFaceIdEnabled.value = value;
  }
}
