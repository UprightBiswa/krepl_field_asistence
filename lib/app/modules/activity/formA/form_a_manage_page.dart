import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../home/components/search_field.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/widgets.dart';
import '../components/form_a_list_view.dart';
import '../controller/form_a_controller.dart';
import 'form_a_create_from_page.dart';

class FormAManagementPage extends StatelessWidget {
  final FormAController formAController = Get.put(FormAController());
  final TextEditingController textController = TextEditingController();

  FormAManagementPage({super.key});

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

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
          'Activity Management',
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
            text: 'Add Activity',
            isBorder: true,
            onTap: () {
              Get.to(() => const CreateFormApage(),
                  transition: Transition.rightToLeftWithFade);
            },
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: Obx(() {
        if (formAController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: SearchField(
                        controller: textController,
                        onChanged: (query) {
                          formAController.filterFormAList(query);
                        },
                        isEnabled: true,
                        hintText: 'Search FormA',
                      ),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () {
                        // Logic for filter action
                      },
                      child: CircleAvatar(
                        radius: 20.w,
                        backgroundColor: Colors.blue.withOpacity(0.15),
                        child: const Icon(
                          Icons.filter_list,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text('Form A List',
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        // Logic to see all forms
                      },
                      child: const Text('See All',
                          style: TextStyle(color: Colors.grey)),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                FormAListView(formAList: formAController.filteredFormAList),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      }),
    );
  }
}
