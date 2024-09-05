import 'package:field_asistence/app/modules/home/components/farmer_card.dart';
import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../data/constrants/constants.dart';
import '../../farmer/controller/farmer_controller.dart';
import '../../farmer/farmer_managment_page.dart';
import '../../widgets/widgets.dart';

class FarmerList extends StatefulWidget {
  const FarmerList({super.key});

  @override
  State<FarmerList> createState() => _FarmerListState();
}

class _FarmerListState extends State<FarmerList> {
  final FarmerController _farmerController = Get.put(FarmerController());
  @override
  void initState() {
    _farmerController.fetchRecentFarmers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('New Farmers', style: AppTypography.kBold14),
            const Spacer(),
            CustomTextButton(
              onPressed: () {
                Get.to<void>(
                  () => const FarmerManagementPage(),
                  transition: Transition.rightToLeftWithFade,
                )!
                    .then((value) {
                  _farmerController.fetchRecentFarmers();
                });
              },
              text: 'See All',
            ),
          ],
        ),
        Obx(() {
          if (_farmerController.isLoadingrecent.value) {
            return buildShimmer();
          } else if (_farmerController.isErrorrecent.value) {
            return PrimaryContainer(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Error loading farmers'),
                  CustomTextButton(
                    onPressed: () {
                      _farmerController.fetchRecentFarmers();
                    },
                    text: 'Retry',
                  ),
                ],
              ),
            );
          } else if (_farmerController.recentFarmers.isEmpty) {
            return const Center(child: Text('No recent farmers found'));
          } else {
            return SizedBox(
              height: 260.h,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                itemBuilder: (context, index) {
                  return FarmerCard(
                    farmer: _farmerController.recentFarmers[index],
                  );
                },
                separatorBuilder: (context, index) => SizedBox(width: 20.w),
                itemCount: _farmerController.recentFarmers.length,
              ),
            );
          }
        }),
      ],
    );
  }

  Widget buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        height: 260.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (_, __) => Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.r),
                color: Colors.white,
              ),
              width: 264.w,
              height: 260.h,
            ),
          ),
          itemCount: 5,
        ),
      ),
    );
  }
}
