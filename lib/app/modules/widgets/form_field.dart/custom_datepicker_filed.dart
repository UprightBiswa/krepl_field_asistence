import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';

class CustomDatePicker extends StatefulWidget {
  final String labelText;
  final String hintText;

  final IconData icon;
  final TextEditingController textEditingController;
  final String? Function(String?)? validator;
  final Future<void> Function(BuildContext context) onDateSelected;

  const CustomDatePicker({
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.onDateSelected,
    required this.textEditingController,
    this.validator,
    super.key,
  });

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: true,
      controller: widget.textEditingController,
      onTap: () => widget.onDateSelected(context),
      decoration: InputDecoration(
        labelText: widget.labelText,
        labelStyle: AppTypography.kLight14,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.tenHorizontal,
          vertical: 10.h,
        ),
        fillColor:
            isDarkMode(context) ? AppColors.kContentColor : AppColors.kInput,
        prefixIcon: Icon(
          widget.icon,
          color: AppColors.kPrimary,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusTen),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusTen),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.kPrimary,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusTen),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusTen),
          borderSide: const BorderSide(color: Colors.red),
        ),
        hintText: widget.hintText,
      ),
      validator: widget.validator ??
          (value) {
            if (widget.textEditingController.text.isEmpty) {
              return 'Please select a date';
            }
            return null;
          },
    );
  }
}
