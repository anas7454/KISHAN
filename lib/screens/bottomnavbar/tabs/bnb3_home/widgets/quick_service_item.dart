import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuickServiceItem extends StatelessWidget {
  final String imagePath;
  final IconData fallbackIcon;
  final String title;
  final String subTitle;
  final Color bgColor;
  final Color borderColor;
  final Color iconBgColor;
  final VoidCallback onTap;

  const QuickServiceItem({
    super.key,
    required this.imagePath,
    required this.fallbackIcon,
    required this.title,
    required this.subTitle,
    required this.bgColor,
    required this.borderColor,
    required this.iconBgColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        width: 68.w,
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 4.w),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Column(
          children: [
            Container(
              height: 44.r,
              width: 44.r,
              padding: EdgeInsets.all(6.r),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: ClipOval(
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(fallbackIcon, color: const Color(0xFF1E6E38), size: 22.sp);
                  },
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
            ),
            SizedBox(height: 2.h),
            Text(
              subTitle,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 9.sp, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
