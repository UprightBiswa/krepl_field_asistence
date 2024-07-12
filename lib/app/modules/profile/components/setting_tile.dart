
import 'package:flutter/material.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/animations/custom_switch.dart';

class SettingTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final bool isSwitch;
  final VoidCallback? onTap;
  final bool? switchValue;
  final void Function(bool)? onChanged;
  const SettingTile({
    required this.title,
    required this.icon,
    this.switchValue,
    this.onChanged,
    this.subtitle,
    this.onTap,
    this.isSwitch = false,
    super.key,
  });

  @override
  State<SettingTile> createState() => _SettingTileState();
}

class _SettingTileState extends State<SettingTile> {
  bool isOn = false;
  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      onTap: widget.onTap,
      leading: Icon(widget.icon),
      title: Text(widget.title, style: AppTypography.kBold16),
      subtitle: widget.isSwitch
          ? null
          : widget.subtitle != null
              ? Text(widget.subtitle!, style: AppTypography.kLight14)
              : null,
      trailing: widget.isSwitch
          ? CustomSwitch(
              value: widget.switchValue!,
              activeColor: isDarkMode(context)
                  ? Colors.black
                  : AppColors.kPrimary,
              onChanged: widget.onChanged!,
            )
          :Icon(
              AppAssets.kArrowForward,
              color: AppColors.kSecondary.withOpacity(0.4),
            ),
      contentPadding: EdgeInsets.zero,
      minVerticalPadding: 0,
    );
  }
}
