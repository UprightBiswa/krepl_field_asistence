// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';

// import '../../data/constrants/constants.dart';
// import '../home/components/search_field.dart';
// import '../widgets/appbars/appbars.dart';
// import '../widgets/buttons/buttons.dart';
// import '../widgets/buttons/custom_button.dart';
// import 'components/route_map_list_view.dart';
// import 'controller/route_controller.dart';
// import 'controller/route_report_controller.dart';
// import 'create_route_form_page.dart';

// class RoutePlanManagementPage extends StatelessWidget {
//   RoutePlanManagementPage({super.key});

//   // final TextEditingController textController = TextEditingController();
//   // final RouteController routeController = Get.put(RouteController());

//   bool isDarkMode(BuildContext context) =>
//       Theme.of(context).brightness == Brightness.dark;

//   @override
//   Widget build(BuildContext context) {
//     final RouteReportController controller = Get.put(RouteReportController());
//     return Scaffold(
//       appBar: CustomBackAppBar(
//         leadingCallback: () {
//           Get.back<void>();
//         },
//         iconColor: isDarkMode(context)
//             ? Colors.black
//             : AppColors.kPrimary.   withValues(alpha:0.15),
//         title: Text(
//           'Route Report',
//           style: AppTypography.kBold14.copyWith(
//             color: isDarkMode(context)
//                 ? AppColors.kWhite
//                 : AppColors.kDarkContiner,
//           ),
//         ),
//         centerTitle: false,
//         // action: [
//         //   CustomButton(
//         //     icon: Icons.add,
//         //     text: 'Add Route',
//         //     isBorder: true,
//         //     onTap: () {
//         //       Get.to(() => const RouteFormPage(),
//         //            );
//         //     },
//         //   ),
//         //   SizedBox(
//         //     width: 10.w,
//         //   )
//         // ],

// //       body: Obx(() {
// //         if (routeController.isLoading.value) {
// //           return const Center(child: CircularProgressIndicator());
// //         }

// //         return SingleChildScrollView(
// //           padding: EdgeInsets.symmetric(horizontal: 20.w),
// //           child: SafeArea(
// //             child: Column(
// //               children: [
// //                 SizedBox(height: 10.h),
// //                 Row(
// //                   children: [
// //                     Expanded(
// //                       child: SearchField(
// //                         controller: textController,
// //                         onChanged: (query) {
// //                           routeController.filterRouteMaps(query);
// //                         },
// //                         isEnabled: true,
// //                         hintText: 'Search RouteMap',
// //                       ),
// //                     ),
// //                     SizedBox(width: 10.w),
// //                     GestureDetector(
// //                       onTap: () {
// //                         // Logic for filter action
// //                       },
// //                       child: CircleAvatar(
// //                         radius: 20.w,
// //                         backgroundColor: AppColors.kPrimary.   withValues(alpha:0.15),
// //                         child: const Icon(
// //                           Icons.filter_list,
// //                           color: AppColors.kPrimary,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(height: 10.h),
// //                 Row(
// //                   children: [
// //                     Text('Route Map', style: AppTypography.kBold16),
// //                     const Spacer(),
// //                     CustomTextButton(
// //                       onPressed: () {
// //                         // Logic to see all farmers
// //                       },
// //                       text: 'See All',
// //                       color: AppColors.kDarkContiner.   withValues(alpha:0.3),
// //                     ),
// //                   ],
// //                 ),
// //                 SizedBox(height: 20.h),
// //                 RouteMapListView(
// //                   route: routeController.filteredRouteMaps,
// //                 ),
// //                 SizedBox(height: AppSpacing.twentyVertical),
// //               ],
// //             ),
// //           ),
// //         );
// //       }),
// //     );
// //   }
// // }
//         action: [
//           IconButton(
//             icon: const Icon(Icons.calendar_today),
//             onPressed: () async {
//               final DateTimeRange? dateRange = await showDateRangePicker(
//                 context: context,
//                 initialDateRange: DateTimeRange(
//                   start: DateTime.now().subtract(const Duration(days: 7)),
//                   end: DateTime.now(),
//                 ),
//                 firstDate: DateTime(2000),
//                 lastDate: DateTime.now(),
//               );
//               if (dateRange != null) {
//                 controller.setDateRange(dateRange.start, dateRange.end);
//               }
//             },
//           ),
//         ],
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (controller.hasError.value) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   'Error: ${controller.errorMessage.value}',
//                   style: const TextStyle(color: Colors.red),
//                 ),
//                 ElevatedButton(
//                   onPressed: () => controller.fetchRouteReport(),
//                   child: const Text('Retry'),
//                 ),
//               ],
//             ),
//           );
//         }

