import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../data/helpers/data/image_doctor_url.dart';
import '../../model/master/villages_model.dart';
import '../../repository/auth/auth_token.dart';
import '../activity/components/single_select_dropdown/activity_master_dropdown.dart';
import '../activity/components/single_select_dropdown/pin_selection_dropdown.dart';
import '../farmer/controller/village_pin_controller.dart';
import '../farmer/model/pin_model.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/dialog/confirmation.dart';
import '../widgets/dialog/error.dart';
import '../widgets/dialog/loading.dart';
import '../widgets/form_field/form_field.dart';
import '../widgets/form_field/form_hader.dart';
import '../widgets/form_field/single_selected_dropdown.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'controller/doctor_controller.dart';

class DoctorForm extends StatefulWidget {
  const DoctorForm({super.key});

  @override
  State<DoctorForm> createState() => _DoctorFormState();
}

class _DoctorFormState extends State<DoctorForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthState authState = AuthState();
  final DoctorController doctorController = Get.find<DoctorController>();
  final VillagePinController _villagePinController =
      Get.put(VillagePinController());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _fatherNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _acreController = TextEditingController();
  // final TextEditingController _pinController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  final TextEditingController _postOfficeController = TextEditingController();
  final TextEditingController _subDistController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _workPlaceCodeController =
      TextEditingController();
  final TextEditingController _workPlaceNameController =
      TextEditingController();
  Village? _selectedVillage;
  PinModel? _selectedPin;

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
        // _pinController.text = selectedVillage.pin;
        _postOfficeController.text = selectedVillage.officeName;
        _subDistController.text = selectedVillage.tehsil;
        _districtController.text = selectedVillage.district;
        _stateController.text = selectedVillage.state;
      });
    } else {
      setState(() {
        _selectedVillage = null;
        _villageController.clear();
        // _pinController.clear();
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
    _fatherNameController.dispose();
    _mobileController.dispose();
    _acreController.dispose();
    // _pinController.dispose();
    _villageController.dispose();
    _postOfficeController.dispose();
    _subDistController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _workPlaceCodeController.dispose();
    _workPlaceNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomBackAppBar(
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: AppColors.kPrimary.withValues(alpha: 0.15),
        title: Text(
          'Doctor Form',
          style: AppTypography.kBold24.copyWith(color: AppColors.kWhite),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            const FormImageHeader(
              tag: 'form',
              image: ImageDoctorUrl.doctorImage,
              header: 'Doctor Form',
              subtitle: 'Fill in the details to add a new doctor',
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
                              text: 'Basic Details',
                              fontSize: 20.sp,
                            ),
                            SizedBox(height: 16.h),
                            CustomTextField(
                              labelText: "Name",
                              hintText: "Enter the doctor's name",
                              icon: Icons.person,
                              controller: _nameController,
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[a-zA-Z\s]+')),
                                LengthLimitingTextInputFormatter(30),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the name';
                                } else if (!RegExp(r'^[a-zA-Z\s]+$')
                                    .hasMatch(value)) {
                                  return 'Only letters are allowed';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              labelText: "Father's Name",
                              hintText: "Enter the father's name",
                              icon: Icons.person,
                              controller: _fatherNameController,
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[a-zA-Z\s]+')),
                                LengthLimitingTextInputFormatter(30),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the father\'s name';
                                } else if (!RegExp(r'^[a-zA-Z\s]+')
                                    .hasMatch(value)) {
                                  return 'Only letters are allowed';
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
                                } else if (!RegExp(r'^\d{10}$')
                                    .hasMatch(value)) {
                                  return 'Enter a valid 10-digit mobile number';
                                }
                                return null;
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
                              text: 'Address Details',
                              fontSize: 20.sp,
                            ),
                            SizedBox(height: 16.h),
                            PinSingleSelectionWidget(
                              onPinModelSelected: (selectedPin) {
                                setState(() {
                                  _selectedPin = selectedPin;
                                });
                                _villagePinController
                                    .fetchVillages(selectedPin!.pin);

                                ///claer old value
                                _selectedVillage = null;
                                _villageController.clear();
                                _postOfficeController.clear();
                                _subDistController.clear();
                                _districtController.clear();
                                _stateController.clear();
                              },
                              selectedItem: _selectedPin,
                              validator: (selected) {
                                if (selected == null) {
                                  return "Please select a pin";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 16.h),
                            Obx(() {
                              if (_villagePinController.isLoading.value) {
                                return const ShimmerLoading(); // Show shimmer loading effect while data is being fetched
                              } else if (_villagePinController.isError.value ||
                                  _villagePinController
                                      .errorMessage.isNotEmpty) {
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Error loading villages'),
                                  ),
                                );
                              } else {
                                return SingleSelectDropdown<Village>(
                                  labelText: "Select Village",
                                  items: _villagePinController.villages,
                                  selectedItem: _selectedVillage,
                                  itemAsString: (village) =>
                                      village.villageName,
                                  onChanged: (selected) {
                                    setState(() {
                                      _selectedVillage =
                                          selected; // Update the selected village
                                    });
                                    _onVillageSelected(selected);
                                  },
                                  searchableFields: {
                                    "village_name": (village) =>
                                        village.villageName,
                                    "village_code": (village) =>
                                        village.villageCode,
                                  },
                                  validator: (selected) {
                                    if (selected == null) {
                                      return "Please select a village";
                                    }
                                    return null;
                                  },
                                );
                              }
                            }),
                            // VillageSingleSelectionWidget(
                            //   onVillageSelected: _onVillageSelected,
                            //   selectedItem: _selectedVillage,
                            //   validator: (selected) {
                            //     if (selected == null) {
                            //       return "Please select a village";
                            //     }
                            //     return null;
                            //   },
                            // ),
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
                            // CustomTextField(
                            //   readonly: true,
                            //   labelText: "PIN Code",
                            //   hintText: "Enter the PIN code",
                            //   icon: Icons.pin_drop,
                            //   controller: _pinController,
                            //   keyboardType: TextInputType.number,
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please enter the PIN code';
                            //     }
                            //     return null;
                            //   },
                            // ),
                            // SizedBox(height: 20.h),
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
                              labelText: "Acre",
                              hintText: "Enter the total acres",
                              icon: Icons.landscape,
                              controller: _acreController,
                              keyboardType: TextInputType.number,
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}'),
                                ),
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the number of acres';
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: AppColors.kInput,
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
      'doctor_name': _nameController.text,
      'doctor_father_name': _fatherNameController.text,
      'mobile_no': _mobileController.text,
      'acre': _acreController.text,
      'pin': _selectedPin?.pin,
      'village': _villageController.text,
      'officename': _postOfficeController.text,
      'tehshil': _subDistController.text,
      'district': _districtController.text,
      'state': _stateController.text,
      'workplace_code': _workPlaceCodeController.text,
    };
    try {
      await doctorController.createDoctor(parameters);
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
