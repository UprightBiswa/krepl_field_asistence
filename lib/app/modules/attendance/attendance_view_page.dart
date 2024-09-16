import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:field_asistence/app/modules/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/constrants/constants.dart';
import '../../model/login/user_details_reponse.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../widgets/dialog/confirmation.dart';
import '../widgets/dialog/error.dart';
import '../widgets/dialog/loading.dart';
import '../widgets/dialog/success.dart';
import 'components/attendance_list_item.dart';
import 'components/custom_slider_button.dart';
import 'components/month_year_picker.dart';
import 'components/today_status_card.dart';
import 'controller/attendance_controller.dart';
import 'controller/location_controller.dart';
import 'controller/location_service.dart';
import 'location_view_list.dart';

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
  final LocationServiceController _locationServiceController =
      Get.put(LocationServiceController());

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
    attendanceController.fetchTodayStatus();
    _fetchAttendanceData();
  }

  Future<void> _fetchAttendanceData() async {
    await attendanceController.fetchAttendance(
      month: _month,
      year: _year,
    );
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
        action: [
          // LocationPage
          IconButton(
              icon: Icon(
                Icons.location_on,
                color: isDarkMode(context)
                    ? AppColors.kWhite
                    : AppColors.kDarkContiner,
              ),
              onPressed: () => Get.to(() => const LocationPage())),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.kPrimary2,
        ),
        child: Container(
          decoration: BoxDecoration(
              color: isDarkMode(context)
                  ? AppColors.kDarkBackground
                  : AppColors.kBackground,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16))),
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                // Today's Status Card
                Obx(() {
                  var todayStatus = attendanceController.todayStatus.value;
                  return TodayStatusCard(
                    empCode: widget.userDetails.hrEmployeeCode,
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
                Obx(() {
                  if (attendanceController.isLodaingList.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (attendanceController.isErrorList.value) {
                    return const Center(child: Text('Error loading data'));
                  } else if (attendanceController.attendanceList.isEmpty) {
                    return const PrimaryContainer(
                      width: double.infinity,
                      child: Center(
                        child: Text('No data found'),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: attendanceController.attendanceList.length,
                      itemBuilder: (context, index) {
                        return AttendanceListItem(
                          data: attendanceController.attendanceList[index],
                        );
                      },
                    );
                  }
                }),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Obx(() {
        var todayStatus = attendanceController.todayStatus.value;

        return Container(
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
              if (!todayStatus.isCheckedIn)
                CustomSliderButton(
                  label: 'Slide to Check-In',
                  activeColor: AppColors.kPrimary,
                  inactiveColor: AppColors.kPrimary.withOpacity(0.3),
                  onSlideComplete: () {
                    Get.dialog(
                      ConfirmationDialog(
                        title: 'Check-In',
                        content: 'Are you sure you want to check in?',
                        onConfirm: () async {
                          Get.back(); // Close confirmation dialog

                          final now = DateTime.now();
                          Get.dialog(const LoadingDialog(),
                              barrierDismissible: false);
                          String checkinDate =
                              DateFormat('yyyy-MM-dd').format(now);
                          String checkinTime =
                              DateFormat('hh:mm a').format(now);
                          double checkinLat =
                              locationController.currentLatitude.value;
                          double checkinLong =
                              locationController.currentLongitude.value;

                          await attendanceController.updateCheckInAttendance(
                            checkinDate: checkinDate,
                            checkinTime: checkinTime,
                            checkinLat: checkinLat.toString(),
                            checkinLong: checkinLong.toString(),
                          );
                          Get.back(); // Close the loading dialog
                          // Show success or error dialog based on result
                          if (attendanceController.isSuccessUpdate.value) {
                            Get.dialog(SuccessDialog(
                              message: "Check-In Successful!",
                              onClose: () {
                                _locationServiceController.clearLocationData();

                                if (!_locationServiceController
                                    .isTracking.value) {
                                  _locationServiceController.startService();
                                }
                                attendanceController.isSuccessUpdate(false);
                                Get.back(); // Close the success dialog
                                attendanceController.fetchTodayStatus();
                                _fetchAttendanceData();
                              },
                            ));
                          } else if (attendanceController.isErrorUpdate.value) {
                            Get.dialog(ErrorDialog(
                              errorMessage:
                                  attendanceController.errorMessageUpdate.value,
                              onClose: () {
                                attendanceController.isErrorUpdate(false);
                                Get.back(); // Close the error dialog
                                attendanceController.fetchTodayStatus();
                                _fetchAttendanceData();
                              },
                            ));
                          }
                        },
                        onCancel: () => Get.back(),
                      ),
                    );
                  },
                ),
              if (todayStatus.isCheckedIn && !todayStatus.isCheckedOut)
                CustomSliderButton(
                  label: 'Slide to Check-Out',
                  activeColor: AppColors.kAccent7,
                  inactiveColor: AppColors.kAccent7.withOpacity(0.3),
                  onSlideComplete: () {
                    Get.dialog(
                      ConfirmationDialog(
                        title: 'Check-Out',
                        content: 'Are you sure you want to check out?',
                        onConfirm: () async {
                          Get.back(); // Close confirmation dialog
                          // Show loading dialog
                          Get.dialog(const LoadingDialog(),
                              barrierDismissible: false);
                          final now = DateTime.now();
                          String checkoutDate =
                              DateFormat('yyyy-MM-dd').format(now);
                          String checkoutTime =
                              DateFormat('hh:mm a').format(now);
                          double checkoutLat =
                              locationController.currentLatitude.value;
                          double checkoutLong =
                              locationController.currentLongitude.value;
                          final List<Map<String, dynamic>> coordinates =
                              await _locationServiceController
                                  .getFormattedLocationData();

                          await attendanceController.updateCheckOutAttendance(
                            checkoutDate: checkoutDate,
                            checkoutTime: checkoutTime,
                            checkoutLat: checkoutLat.toString(),
                            checkoutLong: checkoutLong.toString(),
                            coordinates: coordinates,
                          );
                          Get.back(); // Close the loading dialog
                          // Show success or error dialog based on result
                          if (attendanceController.isSuccessCheckOut.value) {
                            if (_locationServiceController.isTracking.value) {
                              _locationServiceController.stopService();
                            }
                            _locationServiceController.clearLocationData();

                            Get.dialog(SuccessDialog(
                              message: "Check-Out Successful!",
                              onClose: () {
                                attendanceController.isSuccessCheckOut(false);
                                Get.back(); // Close the success dialog
                                attendanceController.fetchTodayStatus();
                                _fetchAttendanceData();
                              },
                            ));
                          } else if (attendanceController
                              .isErrorCheckOut.value) {
                            Get.dialog(ErrorDialog(
                              errorMessage: attendanceController
                                  .errorMessageCheckOut.value,
                              onClose: () {
                                attendanceController.isErrorCheckOut(false);
                                Get.back(); // Close the error dialog
                                attendanceController.fetchTodayStatus();
                                _fetchAttendanceData();
                              },
                            ));
                          }
                        },
                        onCancel: () => Get.back(),
                      ),
                    );
                  },
                ),

              //show text to u have aleady checked in and out  the day and
              if (todayStatus.isCheckedIn && todayStatus.isCheckedOut)
                const Text(
                  'You have already checked in and checked out for today',
                  style: TextStyle(
                    color: AppColors.kPrimary,
                    fontSize: 10,
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
