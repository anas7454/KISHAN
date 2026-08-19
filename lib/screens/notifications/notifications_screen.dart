import 'package:constructo_worker/screens/notifications/notifications_controller.dart';
import 'package:constructo_worker/screens/notifications/notifications_widgets.dart';
import 'package:constructo_worker/utils/appbars/appbar_custom.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationsScreen extends StatelessWidget with NotificationsWidgets {
  NotificationsScreen({super.key});

  final NotificationsController controller = Get.put(NotificationsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scafoldBg,
      appBar: appBarCustom(title: 'Notifications'),
      body: Obx(() {
        if (controller.isLoading.value && controller.notifications.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(15.rw, 15.rh, 15.rw, 0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${controller.unreadCount.value} Unread',
                      style: AppTextStyles.ts14w600colorBlack(),
                    ),
                  ),
                  TextButton(
                    onPressed: controller.unreadCount.value == 0
                        ? null
                        : controller.markAllRead,
                    child: const Text('Mark all as read'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: controller.notifications.isEmpty
                  ? const Center(child: Text('No notifications found'))
                  : RefreshIndicator(
                      onRefresh: controller.refreshPage,
                      child: ListView.separated(
                        padding: EdgeInsets.fromLTRB(
                          15.rw,
                          15.rh,
                          15.rw,
                          40.rh,
                        ),
                        itemCount: controller.notifications.length,
                        separatorBuilder: (_, _) => sizedboxHeight(16),
                        itemBuilder: (_, index) {
                          final item = controller.notifications[index];
                          return notificationCard(
                            item,
                            onTap: () => controller.markRead(item),
                            onDelete: () => controller.deleteNotification(item),
                          );
                        },
                      ),
                    ),
            ),
          ],
        );
      }),
    );
  }
}
