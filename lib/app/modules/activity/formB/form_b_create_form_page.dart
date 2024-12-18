import 'package:field_asistence/app/model/master/product_master.dart';
import 'package:field_asistence/app/model/master/season_model.dart';
import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controllers/master_controller.dart/crop_controller.dart';
import '../../../controllers/master_controller.dart/crop_stage_controller.dart';
import '../../../controllers/master_controller.dart/pest_controller.dart';
import '../../../data/constrants/constants.dart';
import '../../../data/helpers/data/image_doctor_url.dart';
import '../../../model/master/crop_model.dart';
import '../../../model/master/crop_stage.dart';
import '../../../model/master/pest_master.dart';
import '../../../model/master/villages_model.dart';
import '../../route_plan/model/route_list.dart';
import '../../widgets/dialog/confirmation.dart';
import '../../widgets/dialog/error.dart';
import '../../widgets/dialog/loading.dart';
import '../../widgets/form_field.dart/form_field.dart';
import '../../widgets/form_field.dart/form_hader.dart';
import '../../widgets/form_field.dart/single_selected_dropdown.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../../widgets/widgets.dart';
import '../components/expanded_object.dart';
import '../components/multi_select_dropdown/route_selection_dropdown.dart';
import '../components/single_select_dropdown/activity_master_dropdown.dart';
import '../components/multi_select_dropdown/seasion_selection_dropdown.dart';
import '../components/multi_select_dropdown/village_multi_selecton_dropdown.dart';
import '../components/single_select_dropdown/product_selection_autofill.dart';
import '../controller/form_a_controller.dart';
import '../model/activity_master_model.dart';

class CreateFormBpage extends StatefulWidget {
  const CreateFormBpage({super.key});

  @override
  State<CreateFormBpage> createState() => _CreateFormBpageState();
}

class _CreateFormBpageState extends State<CreateFormBpage> {
  final FormAController _formAController = Get.put(FormAController());
  final CropController _cropController = Get.put(CropController());
  final PestController _pestController = Get.put(PestController());
  final CropStageController _cropStageController =
      Get.put(CropStageController());

  final _formKey = GlobalKey<FormState>();
  List<ActivityObject> activityObjects = [ActivityObject()];
  final TextEditingController _remarksController = TextEditingController();

  ActivityMaster? _selectedActivity;
  String? selectedPartyType;

  String? totalSelectedPertyType;

  List<Village> selectedVillages = [];

  List<RouteMaster> selectedRoutes = [];

  List<Season> selectedSeasons = [];

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  void initState() {
    super.initState();
    _cropStageController.loadCropStages();
    _pestController.loadPests();
  }

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
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
          'Create Jeep Campaign Form',
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
              header: 'Jeep Campaign',
              subtitle: 'Fill in the form to create a new Jeep Campaign',
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
                              formType: "B",
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
                            if (selectedPartyType == "Village") ...[
                              VillageSelectionScreen(
                                onSelectionChanged: (selectedVillagesitems) {
                                  setState(() {
                                    selectedVillages = selectedVillagesitems;
                                  });
                                },
                                selectedItems: selectedVillages,
                              ),
                            ],
                            const SizedBox(height: 16),
                            //print text in list of selected items in id selectedPartyNameListId
                            if (selectedVillages.isNotEmpty) ...[
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  'Selected Party Name Ids: ${selectedVillages.map((village) => village.id.toString()).join(', ')}',
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],

