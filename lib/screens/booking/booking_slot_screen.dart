import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:constructo_worker/routes/app_routes_name.dart';
import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';

class BookingSlotScreen extends StatefulWidget {
  const BookingSlotScreen({super.key});

  @override
  State<BookingSlotScreen> createState() => _BookingSlotScreenState();
}

class _BookingSlotScreenState extends State<BookingSlotScreen> {
  int selectedDateIndex = 0; // Default selected 28 May
  int selectedTimeSlotIndex = 2; // Default selected 08:00 AM - 09:00 AM

  final List<Map<String, String>> dateList = [
    {'tag': 'आज', 'date': '28', 'month': 'मई', 'day': 'बुधवार'},
    {'tag': 'कल', 'date': '29', 'month': 'मई', 'day': 'गुरुवार'},
    {'tag': '', 'date': '30', 'month': 'मई', 'day': 'शुक्रवार'},
    {'tag': '', 'date': '31', 'month': 'मई', 'day': 'शनिवार'},
    {'tag': '', 'date': '01', 'month': 'जून', 'day': 'रविवार'},
    {'tag': '', 'date': '02', 'month': 'जून', 'day': 'सोमवार'},
    {'tag': '', 'date': '03', 'month': 'जून', 'day': 'मंगलवार'},
  ];

