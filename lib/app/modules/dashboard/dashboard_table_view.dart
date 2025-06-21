import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import '../../provider/connction_provider/connectivity_provider.dart';
import '../landing_screens/components/gradient_appbar.dart';
import '../profile/settings_view.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'component/common_chart.dart';
import 'component/expense_comparison_chart.dart';
import 'model/expense_data_model.dart';
import 'model/piedata_model.dart';
import 'component/sales_comparison_chart.dart';
import 'model/sales_dara_model.dart';

class DashboardTableView extends StatefulWidget {
  final UserDetails userDetails;

  const DashboardTableView({super.key, required this.userDetails});

  @override
  State<DashboardTableView> createState() => _DashboardTableViewState();
}

class _DashboardTableViewState extends State<DashboardTableView> {
  late ConnectivityProvider connectivityProvider;

  late List<PieData> pieData;
  late List<SelesDateLine> salesYTDData;
  late List<ExpenseData> expensesYTDData;
  late List<SelesDateLine> salesMTDData;
  late List<ExpenseData> expensesMTDData;
  bool _showYtdData = true;
  bool _showMtdData = true;

  @override
  void initState() {
    super.initState();
    connectivityProvider =
        Provider.of<ConnectivityProvider>(context, listen: false);
    pieData = odPieData;
    salesYTDData = salesYtdLine;
    expensesYTDData = ytdExpenseDataList;
    salesMTDData = salesMtdLine;
    expensesMTDData = mtdExpenseDataList;
  }

