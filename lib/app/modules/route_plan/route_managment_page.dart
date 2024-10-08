import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../home/components/search_field.dart';
import '../widgets/appbars/appbars.dart';
import '../widgets/buttons/buttons.dart';
import '../widgets/buttons/custom_button.dart';
import 'components/route_map_list_view.dart';
import 'controller/route_controller.dart';
import 'create_route_form_page.dart';

class RoutePlanManagementPage extends StatelessWidget {
  RoutePlanManagementPage({super.key});

  final TextEditingController textController = TextEditingController();
  final RouteController routeController = Get.put(RouteController());

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
          'RouteMap Management',
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
            text: 'Add Route',
            isBorder: true,
            onTap: () {
              Get.to(() => const RouteFormPage(),
                  transition: Transition.rightToLeftWithFade);
            },
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: Obx(() {
        if (routeController.isLoading.value) {
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
                          routeController.filterRouteMaps(query);
                        },
                        isEnabled: true,
                        hintText: 'Search RouteMap',
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
                    Text('Route Map', style: AppTypography.kBold16),
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
                RouteMapListView(
                  route: routeController.filteredRouteMaps,
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
