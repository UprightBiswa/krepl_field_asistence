import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../home/components/search_field.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../../widgets/widgets.dart';
import '../controller/form_c_controller.dart';
import 'filter_list_view.dart';
import 'form_c_create_from_page.dart';
import 'form_c_list_view.dart';

class FormCManagementPage extends StatefulWidget {
  const FormCManagementPage({super.key});

  @override
  State<FormCManagementPage> createState() => _FormCManagementPageState();
}

class _FormCManagementPageState extends State<FormCManagementPage> {
  final FormCController formCController = Get.put(FormCController());

  final TextEditingController textController = TextEditingController();

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  void initState() {
    super.initState();
    formCController.fetchFormCData(1);
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
          'Dealer Stock',
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
            text: 'Add Stock',
            isBorder: true,
            onTap: () {
              Get.to(() => const CreateFormCpage(),
                      transition: Transition.rightToLeftWithFade)!
                  .then((value) {
                formCController.refreshItems();
              });
            },
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          formCController.refreshItems();
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
                              formCController.setSearchQuery(query);
                            },
                            isEnabled: true,
                            hintText: 'Search Stock',
                          ),
                        ),
                        SizedBox(width: 10.w),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(
                              CFilterBottomSheet(),
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
                    CustomHeaderText(text: 'Stock List', fontSize: 16.sp),
                    const SizedBox(height: 10),
                    Obx(() {
                      if (formCController.isListLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (formCController.isListError.value) {
                        return Center(
                            child:
                                Text(formCController.listErrorMessage.value));
                      }
                      return Column(
                        children: [
                          FormCListView(
                              pagingController:
                                  formCController.pagingController),
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
