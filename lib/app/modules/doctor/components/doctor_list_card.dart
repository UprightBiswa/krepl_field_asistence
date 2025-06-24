import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/constrants/constants.dart';
import '../../home/components/action_menue.dart';
import '../../widgets/buttons/buttons.dart';
import '../../widgets/components/info_row_widget.dart';
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
        onTap: () async {
          await Get.to<dynamic>(DoctorDetailView(
            doctor: doctor,
          ));
          doctorController.refreshItems();
        },
        child: PrimaryContainer(
          padding: EdgeInsets.all(10.h),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundColor: AppColors.kPrimary.withValues(alpha: .15),
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
                      ],
                    ),
                  ),
                  // Action menu icon
                  ActionMenuIcon(
                    onEdit: () async {
                      await Get.to<dynamic>(
                        EditDoctorForm(
                          doctor: doctor,
                        ),
                      );
                      Get.back();
                      doctorController.refreshItems();
                    },
                  ),
                ],
              ),
              Divider(
                color: AppColors.kPrimary.withValues(alpha: .15),
              ),
              InfoRow(
                label: "Mobile No",
                value: doctor.mobileNumber,
              ),
              InfoRow(
                label: "Created Date",
                value: formatDate(doctor.createdAt.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String formatDate(String dateStr) {
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd-MMM-yyyy').format(date);
    } catch (e) {
      return '';
    }
  }
}
