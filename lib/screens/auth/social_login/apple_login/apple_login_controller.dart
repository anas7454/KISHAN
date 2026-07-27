import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:constructo_worker/screens/auth/social_login/social_login_model.dart';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AppleLoginController extends GetxController {
  Future<SocialLoginModel> appleLogin(RxBool isLoading) async {
    if (!Platform.isIOS || !await SignInWithApple.isAvailable()) {
      return SocialLoginModel()
        ..error = 'Sign in with Apple is not supported on this device';
    }

    try {
      isLoading.value = true;
      final String rawNonce = _generateNonce();
      final String nonce = sha256.convert(utf8.encode(rawNonce)).toString();
      final AuthorizationCredentialAppleID credential =
          await SignInWithApple.getAppleIDCredential(
            scopes: <AppleIDAuthorizationScopes>[
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            nonce: nonce,
          );
      final String idToken = credential.identityToken ?? "";
      if (idToken.isEmpty) {
        return SocialLoginModel()
          ..error = 'Apple identity token is not available';
      }

      return SocialLoginModel()
        ..idToken = idToken
        ..signupBy = EnumSignupBy.apple;
    } on SignInWithAppleAuthorizationException catch (error) {
      return SocialLoginModel()
        ..error = error.code == AuthorizationErrorCode.canceled
            ? 'User cancelled login'
            : 'Apple login failed';
    } catch (_) {
      return SocialLoginModel()..error = 'Apple login failed';
    } finally {
      isLoading.value = false;
    }
  }

  String _generateNonce([int length = 32]) {
    const String charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final Random random = Random.secure();
    return List<String>.generate(
      length,
      (_) => charset[random.nextInt(charset.length)],
    ).join();
  }
}
