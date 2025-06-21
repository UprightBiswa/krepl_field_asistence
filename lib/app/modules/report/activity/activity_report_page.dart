import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/constrants/constants.dart';
import '../../widgets/appbars/appbars.dart';
import 'activity_report_controller.dart';

class ActivityReportPage extends StatelessWidget {
  const ActivityReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ActivityReportController controller =
        Get.put(ActivityReportController());

    return Scaffold(
      appBar: CustomBackAppBar(
        spaceBar: true,
        leadingCallback: () => Get.back<void>(),
        iconColor: AppColors.kPrimary.withValues(alpha: 0.15),
        title: Text(
          'Activity Report',
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
                              color: Colors.black,
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
                                color: WidgetStateProperty.resolveWith<Color?>(
                                  (_) {
                                    return controller.activities
                                            .indexOf(activity)
                                            .isEven
                                        ? (Colors.grey[200])
                                        : (Colors.white);
                                  },
                                ),
                                cells: [
                                  DataCell(Text(
                                      (controller.activities.indexOf(activity) +
                                              1)
                                          .toString())),
                                  DataCell(
                                    Text(
                                      formatDate(
                                        activity.createdAt.toString(),
                                      ),
                                    ),
                                  ),
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

  String formatDate(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd-MMM-yyyy').format(date);
    } catch (e) {
      return '';
    }
  }

  Widget _buildDateFilter(
      BuildContext context, ActivityReportController controller) {
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
        controller.fetchActivityReport(); // Fetch data after updating date
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
