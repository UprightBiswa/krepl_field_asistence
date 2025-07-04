import 'package:field_asistence/app/modules/home/components/social_share_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../profile/components/profile_image_card.dart';
import '../../widgets/custom_painter/dotted_divider.dart';
import '../../widgets/widgets.dart';

class OnlinePeople {
  String image;
  String name;

  OnlinePeople({required this.image, required this.name});
}

List<OnlinePeople> onlinePeople = [
  OnlinePeople(
    image: AppAssets.kFarmer,
    name: 'Alex',
  ),
  OnlinePeople(
    image: AppAssets.kFarmer,
    name: 'Qin',
  ),
  OnlinePeople(
    image: AppAssets.kFarmer,
    name: 'Harinder',
  ),
  OnlinePeople(
    image: AppAssets.kFarmer,
    name: 'Lilah',
  ),
  OnlinePeople(
    image: AppAssets.kFarmer,
    name: 'Martin',
  ),
];

class ReferFriendSheet extends StatelessWidget {
  const ReferFriendSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.all(AppSpacing.twentyVertical),
          child: CustomIconButton(
            icon: AppAssets.kArrowBack,
            onTap: () {
              Get.back<void>();
            },
            color: AppColors.kWhite.withValues(alpha: 0.15),
            iconColor: AppColors.kWhite,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30.r),
            ),
            color: AppColors.kWhite,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100.h),
              Center(
                  child: Text('Refer a friend', style: AppTypography.kBold24)),
              SizedBox(height: 8.h),
              Center(
                child: Text(
                  'Earn \$5 for every friend who joins\nLearn Eden through your code.',
                  style: AppTypography.kLight16,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 40.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: AppColors.kPrimary.withValues(alpha: 0.15),
                ),
                child: Column(
                  children: [
                    SizedBox(height: AppSpacing.twentyVertical),
                    Text('EMEL2020', style: AppTypography.kBold24),
                    SizedBox(height: 10.h),
                    const DottedDivider(),
                    CustomTextButton(
                      onPressed: () {},
                      text: 'Copy referral code',
                      fontSize: 14.sp,
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.thirtyVertical),
              Text('Invite a Friend', style: AppTypography.kBold14),
              SizedBox(height: AppSpacing.twentyVertical),
              SizedBox(
                height: 50.h,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return Container(
                        height: 50.h,
                        width: 50.w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: AppColors.kPrimary.withValues(alpha: 0.15),
                        ),
                        child: const Icon(Icons.add, color: AppColors.kPrimary),
                      );
                    } else if (index <= onlinePeople.length) {
                      final data = onlinePeople[index - 1];
                      return ProfileImageCard(
                        image: data.image,
                        size: 50.h,
                      );
                    }
                    return const SizedBox();
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(width: 8.w);
                  },
                  itemCount: onlinePeople.length + 1,
                ),
              ),
              SizedBox(height: AppSpacing.thirtyVertical),
              Text('Share your Friend', style: AppTypography.kBold14),
              SizedBox(height: AppSpacing.twentyVertical),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SocialShareCard(
                    onTap: () {},
                    icon: AppAssets.kFaceBook,
                  ),
                  SocialShareCard(
                    onTap: () {},
                    icon: AppAssets.kGoogle,
                  ),
                  SocialShareCard(
                    onTap: () {},
                    icon: AppAssets.kComment,
                  ),
                  SocialShareCard(
                    onTap: () {},
                    icon: AppAssets.kMail,
                  ),
                  SocialShareCard(
                    onTap: () {},
                    icon: AppAssets.kMoreVert,
                  ),
                ],
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ],
    );
  }
}
