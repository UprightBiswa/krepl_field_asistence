import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/constrants/constants.dart';
import '../../widgets/appbars/appbars.dart';
import 'activity_report_controller.dart';

class ActivityReportPage extends StatelessWidget {
  const ActivityReportPage({super.key});

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    final ActivityReportController controller =
        Get.put(ActivityReportController());

    return Scaffold(
      appBar: CustomBackAppBar(
        spaceBar: true,
        leadingCallback: () => Get.back<void>(),
        iconColor: isDarkMode(context)
            ? Colors.black
            : AppColors.kPrimary.withOpacity(0.15),
        title: Text(
          'Activity Report',
          style: AppTypography.kBold14.copyWith(
            color: isDarkMode(context)
                ? AppColors.kWhite
                : AppColors.kDarkContiner,
          ),
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          _buildDateFilter(context, controller),
          const Divider(thickness: 1),

          // Body Content
          Expanded(
            child: Obx(
              () {
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
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                        ElevatedButton(
                          onPressed: () => controller.fetchActivityReport(),
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  );
                }

                if (controller.activities.isEmpty) {
                  return const Center(child: Text('No data available.'));
                }

                return Column(
                  children: [
                    // Data Table
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
                                  'Created At',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Promotional Activity',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Party Type',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Farmer Name',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Village Name',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Acre',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  'Crop',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                            rows: controller.activities.map((activity) {
                              return DataRow(
                                color:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (_) {
                                    return controller.activities
                                            .indexOf(activity)
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
                                      (controller.activities.indexOf(activity) +
                                              1)
                                          .toString())),
                                  DataCell(Text(activity.createdAt)),
                                  DataCell(Text(activity.promotionalActivity)),
                                  DataCell(Text(activity.partyType)),
                                  DataCell(Text(activity.farmerName)),
                                  DataCell(Text(activity.villageName)),
                                  DataCell(Text(activity.acre)),
                                  DataCell(Text(activity.crop)),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Pagination Controls
                    ColoredBox(
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
                            onPressed: controller.currentPage.value <
                                    controller.totalPages.value
                                ? controller.goToNextPage
                                : null,
                            icon: Icon(
                              Icons.arrow_forward,
                              color: controller.currentPage.value <
                                      controller.totalPages.value
                                  ? AppColors.kWhite
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }

  /// Date Range Filter
  Widget _buildDateFilter(
      BuildContext context, ActivityReportController controller) {
    return GestureDetector(
      onTap: () async {
        final DateTimeRange? picked = await showDateRangePicker(
          context: context,
          firstDate: DateTime(2020),
          lastDate: DateTime.now(),
          initialDateRange: DateTimeRange(
            start: controller.fromDate.value,
            end: controller.toDate.value,
          ),
        );
        if (picked != null) {
          controller.updateDateRange(picked.start, picked.end);
          controller.fetchActivityReport();
        }
      },
      child: Obx(() {
        final DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select date range',
                style: TextStyle(fontSize: 14.0, color: Colors.teal.shade700),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'From: ${dateFormat.format(controller.fromDate.value)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    'To: ${dateFormat.format(controller.toDate.value)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
