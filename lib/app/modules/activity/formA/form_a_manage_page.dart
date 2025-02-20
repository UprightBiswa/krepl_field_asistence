import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../home/components/search_field.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../../widgets/widgets.dart';
import 'filter_list_view.dart';
import 'form_a_list_view.dart';
import '../controller/form_a_controller.dart';
import 'form_a_create_from_page.dart';

class FormAManagementPage extends StatefulWidget {
  const FormAManagementPage({super.key});

  @override
  State<FormAManagementPage> createState() => _FormAManagementPageState();
}

class _FormAManagementPageState extends State<FormAManagementPage> {
  final FormAController formAController = Get.put(FormAController());

  final TextEditingController textController = TextEditingController();

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    super.initState();
    formAController.fetchFormAData(1);
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
          'Activity Management',
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
            text: 'Add Activity',
            isBorder: true,
            onTap: () {
              Get.to(() => const CreateFormApage(),
                      transition: Transition.rightToLeftWithFade)!
                  .then(
                (value) => formAController.refreshItems(),
              );
            },
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          formAController.refreshItems();
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Expanded(
                          child: SearchField(
                            controller: textController,
                            onChanged: (query) {
                              formAController.setSearchQuery(query);
                            },
                            isEnabled: true,
                            hintText: 'Search Activity',
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              AFilterBottomSheet(),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                            );
                          },
                          child: CircleAvatar(
                            radius: 20.w,
                            backgroundColor:
                                AppColors.kPrimary.withOpacity(0.15),
                            child: const Icon(
                              Icons.filter_list,
                              color: AppColors.kPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomHeaderText(text: 'Activity List', fontSize: 16.sp),
                    const SizedBox(height: 10),
                    Obx(() {
                      if (formAController.isListLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (formAController.isListError.value) {
                        return Center(
                            child:
                                Text(formAController.listErrorMessage.value));
                      }
                      return Column(
                        children: [
                          FormAListView(
                              pagingController:
                                  formAController.pagingController),
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
