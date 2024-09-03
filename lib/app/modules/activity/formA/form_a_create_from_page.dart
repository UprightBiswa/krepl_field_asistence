import 'dart:developer';
import 'dart:io';

import 'package:field_asistence/app/model/master/product_master.dart';
import 'package:field_asistence/app/model/master/season_model.dart';
import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/constrants/constants.dart';
import '../../../model/master/crop_model.dart';
import '../../../model/master/crop_stage.dart';
import '../../../model/master/pest_master.dart';
import '../../../model/master/villages_model.dart';
import '../../doctor/model/doctor_list.dart';
import '../../farmer/model/farmer_list.dart';
import '../../widgets/form_field.dart/form_field.dart';
import '../../widgets/widgets.dart';
import '../components/single_select_dropdown/activity_master_dropdown.dart';
import '../components/multi_select_dropdown/crop_selection_dropdown.dart';
import '../components/multi_select_dropdown/doctor_selection_dropdown.dart';
import '../components/multi_select_dropdown/farmer_selection_dropdown.dart';
import '../components/geo_location_selection_page.dart';
import '../components/multi_select_dropdown/pest_selection_dropdown.dart';
import '../components/multi_select_dropdown/products_selection_drodown.dart';
import '../components/multi_select_dropdown/seasion_selection_dropdown.dart';
import '../components/multi_select_dropdown/stages_selection_dropdown.dart';
import '../components/multi_select_dropdown/village_multi_selecton_dropdown.dart';
import '../model/activity_master_model.dart';

class CreateFormApage extends StatefulWidget {
  const CreateFormApage({super.key});

  @override
  State<CreateFormApage> createState() => _CreateFormApageState();
}

class _CreateFormApageState extends State<CreateFormApage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _expenseController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _selectionCountController =
      TextEditingController();

  ActivityMaster? _selectedActivity;
  String? selectedPartyType;

  List<Village> selectedVillages = [];
  List<Farmer> selectedFarmers = [];
  List<Doctor> selectedDoctors = [];
  List<Season> selectedSeasions = [];
  List<Crop> selectedCrops = [];
  List<CropStage> selectedCropStages = [];
  List<ProductMaster> selectedProducts = [];
  List<Pest> selectedPests = [];

  String? totalSelectedPertyType;
  String? _selectedImagePath;
  LocationData? gioLocation;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      log('Picked file path: ${pickedFile.path}');

      setState(() {
        _selectedImagePath = pickedFile.path;
      });

      // Pass the image path to the callback
      // You can store this path to send it in an API later.
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('No image selected'),
        ),
      );
    }
  }

  void _showImagePickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Pick from gallery'),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Take a photo'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateSelectionCount() {
    int count = 0;
    if (selectedPartyType == "Farmer") {
      count = selectedFarmers.length;
    } else if (selectedPartyType == "Village") {
      count = selectedVillages.length;
    } else if (selectedPartyType == "Doctor") {
      count = selectedDoctors.length;
    }

    _selectionCountController.text = count.toString();
  }

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Activity", style: AppTypography.kBold14),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PrimaryContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ActivitySelectionWidget(
                      formType: "A",
                      onSaved: (selectedActivity) {
                        setState(() {
                          _selectedActivity = selectedActivity;

                          if (_selectedActivity != null) {
                            selectedPartyType = _selectedActivity!.masterLink;
                          }
                        });
                      },
                      validator: (selectedActivity) {
                        if (selectedActivity == null) {
                          return 'Please select an activity';
                        }
                        return null;
                      },
                    ),

                    if (_selectedActivity != null) ...[
                      SizedBox(height: 16.h),
                      Text(
                        'Selected Partytype: ${_selectedActivity!.masterLink}',
                      ),
                      SizedBox(height: 16.h),
                    ],
                    // Conditional Fields based on the selected party type
                    if (selectedPartyType == "Farmer") ...[
                      FarmerSelectionScreen(
                        onSelectionChanged: (selectedFarmersitems) {
                          setState(() {
                            selectedFarmers = selectedFarmersitems;
                            _updateSelectionCount();
                          });
                        },
                      ),
                    ] else if (selectedPartyType == "Village") ...[
                      VillageSelectionScreen(
                        onSelectionChanged: (selectedVillagesitems) {
                          setState(() {
                            selectedVillages = selectedVillagesitems;
                            _updateSelectionCount();
                          });
                        },
                      ),
                    ] else if (selectedPartyType == "Doctor") ...[
                      DoctorSelectionScreen(
                        onSelectionChanged: (selectedDoctorsitems) {
                          setState(() {
                            selectedDoctors = selectedDoctorsitems;
                            _updateSelectionCount();
                          });
                        },
                      ),
                    ],
                    const SizedBox(height: 16),

                    TextFormField(
                      controller: _selectionCountController,
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: isDarkMode(context)
                            ? AppColors.kContentColor
                            : AppColors.kInput,
                        filled: true,
                        prefixIcon: const Icon(Icons.bar_chart_outlined,
                            color: AppColors.kPrimary),
                        labelText: 'Total Selected Items',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              PrimaryContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SeasionSelectionScreen(
                      onSelectionChanged: (selectedSeasionsitems) {
                        setState(() {
                          selectedSeasions = selectedSeasionsitems;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    CropSelectionScreen(
                      onSelectionChanged: (selectedCropsitems) {
                        setState(() {
                          selectedCrops = selectedCropsitems;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    CropStageSelectionScreen(
                      onSelectionChanged: (selectedCropStagesitems) {
                        setState(() {
                          selectedCropStages = selectedCropStagesitems;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    ProductMasterSelectionScreen(
                      onSelectionChanged: (selectedProductsitems) {
                        setState(() {
                          selectedProducts = selectedProductsitems;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    PestSelectionScreen(
                      onSelectionChanged: (selectedPestsitems) {
                        setState(() {
                          selectedPests = selectedPestsitems;
                        });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              PrimaryContainer(
                child: Column(
                  children: [
                    CustomTextField(
                      labelText: 'Expense',
                      hintText: 'Enter the expense',
                      icon: Icons.currency_rupee_rounded,
                      controller: _expenseController,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter the expense';
                        }
                        return null;
                      },
                      maxLines: 1,
                    ),
                    const SizedBox(height: 16),
                    GeoLocationInputField(
                      onLocationSelected: (selectedAddress) {
                        setState(() {
                          gioLocation = selectedAddress;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => _showImagePickerOptions(context),
                      child: Container(
                        height: 150.h,
                        width: double.infinity,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: isDarkMode(context)
                              ? Colors.grey[800]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                            color: AppColors.kPrimary,
                            width: 2,
                          ),
                        ),
                        child: _selectedImagePath == null
                            ? Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 50.sp,
                                  color: AppColors.kPrimary,
                                ),
                              )
                            : Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                                child: Image.file(
                                  File(_selectedImagePath!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextField(
                      labelText: 'Remarks',
                      hintText: 'Enter remarks',
                      icon: Icons.comment,
                      controller: _remarksController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter remarks';
                        }
                        return null;
                      },
                      maxLines: 3,
                    ),
                  ],
                ),
              ),
            ],
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
                    // Handle form submission logic here
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
