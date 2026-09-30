import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:constructo_worker/routes/app_routes_name.dart';
import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';

class Bnb3HomeScreen extends StatefulWidget {
  const Bnb3HomeScreen({super.key});

  @override
  State<Bnb3HomeScreen> createState() => _Bnb3HomeScreenState();
}

class _Bnb3HomeScreenState extends State<Bnb3HomeScreen> {
  int activeBannerIndex = 0;
  int selectedCategoryFilter = 0;

  final List<Map<String, dynamic>> banners = [
    {
      'title': 'समृद्ध खेती, समृद्ध किसान 🌾',
      'subtitle': 'आधुनिक ट्रैक्टर एवं ड्रोन स्प्रे पर पाएं 20% की विशेष छूट',
      'tag': 'ऑफ़र चालू है',
      'bgGradient': const [Color(0xFF0F5229), Color(0xFF1E6E38), Color(0xFF2E8B4A)],
    },
    {
      'title': 'ड्रोन से यूरिया छिड़काव ✈️',
      'subtitle': 'मात्र 15 मिनट में 1 एकड़ खेत का सटीक स्प्रे करें',
      'tag': 'स्मार्ट सेवा',
      'bgGradient': const [Color(0xFF0D47A1), Color(0xFF1976D2), Color(0xFF42A5F5)],
    },
    {
      'title': 'मृदा परीक्षण रिपोर्ट 🧪',
      'subtitle': 'मिट्टी की जांच कराएं और फसल उत्पादन 30% बढ़ाएं',
      'tag': 'वैज्ञानिक सलाह',
      'bgGradient': const [Color(0xFFE65100), Color(0xFFF57C00), Color(0xFFFFA726)],
    },
  ];

  final List<Map<String, dynamic>> quickServices = [
    {
      'image': ImageUtility.iconTractorService,
      'title': 'ट्रैक्टर सेवा',
      'subtitle': 'किराए पर लें',
      'color': const Color(0xFFE8F5E9),
      'borderColor': const Color(0xFFC8E6C9),
      'accentColor': const Color(0xFF2E7D32),
    },
    {
      'image': ImageUtility.iconEquipmentService,
      'title': 'उपकरण सेवा',
      'subtitle': 'किराए पर लें',
      'color': const Color(0xFFFFF8E1),
      'borderColor': const Color(0xFFFFECB3),
      'accentColor': const Color(0xFFF57F17),
    },
    {
      'image': ImageUtility.iconSprayService,
      'title': 'स्प्रे सेवा',
      'subtitle': 'बुक करें',
      'color': const Color(0xFFFFF3E0),
      'borderColor': const Color(0xFFFFE0B2),
      'accentColor': const Color(0xFFE65100),
    },
    {
      'image': ImageUtility.iconProductDelivery,
      'title': 'खाद & बीज',
      'subtitle': 'घर तक पाएं',
      'color': const Color(0xFFE3F2FD),
      'borderColor': const Color(0xFFBBDEFB),
      'accentColor': const Color(0xFF1565C0),
    },
    {
      'image': ImageUtility.iconExpertAdvice,
      'title': 'विशेषज्ञ सलाह',
      'subtitle': 'जानकारी पाएं',
      'color': const Color(0xFFF3E5F5),
      'borderColor': const Color(0xFFE1BEE7),
      'accentColor': const Color(0xFF7B1FA2),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7F5),
      body: Column(
        children: [
          // FIXED TOP HERO HEADER (Pinned at top of screen)
          _buildHeroHeader(context),

          // SCROLLABLE BODY CONTENT
          Expanded(
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),

                    // --- 2. WEATHER & LIVE STATS WIDGET ---
                    _buildLiveWeatherWidget(),

                    SizedBox(height: 20.h),

                    // --- 3. DYNAMIC PROMO BANNER CAROUSEL ---
                    _buildPromoBannerCarousel(),

                    SizedBox(height: 24.h),

                    // --- 4. QUICK SERVICES GRID (MODERN VIBRANT CARDS) ---
                    _buildQuickServicesHeader(),
                    SizedBox(height: 14.h),
                    _buildQuickServicesRow(),

                    SizedBox(height: 28.h),

                    // --- 5. RECOMMENDED EQUIPMENT CAROUSEL ---
                    _buildRecommendationsHeader(),
                    SizedBox(height: 14.h),
                    _buildRecommendationsCarousel(),

                    SizedBox(height: 28.h),

                    // --- 6. RECENT BOOKINGS LIVE STATUS ---
                    _buildRecentBookingsSection(),

                    SizedBox(height: 24.h),

                    // --- 7. PREMIUM REFERRAL REWARDS HUB ---
                    _buildReferralHub(),

                    SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- HERO HEADER BUILDER (COMPACT & SLEEK) ---
  Widget _buildHeroHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 6.h,
        left: 14.w,
        right: 14.w,
        bottom: 16.h,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF093117), Color(0xFF165B2D), Color(0xFF22783D)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF165B2D).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Top Row: App Logo Branding + Greeting & Location + Notification & Profile
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: App Logo & App Name Badge
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.5.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        ImageUtility.appLogo,
                        width: 36.w,
                        height: 36.h,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'किसान साथी',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w900,
                              color: const Color(0xFFFFD54F),
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
                            decoration: BoxDecoration(
                              color: const Color(0xFF86CB3A),
                              borderRadius: BorderRadius.circular(6.r),
                            ),
                            child: Text(
                              'APP',
                              style: TextStyle(
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF093117),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'नमस्ते, किसान जी 👋',
                        style: TextStyle(
                          fontSize: 11.5.sp,
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              // Right: Location Badge + Notification + Farmer Avatar
              Row(
                children: [
                  // Location Pill
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20.r),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on, color: const Color(0xFFFFD54F), size: 12.sp),
                        SizedBox(width: 3.w),
                        Text(
                          'सीहोर',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white70, size: 13.sp),
                      ],
                    ),
                  ),

