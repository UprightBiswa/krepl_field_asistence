import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';

class CustomDropdownField extends StatelessWidget {
  final String labelText;
  final IconData icon;
  final List<String> items;
  final String? Function(String?)? validator;
  final ValueChanged<String?> onChanged;
  final String? value;

  const CustomDropdownField({
    required this.labelText,
    required this.icon,
    required this.items,
    required this.onChanged,
    this.validator,
    this.value,
    super.key,
  });
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: AppTypography.kLight14,
        filled: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.tenHorizontal,
          vertical: 10.h,
        ),
        fillColor:
            isDarkMode(context) ? AppColors.kContentColor : AppColors.kInput,
            
        prefixIcon: Icon(icon),
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
      validator: validator,
      onChanged: onChanged,
      items: items.map((String item) {
        return DropdownMenuItem<String>(
          value: item,
          child: Text(item),
        );
      }).toList(),
    );
  }
}
