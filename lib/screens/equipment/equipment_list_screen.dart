import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:constructo_worker/routes/app_routes_name.dart';
import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';

class EquipmentListScreen extends StatefulWidget {
  const EquipmentListScreen({super.key});

  @override
  State<EquipmentListScreen> createState() => _EquipmentListScreenState();
}

class _EquipmentListScreenState extends State<EquipmentListScreen> {
  int selectedFilterIndex = 0;

  final List<String> filterChips = [
    'सभी',
    '4.0+ रेटिंग',
    'सबसे कम मूल्य',
    'फ़िल्टर',
  ];

  final List<Map<String, dynamic>> providerList = [
    {
      'name': 'रामू कृषि सेवा',
      'image': ImageUtility.greenTractorBanner,
      'rating': '4.8',
      'distance': 'बरखेड़ा, सीहोर (1.2 किमी दूर)',
      'experience': '15+ वर्ष अनुभव',
      'completed': '1200+ सेवाएं',
      'tags': ['समय पर सेवा', 'विश्वसनीय', 'अच्छे उपकरण'],
      'price': '₹800',
    },
    {
      'name': 'किसान ट्रैक्टर सर्विस',
      'image': ImageUtility.blueTractorCard,
      'rating': '4.6',
      'distance': 'जावर रोड, सीहोर (1.8 किमी दूर)',
      'experience': '10+ वर्ष अनुभव',
      'completed': '950+ सेवाएं',
      'tags': ['अच्छे उपकरण', 'समय पर सेवा', 'पेशेवर टीम'],
      'price': '₹750',
    },
    {
      'name': 'मालवा एग्री सर्विस',
      'image': ImageUtility.redTractorCard,
      'rating': '4.5',
      'distance': 'सीहोर बस स्टैंड (2.1 किमी दूर)',
      'experience': '8+ वर्ष अनुभव',
      'completed': '780+ सेवाएं',
      'tags': ['ईंधन बचत', 'समय पर सेवा', 'विश्वसनीय'],
      'price': '₹700',
    },
    {
      'name': 'शिव कृषि कार्य',
      'image': ImageUtility.greenTractorBanner,
      'rating': '4.3',
      'distance': 'इछावर रोड, सीहोर (2.4 किमी दूर)',
      'experience': '7+ वर्ष अनुभव',
      'completed': '650+ सेवाएं',
      'tags': ['अच्छे उपकरण', 'पेशेवर टीम', 'समय पर सेवा'],
      'price': '₹650',
    },
    {
      'name': 'अग्रवाल ट्रैक्टर सेवा',
      'image': ImageUtility.blueTractorCard,
      'rating': '4.2',
      'distance': 'श्यामपुर नाका (2.5 किमी दूर)',
      'experience': '5+ वर्ष अनुभव',
      'completed': '500+ सेवाएं',
      'tags': ['विश्वसनीय', 'समय पर सेवा', 'ईंधन बचत'],
      'price': '₹600',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // 1. TOP APP BAR HEADER
                _buildHeader(context),

                // 2. MAIN SCROLLABLE LIST & CONTROLS
                Expanded(
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),

                          // YOUR LOCATION CARD
                          _buildLocationCard(),

                          SizedBox(height: 12.h),

                          // FILTER CHIPS ROW
                          _buildFilterChips(),

                          SizedBox(height: 14.h),

                          // PROVIDERS LIST CARDS
                          ...providerList.map((provider) => _buildProviderCard(provider)),

                          SizedBox(height: 70.h), // Space for floating bottom bar
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // 3. FLOATING BOTTOM CONTROL BAR (SORT & MAP VIEW)
            Positioned(
              left: 14.w,
              right: 14.w,
              bottom: 12.h,
              child: _buildBottomControlBar(),
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
                  'उपलब्ध प्रदाता',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1C1C1C),
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'ट्रैक्टर सेवा (45 HP) • 2.5 किमी के दायरे में',
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

  // --- 2. YOUR LOCATION CARD ---
  Widget _buildLocationCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F9F4),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2EFE4), width: 1),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(7.r),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.location_on, color: const Color(0xFF2E7D32), size: 18.sp),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'आपकी लोकेशन',
                  style: TextStyle(
                    fontSize: 10.5.sp,
                    color: const Color(0xFF757575),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 1.h),
                Text(
                  'बरखेड़ा, सीहोर, मध्य प्रदेश',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1C1C1C),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: const Color(0xFFC8E6C9), width: 1),
            ),
            child: Row(
              children: [
                Icon(Icons.edit_square, color: const Color(0xFF2E7D32), size: 12.sp),
                SizedBox(width: 4.w),
                Text(
                  'बदलें',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
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

  // --- 3. FILTER CHIPS ROW ---
  Widget _buildFilterChips() {
    final icons = [
      Icons.group_rounded,
      Icons.star_rounded,
      Icons.currency_rupee_rounded,
      Icons.tune_rounded,
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      child: Row(
        children: List.generate(filterChips.length, (index) {
          final isSelected = selectedFilterIndex == index;
          return InkWell(
            onTap: () => setState(() => selectedFilterIndex = index),
            child: Container(
              margin: EdgeInsets.only(right: 8.w),
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFE8F5E9) : Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFFE0E0E0),
                  width: isSelected ? 1.2 : 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    icons[index],
                    color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF616161),
                    size: 14.sp,
                  ),
                  SizedBox(width: 5.w),
                  Text(
                    filterChips[index],
                    style: TextStyle(
                      fontSize: 11.5.sp,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                      color: isSelected ? const Color(0xFF2E7D32) : const Color(0xFF424242),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  // --- 4. PROVIDER CARD ITEM ---
  Widget _buildProviderCard(Map<String, dynamic> provider) {
    final tags = provider['tags'] as List<String>;

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: const Color(0xFFECEFF1), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tractor Image Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: SizedBox(
              width: 95.w,
              height: 95.h,
              child: Image.asset(
                provider['image'] as String,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFE8F5E9),
                  child: Icon(Icons.agriculture_rounded, size: 40.sp, color: const Color(0xFF2E7D32)),
                ),
              ),
            ),
          ),

          SizedBox(width: 10.w),

          // Provider Information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Rating Badge & Title Row
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.star_rounded, color: const Color(0xFF2E7D32), size: 12.sp),
                          SizedBox(width: 2.w),
                          Text(
                            provider['rating'] as String,
                            style: TextStyle(
                              fontSize: 10.5.sp,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF2E7D32),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  provider['name'] as String,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1C1C1C),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '📍 ${provider['distance']}',
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: const Color(0xFF757575),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3.h),
                Row(
                  children: [
                    Icon(Icons.verified_user_outlined, color: const Color(0xFF616161), size: 11.sp),
                    SizedBox(width: 3.w),
                    Text(
                      provider['experience'] as String,
                      style: TextStyle(fontSize: 9.5.sp, color: const Color(0xFF616161)),
                    ),
                    SizedBox(width: 6.w),
                    Icon(Icons.work_outline, color: const Color(0xFF616161), size: 11.sp),
                    SizedBox(width: 3.w),
                    Text(
                      provider['completed'] as String,
                      style: TextStyle(fontSize: 9.5.sp, color: const Color(0xFF616161)),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),

                // Small Feature Tags
                Wrap(
                  spacing: 4.w,
                  runSpacing: 4.h,
                  children: tags.map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F9F5),
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(color: const Color(0xFFE0EFE4)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle_outlined, color: const Color(0xFF2E7D32), size: 9.sp),
                          SizedBox(width: 2.w),
                          Text(
                            tag,
                            style: TextStyle(
                              fontSize: 8.5.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF2E7D32),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          SizedBox(width: 6.w),

          // Price & Select Button Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        provider['price'] as String,
                        style: TextStyle(
                          fontSize: 16.sp,
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
                  Text(
                    'न्यूनतम 2 घंटा',
                    style: TextStyle(fontSize: 8.5.sp, color: const Color(0xFF757575)),
                  ),
                ],
              ),

              SizedBox(height: 25.h),

              // Select Button (चुनें)
              ElevatedButton(
                onPressed: () => Get.toNamed(AppRouteName.providerDetailScreen),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF1B5E20),
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                  elevation: 0,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.r)),
                ),
                child: Text(
                  'चुनें',
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- 5. FLOATING BOTTOM CONTROL BAR ---
  Widget _buildBottomControlBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Sort Dropdown Button
          Row(
            children: [
              Icon(Icons.swap_vert_rounded, color: const Color(0xFF2E7D32), size: 16.sp),
              SizedBox(width: 4.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'सॉर्ट करें',
                    style: TextStyle(fontSize: 9.sp, color: const Color(0xFF757575)),
                  ),
                  Row(
                    children: [
                      Text(
                        'सबसे कम मूल्य',
                        style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1C1C1C)),
                      ),
                      Icon(Icons.keyboard_arrow_down_rounded, color: const Color(0xFF616161), size: 14.sp),
                    ],
                  ),
                ],
              ),
            ],
          ),

          Container(height: 24.h, width: 1, color: const Color(0xFFE0E0E0)),

          // Map View Button
          Row(
            children: [
              Icon(Icons.map_outlined, color: const Color(0xFF2E7D32), size: 16.sp),
              SizedBox(width: 6.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'मैप व्यू',
                    style: TextStyle(fontSize: 9.sp, color: const Color(0xFF757575)),
                  ),
                  Text(
                    'नक्शे पर देखें',
                    style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1C1C1C)),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
