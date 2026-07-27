import 'package:constructo/main.dart';
import 'package:constructo/utils/theme/sizes/app_sizes.dart';
import 'package:constructo/utils/theme/sizes/container_const_funtions.dart';
import 'package:constructo/utils/theme/styles/app_textstyles.dart';
import 'package:flutter/material.dart';

bool _toastVisible = false;

void showSnakBarBottomCustomRed(
  String message, {
  Color bgColor = Colors.red,
  int durationSec = 3,
}) {
  if (_toastVisible) return;

  final navigator = rootNavigatorKey.currentState;
  if (navigator == null) return;

  final overlay = navigator.overlay;
  if (overlay == null) return;

  _toastVisible = true;

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (_) => _MobileToastWidget(
      message: message,
      bgColor: bgColor,
      durationSec: durationSec,
      overlayEntry: entry,
    ),
  );

  overlay.insert(entry);
}

class _MobileToastWidget extends StatefulWidget {
  final String message;
  final Color bgColor;
  final int durationSec;
  final OverlayEntry overlayEntry;

  const _MobileToastWidget({
    required this.message,
    required this.bgColor,
    required this.durationSec,
    required this.overlayEntry,
  });

  @override
  State<_MobileToastWidget> createState() => _MobileToastWidgetState();
}

class _MobileToastWidgetState extends State<_MobileToastWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();

    Future.delayed(Duration(seconds: widget.durationSec), _dismiss);
  }

  void _dismiss() async {
    if (!mounted) return;
    await _controller.reverse();
    widget.overlayEntry.remove();
    _toastVisible = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 100.rh,
      left: AppSizes.horzontalSpace15,
      right: AppSizes.horzontalSpace15,
      child: SlideTransition(
        position: _slide,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.rw, vertical: 14.rh),
            decoration: BoxDecoration(
              color: widget.bgColor,
              borderRadius: BorderRadius.circular(8.rr),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 6),
              ],
            ),
            child: Row(
              children: [
                Icon(Icons.info, color: Colors.white, size: 16.rh),
                SizedBox(width: 8.rw),
                Expanded(
                  child: Text(
                    widget.message,
                    style: AppTextStyles.ts12w500colorBlack50().copyWith(
                      color: Colors.white,
                    ),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                GestureDetector(
                  onTap: _dismiss,
                  child: Padding(
                    padding: EdgeInsets.only(left: 5.rw),
                    child: Icon(Icons.close, color: Colors.white, size: 16.rh),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
