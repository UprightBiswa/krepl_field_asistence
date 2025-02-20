import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../controllers/master_controller.dart/village_controller.dart';
import '../../data/constrants/constants.dart';
import '../../data/helpers/data/image_doctor_url.dart';
import '../../model/master/villages_model.dart';
import '../../repository/auth/auth_token.dart';
import '../activity/components/single_select_dropdown/activity_master_dropdown.dart';
import '../activity/components/single_select_dropdown/pin_selection_dropdown.dart';
import '../activity/controller/activity_master_controller.dart';
import '../activity/model/activity_master_model.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/dialog/confirmation.dart';
import '../widgets/dialog/error.dart';
import '../widgets/dialog/loading.dart';
import '../widgets/form_field.dart/form_field.dart';
import '../widgets/form_field.dart/form_hader.dart';
import '../widgets/form_field.dart/single_selected_dropdown.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'controller/farmer_controller.dart';
import 'controller/pin_list_controller.dart';
import 'controller/village_pin_controller.dart';
import 'model/farmer_list.dart';
import 'model/pin_model.dart';

class FarmerEditForm extends StatefulWidget {
  final Farmer farmer;
  final String tag;

  const FarmerEditForm({super.key, required this.farmer, required this.tag});

  @override
  State<FarmerEditForm> createState() => _FarmerEditFormState();
}

class _FarmerEditFormState extends State<FarmerEditForm> {
  final ActivityMasterController _activityMasterController =
      Get.put(ActivityMasterController());
  final FarmerController farmerController = Get.put(FarmerController());
  final VillagePinController _villagePinController =
      Get.put(VillagePinController());

  final AuthState authState = AuthState();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final VillageController _villageControllerlist = Get.put(VillageController());
  final PinController _pinController = Get.put(PinController());
  TextEditingController _nameController = TextEditingController();
  TextEditingController _fatherNameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _acreController = TextEditingController();
  final TextEditingController _villageController = TextEditingController();
  TextEditingController _postOfficeController = TextEditingController();
  TextEditingController _subDistController = TextEditingController();
  TextEditingController _districtController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _cowCountController = TextEditingController();
  TextEditingController _buffaloCountController = TextEditingController();
  final TextEditingController _workPlaceCodeController =
      TextEditingController();
  final TextEditingController _workPlaceNameController =
      TextEditingController();
  ActivityMaster? _selectedActivity;
  PinModel? _selectedPin;
  Village? _selectedVillage;
  @override
  void initState() {
    super.initState();
    _loadSelectedPin();
    _loadVillageData();
    _loadActivityData();
    _initializeControllers();
  }

  void _loadActivityData() {
    try {
      _activityMasterController.fetchActivityMasterData("A").then((value) {
        _setAcitivity();
      });
    } catch (e) {
      Get.snackbar("Error", 'Failed to load activity');
    }
  }

