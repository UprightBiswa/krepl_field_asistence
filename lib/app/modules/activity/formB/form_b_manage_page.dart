import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../home/components/search_field.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/widgets.dart';
import '../components/form_a_list_view.dart';
import '../controller/form_b_controller.dart';
import 'form_b_create_form_page.dart';

class FormBManagementPage extends StatelessWidget {
  final FormBController formBController = Get.put(FormBController());
  final TextEditingController textController = TextEditingController();

  FormBManagementPage({super.key});

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
          'Jeep Campaign',
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
            text: 'Add Campaign',
            isBorder: true,
            onTap: () {
              Get.to(() => const CreateFormBpage(),
                  transition: Transition.rightToLeftWithFade);
            },
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: Obx(() {
        if (formBController.isLoading.value) {
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
                          formBController.filterFormAList(query);
                        },
                        isEnabled: true,
                        hintText: 'Search Campaign',
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
                    Text('Form B List',
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
                FormAListView(formAList: formBController.filteredFormAList),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      }),
    );
  }
}
