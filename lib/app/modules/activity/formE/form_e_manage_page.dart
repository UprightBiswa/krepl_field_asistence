import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../home/components/search_field.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../../widgets/widgets.dart';
import '../controller/form_e_controller.dart';
import 'filter_list_view.dart';
import 'form_e_create_from_page.dart';
import 'form_e_list_view.dart';

class FormEManagementPage extends StatefulWidget {
  const FormEManagementPage({super.key});

  @override
  State<FormEManagementPage> createState() => _FormEManagementPageState();
}

class _FormEManagementPageState extends State<FormEManagementPage> {
  final FormEController formEController = Get.put(FormEController());
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
          'POP Management',
          style: AppTypography.kBold14.copyWith(
            color: AppColors.kDarkContiner,
          ),
        ),
        centerTitle: false,
        action: [
          CustomButton(
            icon: Icons.add,
            text: 'Add POP',
            isBorder: true,
            onTap: () {
              Get.to(
                () {
                  return const CreateFormEpage();
                },
              )!
                  .then((value) => formEController.fetchFormEData(1));
            },
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          formEController.refreshItems();
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
                              formEController.setSearchQuery(query);
                            },
                            isEnabled: true,
                            hintText: 'Search POP',
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              EFilterBottomSheet(),
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
                    CustomHeaderText(
                        text: 'POP Material List', fontSize: 16.sp),
                    const SizedBox(height: 10),
                    Obx(() {
                      if (formEController.isListLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (formEController.isListError.value) {
                        return Center(
                            child:
                                Text(formEController.listErrorMessage.value));
                      }
                      return Column(
                        children: [
                          FormEListView(
                            pagingController: formEController.pagingController,
                          ),
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
