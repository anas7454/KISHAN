import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:constructo_worker/routes/app_routes_name.dart';
import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';

class EquipmentDetailScreen extends StatefulWidget {
  const EquipmentDetailScreen({super.key});

  @override
  State<EquipmentDetailScreen> createState() => _EquipmentDetailScreenState();
}

class _EquipmentDetailScreenState extends State<EquipmentDetailScreen> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBEBEB),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              // 1. TOP HERO IMAGE BANNER
              _buildHeroBanner(context),

              // 2. OVERLAPPING DITTO WHITE CARD SHEET
              Transform.translate(
                offset: Offset(0, -22.h),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(left: 14.w, right: 14.w, top: 14.h, bottom: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // HEADER TITLE & ICON BADGE ROW
                      _buildTitleHeader(),

                      SizedBox(height: 6.h),

                      // RATING & DISTANCE ROW
                      _buildRatingRow(),

                      SizedBox(height: 10.h),

                      // SPECIFICATIONS 4-COLUMN BOX
                      _buildSpecificationsCard(),

                      SizedBox(height: 10.h),

                      // PRICING ROW WITH TAX INCLUDED PILL
                      _buildPricingRow(),

                      SizedBox(height: 10.h),

                      // INCLUDED IN SERVICE (सेवा में शामिल)
                      _buildIncludedServices(),

                      SizedBox(height: 10.h),

                      // AVAILABLE WORK CHIPS (उपलब्ध कार्य)
                      _buildAvailableWork(),

                      SizedBox(height: 10.h),

                      // TIMINGS, AREA & CANCELLATION BOX
                      _buildServiceDetailsBox(),

                      SizedBox(height: 12.h),

                      // 3 ACTION BUTTONS INSIDE DITTO CARD
                      _buildBottomActionBar(context),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- 1. HERO IMAGE BANNER ---
  Widget _buildHeroBanner(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 215.h,
          width: double.infinity,
          child: Image.asset(
            ImageUtility.greenTractorBanner,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: const Color(0xFF1E6E38),
              child: Icon(Icons.agriculture_rounded, size: 70.sp, color: Colors.white),
            ),
          ),
        ),

        // Gradient Overlay
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 80.h,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withValues(alpha: 0.5), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        // Back Button (Top Left)
        Positioned(
          top: MediaQuery.of(context).padding.top + 8.h,
          left: 16.w,
          child: InkWell(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(7.r),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back, color: const Color(0xFF1F2937), size: 18.sp),
            ),
          ),
        ),

        // Language Switcher & Share Buttons (Top Right)
        Positioned(
          top: MediaQuery.of(context).padding.top + 8.h,
          right: 16.w,
          child: Row(
            children: [
              // Language Switcher Pill
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.language, color: const Color(0xFF1E6E38), size: 14.sp),
                    SizedBox(width: 4.w),
                    Text(
                      'भाषा बदलें',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E6E38),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 8.w),

              // Share Button
              Container(
                padding: EdgeInsets.all(7.r),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.share_outlined, color: const Color(0xFF1F2937), size: 18.sp),
              ),
            ],
          ),
        ),

        // Image Counter Pill (📷 1/6)
        Positioned(
          bottom: 30.h,
          left: 16.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.5.h),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(Icons.image_outlined, color: Colors.white, size: 12.sp),
                SizedBox(width: 4.w),
                Text(
                  '1/6',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- 2. TITLE HEADER ROW ---
  Widget _buildTitleHeader() {
    return Row(
      children: [
        // Green Circular Icon Container
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF5ED),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.agriculture_rounded,
            color: const Color(0xFF1E6E38),
            size: 26.sp,
          ),
        ),

        SizedBox(width: 12.w),

        // Title & Subtitle
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ट्रैक्टर सेवा (45 HP)',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1F2937),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'जुताई, बुआई, ढुलाई और अन्य कृषि कार्यों के लिए',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey[600],
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- 3. RATING & DISTANCE ROW ---
  Widget _buildRatingRow() {
    return Row(
      children: [
        Icon(Icons.star_rounded, color: const Color(0xFF1E6E38), size: 16.sp),
        SizedBox(width: 4.w),
        Text(
          '4.8',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F2937),
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          '(125+ रेटिंग)',
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          '•',
          style: TextStyle(color: Colors.grey[400], fontSize: 12.sp),
        ),
        SizedBox(width: 8.w),
        Text(
          '2.5 किमी के दायरे में उपलब्ध',
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  // --- 4. SPECIFICATIONS 4-COLUMN BOX ---
  Widget _buildSpecificationsCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Row(
        children: [
          _buildSpecItem(Icons.speed_rounded, '45 HP', 'इंजन पावर'),
          _buildVerticalDivider(),
          _buildSpecItem(Icons.local_gas_station_rounded, 'डीजल', 'ईंधन प्रकार'),
          _buildVerticalDivider(),
          _buildSpecItem(Icons.settings_rounded, 'मैनुअल', 'गियर बॉक्स'),
          _buildVerticalDivider(),
          _buildSpecItem(Icons.fitness_center_rounded, '1800 KG', 'लिफ्ट क्षमता'),
        ],
      ),
    );
  }

  Widget _buildSpecItem(IconData icon, String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: const Color(0xFF1E6E38), size: 20.sp),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1F2937),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 35.h,
      width: 1,
      color: const Color(0xFFE5E7EB),
    );
  }

  // --- 5. PRICING ROW ---
  Widget _buildPricingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '₹800',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1E6E38),
                  ),
                ),
                Text(
                  ' / घंटा',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF374151),
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Text(
              'न्यूनतम 2 घंटा बुकिंग',
              style: TextStyle(
                fontSize: 10.5.sp,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),

        // Tax Included Pill
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: const Color(0xFFEAF5ED),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            'टैक्स शामिल',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1E6E38),
            ),
          ),
        ),
      ],
    );
  }

  // --- 6. INCLUDED IN SERVICE ---
  Widget _buildIncludedServices() {
    final inclusions = [
      'अनुभवी ड्राइवर',
      'ईंधन खर्च (आपको अलग से भुगतान नहीं करना है)',
      'मशीन की पूरी देखरेख',
      'समय पर सेवा',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'सेवा में शामिल',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F2937),
          ),
        ),
        SizedBox(height: 8.h),
        Column(
          children: inclusions.map((text) {
            return Padding(
              padding: EdgeInsets.only(bottom: 6.h),
              child: Row(
                children: [
                  Icon(Icons.check_circle_outline_rounded, color: const Color(0xFF1E6E38), size: 16.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        color: const Color(0xFF4B5563),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  // --- 7. AVAILABLE WORK CHIPS ---
  Widget _buildAvailableWork() {
    final works = [
      {'icon': Icons.agriculture_rounded, 'title': 'जुताई'},
      {'icon': Icons.grid_view_rounded, 'title': 'बुआई'},
      {'icon': Icons.architecture_rounded, 'title': 'लेजर लेवलिंग'},
      {'icon': Icons.local_shipping_rounded, 'title': 'ढुलाई'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'उपलब्ध कार्य',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1F2937),
          ),
        ),
        SizedBox(height: 8.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: Row(
            children: works.map((item) {
              return Container(
                margin: EdgeInsets.only(right: 8.w),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFFF3F4F6)),
                ),
                child: Row(
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      color: const Color(0xFF1E6E38),
                      size: 15.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      item['title'] as String,
                      style: TextStyle(
                        fontSize: 11.5.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E6E38),
                      ),
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

  // --- 8. SERVICE DETAILS BOX ---
  Widget _buildServiceDetailsBox() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAFB),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFF3F4F6)),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.access_time_rounded,
            label: 'उपलब्ध समय',
            value: 'सुबह 6:00 बजे से शाम 7:00 बजे तक',
          ),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          _buildInfoRow(
            icon: Icons.location_on_outlined,
            label: 'सेवा क्षेत्र',
            value: '2.5 किमी के दायरे में',
          ),
          const Divider(height: 1, color: Color(0xFFF3F4F6)),
          _buildInfoRow(
            icon: Icons.verified_user_outlined,
            label: 'कैंसिलेशन नीति',
            value: 'बुकिंग से 2 घंटे पहले फ्री कैंसिल',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF1E6E38), size: 16.sp),
          SizedBox(width: 8.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.5.sp,
              color: Colors.grey[600],
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1F2937),
            ),
          ),
        ],
      ),
    );
  }

  // --- 9. ACTION BUTTONS INSIDE DITTO CARD ---
  Widget _buildBottomActionBar(BuildContext context) {
    return Row(
      children: [
        // Save Button
        OutlinedButton.icon(
          onPressed: () {
            setState(() {
              isSaved = !isSaved;
            });
          },
          icon: Icon(
            isSaved ? Icons.favorite : Icons.favorite_border_rounded,
            color: isSaved ? const Color(0xFFFF5252) : const Color(0xFF374151),
            size: 15.sp,
          ),
          label: Text(
            'सेव करें',
            style: TextStyle(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF374151),
            ),
          ),
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: Color(0xFFE5E7EB), width: 1.2),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 9.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          ),
        ),

        SizedBox(width: 8.w),

        // Send Message Button
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.chat_bubble_outline_rounded, color: const Color(0xFF1E6E38), size: 15.sp),
            label: Text(
              'संदेश भेजें',
              style: TextStyle(
                fontSize: 11.5.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E6E38),
              ),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFF1E6E38), width: 1.2),
              padding: EdgeInsets.symmetric(vertical: 9.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
          ),
        ),

        SizedBox(width: 8.w),

        // Book Now / View Providers Button
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => Get.toNamed(AppRouteName.equipmentListScreen),
            icon: Icon(Icons.calendar_month_rounded, color: Colors.white, size: 15.sp),
            label: Text(
              'बुक करें',
              style: TextStyle(
                fontSize: 11.5.sp,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1B5E20),
              padding: EdgeInsets.symmetric(vertical: 9.h),
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
            ),
          ),
        ),
      ],
    );
  }
}
