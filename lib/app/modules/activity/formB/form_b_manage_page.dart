import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../home/components/search_field.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../../widgets/widgets.dart';
import '../controller/form_b_controller.dart';
import 'form_b_create_form_page.dart';
import 'form_b_list_view.dart';

class FormBManagementPage extends StatefulWidget {
  const FormBManagementPage({super.key});

  @override
  State<FormBManagementPage> createState() => _FormBManagementPageState();
}

class _FormBManagementPageState extends State<FormBManagementPage> {
  final FormBController formBController = Get.put(FormBController());

  final TextEditingController textController = TextEditingController();

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    super.initState();
    formBController.fetchFormBData(1);
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
          'Jeep Campaign',
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
            text: 'Add Campaign',
            isBorder: true,
            onTap: () {
              Get.to(() => const CreateFormBpage(),
                  transition: Transition.rightToLeftWithFade);
            },
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          formBController.refreshItems();
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    SearchField(
                      controller: textController,
                      onChanged: (query) {
                        formBController.setSearchQuery(query);
                      },
                      isEnabled: true,
                      hintText: 'Search Campaign',
                    ),
                    const SizedBox(height: 10),
                    CustomHeaderText(text: 'Campaign List', fontSize: 16.sp),
                    const SizedBox(height: 10),
                    Obx(() {
                      if (formBController.isListLoading.value) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (formBController.isListError.value) {
                        return Center(
                            child:
                                Text(formBController.listErrorMessage.value));
                      }
                      return Column(
                        children: [
                          FormBListView(
                              pagingController:
                                  formBController.pagingController),
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
