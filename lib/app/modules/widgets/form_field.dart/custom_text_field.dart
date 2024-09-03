import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';

class CustomTextField extends StatelessWidget {
  final bool readonly;
  final String labelText;
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatter;
  final int maxLines;

  const CustomTextField({
    this.readonly = false,
    required this.labelText,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.inputFormatter,
    this.maxLines = 1,
    super.key,
  });
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
       readOnly: readonly,
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      inputFormatters: inputFormatter,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: AppTypography.kLight14,
        hintText: hintText,
        hintStyle: TextStyle(
          color: isDarkMode(context) ? AppColors.kLightBrown : AppColors.kGrey,
          fontSize: 1.sp,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.tenHorizontal,
          vertical: 10.h,
        ),
        fillColor:
            isDarkMode(context) ? AppColors.kContentColor : AppColors.kInput,
        filled: true,
        prefixIcon: Icon(icon, color: AppColors.kPrimary),
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
      ),
    );
  }
}
