import 'package:field_asistence/app/modules/farmer/farmer_form.dart';
import 'package:field_asistence/app/modules/widgets/no_result/error_page.dart';
import 'package:field_asistence/app/modules/widgets/texts/custom_header_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../home/components/search_field.dart';
import '../widgets/appbars/appbars.dart';
import '../widgets/buttons/custom_button.dart';
import 'components/farmer_list_view.dart';
import 'components/filter_bottom_sheet.dart';
import 'controller/farmer_list_view_controller.dart';

class FarmerManagementPage extends StatefulWidget {
  const FarmerManagementPage({super.key});

  @override
  State<FarmerManagementPage> createState() => _FarmerManagementPageState();
}

class _FarmerManagementPageState extends State<FarmerManagementPage> {
  final TextEditingController textController = TextEditingController();

  final FarmerListController farmerController = Get.put(FarmerListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppBar(
        spaceBar: true,
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: AppColors.kPrimary.withValues(alpha: .15),
        title: Text(
          'Farmer Management',
          style: AppTypography.kBold14.copyWith(
            color: AppColors.kDarkContiner,
          ),
        ),
        centerTitle: false,
        action: [
          CustomButton(
            icon: Icons.add,
            text: 'Add Farmer',
            isBorder: true,
            onTap: () {
              Get.to(
                () => const FarmerForm(),
              )!
                  .then((value) {
                farmerController.refreshItems();
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
          farmerController.refreshItems();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: SearchField(
                      controller: textController,
                      onChanged: (query) {
                        farmerController.setSearchQuery(query);
                      },
                      isEnabled: true,
                      hintText: 'Search farmers',
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        FilterBottomSheet(
                          controller: farmerController.filterController!,
                          onApply: farmerController.refreshItems,
                          onClear: farmerController.clearFilters,
                        ),
                        isScrollControlled: true,
                      );
                    },
                    child: CircleAvatar(
                      radius: 20.w,
                      backgroundColor:
                          AppColors.kPrimary.withValues(alpha: .15),
                      child: const Icon(
                        Icons.filter_list,
                        color: AppColors.kPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              CustomHeaderText(text: 'Farmers', fontSize: 16.sp),
              SizedBox(height: 20.h),
              Obx(() {
                if (farmerController.isListLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (farmerController.isListError.value &&
                    farmerController.listErrorMessage.value.isNotEmpty) {
                  return const Error404Screen();
                }
                return Column(
                  children: [
                    FarmerListView(
                      pagingController: farmerController.pagingController,
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
