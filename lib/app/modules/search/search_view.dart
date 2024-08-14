import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../home/components/search_field.dart';
import '../home/controller/search_page_controller.dart';
import '../widgets/widgets.dart';
import 'components/custom_chips.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchPageController searchPageController =
        Get.put(SearchPageController());
    TextEditingController textController = TextEditingController();

    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: CustomBackAppBar(
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: isDarkMode(context)
            ? Colors.black
            : AppColors.kPrimary.withOpacity(0.15),
        title: Text(
          'Search',
          style: AppTypography.kBold20.copyWith(
            color: isDarkMode(context)
                ? AppColors.kWhite
                : AppColors.kDarkContiner,
          ),
        ),
      ),
      body: Obx(() {
        if (searchPageController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: 10.h),
                SearchField(
                  controller: textController,
                  onChanged: (query) {
                    searchPageController.updateSearchQuery(query);
                  },
                  isEnabled: true,
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Text('Menu Items', style: AppTypography.kBold16),
                    const Spacer(),
                    CustomTextButton(
                      onPressed: () {},
                      text: 'See All',
                      color: AppColors.kDarkContiner.withOpacity(0.3),
                    ),
                  ],
                ),
                SizedBox(height: AppSpacing.tenVertical),
                if (searchPageController.errorMessage.value.isNotEmpty)
                  Center(child: Text(searchPageController.errorMessage.value))
                else
                  Wrap(
                    spacing: 15.w,
                    runSpacing: 20.h,
                    alignment: WrapAlignment.spaceBetween,
                    children: List.generate(
                      searchPageController.filteredItems.length,
                      (index) {
                        final menuItem =
                            searchPageController.filteredItems[index];
                        return CustomChips(
                          isSelected: false, // Update selection logic as needed
                          menuItem: menuItem, // Pass MenuItem to CustomChips
                          index: index,
                          onTap: () {
                            menuItem.onTap();
                          },
                        );
                      },
                    ),
                  ),
                SizedBox(height: AppSpacing.tenVertical),
              ],
            ),
          ),
        );
      }),
    );
  }
}
