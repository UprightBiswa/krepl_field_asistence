import 'package:field_asistence/app/modules/home/components/farmer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../farmer/farmer_managment_page.dart';
import '../../farmer/model/farmer_list.dart';
import '../../widgets/widgets.dart';

class FarmerList extends StatelessWidget {
  const FarmerList({super.key});

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
                  () => FarmerManagementPage(),
                  transition: Transition.rightToLeftWithFade,
                );
              },
              text: 'See All',
            ),
          ],
        ),
        SizedBox(
          height: 260.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemBuilder: (context, index) {
              return FarmerCard(
                farmer: farmersList[index],
              );
            },
            separatorBuilder: (context, index) => SizedBox(width: 20.w),
            itemCount: 2,
          ),
        ),
      ],
    );
  }
}
