// import 'dart:developer';
// import 'dart:io';
// import 'package:field_asistence/app/model/master/demo_status_model.dart';
// import 'package:field_asistence/app/model/master/product_master.dart';
// import 'package:field_asistence/app/model/master/result_model.dart';
// import 'package:field_asistence/app/model/master/season_model.dart';
// import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';
// import '../../../controllers/master_controller.dart/crop_controller.dart';
// import '../../../controllers/master_controller.dart/crop_stage_controller.dart';
// import '../../../controllers/master_controller.dart/get_demo_result.dart';
// import '../../../controllers/master_controller.dart/get_demo_status.dart';
// import '../../../controllers/master_controller.dart/pest_controller.dart';
// import '../../../data/constrants/constants.dart';
// import '../../../data/helpers/data/image_doctor_url.dart';
// import '../../../model/master/crop_model.dart';
// import '../../../model/master/crop_stage.dart';
// import '../../../model/master/pest_master.dart';
// import '../../farmer/model/farmer_list.dart';
// import '../../widgets/dialog/confirmation.dart';
// import '../../widgets/dialog/error.dart';
// import '../../widgets/dialog/loading.dart';
// import '../../widgets/form_field.dart/form_field.dart';
// import '../../widgets/form_field.dart/form_hader.dart';
// import '../../widgets/form_field.dart/single_selected_dropdown.dart';
// import '../../widgets/texts/custom_header_text.dart';
// import '../../widgets/widgets.dart';
// import '../components/expanded_object.dart';
// import '../components/multi_select_dropdown/farmer_selection_dropdown.dart';
// import '../components/single_select_dropdown/activity_master_dropdown.dart';
// import '../components/geo_location_selection_page.dart';
// import '../components/multi_select_dropdown/seasion_selection_dropdown.dart';
// import '../components/single_select_dropdown/product_selection_autofill.dart';
// import '../controller/form_a_controller.dart';
// import '../model/activity_master_model.dart';

// class CreateFormDpage extends StatefulWidget {
//   const CreateFormDpage({super.key});

//   @override
//   State<CreateFormDpage> createState() => _CreateFormDpageState();
// }

// class _CreateFormDpageState extends State<CreateFormDpage> {
//   final FormAController _formAController = Get.put(FormAController());
//   final CropController _cropController = Get.put(CropController());
//   final PestController _pestController = Get.put(PestController());
//   final CropStageController _cropStageController =
//       Get.put(CropStageController());

//   final GetDomoResultController _getDomoResultController =
//       Get.put(GetDomoResultController());
//   final GetDomoStausController _getDomoStausController =
//       Get.put(GetDomoStausController());

//   final _formKey = GlobalKey<FormState>();
//   List<ActivityObject> activityObjects = [ActivityObject()];
//   //date text controller for next demo date
//   final TextEditingController _dateController = TextEditingController();
//   final TextEditingController _remarksController = TextEditingController();
//   final TextEditingController _activityDateController = TextEditingController();

//   final TextEditingController _activityLocationController =
//       TextEditingController();
//   ActivityMaster? _selectedActivity;
//   String? selectedPartyType;

//   String? totalSelectedPertyType;
//   String? _selectedImagePath;
//   File? attachment;
//   LocationData? gioLocation;
//   //make a date selcted date veriable // date fromate yyyy-mm-dd
//   DateTime selectedDate = DateTime.now();
//   DateTime selectedactivityDate = DateTime.now();
//   List<Farmer> selectedFarmers = [];

//   List<Season> selectedSeasons = [];

//   Future<void> _pickImage(ImageSource source) async {
//     final pickedFile = await ImagePicker().pickImage(source: source);
//     if (pickedFile != null) {
//       log('Picked file path: ${pickedFile.path}');

//       setState(() {
//         _selectedImagePath = pickedFile.path;
//         attachment = File(pickedFile.path);
//       });
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text('No image selected'),
//         ),
//       );
//     }
//   }

//   void _showImagePickerOptions(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       builder: (BuildContext context) {
//         return SafeArea(
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: const Icon(Icons.photo_library),
//                 title: const Text('Pick from gallery'),
//                 onTap: () {
//                   _pickImage(ImageSource.gallery);
//                   Navigator.of(context).pop();
//                 },
//               ),
//               ListTile(
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text('Take a photo'),
//                 onTap: () {
//                   _pickImage(ImageSource.camera);
//                   Navigator.of(context).pop();
//                 },
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   bool isDarkMode(BuildContext context) =>
//       Theme.of(context).brightness == Brightness.dark;
//   @override
//   void initState() {
//     super.initState();
//     _dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
//     _activityDateController.text =
//         DateFormat('dd-MM-yyyy').format(selectedactivityDate);
//     _cropStageController.loadCropStages();
//     _pestController.loadPests();
//     _getDomoResultController.loaddemoResultData();
//     _getDomoStausController.loadDemoStatusData();
//   }

//   Future<void> _selectDateRange(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       firstDate: DateTime(2017, 1),
//       lastDate: DateTime(9999, 12),
//       helpText: 'Select Date',
//     );

//     if (pickedDate != null) {
//       setState(() {
//         selectedDate = pickedDate;
//         _dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
//       });
//     }
//   }

//   Future<void> _selectActivityDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       firstDate: DateTime(2017, 1),
//       lastDate: DateTime(9999, 12),
//       helpText: 'Select Date',
//     );

//     if (pickedDate != null) {
//       setState(() {
//         selectedactivityDate = pickedDate;
//         _activityDateController.text =
//             DateFormat('dd-MM-yyyy').format(selectedactivityDate);
//       });
//     }
//   }

//   @override
//   void dispose() {
//     _remarksController.dispose();
//     _dateController.dispose();

//     _activityDateController.dispose();
//     _activityLocationController.dispose();

//     for (var object in activityObjects) {
//       object.expenseController.dispose();
//       object.dosageController.dispose();
//       object.areaController.dispose();
//       object.totalAreaController.dispose();
//     }
//     super.dispose();
//   }

//   void addNewObject() {
//     setState(() {
//       activityObjects.add(ActivityObject());
//     });
//   }

//   void removeObject(int index) {
//     setState(() {
//       activityObjects.removeAt(index);
//     });
//   }

