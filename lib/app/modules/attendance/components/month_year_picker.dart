import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/texts/custom_header_text.dart';

class MonthYearPicker extends StatelessWidget {
  final String monthName;
  final String year;
  final VoidCallback onPickMonth;

  const MonthYearPicker({
    super.key,
    required this.monthName,
    required this.year,
    required this.onPickMonth,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryContainer(
      child: Row(
        children: [
          CustomHeaderText(
            text: '$monthName - $year',
            fontSize: 16.sp,
          ),
          const Spacer(),
          CustomButton(
            text: 'Pick a Month',
            icon: AppAssets.kCalendar,
            isBorder: true,
            onTap: onPickMonth,
          ),
        ],
      ),
    );
  }
}
