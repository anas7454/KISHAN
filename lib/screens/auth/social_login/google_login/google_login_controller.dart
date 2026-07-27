import 'dart:io';

import 'package:constructo_worker/screens/auth/social_login/social_login_config.dart';
import 'package:constructo_worker/screens/auth/social_login/social_login_model.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleLoginController extends GetxController {
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  bool _isInitialized = false;

  Future<SocialLoginModel> googleLogin(RxBool isLoading) async {
    try {
      isLoading.value = true;
      final String? configurationError = _configurationError();
      if (configurationError != null) {
        return SocialLoginModel()..error = configurationError;
      }

      await _initialize();
      await _googleSignIn.signOut();
      if (!_googleSignIn.supportsAuthenticate()) {
        return SocialLoginModel()
          ..error = 'Google Sign-In is not supported on this device';
      }

      final GoogleSignInAccount account = await _googleSignIn.authenticate();
      final GoogleSignInAuthentication authentication = account.authentication;
      final String idToken = authentication.idToken ?? "";
      if (idToken.isEmpty) {
        return SocialLoginModel()..error = 'Google ID token is not available';
      }

      return SocialLoginModel()
        ..idToken = idToken
        ..signupBy = EnumSignupBy.google;
    } on GoogleSignInException catch (error) {
      return SocialLoginModel()
        ..error = error.code == GoogleSignInExceptionCode.canceled
            ? 'User cancelled login'
            : (error.description ?? 'Google login failed');
    } catch (_) {
      return SocialLoginModel()..error = 'Google login failed';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _initialize() async {
    if (_isInitialized) return;
    await _googleSignIn.initialize(
      clientId: Platform.isIOS ? SocialLoginConfig.googleIosClientId : null,
      serverClientId: SocialLoginConfig.googleServerClientId,
    );
    _isInitialized = true;
  }

  String? _configurationError() {
    if (Platform.isIOS && SocialLoginConfig.googleIosClientId.isEmpty) {
      return 'GOOGLE_IOS_CLIENT_ID is not configured';
    }
    if (SocialLoginConfig.googleServerClientId.isEmpty) {
      return 'GOOGLE_SERVER_CLIENT_ID is not configured';
    }
    return null;
  }

  Future<void> googleLogout() async {
    if (_isInitialized) await _googleSignIn.signOut();
  }
}
