import 'package:flutter/material.dart';

class ToastService {
  static void show(BuildContext context,String message,  {bool isSuccess = false}) {
    if (ScaffoldMessenger.of(context).mounted) {
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
