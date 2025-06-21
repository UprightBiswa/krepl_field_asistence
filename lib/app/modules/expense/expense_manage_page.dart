import 'package:field_asistence/app/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../home/components/search_field.dart';
import '../widgets/buttons/custom_button.dart';
import '../widgets/texts/custom_header_text.dart';
import 'components/expense_list_view.dart';
import 'components/filter_expense_list_view.dart';
import 'controller/expense_lsit_controller.dart';
import 'fa_expense_create_page.dart';

class ExpenseManagementPage extends StatefulWidget {
  const ExpenseManagementPage({super.key});

  @override
  State<ExpenseManagementPage> createState() => _FormBManagementPageState();
}

class _FormBManagementPageState extends State<ExpenseManagementPage> {
  final ExpenseController controller = Get.put(ExpenseController());

 
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppBar(
        spaceBar: true,
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor:AppColors.kPrimary.withValues(alpha: .15),
        title: Text(
          'Expense Management',
          style: AppTypography.kBold14.copyWith(
            color:  AppColors.kDarkContiner,
          ),
        ),
        centerTitle: false,
        action: [
          CustomButton(
            icon: Icons.add,
            text: 'Add Expense',
            isBorder: true,
            onTap: () {
              Get.to(
                () => const ExpenseCreatePage(),
              )!
                  .then((value) => controller.refreshItems());
            },
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.refreshItems();
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: SearchField(
                            controller: controller.textController,
                            onChanged: (query) {
                              controller.setSearchQuery(query);
                            },
                            isEnabled: true,
                            hintText: 'Search Expense',
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              DateFilterBottomSheet(),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
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
                    const SizedBox(height: 10),
                    CustomHeaderText(text: 'Expense List', fontSize: 16.sp),
                    const SizedBox(height: 10),
                    Obx(() {
                      if (controller.isListLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (controller.isListError.value) {
                        return Center(
                            child: Text(controller.listErrorMessage.value));
                      }
                      return Column(
                        children: [
                          ExpenseListView(
                              pagingController: controller.pagingController),
                          SizedBox(height: 20.h),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
