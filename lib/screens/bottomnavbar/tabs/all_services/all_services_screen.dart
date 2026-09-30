import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:constructo_worker/routes/app_routes_name.dart';
import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';

class AllServicesScreen extends StatefulWidget {
  const AllServicesScreen({super.key});

  @override
  State<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  int selectedCategoryIndex = 0;

  final List<Map<String, dynamic>> categories = [
    {'title': 'कृषि मशीनरी', 'icon': Icons.agriculture},
    {'title': 'फसल देखभाल', 'icon': Icons.eco},
    {'title': 'जुताई और बुआई', 'icon': Icons.landscape},
    {'title': 'स्प्रे सेवा', 'icon': Icons.sanitizer},
    {'title': 'ढुलाई सेवा', 'icon': Icons.local_shipping},
    {'title': 'मृदा परीक्षण', 'icon': Icons.science},
    {'title': 'पशु सेवा', 'icon': Icons.pets},
    {'title': 'अन्य सेवाएं', 'icon': Icons.grid_view_rounded},
  ];

  final List<Map<String, dynamic>> services = [
    {
      'title': 'ट्रैक्टर सेवा',
      'subtitle': 'सभी प्रकार के ट्रैक्टर किराए पर लें',
      'price': '₹800',
      'unit': '/ घंटा से शुरू',
      'rating': '4.8',
      'image': ImageUtility.tractorCard,
    },
    {
      'title': 'रोटावेटर सेवा',
      'subtitle': 'खेत की जुताई और मिट्टी को समतल करें',
      'price': '₹600',
      'unit': '/ घंटा से शुरू',
      'rating': '4.7',
      'image': ImageUtility.rotavatorCard,
    },
    {
      'title': 'ड्रोन स्प्रे सेवा',
      'subtitle': 'आधुनिक ड्रोन से सुरक्षित और सटीक स्प्रे',
      'price': '₹120',
      'unit': '/ एकड़ से शुरू',
      'rating': '4.8',
      'image': ImageUtility.droneCard,
    },
    {
      'title': 'हार्वेस्टर सेवा',
      'subtitle': 'फसल की कटाई के लिए हार्वेस्टर किराए पर लें',
      'price': '₹1,800',
      'unit': '/ घंटा से शुरू',
      'rating': '4.8',
      'image': ImageUtility.harvesterCard,
    },
    {
      'title': 'ढुलाई सेवा',
      'subtitle': 'फसल, खाद और अन्य सामान की ढुलाई',
      'price': '₹500',
      'unit': '/ ट्रिप से शुरू',
      'rating': '4.5',
      'image': ImageUtility.trolleyCard,
    },
    {
      'title': 'मृदा परीक्षण',
      'subtitle': 'मिट्टी की जांच और रिपोर्ट प्राप्त करें',
      'price': '₹299',
      'unit': '/ परीक्षण से शुरू',
      'rating': '4.7',
      'image': ImageUtility.rotavatorCard,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 8.h),

            // --- 1. TOP BAR: Back Button + Title "सभी सेवाएं" ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
              child: Row(
                children: [
                  // Circular Back Button
                  InkWell(
                    onTap: () => Get.back(),
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      height: 38.r,
                      width: 38.r,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF3F4F6),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.arrow_back, color: const Color(0xFF1F2937), size: 20.sp),
                    ),
                  ),
                  SizedBox(width: 12.w),

