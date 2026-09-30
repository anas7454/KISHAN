import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:constructo_worker/routes/app_routes_name.dart';
import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';

class Bnb4MyOrderScreen extends StatefulWidget {
  const Bnb4MyOrderScreen({super.key});

  @override
  State<Bnb4MyOrderScreen> createState() => _Bnb4MyOrderScreenState();
}

class _Bnb4MyOrderScreenState extends State<Bnb4MyOrderScreen> {
  int selectedTab = 0; // 0: All, 1: Active, 2: Completed, 3: Cancelled

  final List<String> tabs = ['सभी (3)', 'सक्रिय (1)', 'पूर्ण (2)', 'रद्द (0)'];

  final List<Map<String, dynamic>> bookings = [
    {
      'providerName': 'रामू कृषि सेवा',
      'serviceTitle': 'ट्रैक्टर सेवा (45 HP)',
      'operator': 'रामू पाटीदार (सत्यापित)',
      'rating': '4.8',
      'image': ImageUtility.greenTractorBanner,
      'date': '28 मई 2025 (08:00 AM - 09:00 AM)',
      'location': 'ग्राम बरखेड़ा, सीहोर (1.2 किमी दूर)',
      'price': '₹800',
      'status': '🟢 लाइव जारी है',
      'statusColor': const Color(0xFF2E7D32),
      'statusBg': const Color(0xFFE8F5E9),
      'isActive': true,
      'bookingId': 'KS-89210',
    },
    {
      'providerName': 'किसान ट्रैक्टर सर्विस',
      'serviceTitle': 'ड्रोन स्प्रे सेवा (4 एकड़)',
      'operator': 'मोहन चौहान (सत्यापित)',
      'rating': '4.7',
      'image': ImageUtility.blueTractorCard,
      'date': '15 मई 2025 (10:00 AM)',
      'location': 'जावर रोड, सीहोर (1.8 किमी दूर)',
      'price': '₹750',
      'status': '✔ कार्य संपन्न',
      'statusColor': const Color(0xFF1565C0),
      'statusBg': const Color(0xFFE3F2FD),
      'isActive': false,
      'bookingId': 'KS-78192',
    },
    {
      'providerName': 'मालवा एग्री सर्विस',
      'serviceTitle': 'रोटावेटर 7 फीट सेवा',
      'operator': 'दिनेश मालवीय (सत्यापित)',
      'rating': '4.9',
      'image': ImageUtility.redTractorCard,
      'date': '02 मई 2025 (02:00 PM)',
      'location': 'सीहोर बस स्टैंड (2.1 किमी दूर)',
      'price': '₹700',
      'status': '✔ कार्य संपन्न',
      'statusColor': const Color(0xFF1565C0),
      'statusBg': const Color(0xFFE3F2FD),
      'isActive': false,
      'bookingId': 'KS-65120',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F5),
      body: SafeArea(
        child: Column(
          children: [
            // 1. TOP HEADER & FILTER TABS
            _buildHeader(),

            SizedBox(height: 10.h),

            // 2. SEARCH BAR
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.w),
              child: _buildSearchBar(),
            ),

            SizedBox(height: 12.h),

            // 3. BOOKINGS LIST
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
                itemCount: bookings.length,
                separatorBuilder: (context, index) => SizedBox(height: 14.h),
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return _buildEnhancedBookingCard(booking);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- 1. TOP HEADER & FILTER TABS ---
  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 12.h, bottom: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF0F5229), Color(0xFF2E7D32)],
                      ),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(Icons.assignment_turned_in_rounded, color: Colors.white, size: 20.sp),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'मेरी बुकिंग्स',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w900,
                          color: const Color(0xFF1C1C1C),
                          letterSpacing: 0.3,
                        ),
                      ),
                      Text(
                        'आपकी सभी कृषि सेवाओं का लाइव रिकॉर्ड',
                        style: TextStyle(fontSize: 10.5.sp, color: const Color(0xFF757575)),
                      ),
                    ],
                  ),
                ],
              ),

              // Active Count Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(color: const Color(0xFFC8E6C9)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.check_circle_rounded, color: const Color(0xFF2E7D32), size: 13.sp),
                    SizedBox(width: 4.w),
                    Text(
                      '3 कुल',
                      style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: const Color(0xFF2E7D32)),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          // Filter Tabs (सभी, सक्रिय, पूर्ण, रद्द)
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const ClampingScrollPhysics(),
            child: Row(
              children: List.generate(tabs.length, (index) {
                final isSelected = selectedTab == index;
                return InkWell(
                  onTap: () => setState(() => selectedTab = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: EdgeInsets.only(right: 8.w),
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
                    decoration: BoxDecoration(
                      gradient: isSelected
                          ? const LinearGradient(colors: [Color(0xFF0F5229), Color(0xFF2E7D32)])
                          : null,
                      color: isSelected ? null : const Color(0xFFF5F7F6),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: isSelected ? const Color(0xFF0F5229) : const Color(0xFFE0E0E0),
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: const Color(0xFF2E7D32).withValues(alpha: 0.25),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                        color: isSelected ? Colors.white : const Color(0xFF616161),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // --- 2. SEARCH BAR ---
  Widget _buildSearchBar() {
    return Container(
      height: 42.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE0E0E0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.search_rounded, color: const Color(0xFF2E7D32), size: 19.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'बुकिंग ID (KS-89210) या प्रदाता खोजें...',
                hintStyle: TextStyle(fontSize: 11.5.sp, color: Colors.grey[500]),
                border: InputBorder.none,
                isCollapsed: true,
              ),
            ),
          ),
          Icon(Icons.tune_rounded, color: Colors.grey[600], size: 17.sp),
        ],
      ),
    );
  }

  // --- 3. ENHANCED ULTRA-PREMIUM BOOKING CARD ---
  Widget _buildEnhancedBookingCard(Map<String, dynamic> booking) {
    final bool isActive = booking['isActive'] as bool;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: isActive ? const Color(0xFF81C784) : const Color(0xFFE2E8F0),
          width: isActive ? 1.5 : 1,
        ),
        boxShadow: [
          // Primary Deep 3D Elevation Shadow (Popped out / Ubhra hua)
          BoxShadow(
            color: isActive
                ? const Color(0xFF2E7D32).withValues(alpha: 0.18)
                : Colors.black.withValues(alpha: 0.09),
            blurRadius: 16,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
          // Secondary Ambient Soft Glow
          BoxShadow(
            color: isActive
                ? const Color(0xFF0F5229).withValues(alpha: 0.08)
                : Colors.black.withValues(alpha: 0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Accent Strip for Active Booking
          if (isActive)
            Container(
              height: 4.h,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF0F5229), Color(0xFF81C784)],
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
              ),
            ),

          Padding(
            padding: EdgeInsets.all(12.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row: Booking ID + Status Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.5.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F7F6),
                            borderRadius: BorderRadius.circular(6.r),
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                          ),
                          child: Text(
                            'ID: ${booking['bookingId']}',
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF424242),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Status Badge Pill
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: booking['statusBg'] as Color,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: (booking['statusColor'] as Color).withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        booking['status'] as String,
                        style: TextStyle(
                          fontSize: 10.5.sp,
                          fontWeight: FontWeight.w900,
                          color: booking['statusColor'] as Color,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 10.h),

                // Main Content: Image & Provider Info
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Machine Image Thumbnail with Rating Badge
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: SizedBox(
                            width: 82.w,
                            height: 82.h,
                            child: Image.asset(
                              booking['image'] as String,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: const Color(0xFFE8F5E9),
                                child: Icon(Icons.agriculture, size: 35.sp, color: const Color(0xFF2E7D32)),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 4.r,
                          left: 4.r,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.5.h),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.7),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.star_rounded, color: const Color(0xFFFFB300), size: 10.sp),
                                SizedBox(width: 2.w),
                                Text(
                                  booking['rating'] as String,
                                  style: TextStyle(color: Colors.white, fontSize: 9.sp, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(width: 12.w),

                    // Machine & Operator Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking['providerName'] as String,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFF1C1C1C),
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            booking['serviceTitle'] as String,
                            style: TextStyle(
                              fontSize: 11.5.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF2E7D32),
                            ),
                          ),
                          SizedBox(height: 3.h),
                          Row(
                            children: [
                              Icon(Icons.person_pin_circle_outlined, color: const Color(0xFF616161), size: 12.sp),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Text(
                                  booking['operator'] as String,
                                  style: TextStyle(fontSize: 10.sp, color: const Color(0xFF616161), fontWeight: FontWeight.w500),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 2.h),
                          Row(
                            children: [
                              Icon(Icons.calendar_today_outlined, color: const Color(0xFF616161), size: 11.sp),
                              SizedBox(width: 3.w),
                              Expanded(
                                child: Text(
                                  booking['date'] as String,
                                  style: TextStyle(fontSize: 10.sp, color: const Color(0xFF424242)),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8.h),

                // Location Box
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F7F6),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.location_on, color: const Color(0xFFE53935), size: 12.sp),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          booking['location'] as String,
                          style: TextStyle(fontSize: 10.sp, color: const Color(0xFF616161), fontWeight: FontWeight.w500),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                const Divider(height: 16, color: Color(0xFFECEFF1)),

                // Bottom Action Bar: Price + CTA Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'कुल मूल्य',
                          style: TextStyle(fontSize: 9.5.sp, color: const Color(0xFF757575)),
                        ),
                        Text(
                          booking['price'] as String,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF0F5229),
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        if (isActive) ...[
                          OutlinedButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.call_outlined, color: const Color(0xFF2E7D32), size: 13.sp),
                            label: Text('कॉल करें', style: TextStyle(fontSize: 10.5.sp, fontWeight: FontWeight.bold, color: const Color(0xFF2E7D32))),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF2E7D32), width: 1.2),
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                            ),
                          ),
                          SizedBox(width: 6.w),
                          ElevatedButton.icon(
                            onPressed: () => Get.toNamed(AppRouteName.bookingSummaryScreen),
                            icon: Icon(Icons.receipt_long_rounded, color: Colors.white, size: 13.sp),
                            label: Text('रसीद देखें', style: TextStyle(fontSize: 10.5.sp, fontWeight: FontWeight.bold, color: Colors.white)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0F5229),
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                            ),
                          ),
                        ] else ...[
                          OutlinedButton.icon(
                            onPressed: () => Get.toNamed(AppRouteName.equipmentDetailScreen),
                            icon: Icon(Icons.replay_rounded, color: const Color(0xFF2E7D32), size: 13.sp),
                            label: Text('पुनः बुक करें', style: TextStyle(fontSize: 10.5.sp, fontWeight: FontWeight.bold, color: const Color(0xFF2E7D32))),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: Color(0xFF2E7D32), width: 1.2),
                              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
