import 'package:field_asistence/app/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../home/components/search_field.dart';
import '../widgets/buttons/custom_button.dart';
import '../widgets/texts/custom_header_text.dart';
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
  final TextEditingController textController = TextEditingController();

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    super.initState();
    controller.fetchTourPlans(1);
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
          'Tour Plan Management',
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
            text: 'Add Tour',
            isBorder: true,
            onTap: () {
              Get.to(() => const TourPlanCreatePage(),
                      transition: Transition.rightToLeftWithFade)!
                  .then((value) => {controller.fetchTourPlans(1)});
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
                      hintText: 'Search Tour',
                    ),
                    const SizedBox(height: 10),
                    CustomHeaderText(text: 'Tour Plan List', fontSize: 16.sp),
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
                          TourPlanListView(
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
