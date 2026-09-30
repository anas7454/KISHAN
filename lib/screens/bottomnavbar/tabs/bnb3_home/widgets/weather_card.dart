import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Weather Sun & Cloud Icon
              Stack(
                children: [
                  Icon(Icons.wb_sunny_rounded, color: const Color(0xFFFFB300), size: 24.sp),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Icon(Icons.cloud, color: const Color(0xFF90CAF9), size: 18.sp),
                  ),
                ],
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '28°C',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                  Text(
                    'आंशिक बादल',
                    style: TextStyle(fontSize: 10.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Divider(height: 1, color: Colors.grey.withOpacity(0.2)),
          SizedBox(height: 6.h),
          Row(
            children: [
              _buildMetric('💧 आर्द्रता', '65%'),
              _buildMetric('💨 हवा', '12किमी/घं'),
              _buildMetric('🌧️ वर्षा', '10%'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              style: TextStyle(fontSize: 8.5.sp, color: Colors.grey[500]),
            ),
          ),
          SizedBox(height: 2.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1F2937)),
            ),
          ),
        ],
      ),
    );
  }
}
