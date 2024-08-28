import 'package:field_asistence/app/modules/farmer/farmer_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../home/components/search_field.dart';
import '../widgets/appbars/appbars.dart';
import '../widgets/buttons/buttons.dart';
import '../widgets/buttons/custom_button.dart';
import 'components/farmer_list_view.dart';
import 'controller/farmer_controller.dart';

class FarmerManagementPage extends StatelessWidget {
  FarmerManagementPage({super.key});

  final TextEditingController textController = TextEditingController();
  final FarmerController farmerController = Get.put(FarmerController());

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

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
          'Farmer Management',
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
            text: 'Add Farmer',
            isBorder: true,
            onTap: () {
              Get.to(() => const FarmerForm(),
                  transition: Transition.rightToLeftWithFade);
            },
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: Obx(() {
        if (farmerController.isLoading.value) {
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
                          farmerController.filterFarmers(query);
                        },
                        isEnabled: true,
                        hintText: 'Search farmers',
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
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text('Farmers', style: AppTypography.kBold16),
                    const Spacer(),
                    CustomTextButton(
                      onPressed: () {
                        // Logic to see all farmers
                      },
                      text: 'See All',
                      color: AppColors.kDarkContiner.withOpacity(0.3),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                FarmerListView(
                  farmers: farmerController.filteredFarmers,
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
