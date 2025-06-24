import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/constrants/constants.dart';
import '../../repository/auth/auth_token.dart';
import '../activity/components/multi_select_dropdown/village_multi_selecton_dropdown.dart';
import '../activity/components/single_select_dropdown/activity_master_dropdown.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/dialog/confirmation.dart';
import '../widgets/form_field/custom_datepicker_filed.dart';
import '../widgets/form_field/custom_text_field.dart';
import '../widgets/form_field/dynamic_dropdown_input_field.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'controller/tour_activity_type_controller.dart';
import 'controller/tour_plan_create_controller.dart';
import 'controller/tour_route_controller.dart';
import 'model/tour_activity_type_model.dart';
import 'model/tour_route_master.dart';

class TourPlanCreatePage extends StatefulWidget {
  const TourPlanCreatePage({super.key});

  @override
  State<TourPlanCreatePage> createState() => _TourPlanCreatePageState();
}

class _TourPlanCreatePageState extends State<TourPlanCreatePage> {
  final TourPlanCreateController controller =
      Get.put(TourPlanCreateController());
  final AuthState authState = AuthState();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Controllers for text fields
  final TextEditingController workPlaceCodeController = TextEditingController();
  final TextEditingController workPlaceNameController = TextEditingController();
  final TextEditingController hrEmployeeCodeController =
      TextEditingController();
  final TextEditingController employeeNameController = TextEditingController();
  final TourActivityController activityController =
      Get.put(TourActivityController());
  final TourRouteController routeController = Get.put(TourRouteController());

  // Controllers for the day
  final TextEditingController dayController = TextEditingController();

  final TourItem tourItem = TourItem();
  @override
  void initState() {
    super.initState();
    initializeControllers();
    activityController.fetchActivities();
  }

  @override
  void dispose() {
    tourItem.disposeControllers();
    dayController.dispose();
    workPlaceCodeController.dispose();
    workPlaceNameController.dispose();
    hrEmployeeCodeController.dispose();
    employeeNameController.dispose();
    super.dispose();
  }

