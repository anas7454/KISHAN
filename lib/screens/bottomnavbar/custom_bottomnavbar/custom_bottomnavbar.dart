import 'package:constructo_worker/screens/bottomnavbar/custom_bottomnavbar/bottom_nav_background_clipper.dart';
import 'package:constructo_worker/utils/theme/app_colors.dart';
import 'package:constructo_worker/utils/theme/sizes/app_sizes.dart';
import 'package:constructo_worker/utils/theme/sizes/responsive_size_utils.dart';
import 'package:constructo_worker/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

typedef BottomNavItemData = ({
  String label,
  String icon,
  String selectedIcon,
  IconData fallback,
  Widget child,
});

// change center
final double barTop = 30.rh;
double curveHalfWidth = 52.rw; // slop width 1

class CustomBottomNav extends StatelessWidget {
  static const double height = 80;
  // static const double contentBottomPadding = 68;

  final List<BottomNavItemData> items;
  final int selectedIndex;
  final ValueChanged<int> onTabChanged;

  const CustomBottomNav({
    super.key,
    required this.items,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    // final double barTop = 28.rh;
    final double curveOverflow = 8.rh;

    return SizedBox(
      height: height.rh + bottomstatusBarHeight,
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -curveOverflow,
            left: 0,
            right: 0,
            bottom: 0,
            child: PhysicalShape(
              clipper: BottomNavBackgroundClipper(
                barTop: barTop,
                cornerRadius: 25.rr,
                curveHalfWidth: curveHalfWidth,
              ),
              color: AppColors.white,
              elevation: 7,
              shadowColor: AppColors.black.withValues(alpha: .12),
              child: Padding(
                padding: EdgeInsets.only(bottom: bottomstatusBarHeight),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(items.length, (index) {
                    if (index == 2) {
                      return const Expanded(flex: 7, child: SizedBox());
                    }
                    return Expanded(flex: 10, child: _item(index));
                  }),
                ),
              ),
            ),
          ),
          Positioned(
            top: -curveOverflow,
            left: 0,
            right: 0,
            bottom: 0,
            child: IgnorePointer(
              child: CustomPaint(
                painter: BottomNavTopBorderPainter(
                  barTop: barTop,
                  cornerRadius: 25.rr,
                  curveHalfWidth: curveHalfWidth,
                  color: AppColors.borderE6E6E6.withValues(alpha: .4),
                  strokeWidth: .8.rh,
                ),
              ),
            ),
          ),
          Positioned(top: 9.rh - curveOverflow, child: _centerButton()),
        ],
      ),
    );
  }

  Widget _item(int index) {
    final selected = selectedIndex == index;
    return InkWell(
      onTap: () => onTabChanged(index),
      child: Padding(
        padding: EdgeInsets.only(bottom: 4.rh),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _icon(index, selected, 24.rh),
            SizedBox(height: 3.rh),
            Text(
              items[index].label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.ts12w500color000000().copyWith(
                fontSize: 11.rsp,
                color: selected ? AppColors.primary : AppColors.color9DB2CE,
                fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _centerButton() {
    final selected = selectedIndex == 2;
    return GestureDetector(
      onTap: () => onTabChanged(2),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        width: 55.rh,
        height: 55.rh,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? AppColors.primary : AppColors.white,
          border: Border.all(color: AppColors.white, width: 0.5.rh),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF613EEA).withValues(alpha: 0.5),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: EdgeInsets.all(14.rh),
        child: _icon(2, selected, 24.rh),
      ),
    );
  }

  Widget _icon(int index, bool selected, double size) {
    final item = items[index];
    final color = selected ? AppColors.primary : AppColors.colorBFBFBF;
    return Image.asset(
      selected ? item.selectedIcon : item.icon,
      width: size,
      height: size,
      errorBuilder: (_, _, _) => Icon(
        item.fallback,
        size: size,
        color: index == 2 && selected ? AppColors.white : color,
      ),
    );
  }
}
