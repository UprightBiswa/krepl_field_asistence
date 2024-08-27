import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../home/components/search_field.dart';
import '../widgets/appbars/appbars.dart';
import '../widgets/buttons/custom_button.dart';
import 'components/doctor_list_view.dart';
import 'controller/doctor_controller.dart';
import 'doctor_form.dart';

class DoctorManagementPage extends StatelessWidget {
  DoctorManagementPage({super.key});

  final TextEditingController textController = TextEditingController();
  final DoctorController doctorController = Get.put(DoctorController());

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
          'Doctor Management',
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
            text: 'Add Doctor',
            isBorder: true,
            onTap: () {
              Get.to(() => const DoctorForm(),
                  transition: Transition.rightToLeftWithFade);
            },
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: Obx(() {
        if (doctorController.isLoading.value) {
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
                          doctorController.filterDoctors(query);
                        },
                        isEnabled: true,
                        hintText: 'Search Doctors',
                      ),
                    ),
                    SizedBox(width: 10.w),
                    GestureDetector(
                      onTap: () {
                        // Logic for filter action
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
                DoctorListView(
                  doctors: doctorController.filteredDoctors,
                ),
                SizedBox(height: AppSpacing.twentyVertical),
              ],
            ),
          ),
        );
      }),
    );
  }
}
