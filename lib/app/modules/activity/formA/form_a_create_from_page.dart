import 'dart:developer';
import 'dart:io';

import 'package:field_asistence/app/model/master/product_master.dart';
import 'package:field_asistence/app/model/master/season_model.dart';
import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../controllers/master_controller.dart/crop_controller.dart';
import '../../../data/constrants/constants.dart';
import '../../../data/helpers/data/image_doctor_url.dart';
import '../../../model/master/crop_model.dart';
import '../../../model/master/crop_stage.dart';
import '../../../model/master/pest_master.dart';
import '../../../model/master/villages_model.dart';
import '../../doctor/model/doctor_list.dart';
import '../../farmer/model/farmer_list.dart';
import '../../widgets/dialog/confirmation.dart';
import '../../widgets/dialog/error.dart';
import '../../widgets/dialog/loading.dart';
import '../../widgets/dialog/success.dart';
import '../../widgets/form_field.dart/form_field.dart';
import '../../widgets/form_field.dart/form_hader.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../../widgets/widgets.dart';
import '../components/expanded_object.dart';
import '../components/single_select_dropdown/activity_master_dropdown.dart';
import '../components/multi_select_dropdown/doctor_selection_dropdown.dart';
import '../components/multi_select_dropdown/farmer_selection_dropdown.dart';
import '../components/geo_location_selection_page.dart';
import '../components/multi_select_dropdown/seasion_selection_dropdown.dart';
import '../components/multi_select_dropdown/village_multi_selecton_dropdown.dart';
import '../components/single_select_dropdown/crop_selection_single.dart';
import '../components/single_select_dropdown/cropstage_single_dropdown.dart';
import '../components/single_select_dropdown/pests_single-dropdown.dart';
import '../components/single_select_dropdown/product_selection_autofill.dart';
import '../controller/form_a_controller.dart';
import '../model/activity_master_model.dart';

class CreateFormApage extends StatefulWidget {
  const CreateFormApage({super.key});

  @override
  State<CreateFormApage> createState() => _CreateFormApageState();
}

class _CreateFormApageState extends State<CreateFormApage> {
  List<ActivityObject> activityObjects = [];
  final FormAController _formAController = Get.put(FormAController());
  final CropController _cropController = Get.put(CropController());

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _selectionCountController =
      TextEditingController();

  ActivityMaster? _selectedActivity;

  String? selectedPartyType;

  List<String>? selectedPartyNameListId;

  List<Village> selectedVillages = [];
  List<Farmer> selectedFarmers = [];
  List<Doctor> selectedDoctors = [];

  //check if the selected items are valid set a sting that store selected items id,
  //switch case functio to check  if (selectedPartyType == "Farmer")
  //then set the selectedFarmers id to the string
  //else if (selectedPartyType == "Village")
  //then set the selectedVillages id to the string
  //else if (selectedPartyType == "Doctor")
  //then set the selectedDoctors id to the string
  //then pass the string to the parameters
  // give me function switch case to check the selectedPartyType and set the selected items id to the string
  void checkSelectedPartyType() {
    switch (selectedPartyType) {
      case "Farmer":
        selectedPartyNameListId =
            selectedFarmers.map((e) => e.id.toString()).toList();
        break;
      case "Village":
        selectedPartyNameListId =
            selectedVillages.map((e) => e.id.toString()).toList();
        break;
      case "Doctor":
        selectedPartyNameListId =
            selectedDoctors.map((e) => e.id.toString()).toList();
        break;
    }
  }

  List<Season> selectedSeasons = [];

  // Crop? selectedCrop;
  // CropStage? selectedCropStage;
  // ProductMaster? selectedProductmaster;
  // Pest? selectedPest;

  String? totalSelectedPertyType;
  String? _selectedImagePath;
  File? attachment;
  LocationData? gioLocation;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      log('Picked file path: ${pickedFile.path}');