                            RouteSelectionScreen(
                              onSelectionChanged: (selectedRoutesItem) {
                                setState(() {
                                  selectedRoutes = selectedRoutesItem;
                                });
                              },
                              selectedItems: selectedRoutes,
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
                                  //clear the crop
                                  for (var element in activityObjects) {
                                    element.crop = null;
                                    element.cropStage = null;
                                    element.product = null;
                                    element.pest = null;
                                  }
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
                                    selectedItem: activityObject.product,
                                    onChanged: (selectedProduct) {
                                      setState(() {
                                        activityObject.product =
                                            selectedProduct;
                                      });
                                    },
                                    itemAsString: (product) =>
                                        product.materialDescription,
                                  ),
                                  const SizedBox(height: 16),
                                  if (selectedSeasons.isNotEmpty)
                                    Obx(() {
                                      if (_cropController.isLoading.value) {
                                        return const ShimmerLoading();
                                      } else if (_cropController
                                              .isError.value ||
                                          _cropController
                                              .errorMessage.isNotEmpty) {
                                        return Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.red[100],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border:
                                                Border.all(color: Colors.red),
                                          ),
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: Text('Error loading crop'),
                                          ),
                                        );
                                      } else {
                                        return SingleSelectDropdown<Crop>(
                                          labelText: "Select Crop",
                                          items: _cropController.crops,
                                          selectedItem: activityObject.crop,
                                          itemAsString: (crop) =>
                                              crop.name ?? '',
                                          onChanged: (selected) {
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              setState(() {
                                                activityObject.crop = selected;
                                              });
                                            });
                                          },
                                          searchableFields: {
                                            "name": (crop) => crop.name ?? '',
                                            "code": (crop) => crop.code ?? '',
                                          },
                                          validator: (selectedPopMaterial) {
                                            if (selectedPopMaterial == null) {
                                              return 'Please select a crop';
                                            }
                                            return null;
                                          },
                                        );
                                      }
                                    })
                                  else
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Select Crop',
                                        ),
                                        SizedBox(height: 8.h),
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Colors.red[100],
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            border:
                                                Border.all(color: Colors.red),
                                          ),
                                          child: const Text(
                                            'Please select a season first',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  const SizedBox(height: 16),
                                  Obx(() {
                                    if (_cropStageController.isLoading.value) {
                                      return const ShimmerLoading();
                                    } else if (_cropStageController
                                            .isError.value ||
                                        _cropStageController
                                            .errorMessage.isNotEmpty) {
                                      return Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.red[100],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child:
                                              Text('Error loading crop stages'),
                                        ),
                                      );
                                    } else {
                                      return SingleSelectDropdown<CropStage>(
                                        labelText: "Select Crop Stage",
                                        items: _cropStageController.cropStages,
                                        selectedItem: activityObject.cropStage,
                                        itemAsString: (cropStages) =>
                                            cropStages.name,
                                        onChanged: (selected) {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            setState(() {
                                              activityObject.cropStage =
                                                  selected;
                                            });
                                          });
                                        },
                                        searchableFields: {
                                          "name": (cropStages) =>
                                              cropStages.name,
                                          "code": (cropStages) =>
                                              cropStages.code,
                                        },
                                        validator: (selectedPopMaterial) {
                                          if (selectedPopMaterial == null) {
                                            return 'Please select a crop Stages';
                                          }
                                          return null;
                                        },
                                      );
                                    }
                                  }),
                                  const SizedBox(height: 16),
                                  Obx(() {
                                    if (_pestController.isLoading.value) {
                                      return const ShimmerLoading();
                                    } else if (_pestController.isError.value ||
                                        _pestController
                                            .errorMessage.isNotEmpty) {
                                      return Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.red[100],
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text('Error loading pests'),
                                        ),
                                      );
                                    } else {
                                      return SingleSelectDropdown<Pest>(
                                        labelText: "Select Pest",
                                        items: _pestController.pests,
                                        selectedItem: activityObject.pest,
                                        itemAsString: (pest) => pest.pest,
                                        onChanged: (selected) {
                                          WidgetsBinding.instance
                                              .addPostFrameCallback((_) {
                                            setState(() {
                                              activityObject.pest = selected;
                                            });
                                          });
                                        },
                                        searchableFields: {
                                          "pest": (pest) => pest.pest,
                                          "code": (pest) => pest.code,
                                        },
                                        validator: (selectedPopMaterial) {
                                          if (selectedPopMaterial == null) {
                                            return 'Please select a pest';
                                          }
                                          return null;
                                        },
                                      );
                                    }
                                  }),
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
                          if (_formKey.currentState?.validate() ?? false) {
                            bool allValid = true;

                            for (var activityObject in activityObjects) {
                              if (!activityObject.validate()) {
                                allValid = false;
                                Get.snackbar('Error',
                                    'Please complete all fields before adding more.');
                                break;
                              }
                            }

                            if (allValid) {
                              addNewObject();
                            }
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
                            CustomTextField(
                              labelText: 'Remarks',
                              hintText: 'Enter remarks',
                              icon: Icons.comment,
                              controller: _remarksController,
                              keyboardType: TextInputType.text,
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
                    for (var activityObject in activityObjects) {
                      if (!activityObject.validate()) {
                        Get.snackbar('Error',
                            'Please fill all fields before submitting.');
                        return;
                      }
                    }
                    _showConfirmationDialog(context);
                  }
                  // Get.snackbar(
                  //   'Error',
                  //   'Please fill all fields before submitting.',
                  //   snackPosition: SnackPosition.BOTTOM,
                  // );
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
      final parameters = {
        'promotional_activity_type': _selectedActivity?.id.toString() ?? '',
        'party_type': selectedPartyType ?? '',
        'remarks': _remarksController.text,
      };
      List<MapEntry<String, String>> fields = [];

      for (var id in selectedVillages) {
        fields.add(MapEntry('party_name[]', id.id.toString()));
      }

      // route_code[]

      for (var route in selectedRoutes) {
        fields.add(MapEntry('route_code[]', route.id.toString()));
      }

      for (var season in selectedSeasons) {
        fields.add(MapEntry('season[]', season.id.toString()));
      }

      for (var activity in activityObjects) {
        fields.add(MapEntry('crop[]', activity.crop!.id.toString()));
        fields.add(MapEntry('crop_stage[]', activity.cropStage!.id.toString()));
        fields.add(
            MapEntry('product[]', activity.product!.materialNumber.toString()));
        fields.add(MapEntry('pest[]', activity.pest!.id.toString()));
      }

      await _formAController.submitActivityAFormData(
        'createFormB',
        parameters,
        fields,
      );

      // // clear all data
      // _selectedActivity = null;
      // selectedPartyType = null;
      // selectedVillages.clear();
      // selectedSeasons.clear();
      // activityObjects.clear();
      // activityObjects.add(ActivityObject());
      // _remarksController.clear();
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

  bool validate() {
    if (product == null || crop == null || cropStage == null || pest == null) {
      return false;
    }
    return true;
  }
}
