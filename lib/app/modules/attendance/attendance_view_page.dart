import 'package:field_asistence/app/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import 'components/attendance_list_item.dart';
import 'components/custom_slider_button.dart';
import 'components/month_year_picker.dart';
import 'components/today_status_card.dart';
import 'controller/attendance_controller.dart';
import 'controller/location_service.dart';

class AttendanceViewPage extends StatefulWidget {
  final UserDetails userDetails;
  const AttendanceViewPage({super.key, required this.userDetails});

  @override
  State<AttendanceViewPage> createState() => _AttendanceViewPageState();
}

class _AttendanceViewPageState extends State<AttendanceViewPage> {
  final AttendanceController attendanceController =
      Get.put(AttendanceController());
  final LocationController locationController = Get.put(LocationController());
  String _month = '';
  String _monthName = '';
  String _year = '';

  @override
  void initState() {
    super.initState();
    _month = DateFormat('MM').format(DateTime.now());
    _monthName = DateFormat('MMMM').format(DateTime.now());
    _year = DateFormat('yyyy').format(DateTime.now());
    locationController.startLocationUpdates();
    _fetchAttendanceData();
  }

  Future<void> _fetchAttendanceData() async {
    await attendanceController.fetchAttendance(
      employeeCode: 'EMP001',
      month: _month,
      year: _year,
    );
    await attendanceController.fetchTodayStatus(employeeCode: 'EMP001');
  }

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
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
          'Attendance',
          style: AppTypography.kBold14.copyWith(
            color: isDarkMode(context)
                ? AppColors.kWhite
                : AppColors.kDarkContiner,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            SizedBox(height: 10.h),

            // Today's Status Card
            Obx(() {
              var todayStatus = attendanceController.todayStatus.value;
              return TodayStatusCard(
                employeeName: widget.userDetails.employeeName,
                checkInTime: todayStatus.checkinTime ?? '--/--',
                checkOutTime: todayStatus.checkoutTime ?? '--/--',
                currentAddress: locationController.currentAddress.value,
              );
            }),
            SizedBox(height: 10.h),

            MonthYearPicker(
              monthName: _monthName,
              year: _year,
              onPickMonth: () async {
                final DateTime? picked = await showMonthPicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2099),
                );

                if (picked != null) {
                  setState(() {
                    _month = DateFormat('MM').format(picked);
                    _monthName = DateFormat('MMMM').format(picked);
                    _year = DateFormat('yyyy').format(picked);
                    _fetchAttendanceData();
                  });
                }
              },
            ),
            SizedBox(height: 10.h),

            Expanded(
              child: Obx(() {
                if (attendanceController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                } else if (attendanceController.isError.value) {
                  return const Center(child: Text('Error loading data'));
                } else if (attendanceController.attendanceList.isEmpty) {
                  return const Center(child: Text('No data found'));
                } else {
                  return ListView.builder(
                    itemCount: attendanceController.attendanceList.length,
                    itemBuilder: (context, index) {
                      return AttendanceListItem(
                        data: attendanceController.attendanceList[index],
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10.h),
        decoration: BoxDecoration(
          color: isDarkMode(context)
              ? AppColors.kDarkSurfaceColor
              : AppColors.kInput,
          boxShadow: [
            BoxShadow(
              color: AppColors.kPrimary.withOpacity(0.2),
              offset: const Offset(0, -5),
              blurRadius: 7,
            ),
          ],
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!attendanceController.todayStatus.value.isCheckedIn)
              CustomSliderButton(
                label: 'Slide to Check-In',
                activeColor: AppColors.kPrimary,
                inactiveColor: AppColors.kPrimary.withOpacity(0.3),
                onSlideComplete: () {
                  setState(() {
                    attendanceController.todayStatus.value.isCheckedIn = true;
                  });
                  // Implement Check-In Logic
                },
              ),
            if (attendanceController.todayStatus.value.isCheckedIn &&
                !attendanceController.todayStatus.value.isCheckedOut)
              CustomSliderButton(
                label: 'Slide to Check-Out',
                activeColor: AppColors.kAccent7,
                inactiveColor: AppColors.kAccent7.withOpacity(0.3),
                onSlideComplete: () {
                  setState(() {
                    attendanceController.todayStatus.value.isCheckedOut = true;
                  });
                  // Implement Check-Out Logic
                },
              ),
          ],
        ),
      ),
    );
  }
}
