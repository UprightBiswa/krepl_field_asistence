import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../farmer/components/filter_bottom_sheet.dart';
import '../home/components/search_field.dart';
import '../widgets/appbars/appbars.dart';
import '../widgets/buttons/custom_button.dart';
import '../widgets/no_result/error_page.dart';
import '../widgets/no_result/no_result.dart';
import 'components/doctor_list_view.dart';
import 'controller/doctor_controller.dart';
import 'doctor_form.dart';

class DoctorManagementPage extends StatefulWidget {
  const DoctorManagementPage({super.key});

  @override
  State<DoctorManagementPage> createState() => _DoctorManagementPageState();
}

class _DoctorManagementPageState extends State<DoctorManagementPage> {
  final TextEditingController textController = TextEditingController();

  final DoctorController doctorController = Get.put(DoctorController());

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  void initState() {
    super.initState();
    doctorController.fetchDoctors(1, doctorController.pagingController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppBar(
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: isDarkMode(context)
            ? Colors.black
            : AppColors.kPrimary.withOpacity(0.15),
        title: Text(
          'Doctor Management',
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
            text: 'Add Doctor',
            isBorder: true,
            onTap: () {
              Get.to(() => const DoctorForm(),
                      transition: Transition.rightToLeftWithFade)!
                  .then((value) {
                doctorController.refreshItems();
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
          doctorController.refreshItems();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: SearchField(
                      controller: textController,
                      onChanged: (query) {
                        doctorController.setSearchQuery(query);
                      },
                      isEnabled: true,
                      hintText: 'Search Doctors',
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(
                    onTap: () {
                      Get.bottomSheet(
                        FilterBottomSheet(
                          controller: doctorController.filterController!,
                          onApply: doctorController.refreshItems,
                          onClear: doctorController.clearFilters,
                        ),
                        isScrollControlled: true,
                      );
                    },
                    child: CircleAvatar(
                      radius: 20.w,
                      backgroundColor: AppColors.kPrimary.withOpacity(0.15),
                      child: const Icon(
                        Icons.filter_list,
                        color: AppColors.kPrimary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Obx(() {
                if (doctorController.isListLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (doctorController.pagingController.itemList == null ||
                    doctorController.pagingController.itemList!.isEmpty) {
                  return const NoResultsScreen();
                } else if (doctorController.isListError.value) {
                  return const Error404Screen();
                }
                return Column(
                  children: [
                    DoctorListView(
                      pagingController: doctorController.pagingController,
                    ),
                    SizedBox(height: 20.h),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
