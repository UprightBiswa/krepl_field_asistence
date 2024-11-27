import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/constrants/constants.dart';
import '../../widgets/appbars/appbars.dart';
import 'demo_report_controller.dart';

class DemoReportPage extends StatelessWidget {
  const DemoReportPage({super.key});

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    final DemoReportController controller = Get.put(DemoReportController());

    return Scaffold(
      appBar: CustomBackAppBar(
        spaceBar: true,
        leadingCallback: () => Get.back<void>(),
        iconColor: isDarkMode(context)
            ? Colors.black
            : AppColors.kPrimary.withOpacity(0.15),
        title: Text(
          'Demo Report',
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

  /// Date Range Filter Widget
  Widget _buildDateFilter(
      BuildContext context, DemoReportController controller) {
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
          controller.fetchDemoReport();
        }
      },
      child: Obx(() {
        final DateFormat dateFormat = DateFormat('dd-MMM-yyyy');
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
          color: isDarkMode(context) ? Colors.grey[900] : Colors.grey[200],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select date range',
                style: TextStyle(
                  fontSize: 14.0,
                  color:
                      isDarkMode(context) ? Colors.teal[100] : Colors.teal[700],
                ),
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

  /// Error State Widget
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
              color: isDarkMode(context) ? Colors.grey : Colors.black,
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
              DataColumn(label: Text('Status')),
            ],
            rows: controller.demoReports.map((demoReport) {
              return DataRow(
                color: MaterialStateProperty.resolveWith<Color?>(
                  (_) => controller.demoReports.indexOf(demoReport).isEven
                      ? (isDarkMode(context)
                          ? Colors.grey[800]
                          : Colors.grey[200])
                      : (isDarkMode(context) ? Colors.grey[700] : Colors.white),
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
                  DataCell(Text(
                    demoReport.status == 1 ? 'Active' : 'Inactive',
                    style: TextStyle(
                      color: demoReport.status == 1 ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
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
}
