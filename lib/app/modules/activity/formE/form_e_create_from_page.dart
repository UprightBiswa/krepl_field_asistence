// import 'dart:developer';
// import 'dart:io';
// import 'package:field_asistence/app/model/master/product_master.dart';
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
// import '../../../controllers/master_controller.dart/pest_controller.dart';
// import '../../../controllers/master_controller.dart/pop_meterial_controller.dart';
// import '../../../data/constrants/constants.dart';
// import '../../../data/helpers/data/image_doctor_url.dart';
// import '../../../model/master/crop_model.dart';
// import '../../../model/master/crop_stage.dart';
// import '../../../model/master/pest_master.dart';
// import '../../../model/master/villages_model.dart';
// import '../../widgets/dialog/confirmation.dart';
// import '../../widgets/dialog/error.dart';
// import '../../widgets/dialog/loading.dart';
// import '../../widgets/form_field.dart/form_field.dart';
// import '../../widgets/form_field.dart/form_hader.dart';
// import '../../widgets/form_field.dart/single_selected_dropdown.dart';
// import '../../widgets/texts/custom_header_text.dart';
// import '../../widgets/widgets.dart';
// import '../components/expanded_object.dart';
// import '../components/single_select_dropdown/activity_master_dropdown.dart';
// import '../components/geo_location_selection_page.dart';
// import '../components/multi_select_dropdown/seasion_selection_dropdown.dart';
// import '../components/multi_select_dropdown/village_multi_selecton_dropdown.dart';
// import '../components/single_select_dropdown/product_selection_autofill.dart';
// import '../controller/form_a_controller.dart';
// import '../model/activity_master_model.dart';

// class CreateFormEpage extends StatefulWidget {
//   const CreateFormEpage({super.key});

//   @override
//   State<CreateFormEpage> createState() => _CreateFormEpageState();
// }

// class _CreateFormEpageState extends State<CreateFormEpage> {

//   final _formKey = GlobalKey<FormState>();
//   final FormAController _formAController = Get.put(FormAController());
//   final CropController _cropController = Get.put(CropController());
//   final PopMaterialController _popMaterialController =
//       Get.put(PopMaterialController());
//   final PestController _pestController = Get.put(PestController());
//   final CropStageController _cropStageController =
//       Get.put(CropStageController());

//   List<ActivityObject> activityObjects = [ActivityObject()];
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

//   List<Village> selectedVillages = [];

//   List<Season> selectedSeasons = [];

//   DateTime selectedDate = DateTime.now();

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

//   Future<void> _selectActivityDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       firstDate: DateTime(2017, 1),
//       lastDate: DateTime(9999, 12),
//       helpText: 'Select Date',
//     );

//     if (pickedDate != null) {
//       setState(() {
//         selectedDate = pickedDate;
//         _activityDateController.text =
//             DateFormat('dd-MM-yyyy').format(selectedDate);
//       });
//     }
//   }

//   bool isDarkMode(BuildContext context) =>
//       Theme.of(context).brightness == Brightness.dark;
//   @override
//   void initState() {
//     super.initState();
//     _activityDateController.text =
//         DateFormat('dd-MM-yyyy').format(selectedDate);
//     _cropController.loadCrops([]);
//     _cropStageController.loadCropStages();
//     _pestController.loadPests();
//     _popMaterialController.loadPopMeterial();
//   }

//   @override
//   void dispose() {
//     _remarksController.dispose();
//     _activityDateController.dispose();
//     _activityLocationController.dispose();

