import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../data/helpers/data/image_doctor_url.dart';
import '../widgets/components/info_row_widget.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/dialog/confirmation.dart';
import '../widgets/dialog/error.dart';
import '../widgets/dialog/loading.dart';
import '../widgets/form_field/form_hader.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'controller/doctor_controller.dart';
import 'doctor_edit_page.dart';
import 'model/doctor_list.dart';

class DoctorDetailView extends StatefulWidget {
  final Doctor doctor;
  const DoctorDetailView({required this.doctor, super.key});

  @override
  State<DoctorDetailView> createState() => _DoctorDetailViewState();
}

class _DoctorDetailViewState extends State<DoctorDetailView> {
  final DoctorController _doctorController = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomBackAppBar(
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: AppColors.kPrimary.withValues(alpha: .15),
        title: Text(
          'doctor Details',
          style: AppTypography.kBold24.copyWith(color: AppColors.kWhite),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            FormImageHeader(
              tag: 'form',
              image: ImageDoctorUrl.doctorImage,
              header: widget.doctor.name,
              subtitle: widget.doctor.mobileNumber,
            ),
            Positioned(
              top: 228.h,
              left: 20.w,
              right: 20.w,
              bottom: 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Segment 1: doctor's Basic Details
                    PrimaryContainer(
                      child: Column(
                        children: [
                          CustomHeaderText(
                            text: widget.doctor.name,
                            fontSize: 20.sp,
                          ),
                          SizedBox(height: 16.h),
                          InfoRow(
                            label: "Father's Name",
                            value: widget.doctor.fatherName,
                          ),
                          InfoRow(
                            label: "Mobile Number",
                            value: widget.doctor.mobileNumber,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Segment 2: doctor's Address Details
                    PrimaryContainer(
                      child: Column(
                        children: [
                          CustomHeaderText(
                            text: 'Address Details',
                            fontSize: 18.sp,
                          ),
                          SizedBox(height: 16.h),
                          InfoRow(
                            label: "Village",
                            value: widget.doctor.villageName ?? '',
                          ),
                          InfoRow(
                            label: "Post Office",
                            value: widget.doctor.postOfficeName,
                          ),
                          InfoRow(
                            label: "Sub-District",
                            value: widget.doctor.subDistName,
                          ),
                          InfoRow(
                            label: "District",
                            value: widget.doctor.districtName,
                          ),
                          InfoRow(
                            label: "State",
                            value: widget.doctor.stateName,
                          ),
                          InfoRow(
                            label: "PIN",
                            value: widget.doctor.pinCode,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),

                    // Segment 3: Field Details
                    PrimaryContainer(
                      child: Column(
                        children: [
                          CustomHeaderText(
                            text: 'Field Details',
                            fontSize: 18.sp,
                          ),
                          SizedBox(height: 16.h),
                          InfoRow(
                            label: "Acre",
                            value: widget.doctor.acre.toString(),
                          ),
                          InfoRow(
                            label: "Work Place Code",
                            value: widget.doctor.workPlaceCode,
                          ),
                          InfoRow(
                            label: "Work Place Name",
                            value: widget.doctor.workPlaceName,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: DoctorActionSheet(
        editCallback: () async {
          await Get.to<dynamic>(
            EditDoctorForm(
              doctor: widget.doctor,
            ),
          );
          Get.back();
        },
        deleteCallback: () {
          _showConfirmationDialog(context);
        },
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ConfirmationDialog(
          title: 'Confirm Action',
          content: 'Are you sure you want to proceed?',
          onConfirm: () {
            Navigator.of(context).pop(); // Close the dialog
            _submitForm();
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

//logic call function to delte and show api call loading, error dailog showw succcess dilog and refesh the list
  void _submitForm() {
    Get.dialog(const LoadingDialog(), barrierDismissible: false);
    try {
      _doctorController.deleteDoctor(widget.doctor.id);
    } catch (e) {
      Get.back();
      Get.dialog(
        ErrorDialog(
          errorMessage: e.toString(),
          onClose: () {
            Get.back();
          },
        ),
        barrierDismissible: false,
      );
    } finally {
      // Ensure loading dialog is closed
      Get.back(); // Close loading dialog if not already closed
    }
  }
}

class DoctorActionSheet extends StatefulWidget {
  final VoidCallback editCallback;
  final VoidCallback deleteCallback;
  const DoctorActionSheet({
    super.key,
    required this.editCallback,
    required this.deleteCallback,
  });

  @override
  State<DoctorActionSheet> createState() => _DoctorActionSheetState();
}

class _DoctorActionSheetState extends State<DoctorActionSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: AppColors.kInput,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Row(
        children: [
          Expanded(
            child: PrimaryButton(
              color: AppColors.kAccent1,
              onTap: widget.deleteCallback,
              text: "Delete doctor",
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: PrimaryButton(
              color: AppColors.kPrimary,
              onTap: widget.editCallback,
              text: "Edit doctor",
            ),
          ),
        ],
      ),
    );
  }
}
