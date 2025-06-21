import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/constrants/constants.dart';
import '../widgets/appbars/custom_back_appbar.dart';
import '../widgets/loading/shimmer_activity_card.dart';
import 'component/customer_sales_continer.dart';
import 'controllers/activity_controller.dart';
import 'model/cutomer_sales_data.dart';

class CustomerSalesPage extends StatelessWidget {
  final ActivityController activityController = Get.put(ActivityController());
  final CustomerSalesController searchController =
      Get.put(CustomerSalesController());

  CustomerSalesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(110.h),
          child: CustomBackAppBar(
            spaceBar: true,
            leadingCallback: () {
              Get.back<void>();
            },
            iconColor: AppColors.kPrimary.withAlpha(50),
            title: Text(
              'Customer Sales',
              style: AppTypography.kBold14.copyWith(
                color: AppColors.kDarkContiner,
              ),
            ),
            centerTitle: false,
            bottom: const TabBar(
              tabs: [
                Tab(text: 'YTD Sales'),
                Tab(text: 'MTD Sales'),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Obx(() {
                return SearchBar(
                    controller: searchController.searchController,
                    onChanged: searchController.updateSearchQuery,
                    hintText: 'Search by Name or Number',
                    leading: const Icon(Icons.search),
                    trailing: [
                      if (searchController.searchQuery.value.isNotEmpty)
                        IconButton(
                          onPressed: () {
                            searchController.searchController.clear();
                            searchController.updateSearchQuery('');
                          },
                          icon: const Icon(Icons.clear),
                        ),
                    ]);
              }),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Obx(() => buildSalesList(
                        activityController.ytdSalesData,
                        activityController.isLoadingYtdSales.value,
                        true,
                      )),
                  Obx(() => buildSalesList(
                        activityController.mtdSalesData,
                        activityController.isLoadingMtdSales.value,
                        false,
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSalesList(List<SalesData> salesList, bool isLoading, bool isYtd) {
    var searchQuery = searchController.searchQuery.value.toLowerCase();
    var filteredList = salesList.where((salesData) {
      return salesData.customerName.toLowerCase().contains(searchQuery) ||
          salesData.customerNo.toString().contains(searchQuery);
    }).toList();

    if (isLoading) {
      return ListView.builder(
        padding: EdgeInsets.all(12.w),
        itemCount: 10,
        itemBuilder: (context, index) => const ShimmerActivityCard(),
      );
    } else if (filteredList.isEmpty) {
      return const Center(child: Text('No sales data available'));
    } else {
      return ListView.builder(
        padding: EdgeInsets.all(12.w),
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          final salesData = filteredList[index];
          return CustomerSalesCard(
            salesData: salesData,
            isYtd: isYtd,
          );
        },
      );
    }
  }
}

class CustomerSalesController extends GetxController {
  var searchQuery = ''.obs;
  TextEditingController searchController = TextEditingController();

  void updateSearchQuery(String value) {
    searchQuery.value = value;
  }
}