//         if (controller.routes.isEmpty) {
//           return const Center(child: Text('No data available.'));
//         }

//         return SingleChildScrollView(
//           child: DataTable(
//             columns: const [
//               DataColumn(label: Text('Route No')),
//               DataColumn(label: Text('Route Name')),
//               DataColumn(label: Text('Pincode')),
//               DataColumn(label: Text('Office Name')),
//               DataColumn(label: Text('Village/Locality')),
//             ],
//             rows: controller.routes.map((route) {
//               return DataRow(cells: [
//                 DataCell(Text(route.routeCode)),
//                 DataCell(Text(route.routeName)),
//                 DataCell(Text(route.pin ?? 'N/A')),
//                 DataCell(Text(route.officename ?? 'N/A')),
//                 DataCell(Text(route.villageName ?? 'N/A')),
//               ]);
//             }).toList(),
//           ),
//         );
//       }),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/constrants/constants.dart';
import '../widgets/widgets.dart';
import 'controller/route_report_controller.dart';
import 'model/route_list.dart';

class RoutePlanManagementPage extends StatelessWidget {
  const RoutePlanManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RouteReportController controller = Get.put(RouteReportController());
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomBackAppBar(
        spaceBar: true,
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: AppColors.kPrimary.withValues(alpha: 0.15),
        title: Text(
          'Route Report',
          style: AppTypography.kBold14.copyWith(
            color: AppColors.kDarkContiner,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          _buildDateFilter(context, controller),
          const Divider(thickness: 1),
          // Data Table
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.hasError.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error: ${controller.errorMessage.value}',
                        style: const TextStyle(color: Colors.red, fontSize: 16),
                      ),
                      ElevatedButton(
                        onPressed: () => controller.fetchRoutes(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (controller.routes.isEmpty) {
                return const Center(child: Text('No routes found.'));
              }

              return Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          border: TableBorder.all(
                            color: isDarkMode(context)
                                ? Colors.grey
                                : Colors.black,
                            width: 1,
                          ),
                          columns: const [
                            DataColumn(
                              label: Text(
                                'Index',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                style: TextStyle(fontWeight: FontWeight.bold),
                                'Route Code',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                style: TextStyle(fontWeight: FontWeight.bold),
                                'Route Name',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                style: TextStyle(fontWeight: FontWeight.bold),
                                'Village',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                style: TextStyle(fontWeight: FontWeight.bold),
                                'Pin',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                style: TextStyle(fontWeight: FontWeight.bold),
                                'Office Name',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                style: TextStyle(fontWeight: FontWeight.bold),
                                'Valid From',
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                style: TextStyle(fontWeight: FontWeight.bold),
                                'Valid To',
                              ),
                            ),
                          ],
                          rows: controller.routes.map((route) {
                            return DataRow(
                              color: WidgetStateProperty.resolveWith<Color?>(
                                (_) {
                                  return controller.routes.indexOf(route).isEven
                                      ? (isDarkMode(context)
                                          ? Colors.grey[800]
                                          : Colors.grey[200])
                                      : (isDarkMode(context)
                                          ? Colors.grey[700]
                                          : Colors.white);
                                },
                              ),
                              cells: [
                                DataCell(Text(
                                    (controller.routes.indexOf(route) + 1)
                                        .toString())),
                                DataCell(Text(route.routeCode)),
                                DataCell(Text(route.routeName)),
                                DataCell(Text(route.villageName ?? '')),
                                DataCell(Text(route.pin ?? '')),
                                DataCell(Text(route.officename ?? '')),
                                DataCell(
                                  Text(
                                    formatDate(
                                      route.validFrom.toString(),
                                    ),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    formatDate(
                                      route.validTo.toString(),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildPagination(controller),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  String formatDate(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd-MMM-yyyy').format(date);
    } catch (e) {
      return '';
    }
  }

// Pagination Controls
  Widget _buildPagination(RouteReportController controller) {
    return ColoredBox(
      color: AppColors.kPrimary,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: controller.currentPage.value > 1
                ? controller.goToPreviousPage
                : null,
            icon: Icon(
              Icons.arrow_back,
              color: controller.currentPage.value > 1
                  ? AppColors.kWhite
                  : Colors.grey,
            ),
          ),
          Obx(() => Text(
                'Page ${controller.currentPage.value} of ${controller.totalPages.value}',
                style: const TextStyle(fontSize: 16),
              )),
          IconButton(
            onPressed:
                controller.currentPage.value < controller.totalPages.value
                    ? controller.goToNextPage
                    : null,
            icon: Icon(
              Icons.arrow_forward,
              color: controller.currentPage.value < controller.totalPages.value
                  ? AppColors.kWhite
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildDateFilter(
  //     BuildContext context, RouteReportController controller) {
  //   return GestureDetector(
  //     onTap: () async {
  //       final DateTimeRange? picked = await showDateRangePicker(
  //         context: context,
  //         firstDate: DateTime(2020),
  //         lastDate: DateTime.now(),
  //         initialDateRange: DateTimeRange(
  //           start: controller.fromDate.value,
  //           end: controller.toDate.value,
  //         ),
  //       );
  //       if (picked != null) {
  //         controller.updateDateRange(picked.start, picked.end);
  //         controller.fetchRoutes();
  //       }
  //     },
  //     child: Obx(() {
  //       final DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
  //       return Container(
  //         padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Text(
  //               'Select date range',
  //               style: TextStyle(fontSize: 14.0, color: Colors.teal.shade700),
  //             ),
  //             const SizedBox(height: 8.0),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'From: ${dateFormat.format(controller.fromDate.value)}',
  //                   style: const TextStyle(fontSize: 16),
  //                 ),
  //                 Text(
  //                   'To: ${dateFormat.format(controller.toDate.value)}',
  //                   style: const TextStyle(fontSize: 16),
  //                 ),
  //               ],
  //             ),
  //           ],
  //         ),
  //       );
  //     }),
  //   );
  // }

  /// Date Picker Fields (From Date & To Date)
  Widget _buildDateFilter(
      BuildContext context, RouteReportController controller) {
    final DateFormat dateFormat = DateFormat('dd-MMM-yy');

    Future<void> selectDate(BuildContext context, bool isFromDate) async {
      final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate:
            isFromDate ? controller.fromDate.value : controller.toDate.value,
        firstDate: DateTime(2020),
        lastDate: isFromDate ? controller.toDate.value : DateTime.now(),
      );

      if (pickedDate != null) {
        if (isFromDate) {
          if (pickedDate.isAfter(controller.toDate.value)) {
            Get.snackbar("Invalid Date", "From Date cannot be after To Date",
                backgroundColor: Colors.red, colorText: Colors.white);
            return;
          }
          controller.fromDate.value = pickedDate;
        } else {
          if (pickedDate.isBefore(controller.fromDate.value)) {
            Get.snackbar("Invalid Date", "To Date cannot be before From Date",
                backgroundColor: Colors.red, colorText: Colors.white);
            return;
          }
          controller.toDate.value = pickedDate;
        }
        controller.fetchRoutes(); // Fetch data after updating date
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Select Date Range',
              style: TextStyle(fontSize: 14.0, color: Colors.teal.shade700)),
          const SizedBox(height: 8.0),
          Row(
            children: [
              Expanded(
                child: Obx(() => TextFormField(
                      readOnly: true,
                      onTap: () => selectDate(context, true),
                      decoration: InputDecoration(
                        labelText: "From Date",
                        suffixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: TextEditingController(
                          text: dateFormat.format(controller.fromDate.value)),
                    )),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Obx(() => TextFormField(
                      readOnly: true,
                      onTap: () => selectDate(context, false),
                      decoration: InputDecoration(
                        labelText: "To Date",
                        suffixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      controller: TextEditingController(
                          text: dateFormat.format(controller.toDate.value)),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RouteDataSource extends DataTableSource {
  final List<RouteModel> routes;

  RouteDataSource(this.routes);

  @override
  DataRow? getRow(int index) {
    if (index >= routes.length) return null;

    final route = routes[index];
    return DataRow(
      cells: [
        DataCell(Text(route.routeCode)),
        DataCell(Text(route.routeName)),
        DataCell(Text(route.villageName ?? 'N/A')),
        DataCell(Text(route.pin ?? 'N/A')),
        DataCell(Text(route.officename ?? 'N/A')),
        DataCell(Text(route.validFrom)),
        DataCell(Text(route.validTo)),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => routes.length;

  @override
  int get selectedRowCount => 0;
}
