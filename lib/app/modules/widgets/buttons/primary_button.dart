import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';

class PrimaryButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double? fontSize;
  final Color? color;
  final bool isBorder;

  const PrimaryButton({
    required this.onTap,
    required this.text,
    this.height,
    this.width,
    this.borderRadius,
    this.fontSize,
    this.color,
    this.isBorder = false,
    super.key,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final Duration _animationDuration = const Duration(milliseconds: 300);
  final Tween<double> _tween = Tween<double>(begin: 1.0, end: 0.95);
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: _animationDuration,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        _controller.forward().then((_) {
          _controller.reverse();
        });
        widget.onTap();
      },
      child: ScaleTransition(
        scale: _tween.animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeOut,
            reverseCurve: Curves.easeIn,
          ),
        ),
        child: Container(
          height: widget.height ?? 55.h,
          alignment: Alignment.center,
          width: widget.width ?? double.maxFinite,
          decoration: BoxDecoration(
            color: widget.color ??
                (isDarkMode(context)
                    ? AppColors.kContentColor
                    : AppColors.kPrimary),
            boxShadow: [
              if (isDarkMode(context))
                AppColors.darkShadow
              else
                AppColors.defaultShadow,
            ],
            borderRadius: BorderRadius.circular(
              widget.borderRadius ?? AppSpacing.radiusTen,
            ),
            border: widget.isBorder ? Border.all(color: AppColors.kHint) : null,
          ),
          child: Text(
            widget.text,
            style: AppTypography.kBold15.copyWith(
              color: widget.color == null ? Colors.white : Colors.black,
              fontSize: widget.fontSize,
            ),
          ),
        ),
      ),
    );
  }
}