  void _setAcitivity() {
    final activitys = _activityMasterController.activityMasterList;
    final selectedActivity = activitys.firstWhereOrNull((activity) =>
        activity.promotionalActivity == widget.farmer.promotionActivity);
    if (selectedActivity != null) {
      setState(() {
        _selectedActivity = selectedActivity;
      });
    } else {
      Get.snackbar("Error", 'Selected activity is not found in the list');
    }
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
          pinList.firstWhereOrNull((pin) => pin.pin == widget.farmer.pin);

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

  void _loadSelectedVillage() {
    final villages = _villageControllerlist.villages;
    final selectedVillage = villages.firstWhereOrNull(
        (village) => village.villageName == widget.farmer.villageName);

    if (selectedVillage != null) {
      setState(() {
        _selectedVillage = selectedVillage;
        _onVillageSelected(selectedVillage);
      });
    } else {
      Get.snackbar('Error', 'Selected village not found in the list.');
    }
  }

  Future<void> _initializeControllers() async {
    // Initial the controller value with widget value
    _nameController =
        TextEditingController(text: widget.farmer.farmerName ?? '');
    _fatherNameController =
        TextEditingController(text: widget.farmer.fatherName ?? '');
    _mobileController =
        TextEditingController(text: widget.farmer.mobileNo ?? '');
    // _pinController = TextEditingController(text: widget.farmer.pin ?? '');
    _postOfficeController =
        TextEditingController(text: widget.farmer.officeName ?? '');
    _subDistController =
        TextEditingController(text: widget.farmer.tehshil ?? '');
    _districtController =
        TextEditingController(text: widget.farmer.district ?? '');
    _stateController = TextEditingController(text: widget.farmer.state ?? '');
    _acreController = TextEditingController(text: widget.farmer.acre ?? '');
    _cowCountController = TextEditingController(text: widget.farmer.cow ?? '');
    _buffaloCountController =
        TextEditingController(text: widget.farmer.buffalo ?? '');

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
    // _pinController.dispose();
    _villageController.dispose();
    _postOfficeController.dispose();
    _subDistController.dispose();
    _districtController.dispose();
    _stateController.dispose();
    _cowCountController.dispose();
    _buffaloCountController.dispose();
    _workPlaceCodeController.dispose();
    _workPlaceNameController.dispose();
    super.dispose();
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
          'Farmer Edit Form',
          style: AppTypography.kBold24.copyWith(
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
            FormImageHeader(
              tag: widget.tag,
              image: ImageDoctorUrl.farmerImage,
              header: widget.farmer.farmerName ?? '',
              subtitle: widget.farmer.promotionActivity ?? '',
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
                              hintText: "Enter the farmer's name",
                              icon: Icons.person,
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[a-zA-Z\s]+$')),
                                LengthLimitingTextInputFormatter(30),
                              ],
                              controller: _nameController,
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
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'^[a-zA-Z\s]+$')),
                                LengthLimitingTextInputFormatter(30),
                              ],
                              controller: _fatherNameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the father\'s name';
                                } else if (!RegExp(r'^[a-zA-Z\s]+$')
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
                              inputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                              controller: _mobileController,
                              keyboardType: TextInputType.phone,
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
                            SizedBox(height: 20.h),
                            ActivitySelectionWidget(
                              formType: "A",
                              onSaved: (selectedActivity) {
                                setState(() {
                                  _selectedActivity = selectedActivity;
                                });
                              },
                              selectedItem: _selectedActivity,
                              // validator: (selectedActivity) {
                              //   if (selectedActivity == null) {
                              //     return 'Please select an activity';
                              //   }
                              //   return null;
                              // }, selectedActivity && _selectedActivity
                              validator: (selectedActivity) {
                                if (selectedActivity == null &&
                                    _selectedActivity == null) {
                                  return 'Please select a promotional activity';
                                }
                                return null;
                              },
                            ),
                            if (_selectedActivity == null) ...[
                              //show text veldaition
                              const Padding(
                                padding: EdgeInsets.only(top: 8.0, left: 8.0),
                                child: Text(
                                  'Please select a promotional activity',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 12),
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
                            // SizedBox(height: 20.h),

                            // CustomTextField(
                            //   readonly: true,
                            //   labelText: "PIN Code",
                            //   hintText: "Enter the PIN code",
                            //   icon: Icons.pin_drop,
                            //   controller: _pinController,
                            //   inputFormatter: [
                            //     FilteringTextInputFormatter.digitsOnly,
                            //     LengthLimitingTextInputFormatter(6),
                            //   ],
                            //   keyboardType: TextInputType.number,
                            //   validator: (value) {
                            //     if (value == null || value.isEmpty) {
                            //       return 'Please enter the PIN code';
                            //     }
                            //     return null;
                            //   },
                            // ),
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
                              labelText: "Cow Count",
                              hintText: "Enter the number of cows",
                              icon: Icons.pets,
                              controller: _cowCountController,
                              keyboardType: TextInputType.number,
                              inputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
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
                              inputFormatter: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
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
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color:
              isDarkMode(context) ? AppColors.kDarkContiner : AppColors.kWhite,
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
                text: "Update",
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
      'farmer_id': widget.farmer.id,
      'promotion_activity': _selectedActivity?.id,
      'farmer_name': _nameController.text,
      'father_name': _fatherNameController.text,
      'mobile_no': _mobileController.text,
      'acre': _acreController.text,
      'pin': _selectedPin?.pin,
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
      await farmerController.editFarmer(parameters);
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
