import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.scafoldBg,
        appBar: AppBar(
          backgroundColor: AppColors.yellowBg,
          surfaceTintColor: AppColors.yellowBg,
          title: Text(
            'Notifications',
            style: AppTextStyles.ts18w700color000000(),
          ),
          bottom: TabBar(
            indicatorColor: AppColors.black,
            indicatorWeight: 3,
            labelColor: AppColors.black,
            unselectedLabelColor: const Color(0xff7D7D7D),
            labelStyle: AppTextStyles.ts14w600colorBlack(),
            tabs: const [
              Tab(text: 'Accepted'),
              Tab(text: 'Rejected'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _NotificationEmptyState(type: 'accepted'),
            _NotificationEmptyState(type: 'rejected'),
          ],
        ),
      ),
    );
  }
}

class _NotificationEmptyState extends StatelessWidget {
  const _NotificationEmptyState({required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.notifications_none_rounded,
            size: 64,
            color: Color(0xffA0A0A0),
          ),
          const SizedBox(height: 12),
          Text(
            'No $type notifications',
            style: AppTextStyles.ts16w600color000000(),
          ),
          const SizedBox(height: 4),
          Text(
            'Your $type request updates will appear here.',
            style: AppTextStyles.ts12w500color808080(),
          ),
        ],
      ),
    );
  }
}