//     for (var object in activityObjects) {
//       object.expenseController.dispose();
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
//             : AppColors.kPrimary.withOpacity(0.15),
//         title: Text(
//           'Create POP Material',
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
//               header: 'POP Material',
//               subtitle: 'Fill in the details to create a new POP Material form',
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
//                               formType: "E",
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
//                             if (selectedPartyType == "Village") ...[
//                               VillageSelectionScreen(
//                                 onSelectionChanged: (selectedVillagesitems) {
//                                   setState(() {
//                                     selectedVillages = selectedVillagesitems;
//                                   });
//                                 },
//                                 selectedItems: selectedVillages,
//                               ),
//                             ],
//                             const SizedBox(height: 16),
//                             SeasionSelectionScreen(
//                               onSelectionChanged: (selectedSeasonsitems) {
//                                 setState(() {
//                                   selectedSeasons = selectedSeasonsitems;
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
//                                             style: TextStyle(color: Colors.red),
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
//                                     if (_popMaterialController
//                                         .isLoading.value) {
//                                       return const ShimmerLoading();
//                                     } else if (_popMaterialController
//                                             .isError.value ||
//                                         _popMaterialController
//                                             .errorMessage.isNotEmpty) {
//                                       return Container(
//                                         width: double.infinity,
//                                         decoration: BoxDecoration(
//                                           color: Colors.red[100],
//                                           borderRadius:
//                                               BorderRadius.circular(10),
//                                         ),
//                                         child: const Padding(
//                                           padding: EdgeInsets.all(8.0),
//                                           child: Text(
//                                               'Error loading pop material'),
//                                         ),
//                                       );
//                                     } else {
//                                       return SingleSelectDropdown<PopMaterial>(
//                                         labelText: "Select Pop Material",
//                                         items:
//                                             _popMaterialController.popMeterial,
//                                         selectedItem:
//                                             activityObject.popMaterial,
//                                         itemAsString: (pop) => pop.name ?? "",
//                                         onChanged: (selected) {
//                                           WidgetsBinding.instance
//                                               .addPostFrameCallback((_) {
//                                             setState(() {
//                                               activityObject.popMaterial =
//                                                   selected;
//                                             });
//                                           });
//                                         },
//                                         searchableFields: {
//                                           "pop_name": (pop) => pop.name ?? "",
//                                           "pop_code": (pop) => pop.code ?? "",
//                                         },
//                                         validator: (selectedPopMaterial) {
//                                           if (selectedPopMaterial == null) {
//                                             return 'Please select a pop material';
//                                           }
//                                           return null;
//                                         },
//                                       );
//                                     }
//                                   }),
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
//                     if (selectedVillages.isEmpty) {
//                       Get.snackbar(
//                           'Error', 'Please select at least one village.');
//                       return;
//                     }
//                     if (selectedSeasons.isEmpty) {
//                       Get.snackbar(
//                           'Error', 'Please select at least one season.');
//                       return;
//                     }
//                     for (var activityObject in activityObjects) {
//                       if (!activityObject.validate()) {
//                         Get.snackbar('Error',
//                             'Please fill all fields before submitting.');
//                         return;
//                       }
//                     }
//                     _showConfirmationDialog(context);
//                   }
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
//         'activity_performed_date':
//             DateFormat('yyyy-MM-dd').format(selectedDate),
//         'activity_performed_location': _activityLocationController.text,
//       };
//       List<MapEntry<String, String>> fields = [];

//       for (var id in selectedVillages) {
//         fields.add(MapEntry('party_name[]', id.id.toString()));
//       }

//       for (var season in selectedSeasons) {
//         fields.add(MapEntry('season[]', season.id.toString()));
//       }

//       for (var activity in activityObjects) {
//         fields.add(MapEntry('crop[]', activity.crop!.id.toString()));
//         fields.add(MapEntry('crop_stage[]', activity.cropStage!.id.toString()));
//         fields.add(
//             MapEntry('product[]', activity.product!.materialNumber.toString()));
//         fields.add(MapEntry('pest[]', activity.pest!.id.toString()));
//         fields.add(
//             MapEntry('publicity_mat[]', activity.popMaterial!.id.toString()));
//         fields.add(MapEntry('expense[]', activity.expenseController.text));
//       }

