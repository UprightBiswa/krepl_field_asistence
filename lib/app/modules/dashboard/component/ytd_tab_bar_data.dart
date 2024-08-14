// import 'package:field_asistence/app/modules/dashboard/component/expense_comparison_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../data/constrants/constants.dart';
// import '../../../model/login/user_details_reponse.dart';
// import '../../widgets/containers/primary_container.dart';
// import '../model/expense_data_model.dart';
// import '../model/sales_dara_model.dart';
// import 'common_chart.dart';
// import 'data_row_widget.dart';
// import '../model/piedata_model.dart';
// import 'sales_comparison_chart.dart';

// class YTDTabBarData extends StatefulWidget {
//   final UserDetails userDetails;

//   const YTDTabBarData({
//     super.key,
//     required this.userDetails,
//   });

//   @override
//   State<YTDTabBarData> createState() => _YTDTabBarDataState();
// }

// class _YTDTabBarDataState extends State<YTDTabBarData> {
//   late List<PieData> pieData;
//   late List<SelesDateLine> salesData;
//   late List<ExpenseData> expensesData;
//   bool _showData = true;
//   @override
//   void initState() {
//     super.initState();
//     pieData = odPieData;
//     salesData = salesYtdLine;
//     expensesData = ytdExpenseDataList;
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool isDarkMode(BuildContext context) =>
//         Theme.of(context).brightness == Brightness.dark;
//     return Column(
//       children: [
//         Row(
//           children: [
//             Text(
//               'Data View (YTD)',
//               style: TextStyle(fontSize: 18.sp),
//             ),
//             const Spacer(),
//             IconButton(
//               onPressed: () {
//                 setState(() {
//                   _showData = true;
//                 });
//               },
//               icon: const Icon(Icons.list),
//               color: _showData ? AppColors.kSecondary : AppColors.kHint,
//             ),
//             SizedBox(width: 8.w),
//             IconButton(
//               onPressed: () {
//                 setState(() {
//                   _showData = false;
//                 });
//               },
//               icon: const Icon(Icons.pie_chart),
//               color: _showData ? AppColors.kHint : AppColors.kSecondary,
//             ),
//           ],
//         ),
//         Visibility(
//           visible: _showData,
//           child: const PrimaryContainer(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 DataRowWidget(
//                   title: 'Aging (OD)',
//                   current: 'Current: 1223',
//                   target: 'Target: 21756',
//                   ly: 'LY: 23812',
//                 ),
//                 Divider(),
//                 DataRowWidget(
//                   title: 'Aging (OS)',
//                   current: 'Current: 1223',
//                   target: 'Target: 21756',
//                   ly: 'LY: 23812',
//                 ),
//                 Divider(),
//                 DataRowWidget(
//                     title: 'Sale',
//                     current: 'Current: 1223',
//                     target: 'Target: 21756',
//                     ly: 'LY: 23812'),
//                 Divider(),
//                 DataRowWidget(
//                   title: 'Coll',
//                   current: 'Current: 1223',
//                   target: 'Target: 21756',
//                   ly: 'LY: 23812',
//                 ),
//                 Divider(),
//                 DataRowWidget(
//                   title: 'Exp',
//                   current: 'Current: 1223',
//                   target: 'Target: 21756',
//                   ly: 'LY: 23812',
//                 ),
//                 Divider(),
//                 DataRowWidget(
//                   title: 'SO RT',
//                   current: 'Current: 1223',
//                   target: 'Target: 21756',
//                   ly: 'LY: 23812',
//                 ),
//                 Divider(),
//                 DataRowWidget(
//                   title: 'SE RT',
//                   current: 'Current: 1223',
//                   target: 'Target: 21756',
//                   ly: 'LY: 23812',
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Visibility(
//           visible: !_showData,
//           child: GridView.count(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             crossAxisCount: 2,
//             mainAxisSpacing: 10.w,
//             crossAxisSpacing: 10.w,
//             children: [
//               CommonChart(data: odPieData, title: 'Aging (OD)'),
//               CommonChart(data: osPieData, title: 'Aging (OS)'),
//               CommonChart(data: salePieData, title: 'Sale'),
//               CommonChart(data: collPieData, title: 'Coll'),
//               CommonChart(data: expPieData, title: 'Exp'),
//               CommonChart(data: soRtPieData, title: 'SO RT'),
//               CommonChart(data: seRtPieData, title: 'SE RT'),
//             ],
//           ),
//         ),
//         SizedBox(height: 8.h),
//         SalesComparisonChart(
//           title: 'Sales Comparison (Trending) YTD',
//           line: salesData,
//         ),
//         SizedBox(height: 8.h),
//         ExpenseComparisonChart(
//           title: 'Expense Comparison YTD',
//           data: expensesData,
//         ),
//         SizedBox(height: 8.h),
//       ],
//     );
//   }
// }

import 'package:field_asistence/app/modules/dashboard/component/expense_comparison_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../model/login/user_details_reponse.dart';
import '../controllers/activity_controller.dart';
import '../model/data_model.dart';
import '../model/expense_data_model.dart';
import '../model/sales_dara_model.dart';

import '../model/piedata_model.dart';
import 'activity_card.dart';
import 'sales_comparison_chart.dart';

class YTDTabBarData extends StatefulWidget {
  final UserDetails userDetails;

  const YTDTabBarData({
    super.key,
    required this.userDetails,
  });

  @override
  State<YTDTabBarData> createState() => _YTDTabBarDataState();
}

class _YTDTabBarDataState extends State<YTDTabBarData> {
  final ActivityController controller = Get.put(ActivityController());
  late List<PieData> pieData;
  late List<SelesDateLine> salesData;
  late List<ExpenseData> expensesData;
  late ScrollController _scrollController;
  @override
  void initState() {
    super.initState();

    pieData = odPieData;
    salesData = salesYtdLine;
    expensesData = ytdExpenseDataList;
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.atEdge) {
      if (_scrollController.position.pixels != 0) {
        controller
            .fetchYtdData(); // Fetch more data when scrolled to the bottom
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return RefreshIndicator(
      onRefresh: () async {
        await controller.fetchYtdData();
      },
      child: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else if (controller.isError.value) {
          return const Center(
              child: Text('An error occurred, please try again.'));
        } else {
          return ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            controller: _scrollController,
            children: [
              SizedBox(height: 8.h),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.ytdData.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.dg,
                  crossAxisSpacing: 8.dg,
                ),
                itemBuilder: (context, index) {
                  ActivityData activity = controller.ytdData[index];
                  return ActivityCard(activity: activity);
                },
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
      }),
    );
  }
}
