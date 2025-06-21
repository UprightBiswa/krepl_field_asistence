import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../home/components/search_field.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../../widgets/widgets.dart';
import '../controller/form_d_controller.dart';
import 'filter_list_view.dart';
import 'form_d_create_from_page.dart';
import 'form_d_list_view.dart';

class FormDManagementPage extends StatefulWidget {
  const FormDManagementPage({super.key});

  @override
  State<FormDManagementPage> createState() => _FormDManagementPageState();
}

class _FormDManagementPageState extends State<FormDManagementPage> {
  final FormDController formDController = Get.put(FormDController());

  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppBar(
        spaceBar: true,
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: AppColors.kPrimary.withValues(alpha: 0.15),
        title: Text(
          'Demo Management',
          style: AppTypography.kBold14.copyWith(
            color: AppColors.kDarkContiner,
          ),
        ),
        centerTitle: false,
        action: [
          CustomButton(
            icon: Icons.add,
            text: 'Add Demo',
            isBorder: true,
            onTap: () {
              Get.to(
                () => const CreateFormDpage(),
              )!
                  .then(
                (value) => formDController.refreshItems(),
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
          formDController.refreshItems();
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
                              formDController.setSearchQuery(query);
                            },
                            isEnabled: true,
                            hintText: 'Search',
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              DFilterBottomSheet(),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                            );
                          },
                          child: CircleAvatar(
                            radius: 20.w,
                            backgroundColor:
                                AppColors.kPrimary.withValues(alpha: 0.15),
                            child: const Icon(
                              Icons.filter_list,
                              color: AppColors.kPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    CustomHeaderText(text: 'Demo List', fontSize: 16.sp),
                    const SizedBox(height: 10),
                    Obx(() {
                      if (formDController.isListLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (formDController.isListError.value) {
                        return Center(
                            child:
                                Text(formDController.listErrorMessage.value));
                      }
                      return Column(
                        children: [
                          FormDListView(
                              pagingController:
                                  formDController.pagingController),
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