  Future<void> initializeControllers() async {
    final workplaceCode = await authState.getWorkplaceCode();
    final workplaceName = await authState.getWorkplaceName();
    final hrEmployeeCode = await authState.getHrEmployeeCode();
    final employeeName = await authState.getEmployeeName();

    workPlaceCodeController.text = workplaceCode ?? '';
    workPlaceNameController.text = workplaceName ?? '';
    hrEmployeeCodeController.text = hrEmployeeCode ?? '';
    employeeNameController.text = employeeName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppBar(
        spaceBar: true,
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: AppColors.kPrimary.withValues(alpha: 0.15),
        title: Text(
          'Create Tour Plan',
          style: AppTypography.kBold14.copyWith(
            color: AppColors.kDarkContiner,
          ),
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                PrimaryContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeaderText(
                        text: 'User\'s Basic Details',
                        fontSize: 20.sp,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        readonly: true,
                        labelText: "Employee Name",
                        hintText: "Enter the employee name",
                        icon: Icons.person,
                        controller: employeeNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the employee name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        readonly: true,
                        labelText: "HR Employee Code",
                        hintText: "Enter the HR employee code",
                        icon: Icons.badge,
                        controller: hrEmployeeCodeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the HR employee code';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        readonly: true,
                        labelText: "Work Place Code",
                        hintText: "Enter the work place code",
                        icon: Icons.work,
                        controller: workPlaceCodeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the work place code';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        readonly: true,
                        labelText: "Work Place Name",
                        hintText: "Enter the work place name",
                        icon: Icons.business,
                        controller: workPlaceNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the work place name';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                PrimaryContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeaderText(
                        text: 'Tour  Details',
                        fontSize: 20.sp,
                      ),
                      SizedBox(height: 16.h),
                      CustomDatePicker(
                        labelText: 'Tour Date',
                        hintText: "Select Date",
                        icon: Icons.calendar_today,
                        onDateSelected: (context) async {
                          final date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2100),
                          );
                          if (date != null) {
                            tourItem.tourDateController.text =
                                DateFormat('dd-MMM-yyyy').format(date);
                            // Update the dayController with the day of the week
                            dayController.text =
                                DateFormat('EEEE').format(date);
                          }
                        },
                        textEditingController: tourItem.tourDateController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Field is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        readonly: true,
                        labelText: "Day",
                        hintText: "Enter the day",
                        icon: Icons.calendar_today,
                        controller: dayController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the day';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      VillageSelectionScreen(
                        onSelectionChanged: (selectedVillagesitems) {
                          setState(() {
                            tourItem.selectedVillages = selectedVillagesitems;
                          });
                          routeController.fetchRoutes(
                              selectedVillagesitems.map((v) => v.id).toList());
                          tourItem.selectedRoutes.clear();
                        },
                        selectedItems: tourItem.selectedVillages,
                      ),
                      const SizedBox(height: 20),
                      if (tourItem.selectedVillages.isNotEmpty) ...[
                        Obx(() {
                          if (routeController.isLoadingList.value) {
                            return const ShimmerLoading();
                          } else if (routeController.isErrorList.value) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Select Routes',
                                ),
                                SizedBox(height: 8.h),
                                Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.red),
                                  ),
                                  child: const Text(
                                    'Failed to fetch routes. Please try again.',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return Column(
                              children: [
                                MultiSelectDropdown<TourRouteMaster>(
                                  labelText: 'Select Routes',
                                  selectedItems: tourItem.selectedRoutes,
                                  items: routeController.routeList,
                                  itemAsString: (route) => route.routeName,
                                  searchableFields: {
                                    'route_name': (route) => route.routeName,
                                    'route_code': (route) => route.routeCode,
                                  },
                                  validator: (selectedRoutes) {
                                    if (selectedRoutes.isEmpty) {
                                      return 'Please select at least one route.';
                                    }
                                    return null;
                                  },
                                  onChanged: (items) {
                                    setState(() {
                                      tourItem.selectedRoutes = items;
                                    });
                                  },
                                ),
                              ],
                            );
                          }
                        }),
                        const SizedBox(height: 20),
                      ],
                      Obx(() {
                        if (activityController.isLoading.value) {
                          return const ShimmerLoading();
                        } else if (activityController.error.value.isNotEmpty) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Select Activities',
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.red[100],
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.red),
                                ),
                                child: const Text(
                                  'Failed to fetch activities. Please try again.',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return MultiSelectDropdown<TourActivity>(
                            labelText: 'Select Activities',
                            selectedItems: tourItem.selectedActivities,
                            items: activityController.activities,
                            itemAsString: (activity) =>
                                activity.promotionalActivity,
                            searchableFields: {
                              'promotionalActivity': (activity) =>
                                  activity.promotionalActivity,
                              'id': (activity) => activity.id.toString(),
                            },
                            validator: (selectedRoutes) {
                              if (selectedRoutes.isEmpty) {
                                return 'Please select at least one activity.';
                              }
                              return null;
                            },
                            onChanged: (items) {
                              setState(() {
                                tourItem.selectedActivities = items;
                              });
                            },
                          );
                        }
                      }),
                      const SizedBox(height: 20),
                      CustomTextField(
                        labelText: 'Remarks',
                        hintText: 'Enter remarks',
                        icon: Icons.comment,
                        controller: tourItem.remarksController,
                        keyboardType: TextInputType.text,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          )),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: AppColors.kPrimary2,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: PrimaryButton(
          onTap: () {
            if (validateAllFields()) {
              _showConfirmationDialog(context);
            }
          },
          text: "Submit",
        ),
      ),
    );
  }

  bool validateAllFields() {
    if (!_formKey.currentState!.validate()) {
      return false; // Standard form validation
    }

    // Check if the selected villages and activities are not empty
    if (tourItem.selectedVillages.isEmpty) {
      Get.snackbar('Error', 'Please select at least one village.');
      return false;
    }
    // Check if the selected villages and activities are not empty
    if (tourItem.selectedRoutes.isEmpty) {
      Get.snackbar('Error', 'Please select at least one routs.');
      return false;
    }

    if (tourItem.selectedActivities.isEmpty) {
      Get.snackbar('Error', 'Please select at least one activity.');
      return false;
    }

    return true; // All fields are valid
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

  void _submitForm() async {
    // Show loading dialog
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );

    bool isSuccess = await controller.submitTourPlan(tourItem);

    // Close loading dialog
    Get.back();

    if (isSuccess) {
      // ✅ Success Dialog
      Get.dialog(
        AlertDialog(
          title: const Text('Success'),
          content: const Text('Tour submitted successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close success dialog
                Get.back(); // Go back to previous screen
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // ❌ Optional: Error dialog (already shown via Get.snackbar in controller)
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to submit tour plan. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close error dialog
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
