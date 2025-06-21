import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/constrants/constants.dart';
import '../../widgets/widgets.dart';
import 'activity_summery_report_controller.dart';

class ActivitySummaryPage extends StatelessWidget {
  const ActivitySummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ActivitySummaryController controller =
        Get.put(ActivitySummaryController());
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      appBar: CustomBackAppBar(
        spaceBar: true,
        leadingCallback: () => Get.back<void>(),
        iconColor: AppColors.kPrimary.withValues(alpha: 0.15),
        title: Text(
          'Activity Summary Report',
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
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => controller.fetchActivitySummary(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (controller.summaries.isEmpty) {
                return const Center(child: Text('No data available.'));
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
                                'Activity',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Numbers',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Villages',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Farmers',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Area Covered',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          rows: controller.summaries.map((summary) {
                            return DataRow(
                              color: WidgetStateProperty.resolveWith<Color?>(
                                (_) {
                                  return controller.summaries
                                          .indexOf(summary)
                                          .isEven
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
                                    (controller.summaries.indexOf(summary) + 1)
                                        .toString())),
                                DataCell(Text(summary.promotionalActivity)),
                                DataCell(
                                    Text(summary.activityNumbers.toString())),
                                DataCell(Text(summary.totalVillage.toString())),
                                DataCell(Text(summary.totalFarmers.toString())),
                                DataCell(
                                    Text(summary.totalAreaCover.toString())),
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

  // /// Date Range Filter
  // Widget _buildDateFilter(
  //     BuildContext context, ActivitySummaryController controller) {
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
  //         controller.fetchActivitySummary();
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
      BuildContext context, ActivitySummaryController controller) {
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
        controller.fetchActivitySummary(); // Fetch data after updating date
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

  /// Pagination Controls
  Widget _buildPagination(ActivitySummaryController controller) {
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
}
