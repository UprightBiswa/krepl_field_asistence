import 'package:field_asistence/app/modules/dashboard/component/expense_comparison_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../data/constrants/constants.dart';
import '../../../model/login/user_details_reponse.dart';
import '../../widgets/containers/primary_container.dart';
import '../model/expense_data_model.dart';
import '../model/sales_dara_model.dart';
import 'common_chart.dart';
import 'data_row_widget.dart';
import '../model/piedata_model.dart';
import 'sales_comparison_chart.dart';


class DashboardYTD extends StatefulWidget {
  final UserDetails userDetails;

  const DashboardYTD({
    Key? key,
    required this.userDetails,
  }) : super(key: key);

  @override
  State<DashboardYTD> createState() => _DashboardYTDState();
}

class _DashboardYTDState extends State<DashboardYTD> {
  late List<PieData> pieData;
  late List<SelesDateLine> salesData;
  late List<ExpenseData> expensesData;
  bool _showData = true;
  @override
  void initState() {
    super.initState();
    pieData = odPieData;
    salesData = salesYtdLine;
    expensesData = ytdExpenseDataList;
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        PrimaryContainer(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: AppSpacing.radiusThirty,
                      backgroundImage: AssetImage(
                        AppAssets.kLogo,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userDetails.employeeName,
                          style: AppTypography.kMedium15.copyWith(
                            color: (isDarkMode(context)
                                ? AppColors.kWhite
                                : AppColors.kGrey),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          'ID: ${widget.userDetails.hrEmployeeCode}',
                          style: AppTypography.kLight14.copyWith(
                            color: isDarkMode(context)
                                ? AppColors.kWhite
                                : AppColors.kGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Text(
              'Data View (YTD)',
              style: TextStyle(fontSize:  18.sp),
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
        Visibility(
          visible: !_showData,
          child: PrimaryContainer(
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
        ),
        SizedBox(height: 8.h),
        SalesComparisonChart(
          title: 'Sales Comparison (Trending) YTD',
          line: salesData,
        ),
        SizedBox(height: 8.h),
        ExpenseComparisonChart(
          title: 'Expense Comparison YTD',
          data: expensesData,
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
