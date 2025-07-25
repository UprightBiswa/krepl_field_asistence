import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../data/constrants/constants.dart';
import '../../data/helpers/data/image_doctor_url.dart';
import '../../model/master/villages_model.dart';
import '../../controllers/master_controller/village_controller.dart';

import '../../repository/auth/auth_token.dart';
import '../activity/components/single_select_dropdown/activity_master_dropdown.dart';
import '../activity/components/single_select_dropdown/pin_selection_dropdown.dart';
import '../farmer/controller/pin_list_controller.dart';
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
  final PinController _pinController = Get.put(PinController());
  final VillagePinController _villagePinController =
      Get.put(VillagePinController());
  late TextEditingController _nameController;
  late TextEditingController _fatherNameController;
  late TextEditingController _mobileController;
  late TextEditingController _acreController;
  late TextEditingController _villageController;
  late TextEditingController _postOfficeController;
  late TextEditingController _subDistController;
  late TextEditingController _districtController;
  late TextEditingController _stateController;
  late TextEditingController _workPlaceCodeController;
  late TextEditingController _workPlaceNameController;
  PinModel? _selectedPin;
  Village? _selectedVillage;
  @override
  void initState() {
    super.initState();
    _loadSelectedPin();
    _loadVillageData();

    _initializeControllers();
  }

  void _loadSelectedPin() {
    // Fetch pins and wait for the result
    _pinController.fetchPins().then((_) {
      // After fetching pins, access the pin list
      final pinList = _pinController.pinList;

      if (pinList.isEmpty) {
        Get.snackbar('Error', 'Pin list is empty. Please load the list first.');
        return;
      }

      final selectedPin =
          pinList.firstWhereOrNull((pin) => pin.pin == widget.doctor.pinCode);

      if (selectedPin != null) {
        setState(() {
          _selectedPin = selectedPin;
          // Optionally load related villages or perform additional actions
          // _loadSelectedVillage();
        });
      } else {
        Get.snackbar('Error', 'Selected Pin not found in the list.');
      }
    }).catchError((error) {
      // Handle errors during the fetch process
      Get.snackbar('Error', 'Failed to fetch pins: ${error.toString()}');
    });
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
    // _pinController = TextEditingController(text: widget.doctor.pinCode);
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
          'Edit Doctor',
          style: AppTypography.kBold24.copyWith(color: AppColors.kWhite),
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
                              text: 'Basic Details',
                              fontSize: 20.sp,
                            ),
                            SizedBox(height: 16.h),
                            CustomTextField(
                              labelText: "Name",
                              hintText: "Enter the doctor's name",
                              controller: _nameController,
                              icon: Icons.person,
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
                              controller: _fatherNameController,
                              icon: Icons.person,
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
                              controller: _mobileController,
                              icon: Icons.phone,
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
                      // Doctor's Address Details
                      PrimaryContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomHeaderText(
                              text: 'Address Details',
                              fontSize: 20.sp,
                            ),
                            SizedBox(height: 16.h),
                            //pin section
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
        // _pinController.text = selectedVillage.pin;
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
      'pin': _selectedPin?.pin,
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
