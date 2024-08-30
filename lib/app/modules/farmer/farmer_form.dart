import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../data/constrants/constants.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/form_field.dart/form_field.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'components/image_picker_continer.dart';

class FarmerForm extends StatefulWidget {
  const FarmerForm({super.key});

  @override
  State<FarmerForm> createState() => _FarmerFormState();
}

class _FarmerFormState extends State<FarmerForm> {
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
  String? _selectedPromotionActivity;
  String? _imagePath;

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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedDateController.text =
            DateFormat('dd/MM/yyyy').format(pickedDate);
        log('Selected Date: ${_selectedDateController.text}');
      });
    }
  }

  void _handleImagePicked(String imagePath) {
    setState(() {
      _imagePath = imagePath;
      log("Image Path: $_imagePath");
    });
  }

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                AppAssets.kOnboardingFirst,
              ),
              fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                PicProfileImgWidget(
                  onImagePicked: _handleImagePicked,
                ),
                SizedBox(height: 20.h),
                // Basic Details Section
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
                      CustomDropdownField(
                        labelText: "Promotion Activity",
                        icon: Icons.star,
                        items: const ["Activity 1", "Activity 2", "Activity 3"],
                        onChanged: (value) {
                          setState(() {
                            _selectedPromotionActivity = value;
                          });
                        },
                        value: _selectedPromotionActivity,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select a promotion activity';
                          }
                          return null;
                        },
                      ),
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
                      CustomTextField(
                        labelText: "Village/Locality",
                        hintText: "Enter village/locality",
                        icon: Icons.location_city,
                        controller: _villageController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the village/locality';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the number of acres';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      CustomTextField(
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
                      CustomDatePicker(
                        labelText: "Date of Registration",
                        icon: Icons.calendar_today,
                        textEditingController: _selectedDateController,
                        onDateSelected: _selectDate,
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
                    // Handle form submission
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
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
}
