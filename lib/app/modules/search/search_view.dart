import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../home/components/search_field.dart';
import '../home/controller/search_page_controller.dart';
import '../widgets/widgets.dart';
import 'components/custom_chips.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    final SearchPageController searchPageController =
        Get.put(SearchPageController());

    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

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
          'Search',
          style: AppTypography.kBold14.copyWith(
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

        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: AppSpacing.twentyVertical),
              // Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 20.w),
              //   child: SearchField(
              //     controller: textController,
              //     onChanged: (query) {
              //       searchPageController.updateSearchQuery(query);
              //     },
              //     isEnabled: true,
              //   ),
              // ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Row(
                  children: [
                    Expanded(
                      child: SearchField(
                        controller: searchPageController.textController,
                        onChanged: (query) {
                          searchPageController.updateSearchQuery(query);
                        },
                        hintText: 'Speak or type...',
                        isEnabled: !searchPageController.isListening.value,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        searchPageController.isListening.value
                            ? Icons.mic_off
                            : Icons.mic,
                        size: 30,
                      ),
                      onPressed: () {
                        if (searchPageController.isListening.value) {
                          searchPageController.stopListening();
                        } else {
                          searchPageController.startListening();
                        }
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: AppSpacing.twentyVertical),
              if (searchPageController.errorMessage.value.isNotEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.h),
                    child: Text(searchPageController.errorMessage.value),
                  ),
                )
              else
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Display two items per row
                      mainAxisSpacing: 15.h,
                      crossAxisSpacing: 15.w,
                      childAspectRatio: 2.0,
                    ),
                    itemBuilder: (context, index) {
                      final menuItem =
                          searchPageController.filteredItems[index];
                      return Obx(() {
                        return CustomChips(
                          isSelected:
                              searchPageController.selectedIndex.value == index,
                          menuItem: menuItem,
                          index: index,
                          onTap: () {
                            searchPageController.selectItem(index);
                            menuItem.onTap();
                          },
                        );
                      });
                    },
                    itemCount: searchPageController.filteredItems.length,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