      setState(() {
        _selectedImagePath = pickedFile.path;
        attachment = File(pickedFile.path);
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
  void initState() {
    super.initState();
    addNewObject();
  }

  void addNewObject() {
    setState(() {
      activityObjects.add(ActivityObject());
    });
  }

  void removeObject(int index) {
    setState(() {
      activityObjects.removeAt(index);
    });
  }

  void _loadNewData(List<int> seasonId) {
    if (seasonId.isNotEmpty) {
      _cropController.loadCrops(seasonId);
    }
  }

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
          'Create Activity Form',
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
              image: ImageDoctorUrl.farmerGroupMeating,
              header: 'Activity Form',
              subtitle: 'Fill in the details to create a new activity form',
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimaryContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomHeaderText(
                              text: 'Activity\'s Basic Details',
                              fontSize: 20.sp,
                            ),
                            SizedBox(height: 16.h),
                            ActivitySelectionWidget(
                              formType: "A",
                              selectedItem: _selectedActivity,
                              onSaved: (selectedActivity) {
                                setState(() {
                                  _selectedActivity = selectedActivity;

                                  if (_selectedActivity != null) {
                                    selectedPartyType =
                                        _selectedActivity!.masterLink;
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
                              CustomTextField(
                                readonly: true,
                                labelText: 'Selected Party Type',
                                hintText: 'Selected Party Type',
                                icon: Icons.person,
                                controller: TextEditingController(
                                  text: selectedPartyType ?? '',
                                ),
                                keyboardType: TextInputType.text,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select a party type';
                                  }
                                  return null;
                                },
                                maxLines: 1,
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
                                selectedItems: selectedFarmers,
                              ),
                            ] else if (selectedPartyType == "Village") ...[
                              VillageSelectionScreen(
                                onSelectionChanged: (selectedVillagesitems) {
                                  setState(() {
                                    selectedVillages = selectedVillagesitems;
                                    _updateSelectionCount();
                                  });
                                },
                                selectedItems: selectedVillages,
                              ),
                            ] else if (selectedPartyType == "Doctor") ...[
                              DoctorSelectionScreen(
                                onSelectionChanged: (selectedDoctorsitems) {
                                  setState(() {
                                    selectedDoctors = selectedDoctorsitems;
                                    _updateSelectionCount();
                                  });
                                },
                                selectedItems: selectedDoctors,
                              ),
                            ],
                            const SizedBox(height: 16),
                            CustomTextField(
                              readonly: true,
                              labelText: 'Total Selected Items',
                              hintText: 'Total Selected Items',
                              icon: Icons.bar_chart_outlined,
                              controller: _selectionCountController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the total selected items';
                                }
                                return null;
                              },
                              maxLines: 1,
                            ),
                            const SizedBox(height: 16),
                            SeasionSelectionScreen(
                              onSelectionChanged: (selectedSeasonsitems) {
                                setState(() {
                                  selectedSeasons = selectedSeasonsitems;
                                });
                                if (selectedSeasons.isNotEmpty) {
                                  _loadNewData(selectedSeasons
                                      .map((season) => season.id)
                                      .toList());
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...activityObjects.asMap().entries.map(
                        (entry) {
                          final index = entry.key;
                          final activityObject = entry.value;
                          return ExpandedObject(
                            title: 'Product\'s Details ${index + 1}',
                            onDismissed: () => removeObject(index),
                            isExpanded: true,
                            onExpansionChanged: (isExpanded) {
                              return true;
                            },
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProductMasterSelector(
                                    labelText: 'Select Products',
                                    icon: Icons.arrow_drop_down,
                                    onChanged: (selectedProduct) {
                                      setState(() {
                                        // selectedProductmaster = selectedProduct;
                                        activityObject.product =
                                            selectedProduct;
                                      });
                                    },
                                    selectedItem: activityObject.product,
                                    itemAsString: (product) =>
                                        product.materialDescription,
                                  ),
                                  const SizedBox(height: 16),
                                  if (selectedSeasons.isNotEmpty)
                                    CropSingleSelectionWidget(
                                      seasonId: selectedSeasons
                                          .map((season) => season.id)
                                          .toList(),
                                      onSaved: (selectedCrop) {
                                        setState(() {
                                          // this.selectedCrop = selectedCrop;
                                          activityObject.crop = selectedCrop;
                                        });
                                      },
                                      // selectedItem: selectedCrop,
                                      selectedItem: activityObject.crop,
                                      validator: (selectedCrop) {
                                        if (selectedCrop == null) {
                                          return 'Please select a crop';
                                        }
                                        return null;
                                      },
                                    )
                                  else
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: Colors.red[100],
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Text(
                                        'Please select a season first',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                  const SizedBox(height: 16),
                                  CropStageSingleSelectionWidget(
                                    selectedItem: activityObject.cropStage,
                                    onCropStageSelected:
                                        (selectedCropStagesitem) {
                                      setState(() {
                                        activityObject.cropStage =
                                            selectedCropStagesitem;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  PestSingleSelectionWidget(
                                    selectedItem: activityObject.pest,
                                    onPestSelected: (selectedPestsitem) {
                                      setState(() {
                                        activityObject.pest = selectedPestsitem;
                                      });
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  CustomTextField(
                                    labelText: 'Expense',
                                    hintText: 'Enter the expense',
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,2}'),
                                      ),
                                      LengthLimitingTextInputFormatter(10),
                                    ],
                                    icon: Icons.currency_rupee_rounded,
                                    controller:
                                        activityObject.expenseController,
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter the expense';
                                      }
                                      return null;
                                    },
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                      PrimaryButton(
                        color: AppColors.kSecondary,
                        isBorder: true,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            addNewObject();
                          }
                        },
                        text: 'Add More Products',
                      ),
                      SizedBox(height: 16.h),
                      PrimaryContainer(
                        child: Column(
                          children: [
                            CustomHeaderText(
                              text: 'Activity\'s Other\'s Details',
                              fontSize: 20.sp,
                            ),
                            SizedBox(height: 16.h),
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
                                      ? AppColors.kContentColor
                                      : AppColors.kInput,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: Colors.grey,
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
                                          borderRadius:
                                              BorderRadius.circular(10.r),
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
                      SizedBox(height: 16.h),
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
                    _showConfirmationDialog(context);
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

  Future<void> _submitForm() async {
    Get.dialog(const LoadingDialog(), barrierDismissible: false);

    try {
      // Prepare parameters
      final parameters = {
        'promotional_activity_type': _selectedActivity?.id,
        'party_type': selectedPartyType,
        'remarks': _remarksController.text,
        'latitude': gioLocation?.latitude ?? '',
        'longitude': gioLocation?.longitude ?? '',
        'party_name[]': selectedPartyNameListId,
        'season[]': selectedSeasons.map((e) => e.id.toString()).toList(),
        'crop[]': activityObjects.map((e) => e.crop!.id.toString()).toList(),
        'crop_stage[]':
            activityObjects.map((e) => e.cropStage!.id.toString()).toList(),
        'product[]': activityObjects
            .map((e) => e.product!.materialNumber.toString())
            .toList(),
        'pest[]': activityObjects.map((e) => e.pest!.id.toString()).toList(),
        'expense[]':
            activityObjects.map((e) => e.expenseController.text).toList(),
      };

      await _formAController.submitActivityAFormData(
        'createFormA',
        parameters,
        _selectedImagePath != null ? File(_selectedImagePath!) : null,
      );

      // On success
      Get.dialog(
          SuccessDialog(
            message: 'Form submitted successfully',
            onClose: () {
              Get.back(); // Close success dialog
              Get.back(); // Close form page
            },
          ),
          barrierDismissible: false);
    } catch (e) {
      // On error
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

class ActivityObject {
  ProductMaster? product;
  Crop? crop;
  CropStage? cropStage;
  Pest? pest;
  TextEditingController expenseController;

  ActivityObject({
    this.product,
    this.crop,
    this.cropStage,
    this.pest,
    TextEditingController? expenseController,
  }) : expenseController = expenseController ?? TextEditingController();

  // bool validate() {
  //   return product.isNotEmpty && crop.isNotEmpty && cropStage.isNotEmpty && pest.isNotEmpty && expenseController.text.isNotEmpty;
  // }
}