  final List<String> timeSlots = [
    '06:00 AM - 07:00 AM',
    '07:00 AM - 08:00 AM',
    '08:00 AM - 09:00 AM',
    '09:00 AM - 10:00 AM',
    '10:00 AM - 11:00 AM',
    '11:00 AM - 12:00 PM',
    '12:00 PM - 01:00 PM',
    '01:00 PM - 02:00 PM',
    '02:00 PM - 03:00 PM',
    '03:00 PM - 04:00 PM',
    '04:00 PM - 05:00 PM',
    '05:00 PM - 06:00 PM',
    '06:00 PM - 07:00 PM',
    '07:00 PM - 08:00 PM',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      body: SafeArea(
        child: Column(
          children: [
            // 1. TOP APP BAR HEADER
            _buildHeader(context),

            // 2. MAIN SCROLLABLE CONTENT
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 14.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),

                      // SELECTED EQUIPMENT SUMMARY CARD
                      _buildEquipmentSummaryCard(),

                      SizedBox(height: 14.h),

                      // SELECT DATE SECTION (तारीख चुनें)
                      _buildDateSelectionSection(),

                      SizedBox(height: 16.h),

                      // SELECT TIME SECTION (समय चुनें)
                      _buildTimeSelectionSection(),

                      SizedBox(height: 16.h),

                      // YOUR BOOKING SUMMARY BOX (आपकी बुकिंग जानकारी)
                      _buildBookingSummaryBox(),

                      SizedBox(height: 12.h),

                      // RESCHEDULE NOTICE BANNER
                      _buildNoticeBanner(),

                      SizedBox(height: 16.h),

                      // PROCEED CTA BUTTON (आगे बढ़ें >)
                      _buildProceedButton(context),

                      SizedBox(height: 16.h),
                    ],
                  ),
                ),
              ),
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
                  'तारीख और समय चुनें',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1C1C1C),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'अपनी सुविधा के अनुसार सेवा का समय चुनें',
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

  // --- 2. SELECTED EQUIPMENT SUMMARY CARD ---
  Widget _buildEquipmentSummaryCard() {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: const Color(0xFFFAFCFA),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2EFE4), width: 1),
      ),
      child: Row(
        children: [
          // Tractor Photo Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: SizedBox(
              width: 75.w,
              height: 75.h,
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

          // Machine Details Column
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
                    fontSize: 10.sp,
                    color: const Color(0xFF757575),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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

          SizedBox(width: 6.w),

          // View Details Button
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              'सेवा विवरण देखें',
              style: TextStyle(
                fontSize: 10.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF2E7D32),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- 3. SELECT DATE SECTION (तारीख चुनें) ---
  Widget _buildDateSelectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.calendar_today_rounded, color: const Color(0xFF2E7D32), size: 16.sp),
                SizedBox(width: 6.w),
                Text(
                  'तारीख चुनें',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1C1C1C),
                  ),
                ),
              ],
            ),
            Icon(Icons.chevron_right_rounded, color: const Color(0xFF2E7D32), size: 20.sp),
          ],
        ),
        SizedBox(height: 8.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: Row(
            children: List.generate(dateList.length, (index) {
              final item = dateList[index];
              final isSelected = selectedDateIndex == index;

              return InkWell(
                onTap: () => setState(() => selectedDateIndex = index),
                child: Container(
                  margin: EdgeInsets.only(right: 8.w),
                  width: 58.w,
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFE8F5E9) : Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFFE0E0E0),
                      width: isSelected ? 1.5 : 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        item['tag']!.isNotEmpty ? item['tag']! : ' ',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF757575),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        item['date']!,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w900,
                          color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF1C1C1C),
                        ),
                      ),
                      Text(
                        item['month']!,
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF616161),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        item['day']!,
                        style: TextStyle(
                          fontSize: 8.5.sp,
                          color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF757575),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  // --- 4. SELECT TIME SECTION (समय चुनें Grid) ---
  Widget _buildTimeSelectionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.access_time_rounded, color: const Color(0xFF2E7D32), size: 16.sp),
            SizedBox(width: 6.w),
            Text(
              'समय चुनें',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1C1C1C),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        // 3 Column Grid of Time Slots
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: timeSlots.length + 1, // 14 slots + 1 notice pill
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 2.6,
            crossAxisSpacing: 8.w,
            mainAxisSpacing: 8.h,
          ),
          itemBuilder: (context, index) {
            if (index == timeSlots.length) {
              // 15th Cell: Mandatory 2 Hours Notice Pill
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF3F9F4),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFFE2EFE4)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.info_outline_rounded, color: const Color(0xFF2E7D32), size: 11.sp),
                    SizedBox(width: 3.w),
                    Expanded(
                      child: Text(
                        'न्यूनतम 2 घंटे की बुकिंग अनिवार्य है',
                        style: TextStyle(
                          fontSize: 7.5.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2E7D32),
                          height: 1.1,
                        ),
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              );
            }

            final isSelected = selectedTimeSlotIndex == index;

            return InkWell(
              onTap: () => setState(() => selectedTimeSlotIndex = index),
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected ? const Color(0xFF0F5229) : Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: isSelected ? const Color(0xFF0F5229) : const Color(0xFFE0E0E0),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        timeSlots[index],
                        style: TextStyle(
                          fontSize: 9.5.sp,
                          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                          color: isSelected ? Colors.white : const Color(0xFF424242),
                        ),
                      ),
                      if (isSelected) ...[
                        SizedBox(width: 3.w),
                        Icon(Icons.check_circle_rounded, color: Colors.white, size: 11.sp),
                      ],
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // --- 5. YOUR BOOKING SUMMARY BOX (आपकी बुकिंग जानकारी) ---
  Widget _buildBookingSummaryBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'आपकी बुकिंग जानकारी',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1C1C1C),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
          decoration: BoxDecoration(
            color: const Color(0xFFFAFCFA),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFEAEFEA), width: 1),
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
                        Text(
                          'तारीख',
                          style: TextStyle(fontSize: 10.sp, color: const Color(0xFF757575)),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      '28 मई 2025',
                      style: TextStyle(fontSize: 11.5.sp, fontWeight: FontWeight.w800, color: const Color(0xFF1C1C1C)),
                    ),
                    Text(
                      'बुधवार',
                      style: TextStyle(fontSize: 9.5.sp, color: const Color(0xFF757575)),
                    ),
                  ],
                ),
              ),

              Container(height: 36.h, width: 1, color: const Color(0xFFEAEFEA)),

              // Col 2: Time
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.access_time_rounded, color: const Color(0xFF2E7D32), size: 13.sp),
                        SizedBox(width: 3.w),
                        Text(
                          'समय',
                          style: TextStyle(fontSize: 10.sp, color: const Color(0xFF757575)),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      '08:00 AM - 09:00 AM',
                      style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w800, color: const Color(0xFF1C1C1C)),
                    ),
                    Text(
                      '(1 घंटा)',
                      style: TextStyle(fontSize: 9.5.sp, color: const Color(0xFF757575)),
                    ),
                  ],
                ),
              ),

              Container(height: 36.h, width: 1, color: const Color(0xFFEAEFEA)),

              // Col 3: Total Price
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.agriculture_rounded, color: const Color(0xFF2E7D32), size: 13.sp),
                        SizedBox(width: 3.w),
                        Text(
                          'कुल अनुमानित',
                          style: TextStyle(fontSize: 10.sp, color: const Color(0xFF757575)),
                        ),
                      ],
                    ),
                    SizedBox(height: 3.h),
                    Text(
                      '₹800',
                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w900, color: const Color(0xFF2E7D32)),
                    ),
                    Text(
                      '(1 घंटा × ₹800)',
                      style: TextStyle(fontSize: 9.sp, color: const Color(0xFF757575)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- 6. RESCHEDULE NOTICE BANNER ---
  Widget _buildNoticeBanner() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(Icons.check_circle_rounded, color: const Color(0xFF2E7D32), size: 16.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              'आप बुकिंग पूरी होने के बाद समय को 1 बार बदल सकते हैं।',
              style: TextStyle(
                fontSize: 10.5.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2E7D32),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- 7. PROCEED CTA BUTTON (आगे बढ़ें >) ---
  Widget _buildProceedButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => Get.toNamed(AppRouteName.bookingSummaryScreen),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0F5229),
          padding: EdgeInsets.symmetric(vertical: 12.h),
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'आगे बढ़ें',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            SizedBox(width: 6.w),
            Icon(Icons.chevron_right_rounded, color: Colors.white, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
