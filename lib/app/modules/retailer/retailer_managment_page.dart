import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../farmer/components/filter_bottom_sheet.dart';
import '../home/components/search_field.dart';
import '../widgets/appbars/appbars.dart';
import '../widgets/buttons/custom_button.dart';
import '../widgets/no_result/error_page.dart';
import 'components/retailer_list_view.dart';
import 'controller/retailer_controller.dart';
import 'retailer_form.dart';

class RetailerManagementPage extends StatefulWidget {
  const RetailerManagementPage({super.key});

  @override
  State<RetailerManagementPage> createState() => _RetailerManagementPageState();
}

class _RetailerManagementPageState extends State<RetailerManagementPage> {
  final TextEditingController textController = TextEditingController();

  final RetailerController retailerController = Get.put(RetailerController());

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    super.initState();
    retailerController.fetchFarmers(1, retailerController.pagingController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppBar(
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: isDarkMode(context)
            ? Colors.black
            : AppColors.kPrimary.withOpacity(0.15),
        title: Text(
          'Retailer Management',
          style: AppTypography.kBold14.copyWith(
            color: isDarkMode(context)
                ? AppColors.kWhite
                : AppColors.kDarkContiner,
          ),
        ),
        centerTitle: false,
        action: [
          CustomButton(
            icon: Icons.add,
            text: 'Add Retailer',
            isBorder: true,
            onTap: () {
              Get.to(() => const RetailerForm(),
                      transition: Transition.rightToLeftWithFade)!
                  .then((value) {
                retailerController.refreshItems();
              });
            },
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          retailerController.refreshItems();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: SearchField(
                      controller: textController,
                      onChanged: (query) {
                        retailerController.setSearchQuery(query);
                      },
                      isEnabled: true,
                      hintText: 'Search Retailers',
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        FilterBottomSheet(
                          controller: retailerController.filterController!,
                          onApply: retailerController.refreshItems,
                          onClear: retailerController.clearFilters,
                        ),
                        isScrollControlled: true,
                      );
                    },
                    child: CircleAvatar(
                      radius: 20.w,
                      backgroundColor: AppColors.kPrimary.withOpacity(0.15),
                      child: const Icon(
                        Icons.filter_list,
                        color: AppColors.kPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Obx(() {
                if (retailerController.isListLoading.value &&
                    retailerController.pagingController.itemList == null) {
                  return const Center(child: CircularProgressIndicator());
                } else if (retailerController.isListError.value) {
                  return const Error404Screen();
                }

                return Column(
                  children: [
                    RetailerListView(
                      pagingController: retailerController.pagingController,
                    ),
                    SizedBox(height: 20.h),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
