import 'package:constructo_worker/utils/theme/app_colors.dart';
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

final double barTop = 0.rh;

class CustomBottomNav extends StatelessWidget {
  static const double height = 69;

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
    final double bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.rr),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      padding: EdgeInsets.only(bottom: bottomPadding),
      child: SizedBox(
        height: height.rh,
        child: Row(
          children: List.generate(items.length, (index) {
            return Expanded(child: _item(index));
          }),
        ),
      ),
    );
  }

  Widget _item(int index) {
    final selected = selectedIndex == index;
    return InkWell(
      onTap: () => onTabChanged(index),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _icon(index, selected, 24.rh),
          SizedBox(height: 4.rh),
          Text(
            items[index].label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.ts12w500color000000().copyWith(
              fontSize: 11.rsp,
              color: selected ? const Color(0xff89B0E5) : const Color(0xff9DB2CE),
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _icon(int index, bool selected, double size) {
    final item = items[index];
    final color = selected ? const Color(0xff89B0E5) : const Color(0xff9DB2CE);
    return Image.asset(
      selected ? item.selectedIcon : item.icon,
      width: size,
      height: size,
      color: color,
      errorBuilder: (_, _, _) => Icon(
        item.fallback,
        size: size,
        color: color,
      ),
    );
  }
}
