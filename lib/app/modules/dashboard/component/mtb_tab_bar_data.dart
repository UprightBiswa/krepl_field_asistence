import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';
import '../../../model/login/user_details_reponse.dart';
import '../../widgets/containers/primary_container.dart';
import '../model/expense_data_model.dart';
import '../model/sales_dara_model.dart';
import 'common_chart.dart';
import 'data_row_widget.dart';
import 'expense_comparison_chart.dart';
import '../model/piedata_model.dart';
import 'sales_comparison_chart.dart';

class MTDTabBarData extends StatefulWidget {
  final UserDetails userDetails;

  const MTDTabBarData({
    super.key,
    required this.userDetails,
  });

  @override
  State<MTDTabBarData> createState() => _MTDTabBarDataState();
}

class _MTDTabBarDataState extends State<MTDTabBarData> {
  late List<PieData> pieData;
  late List<SelesDateLine> salesData;
  late List<ExpenseData> expensesData;

  bool _showData = true;
  @override
  void initState() {
    super.initState();
    pieData = odPieData;
    salesData = salesMtdLine;
    expensesData = mtdExpenseDataList;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Row(
          children: [
            Text(
              'Data View (MTD)',
              style: TextStyle(
                fontSize: 18.sp,
              ),
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  _showData = true;
                });
              },
              icon: const Icon(Icons.list),
              color: _showData ? AppColors.kSecondary : AppColors.kHint,
            ),
            SizedBox(width: 8.w),
            IconButton(
              onPressed: () {
                setState(() {
                  _showData = false;
                });
              },
              icon: const Icon(Icons.pie_chart),
              color: _showData ? AppColors.kHint : AppColors.kSecondary,
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Visibility(
          visible: _showData,
          child: const PrimaryContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DataRowWidget(
                  title: 'Aging (OD)',
                  current: 'Current: 1223',
                  target: 'Target: 21756',
                  ly: 'LY: 23812',
                ),
                Divider(),
                DataRowWidget(
                  title: 'Aging (OS)',
                  current: 'Current: 1223',
                  target: 'Target: 21756',
                  ly: 'LY: 23812',
                ),
                Divider(),
                DataRowWidget(
                    title: 'Sale',
                    current: 'Current: 1223',
                    target: 'Target: 21756',
                    ly: 'LY: 23812'),
                Divider(),
                DataRowWidget(
                  title: 'Coll',
                  current: 'Current: 1223',
                  target: 'Target: 21756',
                  ly: 'LY: 23812',
                ),
                Divider(),
                DataRowWidget(
                  title: 'Exp',
                  current: 'Current: 1223',
                  target: 'Target: 21756',
                  ly: 'LY: 23812',
                ),
                Divider(),
                DataRowWidget(
                  title: 'SO RT',
                  current: 'Current: 1223',
                  target: 'Target: 21756',
                  ly: 'LY: 23812',
                ),
                Divider(),
                DataRowWidget(
                  title: 'SE RT',
                  current: 'Current: 1223',
                  target: 'Target: 21756',
                  ly: 'LY: 23812',
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Visibility(
          visible: !_showData,
          child: GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 10.w,
            crossAxisSpacing: 10.w,
            children: [
              CommonChart(data: odPieData, title: 'Aging (OD)'),
              CommonChart(data: osPieData, title: 'Aging (OS)'),
              CommonChart(data: salePieData, title: 'Sale'),
              CommonChart(data: collPieData, title: 'Coll'),
              CommonChart(data: expPieData, title: 'Exp'),
              CommonChart(data: soRtPieData, title: 'SO RT'),
              CommonChart(data: seRtPieData, title: 'SE RT'),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        SalesComparisonChart(
          title: 'Sales Comparison (Trending) MTD',
          line: salesData,
        ),
        SizedBox(height: 10.h),
        ExpenseComparisonChart(
          title: 'Expense Comparison MTD',
          data: expensesData,
        ),
        SizedBox(height: 10.h),
      ],
    );
  }
}