//       await _formAController.submitActivityAFormData(
//         'createFormE',
//         parameters,
//         fields,
//         imageFile:
//             _selectedImagePath != null ? File(_selectedImagePath!) : null,
//       );

//       _selectedActivity = null;
//       selectedPartyType = null;
//       selectedVillages.clear();
//       selectedSeasons.clear();
//       activityObjects.clear();
//       activityObjects.add(ActivityObject());
//       _remarksController.clear();
//       _selectedImagePath = null;
//       attachment = null;
//       gioLocation = null;
//     } catch (e) {
//       Get.back();
//       Get.dialog(
//           ErrorDialog(
//             errorMessage: e.toString(),
//             onClose: () {
//               Get.back();
//             },
//           ),
//           barrierDismissible: false);
//     } finally {
//       Get.back();
//     }
//   }
// }

// class ActivityObject {
//   ProductMaster? product;
//   Crop? crop;
//   CropStage? cropStage;
//   Pest? pest;
//   PopMaterial? popMaterial;
//   TextEditingController expenseController = TextEditingController();

//   bool validate() {
//     if (product == null ||
//         crop == null ||
//         cropStage == null ||
//         pest == null ||
//         popMaterial == null ||
//         expenseController.text.isEmpty) {
//       return false;
//     }
//     return true;
//   }
// }

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
import 'package:intl/intl.dart';
import '../../../controllers/master_controller.dart/crop_controller.dart';
import '../../../controllers/master_controller.dart/crop_stage_controller.dart';
import '../../../controllers/master_controller.dart/pest_controller.dart';
import '../../../controllers/master_controller.dart/pop_meterial_controller.dart';
import '../../../data/constrants/constants.dart';
import '../../../data/helpers/data/image_doctor_url.dart';
import '../../../model/master/crop_model.dart';
import '../../../model/master/crop_stage.dart';
import '../../../model/master/pest_master.dart';
import '../../../model/master/villages_model.dart';
import '../../widgets/dialog/confirmation.dart';
import '../../widgets/dialog/error.dart';
import '../../widgets/dialog/loading.dart';
import '../../widgets/form_field.dart/dynamic_dropdown_input_field.dart';
import '../../widgets/form_field.dart/form_field.dart';
import '../../widgets/form_field.dart/form_hader.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../../widgets/widgets.dart';
import '../components/multi_select_dropdown/product_multi_selection.dart';
import '../components/single_select_dropdown/activity_master_dropdown.dart';
import '../components/geo_location_selection_page.dart';
import '../components/multi_select_dropdown/seasion_selection_dropdown.dart';
import '../components/multi_select_dropdown/village_multi_selecton_dropdown.dart';
import '../controller/form_a_controller.dart';
import '../model/activity_master_model.dart';

class CreateFormEpage extends StatefulWidget {
  const CreateFormEpage({super.key});

  @override
  State<CreateFormEpage> createState() => _CreateFormEpageState();
}

class _CreateFormEpageState extends State<CreateFormEpage> {
  final _formKey = GlobalKey<FormState>();

  final FormAController _formAController = Get.put(FormAController());
  final CropController _cropController = Get.put(CropController());
  final PopMaterialController _popMaterialController =
      Get.put(PopMaterialController());
  final PestController _pestController = Get.put(PestController());
  final CropStageController _cropStageController =
      Get.put(CropStageController());

  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _activityDateController = TextEditingController();
  final TextEditingController _activityLocationController =
      TextEditingController();
  final TextEditingController expenseController = TextEditingController();

  ActivityMaster? _selectedActivity;
  String? selectedPartyType;
  String? totalSelectedPertyType;
  String? _selectedImagePath;
  File? attachment;
  LocationData? gioLocation;

  List<Village> selectedVillages = [];
  List<Season> selectedSeasons = [];

  List<ProductMaster> products = [];
  List<Crop> crops = [];
  List<CropStage> cropStages = [];
  List<Pest> pests = [];
  List<PopMaterial> popMaterials = [];

