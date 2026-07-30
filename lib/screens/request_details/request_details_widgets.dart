import 'package:constructo_worker/screens/request_details/request_details_controller.dart';
import 'package:constructo_worker/utils/buttons/back_button_custom.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin RequestDetailsWidgets {
  // Top Yellow Header with Back Button
  Widget requestDetailsHeader(BuildContext context) {
    return Container(
      color: AppColors.yellowBg,
      padding: EdgeInsets.only(
        left: 16.rw,
        right: 16.rw,
        top: MediaQuery.paddingOf(context).top + 8.rh,
        bottom: 12.rh,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const BackButtonCustom(),
          sizedboxWidth(12),
          Text(
            'Request Details',
            style: AppTextStyles.ts18w700color000000().copyWith(
              fontSize: 18.rsp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  // Card 1: Request Main Header Card
  Widget requestHeaderCard(RequestDetailsController controller) {
    return Obx(() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.rw),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.rr),
          border: Border.all(color: const Color(0xffDBDBDB), width: 1.rsp),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 42.rw,
                  height: 42.rh,
                  decoration: const BoxDecoration(
                    color: Color(0xffFFF1E5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.widgets_outlined,
                    color: const Color(0xffE67E22),
                    size: 20.rsp,
                  ),
                ),
                sizedboxWidth(10),
                // Title & ID & Pill
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.title.value,
                        style: AppTextStyles.ts16w600color000000().copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.rsp,
                        ),
                      ),
                      sizedboxHeight(2),
                      Text(
                        "ID: ${controller.requestId.value}",
                        style: AppTextStyles.ts12w500color808080().copyWith(
                          fontSize: 11.rsp,
                          color: AppColors.color7D7D7D,
                        ),
                      ),
                      sizedboxHeight(6),
                      Container(
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
                      ),
                    ],
                  ),
                ),
                // Requested on
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
                      controller.date.value,
                      style: AppTextStyles.ts12w500colorBlack().copyWith(
                        fontSize: 11.rsp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            sizedboxHeight(12),
            const Divider(color: Color(0xffEEEEEE), height: 1, thickness: 1),
            sizedboxHeight(10),
            // Start Date, Payment Type, Total Amount Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Start Date",
                      style: AppTextStyles.ts10w500colorBlack().copyWith(
                        fontSize: 10.rsp,
                        color: AppColors.color7D7D7D,
                      ),
                    ),
                    sizedboxHeight(2),
                    Text(
                      controller.startDate.value,
                      style: AppTextStyles.ts12w500colorBlack().copyWith(
                        fontSize: 11.rsp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Payment type",
                      style: AppTextStyles.ts10w500colorBlack().copyWith(
                        fontSize: 10.rsp,
                        color: AppColors.color7D7D7D,
                      ),
                    ),
                    sizedboxHeight(2),
                    Text(
                      controller.paymentType.value,
                      style: AppTextStyles.ts12w500colorBlack().copyWith(
                        fontSize: 11.rsp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
                      controller.amount.value,
                      style: AppTextStyles.ts14w600colorBlack().copyWith(
                        fontSize: 13.rsp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xff16A34A),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  // Card 2: Customer / Client Info Card
  Widget customerInfoCard(RequestDetailsController controller) {
    return Obx(() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.rw),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.rr),
          border: Border.all(color: const Color(0xffDBDBDB), width: 1.rsp),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 42.rw,
                  height: 42.rh,
                  decoration: const BoxDecoration(
                    color: Color(0xffFFF1E5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.widgets_outlined,
                    color: const Color(0xffE67E22),
                    size: 20.rsp,
                  ),
                ),
                sizedboxWidth(10),
                // Name & Email
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.customerName.value,
                        style: AppTextStyles.ts16w600color000000().copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 15.rsp,
                        ),
                      ),
                      sizedboxHeight(2),
                      Text(
                        controller.customerEmail.value,
                        style: AppTextStyles.ts12w500color808080().copyWith(
                          fontSize: 11.rsp,
                          color: AppColors.color7D7D7D,
                        ),
                      ),
                    ],
                  ),
                ),
                // Customer No
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Customer No",
                      style: AppTextStyles.ts10w500colorBlack().copyWith(
                        fontSize: 10.rsp,
                        color: AppColors.color7D7D7D,
                      ),
                    ),
                    sizedboxHeight(2),
                    Text(
                      controller.customerNo.value,
                      style: AppTextStyles.ts12w500colorBlack().copyWith(
                        fontSize: 11.rsp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            sizedboxHeight(12),
            const Divider(color: Color(0xffEEEEEE), height: 1, thickness: 1),
            sizedboxHeight(10),
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
                        controller.address.value,
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
                InkWell(
                  onTap: controller.openMap,
                  borderRadius: BorderRadius.circular(2.rr),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.rw, vertical: 4.rh),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.rr),
                      border: Border.all(color: const Color(0xff0167FA), width: 0.5.rsp),
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
          ],
        ),
      );
    });
  }

  // Card 3: Work Details Card
  Widget workDetailsCard(RequestDetailsController controller) {
    return Obx(() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.rw),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.rr),
          border: Border.all(color: const Color(0xffDBDBDB), width: 1.rsp),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Work type vs Estimated Duration
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Work type",
                      style: AppTextStyles.ts10w500colorBlack().copyWith(
                        fontSize: 10.rsp,
                        color: AppColors.color7D7D7D,
                      ),
                    ),
                    sizedboxHeight(2),
                    Text(
                      controller.workType.value,
                      style: AppTextStyles.ts12w500colorBlack().copyWith(
                        fontSize: 12.rsp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Estimated Duration",
                      style: AppTextStyles.ts10w500colorBlack().copyWith(
                        fontSize: 10.rsp,
                        color: AppColors.color7D7D7D,
                      ),
                    ),
                    sizedboxHeight(2),
                    Text(
                      controller.estimatedDuration.value,
                      style: AppTextStyles.ts12w500colorBlack().copyWith(
                        fontSize: 12.rsp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            sizedboxHeight(10),
            const Divider(color: Color(0xffEEEEEE), height: 1, thickness: 1),
            sizedboxHeight(10),
            // Preferred Date Time
            Text(
              "Preferred Date Time",
              style: AppTextStyles.ts10w500colorBlack().copyWith(
                fontSize: 10.rsp,
                color: AppColors.color7D7D7D,
              ),
            ),
            sizedboxHeight(2),
            Text(
              controller.preferredDateTime.value,
              style: AppTextStyles.ts12w500colorBlack().copyWith(
                fontSize: 11.rsp,
                fontWeight: FontWeight.w700,
              ),
            ),
            sizedboxHeight(10),
            const Divider(color: Color(0xffEEEEEE), height: 1, thickness: 1),
            sizedboxHeight(10),
            // Work Description
            Text(
              "Work Description",
              style: AppTextStyles.ts10w500colorBlack().copyWith(
                fontSize: 10.rsp,
                color: AppColors.color7D7D7D,
              ),
            ),
            sizedboxHeight(2),
            Text(
              controller.workDescription.value,
              style: AppTextStyles.ts12w500colorBlack().copyWith(
                fontSize: 11.rsp,
                fontWeight: FontWeight.w700,
                height: 1.3,
              ),
            ),
            sizedboxHeight(10),
            const Divider(color: Color(0xffEEEEEE), height: 1, thickness: 1),
            sizedboxHeight(10),
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
                        controller.address.value,
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
                InkWell(
                  onTap: controller.openMap,
                  borderRadius: BorderRadius.circular(2.rr),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.rw, vertical: 4.rh),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2.rr),
                      border: Border.all(color: const Color(0xff0167FA), width: 0.5.rsp),
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
          ],
        ),
      );
    });
  }

  // Card 4: Order Summary Card
  Widget orderSummaryCard(RequestDetailsController controller) {
    return Obx(() {
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.rw),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8.rr),
          border: Border.all(color: const Color(0xffDBDBDB), width: 1.rsp),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Order Summary",
              style: AppTextStyles.ts16w600color000000().copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 14.rsp,
              ),
            ),
            sizedboxHeight(10),
            // Subtotal Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Subtotal",
                  style: AppTextStyles.ts12w500colorBlack().copyWith(
                    fontSize: 12.rsp,
                    color: AppColors.color7D7D7D,
                  ),
                ),
                Text(
                  controller.subtotal.value,
                  style: AppTextStyles.ts12w500colorBlack().copyWith(
                    fontSize: 12.rsp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            sizedboxHeight(8),
            // Discount Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Discount",
                  style: AppTextStyles.ts12w500colorBlack().copyWith(
                    fontSize: 12.rsp,
                    color: AppColors.color7D7D7D,
                  ),
                ),
                Text(
                  controller.discount.value,
                  style: AppTextStyles.ts12w500colorBlack().copyWith(
                    fontSize: 12.rsp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xff16A34A),
                  ),
                ),
              ],
            ),
            sizedboxHeight(10),
            const Divider(color: Color(0xffEEEEEE), height: 1, thickness: 1),
            sizedboxHeight(10),
            // Grand Total Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Grand Total",
                  style: AppTextStyles.ts14w600colorBlack().copyWith(
                    fontSize: 13.rsp,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  controller.grandTotal.value,
                  style: AppTextStyles.ts14w600colorBlack().copyWith(
                    fontSize: 14.rsp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff16A34A),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  // Disclaimer Note Container
  Widget disclaimerNoteContainer() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.rw),
      decoration: BoxDecoration(
        color: const Color(0xffFFFDF0),
        borderRadius: BorderRadius.circular(8.rr),
        border: Border.all(color: const Color(0xffFFDEBD), width: 1.rsp),
      ),
      child: Text(
        "By accepting this work request, you confirm that you are available on the selected date and agree to complete the work as per the details provided.",
        style: AppTextStyles.ts12w500colorBlack().copyWith(
          fontSize: 11.rsp,
          color: const Color(0xff7A5800),
          height: 1.35,
        ),
      ),
    );
  }

  // Sticky Bottom Action Bar
  Widget stickyBottomActionBar(RequestDetailsController controller) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 12.rh),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Accept Request Button
          SizedBox(
            width: double.infinity,
            height: 44.rh,
            child: ElevatedButton(
              onPressed: controller.acceptRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                foregroundColor: AppColors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.rr),
                ),
              ),
              child: Text(
                "Accept Request",
                style: TextStyle(
                  fontSize: 14.rsp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          sizedboxHeight(10),
          // Reject Button
          SizedBox(
            width: double.infinity,
            height: 44.rh,
            child: ElevatedButton(
              onPressed: controller.rejectRequest,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFFF9DB),
                foregroundColor: AppColors.black,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.rr),
                ),
              ),
              child: Text(
                "Reject",
                style: TextStyle(
                  fontSize: 14.rsp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff333333),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
