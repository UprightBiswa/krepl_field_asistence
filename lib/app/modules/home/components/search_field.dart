import 'package:flutter/material.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/containers/primary_container.dart';

class SearchField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String hintText;

  final bool isEnabled;
  const SearchField({
    required this.controller,
    this.onChanged,
    this.isEnabled = false,
    this.hintText = 'Search names, etc.',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return PrimaryContainer(
      padding: const EdgeInsets.all(0.0),
      height: 48,
      child: TextFormField(
        controller: controller,
        enabled: isEnabled,
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: IconButton(
            onPressed: null,
            icon: Icon(
              AppAssets.kSearch,
              color: isDarkMode(context) ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