  DateTime selectedDate = DateTime.now();

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

  Future<void> _selectActivityDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(9999, 12),
      helpText: 'Select Date',
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
        _activityDateController.text =
            DateFormat('dd-MM-yyyy').format(selectedDate);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _activityDateController.text =
        DateFormat('dd-MM-yyyy').format(selectedDate);
    _cropController.loadCrops([]);
    _cropStageController.loadCropStages();
    _pestController.loadPests();
    _popMaterialController.loadPopMeterial();
  }

  @override
  void dispose() {
    _remarksController.dispose();
    _activityDateController.dispose();
    _activityLocationController.dispose();
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
        iconColor: AppColors.kPrimary.withOpacity(0.15),
        title: Text(
          'Create POP Material',
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
              header: 'POP Material',
              subtitle: 'Fill in the details to create a new POP Material form',
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
                              formType: "E",
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
                              if (_popMaterialController.isLoading.value) {
                                return const ShimmerLoading();
                              } else if (_popMaterialController.isError.value ||
                                  _popMaterialController
                                      .errorMessage.isNotEmpty) {
                                return Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text('Error loading pop material'),
                                  ),
                                );
                              } else {
                                return MultiSelectDropdown<PopMaterial>(
                                  labelText: "Select Pop Material",
                                  items: _popMaterialController.popMeterial,
                                  selectedItems: popMaterials,
                                  itemAsString: (pop) => pop.name ?? "",
                                  onChanged: (selected) {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      setState(() {
                                        popMaterials = selected;
                                      });
                                    });
                                  },
                                  searchableFields: {
                                    "pop_name": (pop) => pop.name ?? "",
                                    "pop_code": (pop) => pop.code ?? "",
                                  },
                                  validator: (selectedPopMaterial) {
                                    if (selectedPopMaterial.isEmpty) {
                                      return 'Please select a pop material';
                                    }
                                    return null;
                                  },
                                );
                              }
                            }),
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
                              controller: expenseController,
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
                      ),
                      SizedBox(height: 16.h),
                      PrimaryContainer(
                        child: Column(
                          children: [
                            CustomHeaderText(
                              text: 'Other\'s Details',
                              fontSize: 20.sp,
                            ),
                            SizedBox(height: 16.h),
                            CustomDatePicker(
                              labelText: 'Activity Performed Date',
                              hintText: 'Select Date',
                              icon: Icons.calendar_today,
                              textEditingController: _activityDateController,
                              onDateSelected: (context) =>
                                  _selectActivityDate(context),
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
                  if (selectedPartyType == "Village" &&
                      selectedVillages.isEmpty) {
                    Get.snackbar("Error", "Please select at least one village.",
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

                  if (popMaterials.isEmpty) {
                    Get.snackbar(
                        "Error", "Please select at least one pop Material.",
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
        'expense': expenseController.text,
        'remarks': _remarksController.text,
        'latitude': gioLocation?.latitude.toString() ?? '',
        'longitude': gioLocation?.longitude.toString() ?? '',
        'activity_performed_date':
            DateFormat('yyyy-MM-dd').format(selectedDate),
        'activity_performed_location': _activityLocationController.text,
      };
      List<MapEntry<String, String>> fields = [];

      for (var id in selectedVillages) {
        fields.add(MapEntry('party_name[]', id.id.toString()));
      }

      for (var season in selectedSeasons) {
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

      for (var popMaterial in popMaterials) {
        fields.add(MapEntry('publicity_mat[]', popMaterial.id.toString()));
      }

      await _formAController.submitActivityAFormData(
        'createFormE',
        parameters,
        fields,
        imageFile:
            _selectedImagePath != null ? File(_selectedImagePath!) : null,
      );
    } catch (e) {
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
        selectedVillages.clear();
        selectedSeasons.clear();

        _remarksController.clear();
        _selectedImagePath = null;
        attachment = null;
        gioLocation = null;
      });
      Get.back();
    }
  }
}
