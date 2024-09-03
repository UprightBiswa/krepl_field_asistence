import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';

class CustomDatePicker extends StatefulWidget {
  final String labelText;
  final IconData icon;
  final TextEditingController textEditingController;
  final Future<void> Function(BuildContext context) onDateSelected;

  const CustomDatePicker({
    required this.labelText,
    required this.icon,
    required this.onDateSelected,
    required this.textEditingController,
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
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: isDarkMode(context)
                ? AppColors.kInput
                : AppColors.kContentColor,
          ),
          borderRadius: BorderRadius.circular(AppSpacing.radiusTen),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusTen),
          borderSide: const BorderSide(color: Colors.red),
        ),
        hintText: 'DD/MM/YYYY',
      ),
      validator: (value) {
        if (widget.textEditingController.text.isEmpty) {
          return 'Please select a date';
        }
        return null;
      },
    );
  }
}
