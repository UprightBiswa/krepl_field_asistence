import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../model/master/villages_model.dart';
import '../../repository/auth/auth_token.dart';
import '../activity/components/single_select_dropdown/activity_master_dropdown.dart';
import '../activity/components/single_select_dropdown/village_single_selection_dropdown.dart';
import '../activity/model/activity_master_model.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/dialog/confirmation.dart';
import '../widgets/dialog/error.dart';
import '../widgets/dialog/loading.dart';
import '../widgets/form_field.dart/form_field.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'controller/farmer_controller.dart';

class FarmerForm extends StatefulWidget {
  const FarmerForm({super.key});

  @override
  State<FarmerForm> createState() => _FarmerFormState();
}

class _FarmerFormState extends State<FarmerForm> {
  final FarmerController farmerController = Get.put(FarmerController());
  final AuthState authState = AuthState();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _acreController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _postOfficeController = TextEditingController();
  final TextEditingController _subDistController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _cowCountController = TextEditingController();
  final TextEditingController _buffaloCountController = TextEditingController();
  final TextEditingController _workPlaceCodeController =
      TextEditingController();
  final TextEditingController _workPlaceNameController =
      TextEditingController();
  final TextEditingController _selectedDateController = TextEditingController();
  ActivityMaster? _selectedActivity;
  Village? _selectedVillage;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  Future<void> _initializeControllers() async {
    // Fetch workplace code and name from AuthState
    final workplaceCode = await authState.getWorkplaceCode();
    final workplaceName = await authState.getWorkplaceName();

    // Update controllers with the fetched values
    setState(() {
      _workPlaceCodeController.text = workplaceCode ?? '';
      _workPlaceNameController.text = workplaceName ?? '';
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _fatherNameController.dispose();
    _mobileController.dispose();
    _acreController.dispose();
    _pinController.dispose();
    _villageController.dispose();
    _postOfficeController.dispose();
    _subDistController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _cowCountController.dispose();
    _buffaloCountController.dispose();
    _workPlaceCodeController.dispose();
    _workPlaceNameController.dispose();
    _selectedDateController.dispose();
    super.dispose();
  }

  void _onVillageSelected(Village? selectedVillage) {
    if (selectedVillage != null) {
      setState(() {
        _selectedVillage = selectedVillage;
        _villageController.text = selectedVillage.villageName;
        // Auto-fill the address fields
        _pinController.text = selectedVillage.pin;
        _postOfficeController.text = selectedVillage.officeName;
        _subDistController.text = selectedVillage.tehsil;
        _districtController.text = selectedVillage.district;
        _stateController.text = selectedVillage.state;
      });
    } else {
      setState(() {
        _selectedVillage = null;
        _villageController.clear();
        _pinController.clear();
        _postOfficeController.clear();
        _subDistController.clear();
        _districtController.clear();
        _stateController.clear();
      });
    }
  }

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              AppAssets.kFarmer,
            ),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomBackAppBar(
          leadingCallback: () {
            Get.back<void>();
          },
          iconColor: isDarkMode(context)
              ? Colors.black
              : AppColors.kPrimary.withOpacity(0.15),
          title: Text(
            'Farmer Form',
            style: AppTypography.kBold14.copyWith(
              color: isDarkMode(context)
                  ? AppColors.kWhite
                  : AppColors.kDarkContiner,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                PrimaryContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeaderText(
                        text: 'Farmer\'s Basic Details',
                        fontSize: 20.sp,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        labelText: "Name",
                        hintText: "Enter the farmer's name",
                        icon: Icons.person,
                        inputFormatter: [
                          FilteringTextInputFormatter.singleLineFormatter,
                          LengthLimitingTextInputFormatter(30),
                        ],
                        controller: _nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        labelText: "Father's Name",
                        hintText: "Enter the father's name",
                        icon: Icons.person,
                        inputFormatter: [
                          FilteringTextInputFormatter.singleLineFormatter,
                          LengthLimitingTextInputFormatter(30),
                        ],
                        controller: _fatherNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the father\'s name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        labelText: "Mobile Number",
                        hintText: "Enter the mobile number",
                        icon: Icons.phone,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        controller: _mobileController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a mobile number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      ActivitySelectionWidget(
                        formType: "A",
                        onSaved: (selectedActivity) {
                          setState(() {
                            _selectedActivity = selectedActivity;
                          });
                        },
                        validator: (selectedActivity) {
                          if (selectedActivity == null) {
                            return 'Please select an activity';
                          }
                          return null;
                        },
                      ),
                      if (_selectedActivity == null) ...[
                        //show text veldaition
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                          child: Text(
                            'Please select a promotional activity',
                            style: AppTypography.kLight12.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                // Address Details Section
                PrimaryContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeaderText(
                        text: 'Farmer\'s Address Details',
                        fontSize: 20.sp,
                      ),
                      SizedBox(height: 16.h),
                      VillageSingleSelectionWidget(
                        onVillageSelected: _onVillageSelected,
                        validator: (selected) {
                          if (selected == null) {
                            return "Please select a village";
                          }
                          return null;
                        },
                      ),
                      if (_selectedVillage == null) ...[
                        //show text veldaition
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                          child: Text(
                            'Please select a village to auto-fill the address fields',
                            style: AppTypography.kLight12.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                      SizedBox(height: 20.h),

                      CustomTextField(
                        readonly: true,
                        labelText: "PIN Code",
                        hintText: "Enter the PIN code",
                        icon: Icons.pin_drop,
                        controller: _pinController,
                        inputFormatter: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the PIN code';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        readonly: true,
                        labelText: "Post Office Name",
                        hintText: "Enter post office name",
                        icon: Icons.mail,
                        controller: _postOfficeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the post office name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        readonly: true,
                        labelText: "Sub-District",
                        hintText: "Enter sub-district",
                        icon: Icons.map,
                        controller: _subDistController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the sub-district';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        readonly: true,
                        labelText: "District",
                        hintText: "Enter district",
                        icon: Icons.location_on,
                        controller: _districtController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the district';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        readonly: true,
                        labelText: "State",
                        hintText: "Enter state",
                        icon: Icons.public,
                        controller: _stateController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the state';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      // ],
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
                // Field Details Section
                PrimaryContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeaderText(
                        text: 'Field Details',
                        fontSize: 20.sp,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        labelText: "Acre",
                        hintText: "Enter the total acres",
                        icon: Icons.landscape,
                        controller: _acreController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the number of acres';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        labelText: "Cow Count",
                        hintText: "Enter the number of cows",
                        icon: Icons.pets,
                        controller: _cowCountController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the number of cows';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        labelText: "Buffalo Count",
                        hintText: "Enter the number of buffaloes",
                        icon: Icons.pets,
                        controller: _buffaloCountController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the number of buffaloes';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        readonly: true,
                        labelText: "Work Place Code",
                        hintText: "Enter the work place code",
                        icon: Icons.work,
                        controller: _workPlaceCodeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the work place code';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
                        readonly: true,
                        labelText: "Work Place Name",
                        hintText: "Enter the work place name",
                        icon: Icons.business,
                        controller: _workPlaceNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the work place name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(16.h),
          decoration: BoxDecoration(
            color: isDarkMode(context)
                ? AppColors.kDarkContiner
                : AppColors.kWhite,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          ),
          child: Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      _showConfirmationDialog(context);
                    } else {
                      Get.snackbar(
                        'Error',
                        'Please fill all the fields',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      log('Form is invalid');
                    }
                  },
                  text: "Submit",
                ),
              ),
            ],
          ),
        ),
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

  void _submitForm() async {
    Get.dialog(const LoadingDialog(), barrierDismissible: false);
    final parameters = {
      'promotion_activity': _selectedActivity?.promotionalActivity,
      'farmer_name': _nameController.text,
      'father_name': _fatherNameController.text,
      'mobile_no': _mobileController.text,
      'acre': _acreController.text,
      'pin': _pinController.text,
      'village_name': _villageController.text,
      'officename': _postOfficeController.text,
      'tehshil': _subDistController.text,
      'district': _districtController.text,
      'state': _stateController.text,
      'cow': _cowCountController.text,
      'buffalo': _buffaloCountController.text,
      'workplace_code': _workPlaceCodeController.text,
      'workplace_name': _workPlaceNameController.text,
    };
    try {
      await farmerController.submitFarmerData(parameters);
    } catch (e) {
      // In case of error, hide the loading dialog and show the error dialog
      Get.back(); // Close loading dialog
      Get.dialog(
          ErrorDialog(
            errorMessage: e.toString(),
            onClose: () {
              Get.back(); // Close error dialog
            },
          ),
          barrierDismissible: false);
    } finally {
      // Ensure loading dialog is closed
      Get.back(); // Close loading dialog if not already closed

      print(_selectedActivity?.promotionalActivity ?? 'Not selected');
      log('Form is valid');
    }
  }
}
