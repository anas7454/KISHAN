import 'package:constructo_worker/screens/request_details/request_details_controller.dart';
import 'package:constructo_worker/screens/bottomnavbar/widgets/request_card_widget.dart';
import 'package:constructo_worker/utils/buttons/back_button_custom.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin RequestDetailsWidgets {
  Widget requestDetailsSkeleton() {
    Widget card(double height) => Container(
      width: double.infinity,
      height: height,
      margin: EdgeInsets.only(bottom: 12.rh),
      decoration: BoxDecoration(
        color: const Color(0xffE8E8E8),
        borderRadius: BorderRadius.circular(8.rr),
      ),
    );

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 14.rh),
      child: Column(
        children: [card(150.rh), card(145.rh), card(210.rh), card(150.rh)],
      ),
    );
  }

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
                      finalStatusBadge(controller.status.value),
                    ],
                  ),
                ),
                // Requested on
                SizedBox(
                  width: 105.rw,
                  child: Column(
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
                        maxLines: 2,
                        textAlign: TextAlign.end,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.ts12w500colorBlack().copyWith(
                          fontSize: 11.rsp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
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
                Expanded(
                  child: Column(
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.ts12w500colorBlack().copyWith(
                          fontSize: 11.rsp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                sizedboxWidth(8),
                Expanded(
                  child: Column(
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
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.ts12w500colorBlack().copyWith(
                          fontSize: 11.rsp,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
                sizedboxWidth(8),
                Expanded(
                  child: Column(
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
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.ts14w600colorBlack().copyWith(
                          fontSize: 13.rsp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xff16A34A),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget finalStatusBadge(WorkerRequestStatus status) {
    final bool accepted = status == WorkerRequestStatus.accepted;
    final bool rejected = status == WorkerRequestStatus.rejected;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.rw, vertical: 3.rh),
      decoration: BoxDecoration(
        color: accepted
            ? const Color(0xffE6F5E9)
            : rejected
            ? const Color(0xffFFEBEE)
            : const Color(0xffFFF9DB),
        borderRadius: BorderRadius.circular(4.rr),
      ),
      child: Text(
        accepted
            ? 'Accepted'
            : rejected
            ? 'Rejected'
            : 'New Request',
        style: AppTextStyles.ts10w500colorBlack().copyWith(
          fontSize: 10.rsp,
          fontWeight: FontWeight.w600,
          color: accepted
              ? const Color(0xff35AF30)
              : rejected
              ? const Color(0xffD32F2F)
              : const Color(0xff856404),
        ),
      ),
    );
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
    return Obx(() {
      if (controller.isLoading.value) return const SizedBox.shrink();
      if (controller.status.value != WorkerRequestStatus.newRequest) {
        final bool accepted =
            controller.status.value == WorkerRequestStatus.accepted;
        // Work-flow buttons are temporarily hidden. Pending requests still
        // show the Accept and Reject buttons below.
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 16.rw, vertical: 14.rh),
          color: AppColors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                accepted ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: accepted
                    ? const Color(0xff35AF30)
                    : const Color(0xffD32F2F),
              ),
              sizedboxWidth(8),
              Text(
                accepted
                    ? 'This request has been accepted'
                    : 'This request has been rejected',
                style: AppTextStyles.ts14w600colorBlack(),
              ),
            ],
          ),
        );
      }
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
                onPressed:
                    controller.isAccepting.value || controller.isRejecting.value
                    ? null
                    : controller.acceptRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.rr),
                  ),
                ),
                child: controller.isAccepting.value
                    ? SizedBox(
                        width: 20.rw,
                        height: 20.rw,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : Text(
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
                onPressed:
                    controller.isAccepting.value || controller.isRejecting.value
                    ? null
                    : controller.rejectRequest,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xffFFF9DB),
                  foregroundColor: AppColors.black,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.rr),
                  ),
                ),
                child: controller.isRejecting.value
                    ? SizedBox(
                        width: 20.rw,
                        height: 20.rw,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Color(0xff333333),
                        ),
                      )
                    : Text(
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
    });
  }

  Widget _workflowActionBar(RequestDetailsController controller) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.rw, 10.rh, 16.rw, 14.rh),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .08),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _SlideActionButton(
              key: ValueKey(controller.workflowActionLabel),
              label: controller.workflowActionLabel,
              enabled:
                  controller.workflowActionEnabled &&
                  !controller.isWorkflowLoading.value,
              onConfirmed: controller.workflowActionLabel == 'Complete Work'
                  ? () => _showCompleteWorkCommentSheet(controller)
                  : controller.performWorkflowAction,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showCompleteWorkCommentSheet(
    RequestDetailsController controller,
  ) async {
    final commentController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    await Get.bottomSheet<void>(
      AnimatedPadding(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(Get.context!).bottom,
        ),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(Get.context!).height * .85,
          ),
          padding: EdgeInsets.fromLTRB(20.rw, 18.rh, 20.rw, 20.rh),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(22.rr)),
          ),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Complete Work',
                    style: AppTextStyles.ts18w700color000000(),
                  ),
                  sizedboxHeight(14),
                  TextFormField(
                    controller: commentController,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      labelText: 'Comment',
                      hintText: 'Work completion comment enter karein',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.rr),
                      ),
                    ),
                    validator: (value) => value == null || value.trim().isEmpty
                        ? 'Comment is required'
                        : null,
                  ),
                  sizedboxHeight(16),
                  SizedBox(
                    width: double.infinity,
                    height: 46.rh,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (!(formKey.currentState?.validate() ?? false))
                          return;
                        final completed = await controller
                            .completeWorkWithComment(commentController.text);
                        if (completed && Get.isBottomSheetOpen == true) {
                          Get.back<void>();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black,
                        foregroundColor: AppColors.white,
                      ),
                      child: const Text('Complete Work'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      isScrollControlled: true,
    );
    commentController.dispose();
  }

  Future<void> _showAdditionalServicesSheet(
    RequestDetailsController controller,
  ) async {
    await controller.loadAdditionalSkillServices();

    final searchController = TextEditingController();
    final searchQuery = ''.obs;
    final selectedIds = <String>{'s1', 's4'}.obs;

    final List<Map<String, dynamic>> allServices = [];
    if (controller.additionalSkillServices.isNotEmpty) {
      for (final s in controller.additionalSkillServices) {
        allServices.add({'id': s['id'], 'name': s['name'], 'price': 300.0});
      }
    } else {
      allServices.addAll([
        {'id': 's1', 'name': 'Tap leakage', 'price': 300.0},
        {'id': 's2', 'name': 'Tap replacement', 'price': 350.0},
        {'id': 's3', 'name': 'Mixer tap repair', 'price': 450.0},
        {'id': 's4', 'name': 'Shower tap repair', 'price': 325.0},
        {'id': 's5', 'name': 'Water pipe leakage', 'price': 500.0},
        {'id': 's6', 'name': 'Broken pipe', 'price': 400.0},
        {'id': 's7', 'name': 'Pipe replacement', 'price': 600.0},
        {'id': 's8', 'name': 'Joint leakage', 'price': 350.0},
        {'id': 's9', 'name': 'Wash basin', 'price': 450.0},
        {'id': 's10', 'name': 'Toilet blockage', 'price': 550.0},
        {'id': 's11', 'name': 'Flush repair', 'price': 400.0},
        {'id': 's12', 'name': 'Sink blockage', 'price': 350.0},
        {'id': 's13', 'name': 'Tank installation', 'price': 1200.0},
        {'id': 's14', 'name': 'Sink leakage', 'price': 300.0},
        {'id': 's15', 'name': 'Geyser leakage', 'price': 500.0},
      ]);
    }

    final String categoryName = controller.workType.value.isNotEmpty
        ? controller.workType.value
        : 'Plumber';

    await Get.bottomSheet<void>(
      Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(Get.context!).height * .88,
        ),
        decoration: BoxDecoration(
          color: AppColors.yellowBg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(22.rr)),
        ),
        child: Column(
          children: [
            sizedboxHeight(10),
            Center(
              child: Container(
                width: 40.rw,
                height: 4.rh,
                decoration: BoxDecoration(
                  color: AppColors.black.withValues(alpha: .2),
                  borderRadius: BorderRadius.circular(2.rr),
                ),
              ),
            ),
            sizedboxHeight(12),
            // Search Input
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.rw),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.rw),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10.rr),
                  border: Border.all(color: const Color(0xffE2E4E5)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search_rounded,
                      size: 20.rsp,
                      color: AppColors.color7D7D7D,
                    ),
                    sizedboxWidth(8),
                    Expanded(
                      child: TextField(
                        controller: searchController,
                        onChanged: (val) =>
                            searchQuery.value = val.trim().toLowerCase(),
                        decoration: const InputDecoration(
                          hintText: 'Search skilled workers, etc',
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        style: TextStyle(fontSize: 13.rsp),
                      ),
                    ),
                    Icon(
                      Icons.tune_rounded,
                      size: 20.rsp,
                      color: AppColors.color7D7D7D,
                    ),
                  ],
                ),
              ),
            ),
            sizedboxHeight(14),
            // Main Content Area
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.rw),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Header Card
                    Container(
                      padding: EdgeInsets.all(14.rw),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(14.rr),
                        border: Border.all(color: const Color(0xffE8E8E8)),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 42.rw,
                            height: 42.rw,
                            decoration: BoxDecoration(
                              color: AppColors.yellowBg,
                              borderRadius: BorderRadius.circular(10.rr),
                              border: Border.all(color: AppColors.primary),
                            ),
                            child: Icon(
                              Icons.plumbing_rounded,
                              size: 24.rsp,
                              color: AppColors.primary,
                            ),
                          ),
                          sizedboxWidth(14),
                          Text(
                            categoryName,
                            style: TextStyle(
                              fontSize: 16.rsp,
                              fontWeight: FontWeight.w800,
                              color: AppColors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    sizedboxHeight(16),
                    // Sub-Services Chips Grid
                    Obx(() {
                      final query = searchQuery.value;
                      final filtered = allServices.where((s) {
                        final name = (s['name'] ?? '').toString().toLowerCase();
                        return query.isEmpty || name.contains(query);
                      }).toList();

                      if (filtered.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.rh),
                          child: const Center(
                            child: Text('No services found matching search'),
                          ),
                        );
                      }

                      return Wrap(
                        spacing: 8.rw,
                        runSpacing: 10.rh,
                        children: filtered.map((service) {
                          final String id = service['id'] as String;
                          final String name = service['name'] as String;
                          final bool isSelected = selectedIds.contains(id);

                          return GestureDetector(
                            onTap: () {
                              if (isSelected) {
                                selectedIds.remove(id);
                              } else {
                                selectedIds.add(id);
                              }
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.rw,
                                vertical: 10.rh,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.white,
                                borderRadius: BorderRadius.circular(22.rr),
                                border: Border.all(
                                  color: isSelected
                                      ? AppColors.primary
                                      : const Color(0xffE0E0E0),
                                  width: isSelected ? 1.5 : 1,
                                ),
                              ),
                              child: Text(
                                name,
                                style: TextStyle(
                                  fontSize: 11.5.rsp,
                                  fontWeight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? const Color(0xffD9A000)
                                      : const Color(0xff4C4C4C),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      );
                    }),
                    sizedboxHeight(20),
                  ],
                ),
              ),
            ),
            // Bottom Sticky Footer Card
            Container(
              padding: EdgeInsets.fromLTRB(20.rw, 16.rh, 20.rw, 24.rh),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.rr),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.black.withValues(alpha: .06),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Obx(() {
                    double total = 0.0;
                    for (final id in selectedIds) {
                      final found = allServices.firstWhere(
                        (element) => element['id'] == id,
                        orElse: () => {'price': 0.0},
                      );
                      total += (found['price'] as num).toDouble();
                    }
                    if (total == 0 && selectedIds.isNotEmpty) total = 625.0;

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '₹${total.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontSize: 22.rsp,
                                  fontWeight: FontWeight.w900,
                                  color: AppColors.black,
                                ),
                              ),
                              sizedboxHeight(2),
                              Text(
                                'All Services Charge',
                                style: TextStyle(
                                  fontSize: 11.rsp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.color7D7D7D,
                                ),
                              ),
                              sizedboxHeight(2),
                              GestureDetector(
                                onTap: () {
                                  _showPriceDetailsDialog(
                                    allServices,
                                    selectedIds,
                                  );
                                },
                                child: Text(
                                  'View price details',
                                  style: TextStyle(
                                    fontSize: 11.rsp,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                  sizedboxHeight(14),
                  SizedBox(
                    width: double.infinity,
                    height: 48.rh,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (selectedIds.isEmpty) {
                          Get.snackbar(
                            'Select Service',
                            'Please select at least one service',
                          );
                          return;
                        }
                        final itemsToSubmit = <Map<String, dynamic>>[];
                        for (final id in selectedIds) {
                          final found = allServices.firstWhere(
                            (e) => e['id'] == id,
                            orElse: () => {'name': 'Service', 'price': 300.0},
                          );
                          itemsToSubmit.add({
                            'skillServiceId': id,
                            'description': found['name'],
                            'quantity': 1,
                            'amount': found['price'],
                          });
                        }
                        final bool sent = await controller
                            .submitAdditionalServices(itemsToSubmit);
                        if (sent && Get.isBottomSheetOpen == true) {
                          Get.back<void>();
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.black,
                        foregroundColor: AppColors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.rr),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Add Services',
                        style: TextStyle(
                          fontSize: 14.rsp,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
    searchController.dispose();
  }

  void _showPriceDetailsDialog(
    List<Map<String, dynamic>> allServices,
    Set<String> selectedIds,
  ) {
    Get.dialog<void>(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.rr),
        ),
        title: Text(
          'Price Breakdown',
          style: TextStyle(fontSize: 16.rsp, fontWeight: FontWeight.w800),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: selectedIds.map((id) {
            final found = allServices.firstWhere(
              (e) => e['id'] == id,
              orElse: () => {'name': 'Service', 'price': 300.0},
            );
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.rh),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      (found['name'] ?? '').toString(),
                      style: TextStyle(fontSize: 12.rsp),
                    ),
                  ),
                  Text(
                    '₹${(found['price'] as num).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 12.rsp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        actions: [TextButton(onPressed: Get.back, child: const Text('Close'))],
      ),
    );
  }

  Widget _estimateField(
    TextEditingController controller,
    String label, {
    bool required = true,
    bool number = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: number
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      validator: (value) {
        if (required && (value == null || value.trim().isEmpty)) {
          return 'Required';
        }
        if (number && (num.tryParse(value?.trim() ?? '') ?? 0) <= 0) {
          return 'Enter valid value';
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: const Color(0xffF8F8F8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.rr),
          borderSide: const BorderSide(color: Color(0xffDDDDDD)),
        ),
      ),
    );
  }
}

class _SlideActionButton extends StatefulWidget {
  const _SlideActionButton({
    super.key,
    required this.label,
    required this.enabled,
    required this.onConfirmed,
  });

  final String label;
  final bool enabled;
  final Future<void> Function() onConfirmed;

  @override
  State<_SlideActionButton> createState() => _SlideActionButtonState();
}

class _SlideActionButtonState extends State<_SlideActionButton> {
  double _position = 0;
  bool _submitting = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double thumbSize = 38.rh;
        final double maxPosition = constraints.maxWidth - thumbSize - 6.rw;
        return Container(
          width: double.infinity,
          height: 46.rh,
          decoration: BoxDecoration(
            color: widget.enabled ? AppColors.white : const Color(0xffF1F1F1),
            borderRadius: BorderRadius.circular(24.rr),
            border: Border.all(
              color: widget.enabled
                  ? AppColors.primary
                  : const Color(0xffD7D7D7),
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.rw),
                child: Text(
                  _submitting ? 'Please wait...' : widget.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: widget.enabled
                        ? AppColors.black
                        : AppColors.color7D7D7D,
                    fontSize: 12.rsp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 140),
                curve: Curves.easeOut,
                left: 3.rw + _position,
                top: 3.rh,
                child: GestureDetector(
                  onHorizontalDragUpdate: !widget.enabled || _submitting
                      ? null
                      : (details) {
                          setState(() {
                            _position = (_position + details.delta.dx)
                                .clamp(0, maxPosition)
                                .toDouble();
                          });
                        },
                  onHorizontalDragEnd: !widget.enabled || _submitting
                      ? null
                      : (_) async {
                          if (_position < maxPosition * .78) {
                            setState(() => _position = 0);
                            return;
                          }
                          setState(() {
                            _position = maxPosition;
                            _submitting = true;
                          });
                          await widget.onConfirmed();
                          if (!mounted) return;
                          setState(() {
                            _position = 0;
                            _submitting = false;
                          });
                        },
                  child: Container(
                    width: thumbSize,
                    height: thumbSize,
                    decoration: BoxDecoration(
                      color: widget.enabled
                          ? AppColors.primary
                          : const Color(0xffC8C8C8),
                      shape: BoxShape.circle,
                      boxShadow: widget.enabled
                          ? [
                              BoxShadow(
                                color: AppColors.black.withValues(alpha: .12),
                                blurRadius: 5,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : null,
                    ),
                    child: _submitting
                        ? Padding(
                            padding: EdgeInsets.all(10.rw),
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.black,
                            ),
                          )
                        : Icon(
                            Icons.arrow_forward_rounded,
                            color: AppColors.black,
                            size: 20.rsp,
                          ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
