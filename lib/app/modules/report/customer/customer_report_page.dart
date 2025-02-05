import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/constrants/constants.dart';
import '../../home/components/search_field.dart';
import '../../widgets/appbars/appbars.dart';
import 'customer_report_controller.dart';

class CustomerReportPage extends StatelessWidget {
  const CustomerReportPage({super.key});

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    final CustomerReportController controller =
        Get.put(CustomerReportController());

    return Scaffold(
      appBar: CustomBackAppBar(
        spaceBar: true,
        leadingCallback: () => Get.back<void>(),
        iconColor: isDarkMode(context)
            ? Colors.black
            : AppColors.kPrimary.withOpacity(0.15),
        title: Text(
          'Customer Report',
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
          Padding(
            padding: EdgeInsets.all(10.0.w),
            child: SearchField(
              controller: controller.searchController,
              onChanged: (query) {
                controller.setSearchQuery(query);
              },
              isEnabled: true,
              hintText: 'Search farmers',
            ),
          ),
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
                        onPressed: () => controller.fetchCustomerReport(),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              }

              if (controller.customers.isEmpty) {
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
                                'Customer Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Customer Code',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Mobile No',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Village/Location',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          rows: [
                            for (int i = 0;
                                i < controller.customers.length;
                                i++)
                              DataRow(
                                color:
                                    MaterialStateProperty.resolveWith<Color?>(
                                  (_) {
                                    return i.isEven
                                        ? (isDarkMode(context)
                                            ? Colors.grey[800]
                                            : Colors.grey[200])
                                        : (isDarkMode(context)
                                            ? Colors.grey[700]
                                            : Colors.white);
                                  },
                                ),
                                cells: [
                                  DataCell(Text((i + 1).toString())),
                                  DataCell(Text(
                                      controller.customers[i].customerName)),
                                  DataCell(Text(
                                      controller.customers[i].customerNumber)),
                                  DataCell(Text(
                                      controller.customers[i].mobileNumber)),
                                  DataCell(Text(
                                      controller.customers[i].villageName)),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Pagination Controls
                  ColoredBox(
                    color: AppColors.kPrimary,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: controller.currentPage.value > 1
                              ? controller.loadPreviousPage
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
                              ? controller.loadNextPage
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
            }),
          ),
        ],
      ),
    );
  }
}
