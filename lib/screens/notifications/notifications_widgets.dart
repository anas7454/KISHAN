import 'package:constructo_worker/models/app_notification_model.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

mixin NotificationsWidgets {
  Widget notificationCard(
    AppNotificationModel item, {
    required VoidCallback onTap,
    required VoidCallback onDelete,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10.rr),
      child: Container(
        padding: EdgeInsets.all(12.rw),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.rr),
          border: Border.all(color: AppColors.colorEEEEEE),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (!item.isRead) ...[
                  Container(
                    width: 7.rh,
                    height: 7.rh,
                    decoration: const BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                  sizedboxWidth(7),
                ],
                Expanded(
                  child: Text(
                    item.title,
                    style: AppTextStyles.ts14w600colorBlack(),
                  ),
                ),
                IconButton(
                  onPressed: onDelete,
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    size: 18.rsp,
                    color: AppColors.color808080,
                  ),
                ),
              ],
            ),
            Text(item.message, style: AppTextStyles.ts12w400color474747()),
            sizedboxHeight(10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                _date(item.createdAt),
                style: AppTextStyles.ts10w500color6B7080(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _date(String value) {
    final parsed = DateTime.tryParse(value)?.toLocal();
    return parsed == null
        ? value
        : DateFormat('dd MMM yyyy, hh:mm a').format(parsed);
  }
}
