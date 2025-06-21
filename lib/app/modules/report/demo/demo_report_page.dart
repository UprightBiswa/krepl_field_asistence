import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/constrants/constants.dart';
import '../../widgets/appbars/appbars.dart';
import 'demo_report_controller.dart';

class DemoReportPage extends StatelessWidget {
  const DemoReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final DemoReportController controller = Get.put(DemoReportController());

    return Scaffold(
      appBar: CustomBackAppBar(
        spaceBar: true,
        leadingCallback: () => Get.back<void>(),
        iconColor: AppColors.kPrimary.withValues(alpha: 0.15),
        title: Text(
          'Demo Report',
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
                return _buildErrorState(controller);
              }

              if (controller.demoReports.isEmpty) {
                return const Center(child: Text('No data available.'));
              }

              return Column(
                children: [
                  _buildDataTable(context, controller),
                  const SizedBox(height: 10),
                  _buildPaginationControls(controller),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(DemoReportController controller) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Error: ${controller.errorMessage.value}',
            style: const TextStyle(color: Colors.red, fontSize: 16),
          ),
          ElevatedButton(
            onPressed: () => controller.fetchDemoReport(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  /// Data Table Widget
  Widget _buildDataTable(
      BuildContext context, DemoReportController controller) {
    return Expanded(
      child: SingleChildScrollView(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            border: TableBorder.all(
              color: Colors.black,
              width: 1,
            ),
            columns: const [
              DataColumn(label: Text('Index')),
              DataColumn(label: Text('Farmer Name')),
              DataColumn(label: Text('Village Name')),
              DataColumn(label: Text('Product')),
              DataColumn(label: Text('Total Area Cover')),
              DataColumn(label: Text('Area of Demo')),
              DataColumn(label: Text('Dosages')),
              DataColumn(label: Text('Crop Name')),
              DataColumn(label: Text('Demo Status')),
            ],
            rows: controller.demoReports.map((demoReport) {
              return DataRow(
                color: WidgetStateProperty.resolveWith<Color?>(
                  (_) => controller.demoReports.indexOf(demoReport).isEven
                      ? (Colors.grey[200])
                      : (Colors.white),
                ),
                cells: [
                  DataCell(Text((controller.demoReports.indexOf(demoReport) + 1)
                      .toString())),
                  DataCell(Text(demoReport.farmerName)),
                  DataCell(Text(demoReport.villageName)),
                  DataCell(Text(demoReport.product)),
                  DataCell(Text(demoReport.totalAreaCover)),
                  DataCell(Text(demoReport.areaOfDemo)),
                  DataCell(Text(demoReport.dosages)),
                  DataCell(Text(demoReport.cropName)),
                  DataCell(Text(demoReport.status)),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  /// Pagination Controls Widget
  Widget _buildPaginationControls(DemoReportController controller) {
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
                style: const TextStyle(fontSize: 16, color: Colors.white),
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

  /// Date Picker Fields (From Date & To Date)
  Widget _buildDateFilter(
      BuildContext context, DemoReportController controller) {
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
        controller.fetchDemoReport(); // Fetch data after updating date
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
