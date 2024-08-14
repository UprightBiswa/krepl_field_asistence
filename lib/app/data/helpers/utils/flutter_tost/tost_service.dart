import 'package:field_asistence/app/data/constrants/app_colors.dart';
import 'package:flutter/material.dart';

class ToastService {
  static void show(BuildContext context,String message,  {bool isSuccess = false}) {
    if (ScaffoldMessenger.of(context).mounted) {
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? AppColors.kPrimary : AppColors.kAccent7,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