//   void _loadNewData(List<int> seasonId) {
//     if (seasonId.isNotEmpty) {
//       _cropController.loadCrops(seasonId);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: CustomBackAppBar(
//         leadingCallback: () {
//           Get.back<void>();
//         },
//         iconColor: isDarkMode(context)
//             ? Colors.black
//             : AppColors.kPrimary.   withValues(alpha:0.15),
//         title: Text(
//           'Create Demo',
//           style: AppTypography.kBold24.copyWith(color: AppColors.kWhite),
//         ),
//       ),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: Stack(
//           children: [
//             const FormImageHeader(
//               tag: 'form',
//               image: ImageDoctorUrl.farmerGroupMeating,
//               header: 'Create Demo',
//               subtitle: 'Fill in the form below to create a new demo',
//             ),
//             Positioned(
//               top: 228.h,
//               left: 2.w,
//               right: 2.w,
//               bottom: 0,
//               child: Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   padding: EdgeInsets.symmetric(horizontal: 18.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       PrimaryContainer(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             CustomHeaderText(
//                               text: 'Basic Details',
//                               fontSize: 20.sp,
//                             ),
//                             SizedBox(height: 16.h),
//                             ActivitySelectionWidget(
//                               formType: "D",
//                               selectedItem: _selectedActivity,
//                               onSaved: (selectedActivity) {
//                                 setState(() {
//                                   _selectedActivity = selectedActivity;

//                                   if (_selectedActivity != null) {
//                                     selectedPartyType =
//                                         _selectedActivity!.masterLink;
//                                   }
//                                 });
//                               },
//                               validator: (selectedActivity) {
//                                 if (selectedActivity == null) {
//                                   return 'Please select an activity';
//                                 }
//                                 return null;
//                               },
//                             ),