                  // Title right next to Back Button
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'सभी ',
                          style: TextStyle(
                            fontSize: 19.sp,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF1F2937),
                          ),
                          children: [
                            TextSpan(
                              text: 'सेवाएं',
                              style: TextStyle(
                                fontSize: 19.sp,
                                fontWeight: FontWeight.w900,
                                color: const Color(0xFF1E6E38),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'आपकी जरूरत की हर कृषि सेवा',
                        style: TextStyle(fontSize: 10.5.sp, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // --- 2. SEARCH BAR & FILTER BUTTON ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  // Search Input
                  Expanded(
                    child: Container(
                      height: 42.h,
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: const Color(0xFFE5E7EB)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search_rounded, color: const Color(0xFF1E6E38), size: 20.sp),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: 'सेवाएं खोजें...',
                                hintStyle: TextStyle(fontSize: 12.sp, color: Colors.grey[400]),
                                border: InputBorder.none,
                                isCollapsed: true,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),

                  // Filter Pill Button
                  Container(
                    height: 42.h,
                    padding: EdgeInsets.symmetric(horizontal: 14.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEAF5ED),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFFC8E6C9)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.tune_rounded, color: const Color(0xFF1E6E38), size: 18.sp),
                        SizedBox(width: 4.w),
                        Text(
                          'फ़िल्टर',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1E6E38),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 14.h),

            // --- 3. CATEGORIES & SERVICES CONTENT ---
            Expanded(
              child: Row(
                children: [
                  // Left Categories Sidebar
                  Container(
                    width: 92.w,
                    color: const Color(0xFFF9FAFB),
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (context, index) {
                        final isSelected = selectedCategoryIndex == index;
                        return InkWell(
                          onTap: () => setState(() => selectedCategoryIndex = index),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 6.w),
                            decoration: BoxDecoration(
                              color: isSelected ? Colors.white : const Color(0xFFF9FAFB),
                              border: Border(
                                left: BorderSide(
                                  color: isSelected ? const Color(0xFF1E6E38) : Colors.transparent,
                                  width: 4.w,
                                ),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.r),
                                  decoration: BoxDecoration(
                                    color: isSelected ? const Color(0xFFEAF5ED) : Colors.grey[100],
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    categories[index]['icon'] as IconData,
                                    color: isSelected ? const Color(0xFF1E6E38) : Colors.grey[500],
                                    size: 20.sp,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  categories[index]['title'] as String,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                    color: isSelected ? const Color(0xFF1E6E38) : const Color(0xFF6B7280),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Right Services List
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                      itemCount: services.length,
                      separatorBuilder: (context, index) => SizedBox(height: 12.h),
                      itemBuilder: (context, index) {
                        final item = services[index];
                        return InkWell(
                          onTap: () => Get.toNamed(AppRouteName.equipmentDetailScreen),
                          borderRadius: BorderRadius.circular(14.r),
                          child: Container(
                            padding: EdgeInsets.all(10.r),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                              border: Border.all(color: const Color(0xFFF3F4F6)),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10.r),
                                  child: SizedBox(
                                    width: 75.r,
                                    height: 75.r,
                                    child: Image.asset(
                                      item['image'] as String,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) => Container(
                                        color: const Color(0xFFEAF5ED),
                                        child: Icon(Icons.agriculture, size: 35.sp, color: const Color(0xFF1E6E38)),
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
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              item['title'] as String,
                                              style: TextStyle(
                                                fontSize: 13.5.sp,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF1F2937),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Icon(Icons.star_rounded, color: const Color(0xFFF59E0B), size: 14.sp),
                                              SizedBox(width: 2.w),
                                              Text(
                                                item['rating'] as String,
                                                style: TextStyle(
                                                  fontSize: 11.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: const Color(0xFF374151),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 3.h),
                                      Text(
                                        item['subtitle'] as String,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 10.sp, color: const Color(0xFF6B7280)),
                                      ),
                                      SizedBox(height: 6.h),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.baseline,
                                            textBaseline: TextBaseline.alphabetic,
                                            children: [
                                              Text(
                                                item['price'] as String,
                                                style: TextStyle(
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w900,
                                                  color: const Color(0xFF1E6E38),
                                                ),
                                              ),
                                              Text(
                                                ' ${item['unit']}',
                                                style: TextStyle(fontSize: 9.5.sp, color: const Color(0xFF6B7280)),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF1E6E38),
                                              borderRadius: BorderRadius.circular(6.r),
                                            ),
                                            child: Text(
                                              'देखें',
                                              style: TextStyle(
                                                fontSize: 10.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
