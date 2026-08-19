import 'package:constructo_worker/routes/app_routes.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

enum WorkerRequestStatus { newRequest, accepted, rejected }

Widget workerRequestCard({
  required String title,
  required String requestId,
  required String date,
  String? startDate,
  required String amount,
  required String address,
  required WorkerRequestStatus status,
  VoidCallback? onAccept,
  VoidCallback? onReject,
  VoidCallback? onViewMap,
  VoidCallback? onTap,
  bool isAccepting = false,
  bool isRejecting = false,
}) {
  final bool isNew = status == WorkerRequestStatus.newRequest;
  final bool isAccepted = status == WorkerRequestStatus.accepted;

  return InkWell(
    onTap: onTap ?? () => AppRoutes.requestDetailsScreen(),
    borderRadius: BorderRadius.circular(8.rr),
    child: Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 170.rh),
      margin: EdgeInsets.only(bottom: 14.rh),
      padding: EdgeInsets.only(
        top: 12.rh,
        right: 10.rw,
        bottom: 12.rh,
        left: 10.rw,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.rr),
        border: Border.all(color: const Color(0xffE2E8F0), width: 1.rsp),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            spreadRadius: 0,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.02),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Icon + Title/ID/Badge vs Date & Right Info
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Box Icon Circle with Gradient
              Container(
                width: 42.rw,
                height: 42.rh,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xffFFF3E0), Color(0xffFFE5D0)],
                  ),
                  border: Border.all(
                    color: const Color(0xffF57C00).withValues(alpha: 0.15),
                    width: 1.rsp,
                  ),
                ),
                child: Icon(
                  Icons.widgets_outlined,
                  color: const Color(0xffE67E22),
                  size: 20.rsp,
                ),
              ),
              sizedboxWidth(10),
              // Title & ID & Status Badge
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.ts16w600color000000().copyWith(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.rsp,
                      ),
                    ),
                    sizedboxHeight(2),
                    Text(
                      "ID: $requestId",
                      style: AppTextStyles.ts12w500color808080().copyWith(
                        fontSize: 11.rsp,
                        color: AppColors.color7D7D7D,
                      ),
                    ),
                    sizedboxHeight(6),
                    _statusBadge(status),
                  ],
                ),
              ),
              // Requested on & Amount or Start Date
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Requested on",
                    style: AppTextStyles.ts10w500colorBlack().copyWith(
                      fontSize: 10.rsp,
                      color: AppColors.color7D7D7D,
                    ),
                  ),
                  sizedboxHeight(2),
                  Text(
                    date,
                    style: AppTextStyles.ts12w500colorBlack().copyWith(
                      fontSize: 11.rsp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  sizedboxHeight(8),
                  if (isAccepted) ...[
                    Text(
                      "Start Date",
                      style: AppTextStyles.ts10w500colorBlack().copyWith(
                        fontSize: 10.rsp,
                        color: AppColors.color7D7D7D,
                      ),
                    ),
                    sizedboxHeight(2),
                    Text(
                      startDate ?? date,
                      style: AppTextStyles.ts12w500colorBlack().copyWith(
                        fontSize: 11.rsp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ] else ...[
                    Text(
                      "Total Amount",
                      style: AppTextStyles.ts10w500colorBlack().copyWith(
                        fontSize: 10.rsp,
                        color: AppColors.color7D7D7D,
                      ),
                    ),
                    sizedboxHeight(2),
                    Text(
                      amount,
                      style: AppTextStyles.ts14w600colorBlack().copyWith(
                        fontSize: 14.rsp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xff16A34A),
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
          sizedboxHeight(10),
          const Divider(color: Color(0xffEEEEEE), height: 1, thickness: 1),
          sizedboxHeight(8),
          // Address Row + View on Map Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Address",
                      style: AppTextStyles.ts10w500colorBlack().copyWith(
                        fontSize: 10.rsp,
                        color: AppColors.color7D7D7D,
                      ),
                    ),
                    sizedboxHeight(2),
                    Text(
                      address,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.ts12w500colorBlack().copyWith(
                        fontSize: 11.rsp,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              sizedboxWidth(8),
              // View on Map (Figma Spec Frame 2147227031: 69x20px, Radius 2px, Border 0.5px #0167FA, Padding 4px/6px)
              InkWell(
                onTap: onViewMap,
                borderRadius: BorderRadius.circular(2.rr),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 6.rw,
                    vertical: 4.rh,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.rr),
                    border: Border.all(
                      color: const Color(0xff0167FA),
                      width: 0.5.rsp,
                    ),
                  ),
                  child: Text(
                    "View on Map",
                    style: TextStyle(
                      fontSize: 10.rsp,
                      color: const Color(0xff0167FA),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Bottom Section for Accepted status: Total Amount on bottom left
          if (isAccepted) ...[
            sizedboxHeight(8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Amount",
                  style: AppTextStyles.ts10w500colorBlack().copyWith(
                    fontSize: 10.rsp,
                    color: AppColors.color7D7D7D,
                  ),
                ),
                sizedboxHeight(2),
                Text(
                  amount,
                  style: AppTextStyles.ts14w600colorBlack().copyWith(
                    fontSize: 14.rsp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff16A34A),
                  ),
                ),
              ],
            ),
          ],

          // Bottom Action Buttons Row for New Requests
          if (isNew) ...[
            sizedboxHeight(12),
            Row(
              children: [
                // Accept Request Button (Figma Spec: 160x26px, Radius 100px, #000000 fill, Padding 5px 9px, Gap 4px)
                Expanded(
                  child: InkWell(
                    onTap: isAccepting || isRejecting ? null : onAccept,
                    borderRadius: BorderRadius.circular(100.rr),
                    child: Container(
                      height: 26.rh,
                      padding: EdgeInsets.symmetric(
                        horizontal: 9.rw,
                        vertical: 5.rh,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xff000000),
                        borderRadius: BorderRadius.circular(100.rr),
                      ),
                      child: isAccepting
                          ? Center(
                              child: SizedBox(
                                width: 14.rw,
                                height: 14.rw,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: AppColors.white,
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.check_circle_outline_rounded,
                                  size: 13.rsp,
                                  color: AppColors.white,
                                ),
                                sizedboxWidth(4),
                                Text(
                                  "Accept Request",
                                  style: TextStyle(
                                    fontSize: 11.5.rsp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
                sizedboxWidth(10),
                // Reject Request Button (Figma Spec: 160x26px, Radius 100px, #FFCC00 20% fill, Padding 5px 10px, Gap 5px)
                Expanded(
                  child: InkWell(
                    onTap: isAccepting || isRejecting ? null : onReject,
                    borderRadius: BorderRadius.circular(100.rr),
                    child: Container(
                      height: 26.rh,
                      padding: EdgeInsets.symmetric(
                        horizontal: 10.rw,
                        vertical: 5.rh,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xffFFCC00).withValues(alpha: 0.20),
                        borderRadius: BorderRadius.circular(100.rr),
                      ),
                      child: isRejecting
                          ? Center(
                              child: SizedBox(
                                width: 14.rw,
                                height: 14.rw,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Color(0xff333333),
                                ),
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.close_rounded,
                                  size: 13.rsp,
                                  color: const Color(0xff333333),
                                ),
                                sizedboxWidth(5),
                                Text(
                                  "Reject Request",
                                  style: TextStyle(
                                    fontSize: 11.5.rsp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff333333),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    ),
  );
}

Widget _statusBadge(WorkerRequestStatus status) {
  switch (status) {
    case WorkerRequestStatus.newRequest:
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 3.rh),
        decoration: BoxDecoration(
          color: const Color(0xffFFF9DB),
          borderRadius: BorderRadius.circular(4.rr),
        ),
        child: Text(
          "New Request",
          style: AppTextStyles.ts10w500colorBlack().copyWith(
            fontSize: 10.rsp,
            fontWeight: FontWeight.w600,
            color: const Color(0xff856404),
          ),
        ),
      );
    case WorkerRequestStatus.accepted:
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 3.rh),
        decoration: BoxDecoration(
          color: const Color(0xff35AF30).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(4.rr),
        ),
        child: Text(
          "Accepted",
          style: AppTextStyles.ts10w500colorBlack().copyWith(
            fontSize: 10.rsp,
            fontWeight: FontWeight.w700,
            color: const Color(0xff16A34A),
          ),
        ),
      );
    case WorkerRequestStatus.rejected:
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 3.rh),
        decoration: BoxDecoration(
          color: const Color(0xffD32F2F).withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(4.rr),
        ),
        child: Text(
          "Rejected",
          style: AppTextStyles.ts10w500colorBlack().copyWith(
            fontSize: 10.rsp,
            fontWeight: FontWeight.w700,
            color: const Color(0xffD32F2F),
          ),
        ),
      );
  }
}
