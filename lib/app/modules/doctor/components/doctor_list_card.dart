import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../home/components/action_menue.dart';
import '../../widgets/buttons/buttons.dart';
import '../../widgets/containers/primary_container.dart';
import '../doctor_details_view.dart';
import '../doctor_edit_page.dart';
import '../model/doctor_list.dart';
import '../controller/doctor_controller.dart';

class DoctorListCard extends StatelessWidget {
  final Doctor doctor;
  final int index;

  const DoctorListCard({required this.doctor, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    final DoctorController doctorController = Get.put(DoctorController());
    return FadeIn(
      delay: const Duration(milliseconds: 500) * index,
      child: AnimatedButton(
        onTap: () {
          Get.to<dynamic>(
            DoctorDetailView(
              doctor: doctor,
            ),
            transition: Transition.rightToLeftWithFade,
          )!
              .then((value) {
            doctorController.fetchDoctors(1, doctorController.pagingController);
          });
        },
        child: PrimaryContainer(
          padding: EdgeInsets.all(10.h),
          // width: 264.w,
          // height: 150.h,
          child: Row(
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: AppColors.kPrimary.withOpacity(0.15),
                child: Text(
                  doctor.name.substring(0, 2).toUpperCase(),
                  style: AppTypography.kBold14.copyWith(
                    color: AppColors.kPrimary,
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              // doctor details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: AppTypography.kBold20.copyWith(),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      doctor.fatherName,
                      style: AppTypography.kBold14.copyWith(
                        color: AppColors.kPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'No: ${doctor.mobileNumber}',
                      style: AppTypography.kLight16.copyWith(
                        color: AppColors.kNeutral04.withOpacity(0.75),
                      ),
                    ),
                  ],
                ),
              ),
              // Action menu icon
              ActionMenuIcon(
                onEdit: () {
                  Get.to<dynamic>(
                    EditDoctorForm(
                      doctor: doctor,
                    ),
                    transition: Transition.rightToLeftWithFade,
                  )!
                      .then((value) {
                    Get.back();
                    doctorController.fetchDoctors(
                        1, doctorController.pagingController);
                  });
                },
                onDelete: () {
                  // Delete doctor logic
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