                  SizedBox(width: 8.w),

                  // Notification Icon with Red Dot
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(7.r),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
                        ),
                        child: Icon(Icons.notifications_none_rounded, color: Colors.white, size: 18.sp),
                      ),
                      Positioned(
                        top: 4.r,
                        right: 4.r,
                        child: Container(
                          height: 7.r,
                          width: 7.r,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF5252),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 1),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 8.w),

                  // Profile Avatar with Yellow Ring
                  Container(
                    padding: EdgeInsets.all(1.5.r),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFFFFD54F), width: 1.5),
                    ),
                    child: CircleAvatar(
                      radius: 16.r,
                      backgroundImage: const AssetImage(ImageUtility.farmerAvatar),
                    ),
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 14.h),

          // Search Bar
          Container(
            height: 42.h,
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.search_rounded, color: const Color(0xFF165B2D), size: 20.sp),
                SizedBox(width: 8.w),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'ट्रैक्टर, रोटावेटर या स्प्रे सेवा खोजें...',
                      hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(5.r),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F5E9),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Icon(Icons.tune_rounded, color: const Color(0xFF165B2D), size: 16.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- LIVE WEATHER WIDGET ---
  Widget _buildLiveWeatherWidget() {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Row(
        children: [
          // Weather Temperature Column
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF3E0), Color(0xFFFFE0B2)],
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Icon(Icons.wb_sunny_rounded, color: const Color(0xFFFB8C00), size: 30.sp),
              ),
              SizedBox(width: 10.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '28°C',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  Text(
                    'आंशिक धूप & बादल',
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey[600], fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),

          const Spacer(),
          Container(height: 35.h, width: 1, color: Colors.grey[200]),
          const Spacer(),

          // Weather Details Row
          Row(
            children: [
              _buildWeatherDetailItem('💧', '65%', 'आर्द्रता'),
              SizedBox(width: 12.w),
              _buildWeatherDetailItem('💨', '12 km/h', 'हवा की गति'),
              SizedBox(width: 12.w),
              _buildWeatherDetailItem('🌧️', '10%', 'बारिश'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetailItem(String emoji, String val, String label) {
    return Column(
      children: [
        Text('$emoji $val', style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
        SizedBox(height: 2.h),
        Text(label, style: TextStyle(fontSize: 9.sp, color: Colors.grey[500])),
      ],
    );
  }

  // --- PROMO BANNER CAROUSEL ---
  Widget _buildPromoBannerCarousel() {
    return Column(
      children: [
        SizedBox(
          height: 135.h,
          child: PageView.builder(
            itemCount: banners.length,
            onPageChanged: (index) => setState(() => activeBannerIndex = index),
            itemBuilder: (context, index) {
              final banner = banners[index];
              return Container(
                margin: EdgeInsets.only(right: index == banners.length - 1 ? 0 : 8.w),
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: banner['bgGradient'] as List<Color>,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: (banner['bgGradient'] as List<Color>)[1].withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              banner['tag'] as String,
                              style: TextStyle(color: Colors.white, fontSize: 9.5.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            banner['title'] as String,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            banner['subtitle'] as String,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: 10.5.sp),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.arrow_circle_right_rounded, color: Colors.white, size: 36.sp),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 8.h),
        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            banners.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 3.w),
              height: 4.h,
              width: activeBannerIndex == index ? 16.w : 6.w,
              decoration: BoxDecoration(
                color: activeBannerIndex == index ? const Color(0xFF1E6E38) : Colors.grey[300],
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- QUICK SERVICES HEADER ---
  Widget _buildQuickServicesHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 18.h,
              width: 4.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1E6E38),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              'त्वरित सेवाएं',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1F2937),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () => Get.toNamed(AppRouteName.allServicesScreen),
          child: Row(
            children: [
              Text(
                'सभी सेवाएं देखें',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E6E38),
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: const Color(0xFF1E6E38), size: 18.sp),
            ],
          ),
        ),
      ],
    );
  }

  // --- QUICK SERVICES ROW ---
  Widget _buildQuickServicesRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: quickServices.map((item) {
        return InkWell(
          onTap: () => Get.toNamed(AppRouteName.equipmentDetailScreen),
          borderRadius: BorderRadius.circular(16.r),
          child: Container(
            width: 68.w,
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
            decoration: BoxDecoration(
              color: item['color'] as Color,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: item['borderColor'] as Color, width: 1.2),
              boxShadow: [
                BoxShadow(
                  color: (item['accentColor'] as Color).withValues(alpha: 0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  height: 44.r,
                  width: 44.r,
                  padding: EdgeInsets.all(6.r),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      item['image'] as String,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  item['title'] as String,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
                ),
                SizedBox(height: 2.h),
                Text(
                  item['subtitle'] as String,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 9.sp, color: Colors.grey[600], fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // --- RECOMMENDATIONS HEADER ---
  Widget _buildRecommendationsHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 18.h,
              width: 4.w,
              decoration: BoxDecoration(
                color: const Color(0xFF1E6E38),
                borderRadius: BorderRadius.circular(4.r),
              ),
            ),
            SizedBox(width: 8.w),
            Text(
              'आपके लिए सुझाव',
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1F2937),
              ),
            ),
          ],
        ),
        InkWell(
          onTap: () => Get.toNamed(AppRouteName.equipmentListScreen),
          child: Row(
            children: [
              Text(
                'और देखें',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1E6E38),
                ),
              ),
              Icon(Icons.chevron_right_rounded, color: const Color(0xFF1E6E38), size: 18.sp),
            ],
          ),
        ),
      ],
    );
  }

  // --- RECOMMENDATIONS CAROUSEL ---
  Widget _buildRecommendationsCarousel() {
    final List<Map<String, String>> items = [
      {
        'title': 'ट्रैक्टर (45 HP)',
        'price': '₹800',
        'unit': '/ घंटा से शुरू',
        'distance': '2.5 किमी',
        'rating': '4.8',
        'image': ImageUtility.tractorCard,
      },
      {
        'title': 'ड्रोन स्प्रे सेवा',
        'price': '₹120',
        'unit': '/ एकड़ से शुरू',
        'distance': '3.2 किमी',
        'rating': '4.6',
        'image': ImageUtility.droneCard,
      },
      {
        'title': 'रोटावेटर 7 फीट',
        'price': '₹600',
        'unit': '/ घंटा से शुरू',
        'distance': '1.8 किमी',
        'rating': '4.7',
        'image': ImageUtility.rotavatorCard,
      },
    ];

    return SizedBox(
      height: 215.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => SizedBox(width: 12.w),
        itemBuilder: (context, index) {
          final item = items[index];
          return InkWell(
            onTap: () => Get.toNamed(AppRouteName.equipmentDetailScreen),
            borderRadius: BorderRadius.circular(16.r),
            child: Container(
              width: 172.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: const Color(0xFF1E6E38).withValues(alpha: 0.15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
                        child: Image.asset(
                          item['image']!,
                          height: 108.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 6.r,
                        right: 6.r,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.5.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E6E38),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.star, color: Colors.white, size: 11.sp),
                              SizedBox(width: 2.w),
                              Text(
                                item['rating']!,
                                style: TextStyle(color: Colors.white, fontSize: 10.5.sp, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 13.5.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
                        ),
                        SizedBox(height: 3.h),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              item['price']!,
                              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1E6E38)),
                            ),
                            Expanded(
                              child: Text(
                                ' ${item['unit']}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 9.5.sp, color: Colors.grey[600], fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.location_on, color: Colors.grey[600], size: 12.sp),
                                SizedBox(width: 2.w),
                                Text(
                                  item['distance']!,
                                  style: TextStyle(fontSize: 9.5.sp, color: Colors.grey[600], fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFF1E6E38),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'बुक करें',
                                style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // --- RECENT BOOKINGS SECTION ---
  Widget _buildRecentBookingsSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 18.h,
                  width: 4.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1E6E38),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'हाल की बुकिंग',
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Text(
                    'सभी देखें',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E6E38),
                    ),
                  ),
                  Icon(Icons.chevron_right_rounded, color: const Color(0xFF1E6E38), size: 18.sp),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 14.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: const Color(0xFFEEEEEE)),
          ),
          child: Column(
            children: [
              _buildBookingRow(
                image: ImageUtility.tractorCard,
                title: 'ट्रैक्टर (50 HP)',
                dateTime: '08 मई 2024 • 10:00 AM',
                status: 'सेवा पूर्ण',
                rating: '4.8',
              ),
              Divider(height: 1, color: Colors.grey[200]),
              _buildBookingRow(
                image: ImageUtility.droneCard,
                title: 'ड्रोन स्प्रे सेवा',
                dateTime: '06 मई 2024 • 09:30 AM',
                status: 'पूर्ण',
                rating: '4.7',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBookingRow({
    required String image,
    required String title,
    required String dateTime,
    required String status,
    required String rating,
  }) {
    return Padding(
      padding: EdgeInsets.all(12.r),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Image.asset(image, height: 52.r, width: 52.r, fit: BoxFit.cover),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
                SizedBox(height: 3.h),
                Text(dateTime, style: TextStyle(fontSize: 11.sp, color: Colors.grey[600])),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E9),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(status, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: const Color(0xFF2E7D32))),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.amber[700], size: 14.sp),
                  SizedBox(width: 2.w),
                  Text(rating, style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937))),
                ],
              ),
            ],
          ),
          SizedBox(width: 8.w),
          Icon(Icons.chevron_right_rounded, color: Colors.grey[400], size: 22.sp),
        ],
      ),
    );
  }

  // --- REFERRAL HUB ---
  Widget _buildReferralHub() {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE8F5E9), Color(0xFFF1F8E9)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22.r),
        border: Border.all(color: const Color(0xFFC8E6C9)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E6E38).withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 54.r,
            width: 54.r,
            padding: EdgeInsets.all(6.r),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image.asset(ImageUtility.iconGiftBox, fit: BoxFit.contain),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'रिफ़रल करें और इनाम पाएं! 🎁',
                  style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
                ),
                SizedBox(height: 3.h),
                Text(
                  'अपने किसान दोस्तों को जोड़ें और पाएँ आकर्षक कैश बैक!',
                  style: TextStyle(fontSize: 10.5.sp, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          SizedBox(width: 6.w),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E6E38),
              foregroundColor: Colors.white,
              elevation: 2,
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
            ),
            child: Text('रिफ़रल करें >', style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
