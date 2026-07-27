import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

mixin UrlLaunchMethods {
  // launch first app , second browser
  static Future<void> launchStringINAppOrBrowser(String url) async {
    final uri = Uri.parse(url);

    // 1️⃣ Try opening in external app (e.g. WhatsApp, PhonePe, Google Maps)
    final bool canOpenInApp = await canLaunchUrl(uri);

    if (canOpenInApp) {
      try {
        final bool launched = await launchUrl(
          uri,
          mode: LaunchMode.externalApplication, // direct app open
        );

        if (launched) return; // already opened in app
      } catch (_) {}
    }

    // 2️⃣ Fallback → open in browser
    try {
      await launchUrl(
        uri,
        mode: LaunchMode.platformDefault, // this opens browser
      );
    } catch (e) {
      throw "Could not launch URL: $e";
    }
  }

  void openWhatsApp(String phoneNumber) async {
    final whatsappUrl = Uri.parse("https://wa.me/$phoneNumber");

    if (await canLaunchUrl(whatsappUrl)) {
      await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch WhatsApp");
    }
  }

  void openPhoneCall(String phoneNumber) async {
    final telUrl = Uri.parse("tel:$phoneNumber");

    if (await canLaunchUrl(telUrl)) {
      await launchUrl(telUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch Phone dialer");
    }
  }

  void openEmail(String email) async {
    // Manual encoding for subject and body
    final emailUrl = Uri.parse(
      'mailto:$email?subject=${Uri.encodeComponent('Support Request')}&body=${Uri.encodeComponent('Hello constructo Team,')}',
    );
    if (await canLaunchUrl(emailUrl)) {
      await launchUrl(emailUrl, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch Email client");
    }
  }

  static Future<void> openYoutubeVideo(String videoId) async {
    final Uri url = Uri.parse("https://www.youtube.com/watch?v=$videoId");

    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication, // direct YouTube app open karega
    )) {
      throw 'Could not launch $url';
    }
  }
}
