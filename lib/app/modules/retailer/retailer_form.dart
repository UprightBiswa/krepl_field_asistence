import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/master_controller.dart/customer_controller.dart';
import '../../data/constrants/constants.dart';
import '../../data/helpers/data/image_doctor_url.dart';
import '../../model/master/villages_model.dart';
import '../../repository/auth/auth_token.dart';
import '../activity/components/multi_select_dropdown/customer_multi_select_dropdown.dart';
import '../activity/components/single_select_dropdown/village_single_selection_dropdown.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/dialog/confirmation.dart';
import '../widgets/dialog/error.dart';
import '../widgets/dialog/loading.dart';
import '../widgets/form_field.dart/form_field.dart';
import '../widgets/form_field.dart/form_hader.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'controller/retailer_controller.dart';

class RetailerForm extends StatefulWidget {
  const RetailerForm({super.key});

  @override
  State<RetailerForm> createState() => _RetailerFormState();
}

class _RetailerFormState extends State<RetailerForm> {
  final RetailerController retailerController = Get.put(RetailerController());
  final AuthState authState = AuthState();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _postOfficeController = TextEditingController();
  final TextEditingController _subDistController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _workPlaceCodeController =
      TextEditingController();
  final TextEditingController _workPlaceNameController =
      TextEditingController();

  //veriable to store list of customer
  List<Customer> selectedCustomers = [];

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

  void _onVillageSelected(Village? selectedVillage) {
    if (selectedVillage != null) {
      setState(() {
        _selectedVillage = selectedVillage;
        _villageController.text = selectedVillage.id.toString();
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

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _pinController.dispose();
    _villageController.dispose();
    _postOfficeController.dispose();
    _subDistController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _workPlaceCodeController.dispose();
    _workPlaceNameController.dispose();
    super.dispose();
  }

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
          'Retailer Form',
          style: AppTypography.kBold14.copyWith(
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
            const FormImageHeader(
              tag: 'form',
              image: ImageDoctorUrl.retailerImage,
              header: 'Retailer Form',
              subtitle: 'Fill in the details to add a new retailer',
            ),
            Positioned(
              top: 228.h,
              left: 2.w,
              right: 2.w,
              bottom: 0,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Basic Details Section
                      PrimaryContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomHeaderText(
                              text: 'Retailer\'s Basic Details',
                              fontSize: 20.sp,
                            ),
                            SizedBox(height: 16.h),
                            CustomTextField(
                              labelText: "Name",
                              hintText: "Enter the retaile's name",
                              icon: Icons.person,
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
                              labelText: "Mobile Number",
                              hintText: "Enter the mobile number",
                              icon: Icons.phone,
                              controller: _mobileController,
                              keyboardType: TextInputType.phone,
                              inputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a mobile number';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              labelText: "Email Address",
                              hintText: "Enter the email address",
                              icon: Icons.email,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              //input eamil
                              inputFormatter: [
                                FilteringTextInputFormatter.singleLineFormatter,
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the email address';
                                } else if (!GetUtils.isEmail(value)) {
                                  return 'Please enter a valid email address';
                                }

                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            CustomerMultiPleSelectionScreen(
                              onSelectionChanged: (customers) {
                                selectedCustomers = customers;
                              },
                            ),
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
                              text: 'Retailer\'s Address Details',
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
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0, left: 8.0),
                                child: Text(
                                  'Please select a village to auto-fill the address fields',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12),
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
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
                onTap: () {
                  if ((_formKey.currentState?.validate() ?? false) &&
                      selectedCustomers.isNotEmpty) {
                    _formKey.currentState?.save();
                    _showConfirmationDialog(context);
                  } else {
                    Get.snackbar(
                      'Error',
                      'Please fill all the fields',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                text: "Submit",
              ),
            ),
          ],
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
      'retailer_name': _nameController.text,
      'email': _emailController.text,
      'mobile_no': _mobileController.text,
      'pin': _pinController.text,
      'village_name': _villageController.text,
      'officename': _postOfficeController.text,
      'tehshil': _subDistController.text,
      'district': _districtController.text,
      'state': _stateController.text,
      'workplace_code': _workPlaceCodeController.text,
      'customer_code[]': selectedCustomers.map((e) => e.code).toList(),
    };
    try {
      await retailerController.submitRetailerData(parameters);
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
    }
  }
}
