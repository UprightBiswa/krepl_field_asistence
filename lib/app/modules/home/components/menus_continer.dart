import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:field_asistence/app/data/constrants/constants.dart';
import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/menu_group.dart';
import 'custom_menu_card.dart';

class ShortcutMenus extends StatelessWidget {
  const ShortcutMenus({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          shortcutMenuGroup.heading.title,
          style: AppTypography.kBold16,
        ),
        SizedBox(height: 10.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: shortcutMenuItems.length,
          itemBuilder: (context, index) {
            final menuItem = shortcutMenuItems[index];
            return GestureDetector(
              onTap: () => menuItem.onTap(),
              child: PrimaryContainer(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            colorGenerator.generateColor(),
                            colorGenerator.generateColor(),
                          ],
                        ),
                        boxShadow: [AppColors.defaultShadow],
                      ),
                      child: Icon(
                        menuItem.icon,
                        size: 20,
                        color: AppColors.kWhite,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      menuItem.title,
                      style: AppTypography.kLight10,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ReportView extends StatelessWidget {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ReportViewgroup(
          menuGroup: activityFormGroup,
        ),
        const SizedBox(height: 20),
        ReportViewgroup(
          menuGroup: reportMenuGroup,
        ),
      ],
    );
  }
}

class ReportViewgroup extends StatelessWidget {
  final MenuGroup menuGroup;
  const ReportViewgroup({super.key, required this.menuGroup});
  @override
  Widget build(BuildContext context) {
    final isSelectedvalue = isSelected();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          menuGroup.heading.title,
          style: AppTypography.kBold16,
        ),
        SizedBox(height: 10.h),
        PrimaryContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                itemCount: menuGroup.menuItems.length,
                itemBuilder: (context, index) {
                  final menuItem = menuGroup.menuItems[index];

                  return GestureDetector(
                    onTap: () => menuItem.onTap(),
                    child: FadeIn(
                      delay: const Duration(milliseconds: 200) * index,
                      child: CustomMenuCard(
                        isSelected: isSelectedvalue,
                        onTap: () => menuItem.onTap(),
                        icon: menuItem.icon,
                        title: menuItem.title,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  bool isSelected() {
    final Random random = Random();
    return random.nextBool();
  }
}
