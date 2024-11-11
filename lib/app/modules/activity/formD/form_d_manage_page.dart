import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../home/components/search_field.dart';
import '../../widgets/buttons/custom_button.dart';
import '../../widgets/widgets.dart';
import '../controller/form_d_controller.dart';
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

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  void initState() {
    super.initState();
    formDController.fetchFormDData(1);
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
          'Demo Management',
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
            text: 'Add Demo',
            isBorder: true,
            onTap: () {
              Get.to(() => const CreateFormDpage(),
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
          formDController.refreshItems();
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: SearchField(
                controller: textController,
                onChanged: (query) {
                  formDController.setSearchQuery(query);
                },
                isEnabled: true,
                hintText: 'Search',
              ),
            ),
            Obx(() {
              if (formDController.isListLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (formDController.isListError.value) {
                return Center(
                    child: Text(formDController.listErrorMessage.value));
              }
              return Expanded(
                child: FormDListView(
                    pagingController: formDController.pagingController),
              );
            }),
          ],
        ),
      ),
    );
  }
}
