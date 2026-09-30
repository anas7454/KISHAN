import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';

class BookingSummaryScreen extends StatefulWidget {
  const BookingSummaryScreen({super.key});

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      body: SafeArea(
        child: Stack(
          children: [
            // 1. SCROLLABLE BODY CONTENT
            Column(
              children: [
                _buildHeader(context),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),

                          // SELECTED EQUIPMENT BRIEF CARD
                          _buildEquipmentCard(),

                          SizedBox(height: 12.h),

                          // SERVICE LOCATION CARD (सेवा स्थान)
                          _buildServiceLocationCard(),

                          SizedBox(height: 12.h),

                          // DATE, TIME & DURATION SUMMARY BOX
                          _buildDateTimeSummaryBox(),

                          SizedBox(height: 14.h),

                          // REQUIRED WORK CHIPS (आवश्यक कार्य)
                          _buildRequiredWorkChips(),

                          SizedBox(height: 14.h),

                          // PAYMENT DETAILS CARD (भुगतान विवरण)
                          _buildPaymentDetailsCard(),

                          SizedBox(height: 12.h),

                          // SECURE BOOKING GUARANTEE CARD (सुरक्षित बुकिंग)
                          _buildSecureBookingCard(),

                          SizedBox(height: 12.h),

                          // IMPORTANT INFORMATION (महत्वपूर्ण जानकारी)
                          _buildImportantInfoSection(),

                          SizedBox(height: 75.h), // Space for fixed bottom action bar
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 2. FIXED BOTTOM ACTION BUTTONS BAR
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomActionBar(context),
            ),
          ],
        ),
      ),
    );
  }

  // --- 1. TOP APP BAR HEADER ---
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
      ),
      child: Row(
        children: [
          // Back Button
          InkWell(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(6.r),
              decoration: const BoxDecoration(
                color: Color(0xFFF4F7F5),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back, color: const Color(0xFF2E7D32), size: 18.sp),
            ),
          ),
          SizedBox(width: 10.w),

          // Title & Subtitle Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'बुकिंग सारांश',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1C1C1C),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'कृपया अपनी बुकिंग की सभी जानकारी जांचें',
                  style: TextStyle(
                    fontSize: 10.5.sp,
                    color: const Color(0xFF757575),
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),

          // Language Change Button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: const Color(0xFFC8E6C9), width: 1),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.language_rounded, color: const Color(0xFF2E7D32), size: 13.sp),
                SizedBox(width: 3.w),
                Text(
                  'भाषा बदलें',
                  style: TextStyle(
                    fontSize: 10.5.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 2. SELECTED EQUIPMENT CARD ---
  Widget _buildEquipmentCard() {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFCFA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2EFE4), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: SizedBox(
              width: 80.w,
              height: 80.h,
              child: Image.asset(
                ImageUtility.greenTractorBanner,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFE8F5E9),
                  child: Icon(Icons.agriculture_rounded, size: 35.sp, color: const Color(0xFF2E7D32)),
                ),
              ),
            ),
          ),

          SizedBox(width: 10.w),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.agriculture_rounded, color: const Color(0xFF2E7D32), size: 15.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'ट्रैक्टर सेवा (45 HP)',
                      style: TextStyle(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xFF1C1C1C),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  '📍 बरखेड़ा, सीहोर, मध्य प्रदेश (1.2 किमी दूर)',
                  style: TextStyle(
                    fontSize: 9.5.sp,
                    color: const Color(0xFF757575),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),

                // Feature Pills Row
                Wrap(
                  spacing: 4.w,
                  runSpacing: 4.h,
                  children: [
                    _buildSmallTag('ड्राइवर सहित'),
                    _buildSmallTag('डीजल शामिल'),
                    _buildSmallTag('उपकरण सहित'),
                  ],
                ),

                SizedBox(height: 4.h),
                Row(
                  children: [
                    Text(
                      '₹800',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w900,
                        color: const Color(0xFF2E7D32),
                      ),
                    ),
                    Text(
                      ' / घंटा',
                      style: TextStyle(fontSize: 10.sp, color: const Color(0xFF616161)),
                    ),
                  ],
                ),
              ],
            ),
          ),

          SizedBox(width: 4.w),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'सेवा विवरण देखें',
              style: TextStyle(
                fontSize: 9.5.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2E7D32),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSmallTag(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle_outlined, color: const Color(0xFF2E7D32), size: 9.sp),
          SizedBox(width: 2.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 8.5.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF2E7D32),
            ),
          ),
        ],
      ),
    );
  }

  // --- 3. SERVICE LOCATION CARD ---
  Widget _buildServiceLocationCard() {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFCFA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2EFE4), width: 1),
      ),
      child: Row(
        children: [
          Icon(Icons.location_on, color: const Color(0xFF2E7D32), size: 18.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'सेवा स्थान',
                  style: TextStyle(fontSize: 10.sp, color: const Color(0xFF757575), fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 1.h),
                Text(
                  'रामू पाटीदार',
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w800, color: const Color(0xFF1C1C1C)),
                ),
                SizedBox(height: 1.h),
                Text(
                  'ग्राम बरखेड़ा, तहसील सीहोर, जिला सीहोर, मध्य प्रदेश - 466001',
                  style: TextStyle(fontSize: 9.5.sp, color: const Color(0xFF616161)),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 6.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(Icons.map_outlined, color: const Color(0xFF2E7D32), size: 12.sp),
                SizedBox(width: 3.w),
                Text(
                  'नक्शा देखें',
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w700, color: const Color(0xFF2E7D32)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 4. DATE, TIME & DURATION SUMMARY BOX ---
  Widget _buildDateTimeSummaryBox() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFECEFF1), width: 1),
      ),
      child: Row(
        children: [
          // Col 1: Date
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.calendar_today_outlined, color: const Color(0xFF2E7D32), size: 13.sp),
                    SizedBox(width: 3.w),
                    Text('तारीख', style: TextStyle(fontSize: 10.sp, color: const Color(0xFF757575))),
                  ],
                ),
                SizedBox(height: 3.h),
                Text('28 मई 2025', style: TextStyle(fontSize: 11.5.sp, fontWeight: FontWeight.w800, color: const Color(0xFF1C1C1C))),
                Text('बुधवार', style: TextStyle(fontSize: 9.5.sp, color: const Color(0xFF757575))),
              ],
            ),
          ),

          Container(height: 36.h, width: 1, color: const Color(0xFFECEFF1)),

          // Col 2: Time
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.access_time_rounded, color: const Color(0xFF2E7D32), size: 13.sp),
                    SizedBox(width: 3.w),
                    Text('समय', style: TextStyle(fontSize: 10.sp, color: const Color(0xFF757575))),
                  ],
                ),
                SizedBox(height: 3.h),
                Text('08:00 AM - 09:00 AM', style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w800, color: const Color(0xFF1C1C1C))),
                Text('(1 घंटा)', style: TextStyle(fontSize: 9.5.sp, color: const Color(0xFF757575))),
              ],
            ),
          ),

          Container(height: 36.h, width: 1, color: const Color(0xFFECEFF1)),

          // Col 3: Duration
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.timer_outlined, color: const Color(0xFF2E7D32), size: 13.sp),
                    SizedBox(width: 3.w),
                    Text('कुल अनुमानित समय', style: TextStyle(fontSize: 9.sp, color: const Color(0xFF757575))),
                  ],
                ),
                SizedBox(height: 3.h),
                Text('1 घंटा', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w900, color: const Color(0xFF1C1C1C))),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 5. REQUIRED WORK CHIPS ---
  Widget _buildRequiredWorkChips() {
    final workList = [
      {'icon': Icons.agriculture_rounded, 'title': 'जुताई'},
      {'icon': Icons.grid_view_rounded, 'title': 'बुआई'},
      {'icon': Icons.architecture_rounded, 'title': 'लेजर लेवलिंग'},
      {'icon': Icons.local_shipping_rounded, 'title': 'ढुलाई'},
      {'icon': Icons.more_horiz_rounded, 'title': 'अन्य कृषि कार्य'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.settings_rounded, color: const Color(0xFF2E7D32), size: 15.sp),
            SizedBox(width: 6.w),
            Text(
              'आवश्यक कार्य',
              style: TextStyle(
                fontSize: 13.5.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1C1C1C),
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: Row(
            children: workList.map((work) {
              return Container(
                margin: EdgeInsets.only(right: 6.w),
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F9F4),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFFE2EFE4)),
                ),
                child: Row(
                  children: [
                    Icon(work['icon'] as IconData, color: const Color(0xFF2E7D32), size: 13.sp),
                    SizedBox(width: 4.w),
                    Text(
                      work['title'] as String,
                      style: TextStyle(fontSize: 10.5.sp, fontWeight: FontWeight.w700, color: const Color(0xFF2E7D32)),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  // --- 6. PAYMENT DETAILS CARD ---
  Widget _buildPaymentDetailsCard() {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFECEFF1), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.receipt_long_outlined, color: const Color(0xFF2E7D32), size: 16.sp),
              SizedBox(width: 6.w),
              Text(
                'भुगतान विवरण',
                style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.w800, color: const Color(0xFF1C1C1C)),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          _buildPaymentRow('सेवा शुल्क (1 घंटा)', '₹800.00'),
          SizedBox(height: 6.h),
          _buildPaymentRow('प्लेटफॉर्म शुल्क', '₹20.00'),
          const Divider(height: 16, color: Color(0xFFECEFF1)),
          _buildPaymentRow('कुल', '₹820.00', isBold: true),
          SizedBox(height: 10.h),

          // Highlighted Pay Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F9F4),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: const Color(0xFFE2EFE4)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'आपको भुगतान करना है',
                  style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w800, color: const Color(0xFF2E7D32)),
                ),
                Text(
                  '₹820.00',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w900, color: const Color(0xFF2E7D32)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String amount, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isBold ? 12.5.sp : 11.sp,
            fontWeight: isBold ? FontWeight.w800 : FontWeight.w500,
            color: isBold ? const Color(0xFF1C1C1C) : const Color(0xFF616161),
          ),
        ),
        Text(
          amount,
          style: TextStyle(
            fontSize: isBold ? 13.sp : 11.5.sp,
            fontWeight: isBold ? FontWeight.w900 : FontWeight.w700,
            color: const Color(0xFF1C1C1C),
          ),
        ),
      ],
    );
  }

  // --- 7. SECURE BOOKING GUARANTEE CARD ---
  Widget _buildSecureBookingCard() {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F9F4),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFE2EFE4)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.verified_user_rounded, color: const Color(0xFF2E7D32), size: 18.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'सुरक्षित बुकिंग',
                  style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w800, color: const Color(0xFF2E7D32)),
                ),
                SizedBox(height: 1.h),
                Text(
                  'आपका भुगतान सुरक्षित है। सेवा पूरी होने के बाद ही प्रदाता को भुगतान किया जाएगा।',
                  style: TextStyle(fontSize: 9.5.sp, color: const Color(0xFF616161), height: 1.25),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 8. IMPORTANT INFORMATION SECTION ---
  Widget _buildImportantInfoSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.info_outline_rounded, color: const Color(0xFF616161), size: 14.sp),
            SizedBox(width: 5.w),
            Text(
              'महत्वपूर्ण जानकारी',
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w800, color: const Color(0xFF424242)),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle_outlined, color: const Color(0xFF2E7D32), size: 12.sp),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                'सेवा शुरू होने से 2 घंटे पहले तक बुकिंग में बदलाव/रद्द किया जा सकता है।',
                style: TextStyle(fontSize: 9.5.sp, color: const Color(0xFF616161)),
              ),
            ),
          ],
        ),
        SizedBox(height: 3.h),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.check_circle_outlined, color: const Color(0xFF2E7D32), size: 12.sp),
            SizedBox(width: 4.w),
            Expanded(
              child: Text(
                'रद्द करने पर हमारी रद्द नीति लागू होगी।',
                style: TextStyle(fontSize: 9.5.sp, color: const Color(0xFF616161)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- 9. FIXED BOTTOM ACTION BAR (2 BUTTONS) ---
  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(top: BorderSide(color: Color(0xFFEEEEEE), width: 1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        children: [
          // Back Button (< वापस जाएं)
          InkWell(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFFD0D0D0), width: 1),
              ),
              child: Row(
                children: [
                  Icon(Icons.chevron_left_rounded, color: const Color(0xFF424242), size: 18.sp),
                  SizedBox(width: 2.w),
                  Text(
                    'वापस जाएं',
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF424242),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(width: 10.w),

          // Proceed and Pay Button (आगे बढ़ें और भुगतान करें >)
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                Get.snackbar(
                  'सफलता!',
                  'आपकी बुकिंग और भुगतान सफलतापूर्वक पूरा हुआ!',
                  backgroundColor: const Color(0xFF0F5229),
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0F5229),
                padding: EdgeInsets.symmetric(vertical: 11.h),
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'आगे बढ़ें और भुगतान करें',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  Icon(Icons.chevron_right_rounded, color: Colors.white, size: 18.sp),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
