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
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1.2,
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
                    const Spacer(),
                    Text(
                      menuItem.title,
                      style: AppTypography.kLight12,
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
          menuGroup: reportMenuGroup,
        ),
        const SizedBox(height: 20),
        ReportViewgroup(
          menuGroup: activityFormGroup,
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
    return PrimaryContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            menuGroup.heading.title,
            style: AppTypography.kBold16,
          ),
          SizedBox(height: AppSpacing.twentyVertical),
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
                    isSelected: true,
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
    );
  }
}