//                             if (_selectedActivity != null) ...[
//                               SizedBox(height: 16.h),
//                               CustomTextField(
//                                 readonly: true,
//                                 labelText: 'Selected Party Type',
//                                 hintText: 'Selected Party Type',
//                                 icon: Icons.person,
//                                 controller: TextEditingController(
//                                   text: selectedPartyType ?? '',
//                                 ),
//                                 keyboardType: TextInputType.text,
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please select a party type';
//                                   }
//                                   return null;
//                                 },
//                                 maxLines: 1,
//                               ),
//                               SizedBox(height: 16.h),
//                             ],
//                             // Conditional Fields based on the selected party type
//                             if (selectedPartyType == "Farmer") ...[
//                               FarmerSelectionScreen(
//                                 onSelectionChanged: (selectedFarmersitems) {
//                                   setState(() {
//                                     selectedFarmers = selectedFarmersitems;
//                                   });
//                                 },
//                                 selectedItems: selectedFarmers,
//                               ),
//                             ],
//                             const SizedBox(height: 16),
//                             SeasionSelectionScreen(
//                               onSelectionChanged: (selectedSeasonsitems) {
//                                 setState(() {
//                                   selectedSeasons = selectedSeasonsitems;
//                                   //clear the selection crops for activityObjects
//                                   for (var activityObject in activityObjects) {
//                                     activityObject.crop = null;
//                                   }
//                                 });
//                                 if (selectedSeasons.isNotEmpty) {
//                                   _loadNewData(selectedSeasons
//                                       .map((season) => season.id)
//                                       .toList());
//                                 }
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       ...activityObjects.asMap().entries.map(
//                         (entry) {
//                           final index = entry.key;
//                           final activityObject = entry.value;
//                           return ExpandedObject(
//                             title: 'Product\'s Details ${index + 1}',
//                             onDismissed: () => removeObject(index),
//                             isExpanded: true,
//                             onExpansionChanged: (isExpanded) {
//                               return true;
//                             },
//                             children: [
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   ProductMasterSelector(
//                                     labelText: 'Select Products',
//                                     icon: Icons.arrow_drop_down,
//                                     onChanged: (selectedProduct) {
//                                       setState(() {
//                                         activityObject.product =
//                                             selectedProduct;
//                                       });
//                                     },
//                                     selectedItem: activityObject.product,
//                                     itemAsString: (product) =>
//                                         product.materialDescription,
//                                   ),
//                                   const SizedBox(height: 16),
//                                   if (selectedSeasons.isNotEmpty)
//                                     Obx(() {
//                                       if (_cropController.isLoading.value) {
//                                         return const ShimmerLoading();
//                                       } else if (_cropController
//                                               .isError.value ||
//                                           _cropController
//                                               .errorMessage.isNotEmpty) {
//                                         return Container(
//                                           width: double.infinity,
//                                           decoration: BoxDecoration(
//                                             color: Colors.red[100],
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             border:
//                                                 Border.all(color: Colors.red),
//                                           ),
//                                           child: const Padding(
//                                             padding: EdgeInsets.all(8.0),
//                                             child: Text('Error loading crop'),
//                                           ),
//                                         );
//                                       } else {
//                                         return SingleSelectDropdown<Crop>(
//                                           labelText: "Select Crop",
//                                           items: _cropController.crops,
//                                           selectedItem: activityObject.crop,
//                                           itemAsString: (crop) =>
//                                               crop.name ?? '',
//                                           onChanged: (selected) {
//                                             WidgetsBinding.instance
//                                                 .addPostFrameCallback((_) {
//                                               setState(() {
//                                                 activityObject.crop = selected;
//                                               });
//                                             });
//                                           },
//                                           searchableFields: {
//                                             "name": (crop) => crop.name ?? '',
//                                             "code": (crop) => crop.code ?? '',
//                                           },
//                                           validator: (selectedPopMaterial) {
//                                             if (selectedPopMaterial == null) {
//                                               return 'Please select a crop';
//                                             }
//                                             return null;
//                                           },
//                                         );
//                                       }
//                                     })
//                                   else
//                                     Column(
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.start,
//                                       children: [
//                                         const Text(
//                                           'Select Crop',
//                                         ),
//                                         SizedBox(height: 8.h),
//                                         Container(
//                                           width: double.infinity,
//                                           padding: const EdgeInsets.all(8),
//                                           decoration: BoxDecoration(
//                                             color: Colors.red[100],
//                                             borderRadius:
//                                                 BorderRadius.circular(10),
//                                             border:
//                                                 Border.all(color: Colors.red),
//                                           ),
//                                           child: const Text(
//                                             'Please select a season first',
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   const SizedBox(height: 16),
//                                   Obx(() {
//                                     if (_cropStageController.isLoading.value) {
//                                       return const ShimmerLoading();
//                                     } else if (_cropStageController
//                                             .isError.value ||
//                                         _cropStageController
//                                             .errorMessage.isNotEmpty) {
//                                       return Container(
//                                         width: double.infinity,
//                                         decoration: BoxDecoration(
//                                           color: Colors.red[100],
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           border: Border.all(color: Colors.red),
//                                         ),
//                                         child: const Padding(
//                                           padding: EdgeInsets.all(8.0),
//                                           child:
//                                               Text('Error loading crop stages'),
//                                         ),
//                                       );
//                                     } else {
//                                       return SingleSelectDropdown<CropStage>(
//                                         labelText: "Select Crop Stage",
//                                         items: _cropStageController.cropStages,
//                                         selectedItem: activityObject.cropStage,
//                                         itemAsString: (cropStages) =>
//                                             cropStages.name,
//                                         onChanged: (selected) {
//                                           WidgetsBinding.instance
//                                               .addPostFrameCallback((_) {
//                                             setState(() {
//                                               activityObject.cropStage =
//                                                   selected;
//                                             });
//                                           });
//                                         },
//                                         searchableFields: {
//                                           "name": (cropStages) =>
//                                               cropStages.name,
//                                           "code": (cropStages) =>
//                                               cropStages.code,
//                                         },
//                                         validator: (selectedPopMaterial) {
//                                           if (selectedPopMaterial == null) {
//                                             return 'Please select a crop Stages';
//                                           }
//                                           return null;
//                                         },
//                                       );
//                                     }
//                                   }),
//                                   const SizedBox(height: 16),
//                                   Obx(() {
//                                     if (_pestController.isLoading.value) {
//                                       return const ShimmerLoading();
//                                     } else if (_pestController.isError.value ||
//                                         _pestController
//                                             .errorMessage.isNotEmpty) {
//                                       return Container(
//                                         width: double.infinity,
//                                         decoration: BoxDecoration(
//                                           color: Colors.red[100],
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           border: Border.all(color: Colors.red),
//                                         ),
//                                         child: const Padding(
//                                           padding: EdgeInsets.all(8.0),
//                                           child: Text('Error loading pests'),
//                                         ),
//                                       );
//                                     } else {
//                                       return SingleSelectDropdown<Pest>(
//                                         labelText: "Select Pest",
//                                         items: _pestController.pests,
//                                         selectedItem: activityObject.pest,
//                                         itemAsString: (pest) => pest.pest,
//                                         onChanged: (selected) {
//                                           WidgetsBinding.instance
//                                               .addPostFrameCallback((_) {
//                                             setState(() {
//                                               activityObject.pest = selected;
//                                             });
//                                           });
//                                         },
//                                         searchableFields: {
//                                           "pest": (pest) => pest.pest,
//                                           "code": (pest) => pest.code,
//                                         },
//                                         validator: (selectedPopMaterial) {
//                                           if (selectedPopMaterial == null) {
//                                             return 'Please select a pest';
//                                           }
//                                           return null;
//                                         },
//                                       );
//                                     }
//                                   }),
//                                   const SizedBox(height: 16),
//                                   Obx(() {
//                                     if (_getDomoStausController
//                                         .isLoading.value) {
//                                       return const ShimmerLoading();
//                                     } else if (_getDomoStausController
//                                             .isError.value ||
//                                         _getDomoStausController
//                                             .errorMessage.isNotEmpty) {
//                                       return Container(
//                                         width: double.infinity,
//                                         decoration: BoxDecoration(
//                                           color: Colors.red[100],
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           border: Border.all(color: Colors.red),
//                                         ),
//                                         child: const Padding(
//                                           padding: EdgeInsets.all(8.0),
//                                           child: Text(
//                                               'Error loading demo status data'),
//                                         ),
//                                       );
//                                     } else if (_getDomoStausController
//                                         .demoStatusData.isEmpty) {
//                                       return Container(
//                                         child: Text('No data found'),
//                                       );
//                                     } else {
//                                       return SingleSelectDropdown<DemoStatus>(
//                                         labelText: "Select Demo Status",
//                                         items: _getDomoStausController
//                                             .demoStatusData,
//                                         selectedItem: activityObject.demoStatus,
//                                         itemAsString: (demoStatus) =>
//                                             demoStatus.name,
//                                         onChanged: (selected) {
//                                           WidgetsBinding.instance
//                                               .addPostFrameCallback((_) {
//                                             setState(() {
//                                               activityObject.demoStatus =
//                                                   selected;
//                                             });
//                                           });
//                                         },
//                                         searchableFields: {
//                                           "name": (demostatus) =>
//                                               demostatus.name,
//                                           "code": (demostatus) =>
//                                               demostatus.code,
//                                         },
//                                         validator: (selectedDemoStatus) {
//                                           if (selectedDemoStatus == null) {
//                                             return 'Please select a demo status';
//                                           }
//                                           return null;
//                                         },
//                                       );
//                                     }
//                                   }),
//                                   const SizedBox(height: 16),
//                                   Obx(() {
//                                     if (_getDomoResultController
//                                         .isLoading.value) {
//                                       return const ShimmerLoading();
//                                     } else if (_getDomoResultController
//                                             .isError.value ||
//                                         _getDomoResultController
//                                             .errorMessage.isNotEmpty) {
//                                       return Container(
//                                         width: double.infinity,
//                                         decoration: BoxDecoration(
//                                           color: Colors.red[100],
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                           border: Border.all(color: Colors.red),
//                                         ),
//                                         child: const Padding(
//                                           padding: EdgeInsets.all(8.0),
//                                           child: Text(
//                                               'Error loading demo result data'),
//                                         ),
//                                       );
//                                     } else {
//                                       return SingleSelectDropdown<DemoResult>(
//                                         labelText: "Select Demo Result",
//                                         items: _getDomoResultController
//                                             .demoResultData,
//                                         selectedItem: activityObject.demoResult,
//                                         itemAsString: (demoResult) =>
//                                             demoResult.name,
//                                         onChanged: (selected) {
//                                           WidgetsBinding.instance
//                                               .addPostFrameCallback((_) {
//                                             setState(() {
//                                               activityObject.demoResult =
//                                                   selected;
//                                             });
//                                           });
//                                         },
//                                         searchableFields: {
//                                           "name": (pop) => pop.name,
//                                           "code": (pop) => pop.code,
//                                         },
//                                         validator: (selectedDemoStatus) {
//                                           if (selectedDemoStatus == null) {
//                                             return 'Please select a demo result';
//                                           }
//                                           return null;
//                                         },
//                                       );
//                                     }
//                                   }),
//                                   const SizedBox(height: 16),
//                                   CustomTextField(
//                                     labelText: 'Dosage',
//                                     hintText: 'Enter the dosage',
//                                     icon: Icons.medication_liquid_outlined,
//                                     controller: activityObject.dosageController,
//                                     keyboardType: TextInputType.number,
//                                     inputFormatter: [
//                                       FilteringTextInputFormatter.digitsOnly,
//                                       LengthLimitingTextInputFormatter(10),
//                                     ],
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter the dosage';
//                                       }
//                                       return null;
//                                     },
//                                     maxLines: 1,
//                                   ),
//                                   const SizedBox(height: 16),
//                                   CustomTextField(
//                                     labelText: 'Area of Demonstration',
//                                     hintText: 'Enter the area of demonstration',
//                                     icon: Icons.area_chart_outlined,
//                                     controller: activityObject.areaController,
//                                     keyboardType: TextInputType.streetAddress,
//                                     inputFormatter: [],
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter the area of demonstration';
//                                       }
//                                       return null;
//                                     },
//                                     maxLines: 1,
//                                   ),
//                                   const SizedBox(height: 16),
//                                   CustomTextField(
//                                     labelText: 'Total Area Covered',
//                                     hintText: 'Enter the total area covered',
//                                     icon: Icons.area_chart,
//                                     controller:
//                                         activityObject.totalAreaController,
//                                     keyboardType: TextInputType.number,
//                                     inputFormatter: [
//                                       FilteringTextInputFormatter.allow(
//                                         RegExp(r'^\d+\.?\d{0,2}'),
//                                       ),
//                                       LengthLimitingTextInputFormatter(10),
//                                     ],
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter the total area covered';
//                                       }
//                                       return null;
//                                     },
//                                     maxLines: 1,
//                                   ),
//                                   const SizedBox(height: 16),
//                                   CustomTextField(
//                                     labelText: 'Expense',
//                                     hintText: 'Enter the expense',
//                                     inputFormatter: [
//                                       FilteringTextInputFormatter.allow(
//                                         RegExp(r'^\d+\.?\d{0,2}'),
//                                       ),
//                                       LengthLimitingTextInputFormatter(10),
//                                     ],
//                                     icon: Icons.currency_rupee_rounded,
//                                     controller:
//                                         activityObject.expenseController,
//                                     keyboardType: TextInputType.number,
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter the expense';
//                                       }
//                                       return null;
//                                     },
//                                     maxLines: 1,
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           );
//                         },
//                       ),
//                       PrimaryButton(
//                         color: AppColors.kSecondary,
//                         isBorder: true,
//                         onTap: () {
//                           if (_formKey.currentState?.validate() ?? false) {
//                             bool allValid = true;

//                             for (var activityObject in activityObjects) {
//                               if (!activityObject.validate()) {
//                                 allValid = false;
//                                 Get.snackbar('Error',
//                                     'Please complete all fields before adding more.');
//                                 break;
//                               }
//                             }

//                             if (allValid) {
//                               addNewObject();
//                             }
//                           }
//                         },
//                         text: 'Add More Products',
//                       ),
//                       SizedBox(height: 16.h),
//                       PrimaryContainer(
//                         child: Column(
//                           children: [
//                             CustomHeaderText(
//                               text: 'Other\'s Details',
//                               fontSize: 20.sp,
//                             ),
//                             SizedBox(height: 16.h),
//                             CustomDatePicker(
//                               labelText: 'Activity Performed Date',
//                               hintText: 'Select Date',
//                               icon: Icons.calendar_today,
//                               textEditingController: _activityDateController,
//                               onDateSelected: (context) =>
//                                   _selectActivityDate(context),
//                             ),
//                             SizedBox(height: 16.h),
//                             CustomDatePicker(
//                               labelText: 'Next Demo Date',
//                               hintText: 'Select Date',
//                               icon: Icons.calendar_today,
//                               textEditingController: _dateController,
//                               onDateSelected: (context) =>
//                                   _selectDateRange(context),
//                             ),
//                             SizedBox(height: 16.h),
//                             CustomTextField(
//                               labelText: 'Activity Performed Location',
//                               hintText: 'Enter Location',
//                               icon: Icons.location_on,
//                               controller: _activityLocationController,
//                               keyboardType: TextInputType.text,
//                             ),
//                             SizedBox(height: 16.h),
//                             GeoLocationInputField(
//                               onLocationSelected: (selectedAddress) {
//                                 setState(() {
//                                   gioLocation = selectedAddress;
//                                 });
//                               },
//                             ),
//                             const SizedBox(height: 16),
//                             GestureDetector(
//                               onTap: () => _showImagePickerOptions(context),
//                               child: Container(
//                                 height: 150.h,
//                                 width: double.infinity,
//                                 clipBehavior: Clip.antiAlias,
//                                 decoration: BoxDecoration(
//                                   color: isDarkMode(context)
//                                       ? AppColors.kContentColor
//                                       : AppColors.kInput,
//                                   borderRadius: BorderRadius.circular(10.r),
//                                   border: Border.all(
//                                     color: Colors.grey,
//                                   ),
//                                 ),
//                                 child: _selectedImagePath == null
//                                     ? Center(
//                                         child: Icon(
//                                           Icons.camera_alt,
//                                           size: 50.sp,
//                                           color: AppColors.kPrimary,
//                                         ),
//                                       )
//                                     : Container(
//                                         clipBehavior: Clip.antiAlias,
//                                         decoration: BoxDecoration(
//                                           borderRadius:
//                                               BorderRadius.circular(10.r),
//                                         ),
//                                         child: Image.file(
//                                           File(_selectedImagePath!),
//                                           fit: BoxFit.cover,
//                                         ),
//                                       ),
//                               ),
//                             ),
//                             const SizedBox(height: 16),
//                             // add a delte image iocn in image
//                             if (_selectedImagePath != null) ...[
//                               InkWell(
//                                 onTap: () {
//                                   setState(() {
//                                     _selectedImagePath = null;
//                                     attachment = null;
//                                   });
//                                 },
//                                 child: Container(
//                                   width: double.infinity,
//                                   padding: const EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: Colors.red[100],
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(color: Colors.red),
//                                   ),
//                                   child: const Padding(
//                                     padding: EdgeInsets.all(8.0),
//                                     child: Text(
//                                       'Delete Image',
//                                       style: TextStyle(color: Colors.red),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 16),
//                             ],
//                             CustomTextField(
//                               labelText: 'Remarks',
//                               hintText: 'Enter remarks',
//                               icon: Icons.comment,
//                               controller: _remarksController,
//                               keyboardType: TextInputType.text,
//                               maxLines: 3,
//                             ),
//                           ],
//                         ),
//                       ),
//                       SizedBox(height: 16.h),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.all(16.h),
//         decoration: BoxDecoration(
//           color: isDarkMode(context)
//               ? AppColors.kDarkSurfaceColor
//               : AppColors.kInput,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: PrimaryButton(
//                 onTap: () {
//                   if (_formKey.currentState?.validate() ?? false) {
//                     for (var activityObject in activityObjects) {
//                       if (!activityObject.validate()) {
//                         Get.snackbar('Error',
//                             'Please fill all fields before submitting.');
//                         return;
//                       }
//                     }
//                     _showConfirmationDialog(context);
//                   }
//                   // Get.snackbar('Error',
//                   //     'Please complete all fields before adding more.');
//                 },
//                 text: "Submit",
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _showConfirmationDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return ConfirmationDialog(
//           title: 'Confirm Action',
//           content: 'Are you sure you want to proceed?',
//           onConfirm: () {
//             Navigator.of(context).pop(); // Close the dialog
//             _submitForm();
//           },
//           onCancel: () {
//             Navigator.of(context).pop();
//           },
//         );
//       },
//     );
//   }

//   Future<void> _submitForm() async {
//     Get.dialog(const LoadingDialog(), barrierDismissible: false);

//     try {
//       final parameters = {
//         'promotional_activity_type': _selectedActivity?.id.toString() ?? '',
//         'party_type': selectedPartyType ?? '',
//         'remarks': _remarksController.text,
//         'latitude': gioLocation?.latitude.toString() ?? '',
//         'longitude': gioLocation?.longitude.toString() ?? '',
//         'next_demo_date': DateFormat('yyyy-MM-dd').format(selectedDate),
//         'activity_performed_date':
//             DateFormat('yyyy-MM-dd').format(selectedactivityDate),
//         'activity_performed_location': _activityLocationController.text,
//       };
//       print('Parameters: $parameters');
//       List<MapEntry<String, String>> fields = [];

//       for (var id in selectedFarmers) {
//         print('Field: $id');
//         fields.add(MapEntry('party_name[]', id.id.toString()));
//       }

//       for (var season in selectedSeasons) {
//         print('Season: $season');
//         fields.add(MapEntry('season[]', season.id.toString()));
//       }

//       for (var activity in activityObjects) {
//         print('Activity Object: $activity');
//         print('Crop: ${activity.crop}');
//         print('Crop Stage: ${activity.cropStage}');
//         print('Product: ${activity.product}');
//         print('Pest: ${activity.pest}');
//         print('Demo Status: ${activity.demoStatus}');
//         print('Demo Result: ${activity.demoResult}');
//         print('Dosage: ${activity.dosageController.text}');
//         print('Area of Demo: ${activity.areaController.text}');
//         print('Total Area Cover: ${activity.totalAreaController.text}');
//         print('Expense: ${activity.expenseController.text}');
//         fields.add(MapEntry('crop[]', activity.crop!.id.toString()));
//         fields.add(MapEntry('crop_stage[]', activity.cropStage!.id.toString()));
//         fields.add(
//             MapEntry('product[]', activity.product!.materialNumber.toString()));
//         fields.add(MapEntry('pest[]', activity.pest!.id.toString()));
//         fields
//             .add(MapEntry('demo_status[]', activity.demoStatus!.id.toString()));
//         fields.add(MapEntry('result[]', activity.demoResult!.id.toString()));
//         fields.add(MapEntry('dosages[]', activity.dosageController.text));
//         fields.add(MapEntry('area_of_demo[]', activity.areaController.text));
//         fields.add(
//             MapEntry('total_area_cover[]', activity.totalAreaController.text));
//         fields.add(MapEntry('expense[]', activity.expenseController.text));
//       }

//       print('Fields: $fields');
//       print('image: $_selectedImagePath');

//       await _formAController.submitActivityAFormData(
//         'createFormD',
//         parameters,
//         fields,
//         imageFile:
//             _selectedImagePath != null ? File(_selectedImagePath!) : null,
//       );

//       // // // clear all data
//       // // _selectedActivity = null;
//       // // selectedPartyType = null;
//       // // selectedFarmers.clear();
//       // // selectedSeasons.clear();
//       // // activityObjects.clear();
//       // // activityObjects.add(ActivityObject());
//       // // _remarksController.clear();
//       // // _selectedImagePath = null;
//       // // attachment = null;
//       // gioLocation = null;
//     } catch (e) {
//       // On error
//       print('Error: $e');
//       Get.back(); // Close loading dialog
//       Get.dialog(
//           ErrorDialog(
//             errorMessage: e.toString(),
//             onClose: () {
//               Get.back(); // Close error dialog
//             },
//           ),
//           barrierDismissible: false);
//     } finally {
//       // Ensure loading dialog is closed
//       Get.back(); // Close loading dialog if not already closed
//     }
//   }
// }

// class ActivityObject {
//   ProductMaster? product;
//   Crop? crop;
//   CropStage? cropStage;
//   Pest? pest;
//   DemoStatus? demoStatus;
//   DemoResult? demoResult;
//   //text controllr fpr dosages and area of demonstrations and total area cover
//   TextEditingController dosageController = TextEditingController();
//   TextEditingController areaController = TextEditingController();
//   TextEditingController totalAreaController = TextEditingController();
//   TextEditingController expenseController = TextEditingController();

//   bool validate() {
//     if (product == null ||
//         crop == null ||
//         cropStage == null ||
//         pest == null ||
//         demoResult == null ||
//         demoStatus == null ||
//         dosageController.text.isEmpty ||
//         areaController.text.isEmpty ||
//         totalAreaController.text.isEmpty ||
//         expenseController.text.isEmpty) {
//       return false;
//     }
//     return true;
//   }
// }

import 'dart:developer';
import 'dart:io';
import 'package:field_asistence/app/model/master/demo_status_model.dart';
import 'package:field_asistence/app/model/master/product_master.dart';
import 'package:field_asistence/app/model/master/result_model.dart';
import 'package:field_asistence/app/model/master/season_model.dart';
import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../controllers/master_controller/crop_controller.dart';
import '../../../controllers/master_controller/crop_stage_controller.dart';
import '../../../controllers/master_controller/get_demo_result.dart';
import '../../../controllers/master_controller/get_demo_status.dart';
import '../../../controllers/master_controller/pest_controller.dart';
import '../../../data/constrants/constants.dart';
import '../../../data/helpers/data/image_doctor_url.dart';
import '../../../model/master/crop_model.dart';
import '../../../model/master/crop_stage.dart';
import '../../../model/master/pest_master.dart';
import '../../farmer/model/farmer_list.dart';
import '../../widgets/dialog/confirmation.dart';
import '../../widgets/dialog/error.dart';
import '../../widgets/dialog/loading.dart';
import '../../widgets/form_field/dynamic_dropdown_input_field.dart';
import '../../widgets/form_field/form_field.dart';
import '../../widgets/form_field/form_hader.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../../widgets/widgets.dart';
import '../components/multi_select_dropdown/farmer_selection_dropdown.dart';
import '../components/multi_select_dropdown/product_multi_selection.dart';
import '../components/single_select_dropdown/activity_master_dropdown.dart';
import '../components/geo_location_selection_page.dart';
import '../components/multi_select_dropdown/seasion_selection_dropdown.dart';
import '../controller/form_a_controller.dart';
import '../model/activity_master_model.dart';

class CreateFormDpage extends StatefulWidget {
  const CreateFormDpage({super.key});

  @override
  State<CreateFormDpage> createState() => _CreateFormDpageState();
}

class _CreateFormDpageState extends State<CreateFormDpage> {
  final _formKey = GlobalKey<FormState>();

  final FormAController _formAController = Get.put(FormAController());
  final CropController _cropController = Get.put(CropController());
  final PestController _pestController = Get.put(PestController());
  final CropStageController _cropStageController =
      Get.put(CropStageController());
  final GetDomoResultController _getDomoResultController =
      Get.put(GetDomoResultController());
  final GetDomoStausController _getDomoStausController =
      Get.put(GetDomoStausController());

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _activityDateController = TextEditingController();
  final TextEditingController _activityLocationController =
      TextEditingController();
  final TextEditingController dosageController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController totalAreaController = TextEditingController();
  final TextEditingController expenseController = TextEditingController();

  ActivityMaster? _selectedActivity;
  String? selectedPartyType;
  String? totalSelectedPertyType;

  String? _selectedImagePath;
  File? attachment;
  LocationData? gioLocation;
  DateTime selectedDate = DateTime.now();
  DateTime selectedactivityDate = DateTime.now();
  List<Farmer> selectedFarmers = [];

  List<Season> selectedSeasons = [];

  List<ProductMaster> products = [];
  List<Crop> crops = [];
  List<CropStage> cropStages = [];
  List<Pest> pests = [];
  List<DemoStatus> demoStatus = [];
  List<DemoResult> demoResults = [];

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      log('Picked file path: ${pickedFile.path}');

      setState(() {
        _selectedImagePath = pickedFile.path;
        attachment = File(pickedFile.path);
      });
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

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
    _activityDateController.text =
        DateFormat('dd-MM-yyyy').format(selectedactivityDate);
    _cropStageController.loadCropStages();
    _pestController.loadPests();
    _getDomoResultController.loaddemoResultData();
    _getDomoStausController.loadDemoStatusData();
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(9999, 12),
      helpText: 'Select Date',
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        _dateController.text = DateFormat('dd-MM-yyyy').format(selectedDate);
      });
    }
  }

  Future<void> _selectActivityDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(9999, 12),
      helpText: 'Select Date',
    );

    if (pickedDate != null) {
      setState(() {
        selectedactivityDate = pickedDate;
        _activityDateController.text =
            DateFormat('dd-MM-yyyy').format(selectedactivityDate);
      });
    }
  }

  @override
  void dispose() {
    _remarksController.dispose();
    _dateController.dispose();

    _activityDateController.dispose();
    _activityLocationController.dispose();

    dosageController.dispose();
    areaController.dispose();
    totalAreaController.dispose();
    expenseController.dispose();
    super.dispose();
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
        iconColor: AppColors.kPrimary.withValues(alpha: 0.15),
        title: Text(
          'Create Demo',
          style: AppTypography.kBold24.copyWith(color: AppColors.kWhite),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            const FormImageHeader(
              tag: 'form',
              image: ImageDoctorUrl.farmerGroupMeating,
              header: 'Create Demo',
              subtitle: 'Fill in the form below to create a new demo',
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
                              text: 'Basic Details',
                              fontSize: 20.sp,
                            ),
                            SizedBox(height: 16.h),
                            ActivitySelectionWidget(
                              formType: "D",
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
                                  });
                                },
                                selectedItems: selectedFarmers,
                              ),
                            ],
                            const SizedBox(height: 16),
                            SeasionSelectionScreen(
                              onSelectionChanged: (selectedSeasonsitems) {
                                setState(() {
                                  selectedSeasons = selectedSeasonsitems;
                                  crops.clear();
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
                      PrimaryContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomHeaderText(
                              text: 'Product\'s Details',
                              fontSize: 18.sp,
                            ),
                            SizedBox(height: 16.h),
                            MultiProductMasterSelector<ProductMaster>(
                              labelText: 'Select Products',
                              onChanged: (selectedProduct) {
                                setState(() {
                                  products = selectedProduct;
                                });
                              },
                              selectedItems: products,
                              itemAsString: (product) =>
                                  product.materialDescription,
                            ),
                            const SizedBox(height: 16),
                            if (selectedSeasons.isNotEmpty)
                              Obx(() {
                                if (_cropController.isLoading.value) {
                                  return const ShimmerLoading();
                                } else if (_cropController.isError.value ||
                                    _cropController.errorMessage.isNotEmpty) {
                                  return Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.red[100],
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.red),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Error loading crop'),
                                    ),
                                  );
                                } else {
                                  return MultiSelectDropdown<Crop>(
                                    labelText: "Select Crops",
                                    items: _cropController.crops,
                                    selectedItems: crops,
                                    itemAsString: (crop) => crop.name ?? '',
                                    onChanged: (selected) {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        setState(() {
                                          crops = selected;
                                        });
                                      });
                                    },
                                    searchableFields: {
                                      "name": (crop) => crop.name ?? '',
                                      "code": (crop) => crop.code ?? '',
                                    },
                                    validator: (selectedCrops) {
                                      if (selectedCrops.isEmpty) {
                                        return 'Please select at least one crop.';
                                      }
                                      return null;
                                    },
                                  );
                                }
                              })
                            else
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.red),
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
                              } else if (_cropStageController.isError.value ||
                                  _cropStageController
                                      .errorMessage.isNotEmpty) {
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.red),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Error loading crop stages'),
                                  ),
                                );
                              } else {
                                return MultiSelectDropdown<CropStage>(
                                  labelText: "Select Crop Stage",
                                  items: _cropStageController.cropStages,
                                  selectedItems: cropStages,
                                  itemAsString: (cropStages) => cropStages.name,
                                  onChanged: (selected) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      setState(() {
                                        cropStages = selected;
                                      });
                                    });
                                  },
                                  searchableFields: {
                                    "name": (cropStages) => cropStages.name,
                                    "code": (cropStages) => cropStages.code,
                                  },
                                  validator: (selectedPopMaterial) {
                                    if (selectedPopMaterial.isEmpty) {
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
                                  _pestController.errorMessage.isNotEmpty) {
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.red),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Error loading pests'),
                                  ),
                                );
                              } else {
                                return MultiSelectDropdown<Pest>(
                                  labelText: "Select Pest",
                                  items: _pestController.pests,
                                  selectedItems: pests,
                                  itemAsString: (pest) => pest.pest,
                                  onChanged: (selected) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      setState(() {
                                        pests = selected;
                                      });
                                    });
                                  },
                                  searchableFields: {
                                    "pest": (pest) => pest.pest,
                                    "code": (pest) => pest.code,
                                  },
                                  validator: (selectedPopMaterial) {
                                    if (selectedPopMaterial.isEmpty) {
                                      return 'Please select a pest';
                                    }
                                    return null;
                                  },
                                );
                              }
                            }),
                            const SizedBox(height: 16),
                            Obx(() {
                              if (_getDomoStausController.isLoading.value) {
                                return const ShimmerLoading();
                              } else if (_getDomoStausController
                                      .isError.value ||
                                  _getDomoStausController
                                      .errorMessage.isNotEmpty) {
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.red),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child:
                                        Text('Error loading demo status data'),
                                  ),
                                );
                              } else if (_getDomoStausController
                                  .demoStatusData.isEmpty) {
                                return Text('No data found');
                              } else {
                                return MultiSelectDropdown<DemoStatus>(
                                  labelText: "Select Demo Status",
                                  items: _getDomoStausController.demoStatusData,
                                  selectedItems: demoStatus,
                                  itemAsString: (demoStatus) => demoStatus.name,
                                  onChanged: (selected) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      setState(() {
                                        demoStatus = selected;
                                      });
                                    });
                                  },
                                  searchableFields: {
                                    "name": (demostatus) => demostatus.name,
                                    "code": (demostatus) => demostatus.code,
                                  },
                                  validator: (selectedDemoStatus) {
                                    if (selectedDemoStatus.isEmpty) {
                                      return 'Please select a demo status';
                                    }
                                    return null;
                                  },
                                );
                              }
                            }),
                            const SizedBox(height: 16),
                            Obx(() {
                              if (_getDomoResultController.isLoading.value) {
                                return const ShimmerLoading();
                              } else if (_getDomoResultController
                                      .isError.value ||
                                  _getDomoResultController
                                      .errorMessage.isNotEmpty) {
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.red),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child:
                                        Text('Error loading demo result data'),
                                  ),
                                );
                              } else {
                                return MultiSelectDropdown<DemoResult>(
                                  labelText: "Select Demo Result",
                                  items:
                                      _getDomoResultController.demoResultData,
                                  selectedItems: demoResults,
                                  itemAsString: (demoResult) => demoResult.name,
                                  onChanged: (selected) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      setState(() {
                                        demoResults = selected;
                                      });
                                    });
                                  },
                                  searchableFields: {
                                    "name": (pop) => pop.name,
                                    "code": (pop) => pop.code,
                                  },
                                  validator: (selectedDemoStatus) {
                                    if (selectedDemoStatus.isEmpty) {
                                      return 'Please select a demo result';
                                    }
                                    return null;
                                  },
                                );
                              }
                            }),
                            const SizedBox(height: 16),
                            CustomTextField(
                              labelText: 'Dosage',
                              hintText: 'Enter the dosage',
                              icon: Icons.medication_liquid_outlined,
                              controller: dosageController,
                              keyboardType: TextInputType.text,
                              inputFormatter: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the dosage';
                                }
                                return null;
                              },
                              maxLines: 1,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              labelText: 'Area of Demonstration',
                              hintText: 'Enter the area of demonstration',
                              icon: Icons.area_chart_outlined,
                              controller: areaController,
                              keyboardType: TextInputType.streetAddress,
                              inputFormatter: [],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the area of demonstration';
                                }
                                return null;
                              },
                              maxLines: 1,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              labelText: 'Total Acre of Farmers in Demo',
                              hintText: 'Enter acre',
                              icon: Icons.area_chart,
                              controller: totalAreaController,
                              keyboardType: TextInputType.number,
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}'),
                                ),
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the total acre';
                                }
                                return null;
                              },
                              maxLines: 1,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              labelText: 'Value',
                              hintText: 'Enter the value',
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}'),
                                ),
                                LengthLimitingTextInputFormatter(10),
                              ],
                              icon: Icons.currency_rupee_rounded,
                              controller: expenseController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the value';
                                }
                                return null;
                              },
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
                      PrimaryContainer(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomHeaderText(
                              text: 'Other\'s Details',
                              fontSize: 20.sp,
                            ),
                            SizedBox(height: 16.h),
                            CustomDatePicker(
                              labelText: 'Demo Date',
                              hintText: 'Select Date',
                              icon: Icons.calendar_today,
                              textEditingController: _activityDateController,
                              onDateSelected: (context) =>
                                  _selectActivityDate(context),
                            ),
                            SizedBox(height: 16.h),
                            CustomDatePicker(
                              labelText: 'Next Demo Date',
                              hintText: 'Select Date',
                              icon: Icons.calendar_today,
                              textEditingController: _dateController,
                              onDateSelected: (context) =>
                                  _selectDateRange(context),
                            ),
                            SizedBox(height: 16.h),
                            CustomTextField(
                              labelText: 'Activity Performed Location',
                              hintText: 'Enter Location',
                              icon: Icons.location_on,
                              controller: _activityLocationController,
                              keyboardType: TextInputType.text,
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
                            Text('Demo Application Photo:*'),
                            const SizedBox(height: 8),

                            GestureDetector(
                              onTap: () => _showImagePickerOptions(context),
                              child: Container(
                                height: 150.h,
                                width: double.infinity,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: AppColors.kInput,
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: _selectedImagePath == null
                                        ? AppColors.kAccent7
                                        : Colors.grey,
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
                            // add a delte image iocn in image
                            if (_selectedImagePath != null) ...[
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    _selectedImagePath = null;
                                    attachment = null;
                                  });
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.red),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Delete Image',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                            CustomTextField(
                              labelText: 'Remarks',
                              hintText: 'Enter remarks',
                              icon: Icons.comment,
                              controller: _remarksController,
                              keyboardType: TextInputType.text,
                              maxLines: 3,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the remarks';
                                }
                                return null;
                              },
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
          color: AppColors.kInput,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Row(
          children: [
            Expanded(
              child: PrimaryButton(
                onTap: () {
                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  // Validation for lists and dropdowns
                  if (_selectedActivity == null) {
                    Get.snackbar("Error", "Please select an activity.",
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }
                  if (selectedSeasons.isEmpty) {
                    Get.snackbar("Error", "Please select at least one season.",
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }
                  if (selectedPartyType == null || selectedPartyType!.isEmpty) {
                    Get.snackbar("Error", "Please select a party type.",
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }
                  if (selectedPartyType == "Farmer" &&
                      selectedFarmers.isEmpty) {
                    Get.snackbar("Error", "Please select at least one farmer.",
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }
                  if (products.isEmpty) {
                    Get.snackbar("Error", "Please select at least one product.",
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }
                  if (crops.isEmpty) {
                    Get.snackbar("Error", "Please select at least one crop.",
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }
                  if (cropStages.isEmpty) {
                    Get.snackbar(
                        "Error", "Please select at least one crop stage.",
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }
                  if (pests.isEmpty) {
                    Get.snackbar("Error", "Please select at least one pest.",
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }
                  if (demoStatus.isEmpty) {
                    Get.snackbar(
                        "Error", "Please select at least one demo status.",
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }
                  if (demoResults.isEmpty) {
                    Get.snackbar(
                        "Error", "Please select at least one demo result.",
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }

                  if (_selectedImagePath == null) {
                    Get.snackbar("Error", "Please upload an attachment.",
                        backgroundColor: Colors.red, colorText: Colors.white);
                    return;
                  }
                  _showConfirmationDialog(context);
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
        'dosages': dosageController.text,
        'area_of_demo': areaController.text,
        'total_area_cover': totalAreaController.text,
        'expense': expenseController.text,
        'remarks': _remarksController.text,
        'latitude': gioLocation?.latitude.toString() ?? '',
        'longitude': gioLocation?.longitude.toString() ?? '',
        'next_demo_date': DateFormat('yyyy-MM-dd').format(selectedDate),
        'activity_performed_date':
            DateFormat('yyyy-MM-dd').format(selectedactivityDate),
        'activity_performed_location': _activityLocationController.text,
      };
      print('Parameters: $parameters');
      List<MapEntry<String, String>> fields = [];

      for (var id in selectedFarmers) {
        print('Field: $id');
        fields.add(MapEntry('party_name[]', id.id.toString()));
      }

      for (var season in selectedSeasons) {
        print('Season: $season');
        fields.add(MapEntry('season[]', season.id.toString()));
      }

      for (var product in products) {
        fields.add(MapEntry('product[]', product.materialNumber.toString()));
      }

      for (var crop in crops) {
        fields.add(MapEntry('crop[]', crop.id.toString()));
      }
      for (var cropStage in cropStages) {
        fields.add(MapEntry('crop_stage[]', cropStage.id.toString()));
      }

      for (var pest in pests) {
        fields.add(MapEntry('pest[]', pest.id.toString()));
      }

      for (var demostatus in demoStatus) {
        fields.add(MapEntry('demo_status[]', demostatus.id.toString()));
      }
      for (var demoResult in demoResults) {
        fields.add(MapEntry('result[]', demoResult.id.toString()));
      }

      print('Fields: $fields');
      print('image: $_selectedImagePath');

      await _formAController.submitActivityAFormData(
        'createFormD',
        parameters,
        fields,
        imageFile:
            _selectedImagePath != null ? File(_selectedImagePath!) : null,
      );
    } catch (e) {
      print('Error: $e');
      Get.back();
      Get.dialog(
          ErrorDialog(
            errorMessage: e.toString(),
            onClose: () {
              Get.back();
            },
          ),
          barrierDismissible: false);
    } finally {
      setState(() {
        _selectedActivity = null;
        selectedPartyType = null;
        selectedFarmers.clear();
        selectedSeasons.clear();
        products.clear();
        crops.clear();
        cropStages.clear();
        pests.clear();
        demoStatus.clear();
        demoResults.clear();
        dosageController.clear();
        areaController.clear();
        totalAreaController.clear();
        expenseController.clear();
        _activityLocationController.clear();
        _dateController.clear();
        _activityDateController.clear();
        _remarksController.clear();
        _selectedImagePath = null;
        attachment = null;
        gioLocation = null;
      });

      Get.back();
    }
  }
}
