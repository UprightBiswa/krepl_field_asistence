import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../data/helpers/data/image_doctor_url.dart';
import '../../model/master/villages_model.dart';
import '../../controllers/master_controller.dart/village_controller.dart';

import '../../repository/auth/auth_token.dart';
import '../activity/components/single_select_dropdown/village_single_selection_dropdown.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/dialog/confirmation.dart';
import '../widgets/dialog/error.dart';
import '../widgets/dialog/loading.dart';
import '../widgets/form_field.dart/form_field.dart';
import '../widgets/form_field.dart/form_hader.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'controller/doctor_controller.dart';
import 'model/doctor_list.dart';

class EditDoctorForm extends StatefulWidget {
  final Doctor doctor;

  const EditDoctorForm({super.key, required this.doctor});

  @override
  State<EditDoctorForm> createState() => _EditDoctorFormState();
}

class _EditDoctorFormState extends State<EditDoctorForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthState authState = AuthState();

  final DoctorController doctorController = Get.find<DoctorController>();
  final VillageController _villageControllerlist = Get.put(VillageController());

  late TextEditingController _nameController;
  late TextEditingController _fatherNameController;
  late TextEditingController _mobileController;
  late TextEditingController _acreController;
  late TextEditingController _pinController;
  late TextEditingController _villageController;
  late TextEditingController _postOfficeController;
  late TextEditingController _subDistController;
  late TextEditingController _districtController;
  late TextEditingController _stateController;
  late TextEditingController _workPlaceCodeController;
  late TextEditingController _workPlaceNameController;

  Village? _selectedVillage;
  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadVillageData();
  }

  void _loadVillageData() async {
    try {
      await _villageControllerlist.fetchVillageMasterData().then((value) {
        _loadSelectedVillage();
      });
    } catch (e) {
      Get.snackbar('Error', 'Failed to load villages: ${e.toString()}');
    }
  }

  void _loadSelectedVillage() {
    final villages = _villageControllerlist.villages;
    final selectedVillage = villages.firstWhereOrNull(
        (village) => village.villageName == widget.doctor.villageName);

    if (selectedVillage != null) {
      setState(() {
        _selectedVillage = selectedVillage;
        _onVillageSelected(selectedVillage);
      });
    } else {
      Get.snackbar('Error', 'Selected village not found in the list.');
    }
  }

  void _initializeControllers() async {
    _nameController = TextEditingController(text: widget.doctor.name);
    _fatherNameController =
        TextEditingController(text: widget.doctor.fatherName);
    _mobileController = TextEditingController(text: widget.doctor.mobileNumber);
    _acreController = TextEditingController(text: widget.doctor.acre);
    _pinController = TextEditingController(text: widget.doctor.pinCode);
    _villageController = TextEditingController(text: widget.doctor.villageName);
    _postOfficeController =
        TextEditingController(text: widget.doctor.postOfficeName);
    _subDistController = TextEditingController(text: widget.doctor.subDistName);
    _districtController =
        TextEditingController(text: widget.doctor.districtName);
    _stateController = TextEditingController(text: widget.doctor.stateName);
    _workPlaceCodeController = TextEditingController();
    _workPlaceNameController = TextEditingController();

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
          'Edit Doctor',
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
              tag: 'edit form',
              image: ImageDoctorUrl.doctorImage,
              header: 'Edit Doctor',
              subtitle: '',
            ),
            Positioned(
              top: 228.h,
              left: 2.w,
              right: 2.w,
              bottom: 0,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 18.w),
                  child: Column(
                    children: [
                      // Doctor's Basic Details
                      PrimaryContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomHeaderText(
                              text: 'Doctor\'s Basic Details',
                              fontSize: 20.sp,
                            ),
                            SizedBox(height: 16.h),
                            CustomTextField(
                              labelText: "Name",
                              hintText: "Enter the doctor's name",
                              controller: _nameController,
                              icon: Icons.person,
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
                              controller: _fatherNameController,
                              icon: Icons.person,
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
                              controller: _mobileController,
                              icon: Icons.phone,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter a mobile number';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      // Doctor's Address Details
                      PrimaryContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomHeaderText(
                              text: 'Doctor\'s Address Details',
                              fontSize: 20.sp,
                            ),
                            SizedBox(height: 16.h),
                            VillageSingleSelectionWidget(
                              onVillageSelected: _onVillageSelected,
                              selectedItem: _selectedVillage,
                              validator: (selected) {
                                if (selected == null) {
                                  return "Please select a village";
                                }
                                return null;
                              },
                            ),
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
                      // Doctor's Work Place Details
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
                text: "Update",
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onVillageSelected(Village? selectedVillage) {
    if (selectedVillage != null) {
      setState(() {
        _selectedVillage = selectedVillage;
        _villageController.text = selectedVillage.id.toString();
        _pinController.text = selectedVillage.pin;
        _postOfficeController.text = selectedVillage.officeName;
        _subDistController.text = selectedVillage.tehsil;
        _districtController.text = selectedVillage.district;
        _stateController.text = selectedVillage.state;
      });
    }
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

            _submitEditForm();
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _submitEditForm() async {
    Get.dialog(const LoadingDialog(), barrierDismissible: false);

    final parameters = {
      'doctor_name': _nameController.text,
      'doctor_father_name': _fatherNameController.text,
      'mobile_no': _mobileController.text,
      'acre': _acreController.text,
      'pin': _pinController.text,
      'village': _villageController.text,
      'officename': _postOfficeController.text,
      'tehshil': _subDistController.text,
      'district': _districtController.text,
      'state': _stateController.text,
      'workplace_code': _workPlaceCodeController.text,
      'doctor_id': widget.doctor.id,
    };
    try {
      await doctorController.editDoctor(parameters);
    } catch (e) {
      Get.back(); // Close the Loading dialog
      Get.dialog(
          ErrorDialog(
            errorMessage: e.toString(),
            onClose: () {
              Get.back(); // Close error dialog
            },
          ),
          barrierDismissible: false);
    }
  }
}
