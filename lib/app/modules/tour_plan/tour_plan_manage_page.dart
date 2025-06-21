import 'package:field_asistence/app/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../home/components/search_field.dart';
import '../widgets/buttons/custom_button.dart';
import '../widgets/texts/custom_header_text.dart';
import 'components/filter_list_view.dart';
import 'components/tour_list_view.dart';
import 'controller/tour_plan_lsit_controller.dart';
import 'tour_plan_create_page.dart';

class TourPlanManagementPage extends StatefulWidget {
  const TourPlanManagementPage({super.key});

  @override
  State<TourPlanManagementPage> createState() => _TourPlanManagementPageState();
}

class _TourPlanManagementPageState extends State<TourPlanManagementPage> {
  final TourPlanController controller = Get.put(TourPlanController());

  @override
  void initState() {
    super.initState();
    controller.fetchTourPlans(refresh: true);
  }

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
          'Tour Plan Management',
          style: AppTypography.kBold14.copyWith(
            color: AppColors.kDarkContiner,
          ),
        ),
        centerTitle: false,
        action: [
          CustomButton(
            icon: Icons.add,
            text: 'Add Tour',
            isBorder: true,
            onTap: () async {
              await Get.to(
                () => const TourPlanCreatePage(),
              );
              controller.fetchTourPlans(refresh: true);
            },
          ),
          SizedBox(
            width: 10,
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          controller.fetchTourPlans(refresh: true);
        },
        child: ListView(
          controller: controller.scrollController,
          padding: EdgeInsets.symmetric(horizontal: 20.0.w),
          children: [
            Column(
              children: [
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: SearchField(
                        controller: controller.textEditingController,
                        onChanged: (query) {
                          controller.setSearchQuery(query);
                        },
                        isEnabled: true,
                        hintText: 'Search Tour',
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
                CustomHeaderText(text: 'Tour List', fontSize: 16.sp),
                const SizedBox(height: 10),
                TourPlanListView(),
                SizedBox(height: 20.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