  @override
  Widget build(BuildContext context) {
    connectivityProvider = Provider.of<ConnectivityProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: GradientContainer(
          child: Container(),
        ),
        title: Text(
          'Dashboard',
          style: AppTypography.kLight16.copyWith(
            color: AppColors.kGrey,
          ),
        ),
        centerTitle: true,
        actions: [
          CustomIconButton(
            onTap: () {
              Get.to<dynamic>(
                SettingsView(
                  userDetails: widget.userDetails,
                ),
              );
            },
            icon: AppAssets.kSetting,
            iconColor: AppColors.kWhite,
            color: AppColors.kWhite.withValues(alpha: 0.15),
          ),
          SizedBox(width: AppSpacing.twentyHorizontal),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (!connectivityProvider.isConnected) ...[
              Container(
                padding: EdgeInsets.all(8.h),
                color: Colors.red[400],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wifi_off,
                      color: Colors.white,
                      size: 20.h,
                    ),
                    SizedBox(
                      width: 8.h,
                    ),
                    Text(
                      'You are offline.',
                      style: AppTypography.kMedium12.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
            ],
            PrimaryContainer(
              radius: 0,
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
                              color: AppColors.kGrey,
                            ),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'ID: ${widget.userDetails.hrEmployeeCode}',
                            style: AppTypography.kLight14.copyWith(
                              color: AppColors.kGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  CustomHeaderText(
                    text: 'Data View (YTD)',
                    fontSize: 18.sp,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _showYtdData = true;
                      });
                    },
                    icon: const Icon(Icons.table_chart),
                    color:
                        _showYtdData ? AppColors.kSecondary : AppColors.kHint,
                  ),
                  SizedBox(width: 8.w),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _showYtdData = false;
                      });
                    },
                    icon: const Icon(Icons.pie_chart),
                    color:
                        _showYtdData ? AppColors.kHint : AppColors.kSecondary,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _showYtdData,
              child: PrimaryContainer(
                radius: 0,
                padding: EdgeInsets.all(4.w),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(15),
                    1: FlexColumnWidth(10),
                    2: FlexColumnWidth(10),
                    3: FlexColumnWidth(15),
                    4: FlexColumnWidth(10),
                    5: FlexColumnWidth(10),
                    6: FlexColumnWidth(15),
                    7: FlexColumnWidth(15),
                  },
                  border: TableBorder.all(color: Colors.black),
                  defaultColumnWidth: const IntrinsicColumnWidth(),
                  children: [
                    TableRow(
                      children: [
                        _buildTableCell('Index', isHeader: true),
                        _buildTableCell('OD', isHeader: true),
                        _buildTableCell('OS', isHeader: true),
                        _buildTableCell('Sale', isHeader: true),
                        _buildTableCell('Coll', isHeader: true),
                        _buildTableCell('Exp', isHeader: true),
                        _buildTableCell('SO RT', isHeader: true),
                        _buildTableCell('SE RT', isHeader: true),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildTableCell('Current', isHeader: true),
                        _buildTableCell('123', bgColor: Colors.red),
                        _buildTableCell('123'),
                        _buildTableCell('123', bgColor: Colors.blue),
                        _buildTableCell('123'),
                        _buildTableCell('123'),
                        _buildTableCell('12%', bgColor: Colors.cyan),
                        _buildTableCell('12%', bgColor: Colors.cyan),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildTableCell('Target', isHeader: true),
                        _buildTableCell('0', bgColor: Colors.red),
                        _buildTableCell('0'),
                        _buildTableCell('0', bgColor: Colors.blue),
                        _buildTableCell('21'),
                        _buildTableCell('21'),
                        _buildTableCell('21%', bgColor: Colors.cyan),
                        _buildTableCell('21%', bgColor: Colors.cyan),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildTableCell('LY', isHeader: true),
                        _buildTableCell('238', bgColor: Colors.red),
                        _buildTableCell('238'),
                        _buildTableCell('238', bgColor: Colors.blue),
                        _buildTableCell('238'),
                        _buildTableCell('238'),
                        _buildTableCell('23%', bgColor: Colors.cyan),
                        _buildTableCell('23%', bgColor: Colors.cyan),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !_showYtdData,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.w,
                  crossAxisSpacing: 10.w,
                  children: [
                    CommonChart(
                      data: odPieData,
                      title: 'Aging (OD)',
                    ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  CustomHeaderText(
                    text: 'Data View (MTD)',
                    fontSize: 18.sp,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _showMtdData = true;
                      });
                    },
                    icon: const Icon(Icons.table_chart),
                    color:
                        _showMtdData ? AppColors.kSecondary : AppColors.kHint,
                  ),
                  SizedBox(width: 8.w),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _showMtdData = false;
                      });
                    },
                    icon: const Icon(Icons.pie_chart),
                    color:
                        _showMtdData ? AppColors.kHint : AppColors.kSecondary,
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _showMtdData,
              child: PrimaryContainer(
                radius: 0,
                padding: EdgeInsets.all(4.w),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(15),
                    1: FlexColumnWidth(10),
                    2: FlexColumnWidth(10),
                    3: FlexColumnWidth(15),
                    4: FlexColumnWidth(10),
                    5: FlexColumnWidth(10),
                    6: FlexColumnWidth(15),
                    7: FlexColumnWidth(15),
                  },
                  border: TableBorder.all(color: Colors.black),
                  defaultColumnWidth: const IntrinsicColumnWidth(),
                  children: [
                    TableRow(
                      children: [
                        _buildTableCell('Index', isHeader: true),
                        _buildTableCell('OD', isHeader: true),
                        _buildTableCell('OS', isHeader: true),
                        _buildTableCell('Sale', isHeader: true),
                        _buildTableCell('Coll', isHeader: true),
                        _buildTableCell('Exp', isHeader: true),
                        _buildTableCell('SO RT', isHeader: true),
                        _buildTableCell('SE RT', isHeader: true),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildTableCell('Current', isHeader: true),
                        _buildTableCell('12', bgColor: Colors.red),
                        _buildTableCell('12'),
                        _buildTableCell('12', bgColor: Colors.blue),
                        _buildTableCell('12'),
                        _buildTableCell('12'),
                        _buildTableCell('12%', bgColor: Colors.cyan),
                        _buildTableCell('12%', bgColor: Colors.cyan),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildTableCell('Target', isHeader: true),
                        _buildTableCell('0', bgColor: Colors.red),
                        _buildTableCell('213'),
                        _buildTableCell('213', bgColor: Colors.blue),
                        _buildTableCell('213'),
                        _buildTableCell('213'),
                        _buildTableCell('21%', bgColor: Colors.cyan),
                        _buildTableCell('21%', bgColor: Colors.cyan),
                      ],
                    ),
                    TableRow(
                      children: [
                        _buildTableCell('LY', isHeader: true),
                        _buildTableCell('238', bgColor: Colors.red),
                        _buildTableCell('238'),
                        _buildTableCell('238', bgColor: Colors.blue),
                        _buildTableCell('238'),
                        _buildTableCell('238'),
                        _buildTableCell('23%', bgColor: Colors.cyan),
                        _buildTableCell('23%', bgColor: Colors.cyan),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Visibility(
              visible: !_showMtdData,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SalesComparisonChart(
                title: 'Sales Comparison YTD',
                line: salesYTDData,
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ExpenseComparisonChart(
                title: 'Expense Comparison YTD',
                data: expensesYTDData,
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: SalesComparisonChart(
                title: 'Sales Comparison MTD',
                line: salesMTDData,
              ),
            ),
            SizedBox(height: 8.h),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ExpenseComparisonChart(
                title: 'Expense Comparison MTD',
                data: expensesMTDData,
              ),
            ),
            SizedBox(height: 8.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false, Color? bgColor}) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = bgColor ??
        (isHeader
            ? (isDarkMode(context) ? AppColors.kGrey : AppColors.kHint)
            : (isDarkMode(context)
                ? AppColors.kDarkHint
                : AppColors.kNeutral01));
    return Container(
      padding: EdgeInsets.all(8.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
            color: isDarkMode(context) ? Colors.grey[600]! : Colors.grey[400]!),
      ),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 10.sp,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            color: isHeader
                ? (isDarkMode(context) ? Colors.grey[200] : AppColors.kGrey)
                : (isDarkMode(context) ? AppColors.kWhite : Colors.grey[800])),
      ),
    );
  }
}
