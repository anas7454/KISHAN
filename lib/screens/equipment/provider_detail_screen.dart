import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:constructo_worker/routes/app_routes_name.dart';
import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';

class ProviderDetailScreen extends StatefulWidget {
  const ProviderDetailScreen({super.key});

  @override
  State<ProviderDetailScreen> createState() => _ProviderDetailScreenState();
}

class _ProviderDetailScreenState extends State<ProviderDetailScreen> {
  bool isSaved = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      body: SafeArea(
        child: Stack(
          children: [
            // 1. SCROLLABLE BODY CONTENT
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),

                    // TOP CONTROLS & SIDE-BY-SIDE HEADER
                    _buildSideBySideHeader(context),

                    SizedBox(height: 14.h),

                    // SPECIFICATIONS 4-COLUMN BOX
                    _buildSpecificationsCard(),

                    SizedBox(height: 14.h),

                    // ABOUT SERVICE PROVIDER (सेवा प्रदाता के बारे में)
                    _buildAboutProviderCard(),

                    SizedBox(height: 14.h),

                    // AVAILABLE SERVICES (उपलब्ध सेवाएं)
                    _buildAvailableServices(),

                    SizedBox(height: 14.h),

                    // TIMING & BOOKING POLICY CONTAINER
                    _buildServiceDetailsBox(),

                    SizedBox(height: 14.h),

                    // CUSTOMER REVIEWS (ग्राहक समीक्षा 125+)
                    _buildCustomerReviewsSection(),

                    SizedBox(height: 70.h), // Bottom spacing for action bar
                  ],
                ),
              ),
            ),

            // 2. FIXED BOTTOM ACTION BAR (3 BUTTONS)
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

  // --- 1. SIDE-BY-SIDE BANNER & PROVIDER DETAILS HEADER ---
  Widget _buildSideBySideHeader(BuildContext context) {
    return Stack(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // LEFT: TRACTOR PHOTO CARD WITH IMAGE COUNTER
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16.r),
                  child: SizedBox(
                    width: 145.w,
                    height: 195.h,
                    child: Image.asset(
                      ImageUtility.greenTractorBanner,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: const Color(0xFF1E6E38),
                        child: Icon(Icons.agriculture_rounded, size: 50.sp, color: Colors.white),
                      ),
                    ),
                  ),
                ),

                // Image Count Pill (📷 1/8)
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.image_outlined, color: Colors.white, size: 11.sp),
                        SizedBox(width: 3.w),
                        Text(
                          '1/8',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(width: 12.w),

            // RIGHT: PROVIDER DETAILS & PRICE CARD
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 38.h), // Top spacing for floating back/share/heart buttons

                  // Rating Badge Pill (★ 4.8)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.5.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F5229),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star_rounded, color: Colors.white, size: 12.sp),
                        SizedBox(width: 2.w),
                        Text(
                          '4.8',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 4.h),

                  // Provider Name
                  Text(
                    'रामू कृषि सेवा',
                    style: TextStyle(
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF1C1C1C),
                    ),
                  ),

                  SizedBox(height: 2.h),

                  // Machine Subtitle
                  Text(
                    'ट्रैक्टर सेवा (45 HP)',
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      color: const Color(0xFF616161),
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  SizedBox(height: 3.h),

                  // Distance & Location
                  Row(
                    children: [
                      Icon(Icons.location_on, color: const Color(0xFFE53935), size: 12.sp),
                      SizedBox(width: 2.w),
                      Expanded(
                        child: Text(
                          'बरखेड़ा, सीहोर, मध्य प्रदेश (1.2 किमी दूर)',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color(0xFF757575),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 4.h),

                  // Experience & Completed Services Stats
                  Row(
                    children: [
                      Icon(Icons.verified_user_outlined, color: const Color(0xFF616161), size: 11.sp),
                      SizedBox(width: 3.w),
                      Text(
                        '15+ वर्ष का अनुभव',
                        style: TextStyle(fontSize: 9.5.sp, color: const Color(0xFF616161)),
                      ),
                      SizedBox(width: 6.w),
                      Icon(Icons.work_outline, color: const Color(0xFF616161), size: 11.sp),
                      SizedBox(width: 3.w),
                      Text(
                        '1200+ सेवाएं पूरी',
                        style: TextStyle(fontSize: 9.5.sp, color: const Color(0xFF616161)),
                      ),
                    ],
                  ),

                  SizedBox(height: 6.h),

                  // Feature Pills Row
                  Wrap(
                    spacing: 4.w,
                    runSpacing: 4.h,
                    children: [
                      _buildSmallTag('समय पर सेवा'),
                      _buildSmallTag('विश्वसनीय'),
                      _buildSmallTag('अच्छे उपकरण'),
                    ],
                  ),

                  SizedBox(height: 8.h),

                  // Light Green Price Box
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF3F9F4),
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(color: const Color(0xFFE2EFE4)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '₹800',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF2E7D32),
                              ),
                            ),
                            Text(
                              ' / घंटा',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF424242),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'न्यूनतम 2 घंटा बुकिंग',
                          style: TextStyle(
                            fontSize: 9.5.sp,
                            color: const Color(0xFF757575),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // FLOATING TOP CONTROLS (Back Arrow, Share, Heart)
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Back Button
              InkWell(
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.all(7.r),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_back, color: const Color(0xFF2E7D32), size: 18.sp),
                ),
              ),

              // Share & Favorite Buttons
              Row(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(7.r),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.share_outlined, color: const Color(0xFF2E7D32), size: 16.sp),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isSaved = !isSaved;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(7.r),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isSaved ? Icons.favorite : Icons.favorite_border_rounded,
                        color: isSaved ? const Color(0xFFFF5252) : const Color(0xFF424242),
                        size: 16.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
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

  // --- 2. SPECIFICATIONS 4-COLUMN BOX ---
  Widget _buildSpecificationsCard() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFECEFF1), width: 1),
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
          Icon(icon, color: const Color(0xFF2E7D32), size: 19.sp),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 11.5.sp,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1C1C1C),
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 9.5.sp,
              color: const Color(0xFF757575),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      height: 32.h,
      width: 1,
      color: const Color(0xFFECEFF1),
    );
  }

  // --- 3. ABOUT SERVICE PROVIDER ---
  Widget _buildAboutProviderCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'सेवा प्रदाता के बारे में',
          style: TextStyle(
            fontSize: 14.5.sp,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1C1C1C),
          ),
        ),
        SizedBox(height: 6.h),
        Row(
          children: [
            Expanded(
              child: Text(
                'हम पिछले 15+ वर्षों से किसानों को ट्रैक्टर और अन्य कृषि कार्यों की विश्वसनीय और समय पर सेवा प्रदान कर रहे हैं।',
                style: TextStyle(
                  fontSize: 11.sp,
                  color: const Color(0xFF555555),
                  height: 1.35,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E9),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: const Color(0xFFC8E6C9)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.verified_rounded, color: const Color(0xFF2E7D32), size: 14.sp),
                      SizedBox(width: 4.w),
                      Text(
                        'सत्यापित सेवा प्रदाता',
                        style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF2E7D32),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  Row(
                    children: [
                      Icon(Icons.star_rounded, color: const Color(0xFFFFB300), size: 13.sp),
                      SizedBox(width: 4.w),
                      Text(
                        'दस्तावेज़ सत्यापित',
                        style: TextStyle(
                          fontSize: 9.5.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF1C1C1C),
                        ),
                      ),
                      Icon(Icons.chevron_right_rounded, color: const Color(0xFF616161), size: 14.sp),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // --- 4. AVAILABLE SERVICES ---
  Widget _buildAvailableServices() {
    final services = [
      {'icon': Icons.agriculture_rounded, 'title': 'जुताई'},
      {'icon': Icons.grid_view_rounded, 'title': 'बुआई'},
      {'icon': Icons.architecture_rounded, 'title': 'लेजर लेवलिंग'},
      {'icon': Icons.local_shipping_rounded, 'title': 'ढुलाई'},
      {'icon': Icons.more_horiz_rounded, 'title': 'अन्य कृषि कार्य'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'उपलब्ध सेवाएं',
          style: TextStyle(
            fontSize: 14.5.sp,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1C1C1C),
          ),
        ),
        SizedBox(height: 6.h),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: Row(
            children: services.map((item) {
              return Container(
                margin: EdgeInsets.only(right: 8.w),
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 7.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4F9F5),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: const Color(0xFFE0EFE4), width: 1),
                ),
                child: Row(
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      color: const Color(0xFF2E7D32),
                      size: 14.sp,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      item['title'] as String,
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF2E7D32),
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

  // --- 5. TIMING & BOOKING POLICY CONTAINER ---
  Widget _buildServiceDetailsBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: const Color(0xFFECEFF1), width: 1),
      ),
      child: Column(
        children: [
          _buildInfoRow(
            icon: Icons.access_time_rounded,
            label: 'उपलब्ध समय',
            value: 'सुबह 6:00 बजे से शाम 7:00 बजे तक',
          ),
          const Divider(height: 1, color: Color(0xFFECEFF1)),
          _buildInfoRow(
            icon: Icons.location_on_outlined,
            label: 'सेवा क्षेत्र',
            value: '2.5 किमी के दायरे में',
          ),
          const Divider(height: 1, color: Color(0xFFECEFF1)),
          _buildInfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'बुकिंग नीति',
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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF2E7D32), size: 15.sp),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              color: const Color(0xFF616161),
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 11.sp,
              color: const Color(0xFF1C1C1C),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // --- 6. CUSTOMER REVIEWS SECTION ---
  Widget _buildCustomerReviewsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'ग्राहक समीक्षा (125+)',
              style: TextStyle(
                fontSize: 14.5.sp,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1C1C1C),
              ),
            ),
            Row(
              children: [
                Text(
                  'सभी देखें',
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF2E7D32),
                  ),
                ),
                Icon(Icons.chevron_right_rounded, color: const Color(0xFF2E7D32), size: 16.sp),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(10.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFECEFF1)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left Score Column
              Column(
                children: [
                  Text(
                    '4.8',
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF1C1C1C),
                    ),
                  ),
                  Row(
                    children: List.generate(
                      5,
                      (index) => Icon(Icons.star_rounded, color: const Color(0xFFFFB300), size: 13.sp),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '125+ रेटिंग',
                    style: TextStyle(fontSize: 9.5.sp, color: const Color(0xFF757575)),
                  ),
                ],
              ),

              SizedBox(width: 12.w),
              Container(width: 1, height: 80.h, color: const Color(0xFFECEFF1)),
              SizedBox(width: 12.w),

              // Right Customer Review Cards List
              Expanded(
                child: Column(
                  children: [
                    _buildReviewItem(
                      avatar: ImageUtility.farmerReviewAvatar1,
                      name: 'मोहन पटेल',
                      rating: '5.0',
                      time: '2 दिन पहले',
                      comment: 'बहुत अच्छी सेवा, समय पर आए और काम बहुत अच्छा किया।',
                    ),
                    const Divider(height: 12, color: Color(0xFFECEFF1)),
                    _buildReviewItem(
                      avatar: ImageUtility.farmerReviewAvatar2,
                      name: 'किशन चौहान',
                      rating: '4.5',
                      time: '1 सप्ताह पहले',
                      comment: 'ट्रैक्टर और ऑपरेटर दोनों बहुत अच्छे थे। जल्द दोबारा बुक करूंगा।',
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

  Widget _buildReviewItem({
    required String avatar,
    required String name,
    required String rating,
    required String time,
    required String comment,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 12.r,
                  backgroundImage: AssetImage(avatar),
                ),
                SizedBox(width: 6.w),
                Text(
                  name,
                  style: TextStyle(fontSize: 11.5.sp, fontWeight: FontWeight.w800, color: const Color(0xFF1C1C1C)),
                ),
                SizedBox(width: 4.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: Row(
                    children: [
                      Text(
                        rating,
                        style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold, color: const Color(0xFF2E7D32)),
                      ),
                      Icon(Icons.star_rounded, color: const Color(0xFF2E7D32), size: 9.sp),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              time,
              style: TextStyle(fontSize: 9.sp, color: const Color(0xFF757575)),
            ),
          ],
        ),
        SizedBox(height: 3.h),
        Text(
          comment,
          style: TextStyle(fontSize: 10.5.sp, color: const Color(0xFF555555)),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  // --- 7. FIXED BOTTOM ACTION BAR (3 BUTTONS) ---
  Widget _buildBottomActionBar(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
          // Message Button
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.chat_bubble_outline_rounded, color: const Color(0xFF2E7D32), size: 15.sp),
              label: Text(
                'संदेश भेजें',
                style: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2E7D32),
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF2E7D32), width: 1.2),
                padding: EdgeInsets.symmetric(vertical: 9.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
            ),
          ),

          SizedBox(width: 6.w),

          // Call Button
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.call_outlined, color: const Color(0xFF2E7D32), size: 15.sp),
              label: Text(
                'कॉल करें',
                style: TextStyle(
                  fontSize: 11.5.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2E7D32),
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF2E7D32), width: 1.2),
                padding: EdgeInsets.symmetric(vertical: 9.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
              ),
            ),
          ),

          SizedBox(width: 6.w),

          // Book Now Button (Navigates to Date & Time Slot Screen)
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => Get.toNamed(AppRouteName.bookingSlotScreen),
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
      ),
    );
  }
}
