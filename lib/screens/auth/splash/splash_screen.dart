import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:constructo_worker/screens/auth/splash/splash_controller.dart';
import 'package:constructo_worker/utils/images/image_utility/image_utility.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    Get.put(SplashController());

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFE6),
      body: Stack(
        children: [
          // 1. FULL SCREEN SCENIC FARM LANDSCAPE BACKGROUND
          Positioned.fill(
            child: Image.asset(
              ImageUtility.splashBg,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFFEAF5ED), Color(0xFFC8E6C9)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),

          // Soft Warm Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.25),
                    Colors.transparent,
                    const Color(0xFF0F5229).withValues(alpha: 0.85),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 0.45, 1.0],
                ),
              ),
            ),
          ),

          // 2. CENTER CONTENT (ANIMATED EMBLEM + BRANDING)
          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Glowing Circular Emblem Badge Logo
                    Container(
                      width: 155.w,
                      height: 155.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF1E6E38).withValues(alpha: 0.2),
                            blurRadius: 25,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          ImageUtility.splashEmblem,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.white,
                            child: Icon(Icons.agriculture_rounded, size: 70.sp, color: const Color(0xFF2E7D32)),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 16.h),

                    // App Title: किसान साथी
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'किसान साथी',
                          style: TextStyle(
                            fontSize: 32.sp,
                            fontWeight: FontWeight.w900,
                            color: const Color(0xFF0F5229),
                            letterSpacing: 0.5,
                            shadows: [
                              Shadow(
                                color: Colors.white.withValues(alpha: 0.8),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 4.w),
                        Icon(Icons.eco_rounded, color: const Color(0xFF2E7D32), size: 24.sp),
                      ],
                    ),

                    SizedBox(height: 6.h),

                    // Slogan Row: — खेती आसान, मुनाफा ज्यादा —
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 25.w, height: 1.5.h, color: const Color(0xFF2E7D32)),
                        SizedBox(width: 8.w),
                        Text(
                          'खेती आसान, मुनाफा ज्यादा',
                          style: TextStyle(
                            fontSize: 13.5.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF2E7D32),
                            letterSpacing: 0.3,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Container(width: 25.w, height: 1.5.h, color: const Color(0xFF2E7D32)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 3. BOTTOM CURVED HILL WAVES & LOADING INDICATOR
          Positioned(
            left: 0,
            right: 0,
            bottom: 30.h,
            child: Column(
              children: [
                SizedBox(
                  width: 24.r,
                  height: 24.r,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF81C784)),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'लोड हो रहा है...',
                  style: TextStyle(
                    fontSize: 11.5.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withValues(alpha: 0.9),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
