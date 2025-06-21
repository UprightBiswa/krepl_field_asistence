import 'package:field_asistence/app/modules/widgets/buttons/buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../model/login/user_details_reponse.dart';
import '../../widgets/loading/shimmer_activity_card.dart';
import '../../widgets/no_result/error_activity_data.dart';
import '../controllers/activity_controller.dart';
import '../model/data_model.dart';

import 'activity_card.dart';

class YTDTabBarData extends StatefulWidget {
  final UserDetails userDetails;

  const YTDTabBarData({
    super.key,
    required this.userDetails,
  });

  @override
  State<YTDTabBarData> createState() => _YTDTabBarDataState();
}

class _YTDTabBarDataState extends State<YTDTabBarData> {
  final ActivityController controller = Get.put(ActivityController());

  // Variable to keep track of whether to show all items or just a few
  bool showAllItems = false;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingYtd.value) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 10, // Number of shimmer placeholders
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10.dg,
            crossAxisSpacing: 10.dg,
          ),
          itemBuilder: (context, index) => const ShimmerActivityCard(),
        );
      } else if (controller.ytdData.isEmpty) {
        return ActivityErrorView(
          onTap: () {
            controller.fetchYtdData();
          },
        );
      } else {
        int itemCount = showAllItems
            ? controller.ytdData.length
            : (controller.ytdData.length > 4 ? 4 : controller.ytdData.length);
        return Column(
          children: [
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: itemCount,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10.dg,
                crossAxisSpacing: 10.dg,
              ),
              itemBuilder: (context, index) {
                ActivityData activity = controller.ytdData[index];
                return ActivityCard(activity: activity, index: index);
              },
            ),
            SizedBox(height: 10.h),
            PrimaryButton(
              onTap: () {
                setState(
                  () {
                    showAllItems = !showAllItems;
                  },
                );
              },
              text: showAllItems ? 'See Less' : 'See All',
            ),
          ],
        );
      }
    });
  }
}
