import 'package:field_asistence/app/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../home/components/search_field.dart';
import '../widgets/buttons/custom_button.dart';
import '../widgets/texts/custom_header_text.dart';
import 'components/expense_list_view.dart';
import 'controller/expense_lsit_controller.dart';
import 'fa_expense_create_page.dart';

class ExpenseManagementPage extends StatefulWidget {
  const ExpenseManagementPage({super.key});

  @override
  State<ExpenseManagementPage> createState() => _FormBManagementPageState();
}

class _FormBManagementPageState extends State<ExpenseManagementPage> {
  final ExpenseController controller = Get.put(ExpenseController());
  final TextEditingController textController = TextEditingController();

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    super.initState();
    controller.fetchExpenses(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppBar(
        spaceBar: true,
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: isDarkMode(context)
            ? Colors.black
            : AppColors.kPrimary.withOpacity(0.15),
        title: Text(
          'Expense Management',
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
            text: 'Add Expense',
            isBorder: true,
            onTap: () {
              Get.to(() => const ExpenseCreatePage(),
                  transition: Transition.rightToLeftWithFade);
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
                    SearchField(
                      controller: textController,
                      onChanged: (query) {
                        controller.setSearchQuery(query);
                      },
                      isEnabled: true,
                      hintText: 'Search Expense',
                    ),
                    const SizedBox(height: 10),
                    CustomHeaderText(text: 'Ex List', fontSize: 16.sp),
                    const SizedBox(height: 10),
                     Obx(() {
                      if (controller.isListLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (controller.isListError.value) {
                        return Center(
                            child:
                                Text(controller.listErrorMessage.value));
                      }
                      return Column(
                        children: [
                          ExpenseListView(
                              pagingController:
                                  controller.pagingController),
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
