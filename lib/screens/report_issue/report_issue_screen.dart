import 'package:constructo_worker/utils/appbars/appbar_custom.dart';
import 'package:constructo_worker/utils/images/cache_network/asset_icon_widget.dart';
import 'package:constructo_worker/utils/images/image_utility/icon_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:constructo_worker/utils/url_launchar_methods.dart';
import 'package:flutter/material.dart';

class ReportIssueScreen extends StatelessWidget with UrlLaunchMethods {
  ReportIssueScreen({super.key});

  static const _email = 'support@constructoworker.in';
  static const _phone = '+919876543210';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldBg,
      appBar: appBarCustom(title: 'Report & Issue'),
      body: GridView.count(
        padding: EdgeInsets.fromLTRB(12.rw, 15.rh, 12.rw, 20.rh),
        crossAxisCount: 2,
        crossAxisSpacing: 12.rw,
        mainAxisSpacing: 12.rh,
        mainAxisExtent: 156.rh,
        children: [
          _card(
            IconUtility.reportEmailSupport,
            'Email Support',
            'Get help via email',
            _email,
            () => openEmail(_email),
          ),
          _card(
            IconUtility.reportPhoneSupport,
            'Phone Support',
            'Call us directly',
            '+91 98765 43210',
            () => openPhoneCall(_phone),
          ),
          _card(
            IconUtility.reportWhatsapp,
            'WhatsApp',
            'Chat with us on WhatsApp',
            '+91 98765 43210',
            () => openWhatsApp(_phone),
          ),
          _card(
            IconUtility.reportBusinessHours,
            'Business Hours',
            'Sunday - Thursday',
            '9:00 AM - 6:00 PM',
            null,
          ),
        ],
      ),
    );
  }

  Widget _card(
    String iconPath,
    String title,
    String description,
    String value,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.rr),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.rw, vertical: 12.rh),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.rr),
          border: Border.all(color: AppColors.colorEEEEEE),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52.rh,
              height: 52.rh,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.colorF5F5F5,
                shape: BoxShape.circle,
              ),
              child: assetImageWidget(iconPath, size: 24.rh),
            ),
            SizedBox(height: 10.rh),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.ts12w500colorBlack(),
            ),
            SizedBox(height: 3.rh),
            Text(
              description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.ts12w400color474747().copyWith(
                fontSize: 10.rsp,
              ),
            ),
            SizedBox(height: 9.rh),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.ts12w600color000000(),
            ),
          ],
        ),
      ),
    );
  }
}
