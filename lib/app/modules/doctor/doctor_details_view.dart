import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../data/helpers/data/image_doctor_url.dart';
import '../widgets/components/Info_row_widget.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'model/doctor_list.dart';

class DoctorDetailView extends StatefulWidget {
  final Doctor doctor;
  const DoctorDetailView({required this.doctor, super.key});

  @override
  State<DoctorDetailView> createState() => _DoctorDetailViewState();
}

class _DoctorDetailViewState extends State<DoctorDetailView> {
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomBackAppBar(
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: isDarkMode(context)
            ? Colors.black
            : AppColors.kPrimary.withOpacity(0.15),
        title: Text(
          'doctor Details',
          style: AppTypography.kBold20.copyWith(
            color: isDarkMode(context)
                ? AppColors.kWhite
                : AppColors.kDarkContiner,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            DetailImageHeader(doctor: widget.doctor),
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
                            value: widget.doctor.villageLocalityName,
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
        editCallback: () {
          // Logic for editing doctor details
        },
      ),
    );
  }
}

class DetailImageHeader extends StatelessWidget {
  final Doctor doctor;
  const DetailImageHeader({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270.h,
      width: Get.width,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(ImageDoctorUrl.doctorImage),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            height: 270.h,
            width: Get.width,
            padding: EdgeInsets.all(12.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, Colors.black.withOpacity(0.5)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctor.name,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  doctor.mobileNumber,
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: Colors.white.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DoctorActionSheet extends StatefulWidget {
  final VoidCallback editCallback;
  const DoctorActionSheet({
    super.key,
    required this.editCallback,
  });

  @override
  State<DoctorActionSheet> createState() => _DoctorActionSheetState();
}

class _DoctorActionSheetState extends State<DoctorActionSheet> {
  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: isDarkMode(context)
            ? AppColors.kDarkSurfaceColor
            : AppColors.kInput,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Row(
        children: [
          Expanded(
            child: PrimaryButton(
              onTap: widget.editCallback,
              text: "Edit doctor Details",
            ),
          ),
        ],
      ),
    );
  }
}
