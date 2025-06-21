// import 'dart:developer';
// import 'dart:io';

// import 'package:field_asistence/app/model/master/product_master.dart';
// import 'package:field_asistence/app/modules/retailer/model/retailer_model_list.dart';
// import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:intl/intl.dart';

// import '../../../data/constrants/constants.dart';
// import '../../../data/helpers/data/image_doctor_url.dart';
// import '../../../model/master/customer_model.dart';
// import '../../widgets/dialog/confirmation.dart';
// import '../../widgets/dialog/error.dart';
// import '../../widgets/dialog/loading.dart';
// import '../../widgets/form_field.dart/form_field.dart';
// import '../../widgets/form_field.dart/form_hader.dart';
// import '../../widgets/texts/custom_header_text.dart';
// import '../../widgets/widgets.dart';
// import '../components/expanded_object.dart';
// import '../components/multi_select_dropdown/customer_multi_select_dropdown.dart';
// import '../components/multi_select_dropdown/product_multi_selection.dart';
// import '../components/multi_select_dropdown/retailer_multiselection_dropdown.dart';
// import '../components/single_select_dropdown/activity_master_dropdown.dart';
// import '../components/single_select_dropdown/product_selection_autofill.dart';
// import '../controller/form_a_controller.dart';
// import '../model/activity_master_model.dart';

// class CreateFormCpage extends StatefulWidget {
//   const CreateFormCpage({super.key});

//   @override
//   State<CreateFormCpage> createState() => _CreateFormCpageState();
// }

// class _CreateFormCpageState extends State<CreateFormCpage> {
//   final FormAController _formAController = Get.put(FormAController());
//   final _formKey = GlobalKey<FormState>();
//   List<ActivityObjectC> activityObjectsC = [ActivityObjectC()];
//   final TextEditingController _remarksController = TextEditingController();

//   ActivityMaster? _selectedActivity;
//   String? selectedPartyType;

//   List<Retailer> selectedRetailers = [];
//   List<Customer> selectedCustomers = [];
//   List<String>? selectedPartyNameListId;

//   bool isDarkMode(BuildContext context) =>
//       Theme.of(context).brightness == Brightness.dark;

//   final TextEditingController _activityDateController = TextEditingController();

//   final TextEditingController _activityLocationController =
//       TextEditingController();

//   DateTime selectedDate = DateTime.now();
//   String? _selectedImagePath;
//   File? attachment;
//   @override
//   void initState() {
//     super.initState();
//     _activityDateController.text =
//         DateFormat('dd-MM-yyyy').format(selectedDate);
//   }

//   @override
//   void dispose() {
//     _remarksController.dispose();
//     _activityDateController.dispose();
//     _activityLocationController.dispose();
//     for (var activityObject in activityObjectsC) {
//       activityObject.quantityController.dispose();
//       activityObject.expenseController.dispose();
//     }
//     super.dispose();
//   }

//   void addNewObject() {
//     setState(() {
//       activityObjectsC.add(ActivityObjectC());
//     });
//   }

//   // Remove an ActivityObject
//   void removeObject(int index) {
//     setState(() {
//       activityObjectsC.removeAt(index);
//     });
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
//           'Create Dealer Stock',
//           style: AppTypography.kBold24.copyWith(color: AppColors.kWhite),
//         ),
//       ),
//       body: SizedBox(
//         height: MediaQuery.of(context).size.height,
//         child: Stack(
//           children: [
//             const FormImageHeader(
//               tag: 'form',
//               image: ImageDoctorUrl.retailerImage,
//               header: 'Create Dealer Stock',
//               subtitle: 'Fill in the form below to create a new dealer stock',
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
//                               formType: "C",
//                               onSaved: (selectedActivity) {
//                                 setState(() {
//                                   _selectedActivity = selectedActivity;

//                                   if (_selectedActivity != null) {
//                                     selectedPartyType =
//                                         _selectedActivity!.masterLink;
//                                   }
//                                   selectedCustomers.clear();
//                                   selectedRetailers.clear();
//                                 });
//                               },
//                               selectedItem: _selectedActivity,
//                               validator: (selectedActivity) {
//                                 if (selectedActivity == null) {
//                                   return 'Please select an activity';
//                                 }
//                                 return null;
//                               },
//                             ),

//                             if (_selectedActivity != null) ...[
//                               SizedBox(height: 16.h),
//                               Container(
//                                 padding: EdgeInsets.all(8.w),
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   color: AppColors.kSecondary.   withValues(alpha:0.1),
//                                   borderRadius: BorderRadius.circular(10.r),
//                                   border: Border.all(
//                                     color:
//                                         AppColors.kSecondary.   withValues(alpha:0.5),
//                                   ),
//                                 ),
//                                 child: Text(
//                                   'Selected Partytype: ${_selectedActivity!.masterLink}',
//                                 ),
//                               ),
//                               SizedBox(height: 16.h),
//                             ],
//                             // Conditional Fields based on the selected party type
//                             if (selectedPartyType == "Customer") ...[
//                               CustomerMultiPleSelectionScreen(
//                                 onSelectionChanged: (selectedCustomersitems) {
//                                   setState(() {
//                                     selectedCustomers = selectedCustomersitems;
//                                     selectedPartyNameListId = selectedCustomers
//                                         .map((e) => e.id.toString())
//                                         .toList();
//                                   });
//                                 },
//                                 selectedItems: selectedCustomers,
//                               ),
//                             ] else if (selectedPartyType == "Retailer") ...[
//                               RetailerSelectionScreen(
//                                 onSelectionChanged: (selectedRetailersitems) {
//                                   setState(() {
//                                     selectedRetailers = selectedRetailersitems;
//                                     selectedPartyNameListId = selectedRetailers
//                                         .map((e) => e.id.toString())
//                                         .toList();
//                                   });
//                                 },
//                                 selectedItems: selectedRetailers,
//                               ),
//                             ],
//                           ],
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       ...activityObjectsC.asMap().entries.map(
//                         (entry) {
//                           final index = entry.key;
//                           final activityObject = entry.value;
//                           return ExpandedObject(
//                             title: 'Product\'s Details ${index + 1}',
//                             onDismissed: () => removeObject(index),
//                             isExpanded: true,
//                             onExpansionChanged: (isExpanded) => true,
//                             children: [
//                               Column(
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
//                                   // MultiProductMasterSelector(
//                                   //   labelText: 'Select Products',
//                                   //   icon: Icons.arrow_drop_down,
//                                   //   onChanged: (selectedProduct) {
//                                   //     setState(() {
//                                   //       activityObject.product = selectedProduct;
//                                   //     });
//                                   //   },
//                                   //   selectedItems: activityObject.product,
//                                   //   itemAsString: (product) =>
//                                   //       product.materialDescription,
//                                   // ),
//                                   const SizedBox(height: 16),
//                                   CustomTextField(
//                                     labelText: 'Quantity',
//                                     hintText: 'Enter the product quantity',
//                                     icon: Icons.add,
//                                     controller:
//                                         activityObject.quantityController,
//                                     keyboardType: TextInputType.number,
//                                     inputFormatter: [
//                                       FilteringTextInputFormatter.allow(
//                                           RegExp(r'[0-9]')),
//                                       LengthLimitingTextInputFormatter(10),
//                                     ],
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter the quantity';
//                                       }
//                                       return null;
//                                     },
//                                     maxLines: 1,
//                                   ),
//                                   const SizedBox(height: 16),
//                                   CustomTextField(
//                                     labelText: 'Expense',
//                                     hintText: 'Enter the expense',
//                                     icon: Icons.currency_rupee,
//                                     controller:
//                                         activityObject.expenseController,
//                                     keyboardType:
//                                         TextInputType.numberWithOptions(
//                                             decimal: true),
//                                     inputFormatter: [
//                                       FilteringTextInputFormatter.allow(
//                                           // RegExp(r'^\d*\.?\d{0,2}$')),
//                                           RegExp(r'^\d+\.?\d{0,2}')),
//                                       LengthLimitingTextInputFormatter(10),
//                                     ],
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter the expense';
//                                       }
//                                       if (double.tryParse(value) == null) {
//                                         return 'Enter a valid number';
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

//                       // Add New Product Button
//                       PrimaryButton(
//                         text: 'Add More Products',
//                         color: AppColors.kSecondary,
//                         isBorder: true,
//                         onTap: () {
//                           bool allValid = true;
//                           for (var activityObject in activityObjectsC) {
//                             if (!activityObject.validate()) {
//                               allValid = false;
//                               Get.snackbar('Error',
//                                   'Please complete all fields before adding more.',
//                                   snackPosition: SnackPosition.BOTTOM);
//                               break;
//                             }
//                           }
//                           if (allValid) addNewObject();
//                         },
//                       ),

//                       const SizedBox(height: 16),
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
//                                   border: Border.all(color: Colors.grey),
//                                 ),
//                                 child: _selectedImagePath == null
//                                     ? Center(
//                                         child: Icon(Icons.camera_alt,
//                                             size: 50.sp,
//                                             color: AppColors.kPrimary),
//                                       )
//                                     : ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(10.r),
//                                         child: Image.file(
//                                             File(_selectedImagePath!),
//                                             fit: BoxFit.cover),
//                                       ),
//                               ),
//                             ),
//                             SizedBox(height: 16.h),
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
//                                   padding: EdgeInsets.all(8),
//                                   decoration: BoxDecoration(
//                                     color: Colors.red[100],
//                                     borderRadius: BorderRadius.circular(10),
//                                     border: Border.all(color: Colors.red),
//                                   ),
//                                   child: Center(
//                                     child: Text(
//                                       'Delete Image',
//                                       style: TextStyle(
//                                           color: Colors.red,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 16.h),
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
//                       const SizedBox(height: 16),
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
//                     if (selectedRetailers.isEmpty) {
//                       Get.snackbar(
//                           'Error', 'Please select at least one party.');
//                       return;
//                     }

//                     for (var activityObject in activityObjectsC) {
//                       if (!activityObject.validate()) {
//                         Get.snackbar('Error',
//                             'Please complete all fields before submitting.',
//                             snackPosition: SnackPosition.BOTTOM);
//                         return;
//                       }
//                     }
//                     _showConfirmationDialog(context);
//                   } else {
//                     Get.snackbar('Error', 'Please fill all required fields.');
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
//       // Prepare parameters for API submission
//       Map<String, dynamic> parameters = {
//         'promotional_activity_type': _selectedActivity!.id,
//         'party_type': selectedPartyType,
//         'remarks': _remarksController.text,
//         'activity_performed_date':
//             DateFormat('yyyy-MM-dd').format(selectedDate),
//         'activity_performed_location': _activityLocationController.text,
//       };
//       List<MapEntry<String, String>> fields = [];

//       if (selectedPartyType == "Customer") {
//         for (var id in selectedCustomers) {
//           fields.add(MapEntry('party_name[]', id.id.toString()));
//         }
//         // parameters['party_name[]'] = selectedCustomers.map((e) => e.id.toString()).toList();
//       } else if (selectedPartyType == "Retailer") {
//         for (var id in selectedRetailers) {
//           fields.add(MapEntry('party_name[]', id.id.toString()));
//         }
//         // parameters['party_name[]'] = selectedRetailers.map((e) => e.id.toString()).toList();
//       }

//       for (var activity in activityObjectsC) {
//         fields.add(
//             MapEntry('product[]', activity.product!.materialNumber.toString()));
//         fields.add(MapEntry('quantity[]', activity.quantityController.text));
//         fields.add(MapEntry('expense[]', activity.expenseController.text));
//       }

//       await _formAController.submitActivityAFormData(
//         'createFormC',
//         parameters,
//         fields,
//         imageFile:
//             _selectedImagePath != null ? File(_selectedImagePath!) : null,
//       );

//       Get.back(); // Close loading dialog
//       Get.snackbar('Success', 'Form submitted successfully!');
//     } catch (e) {
//       Get.back(); // Close loading dialog
//       Get.dialog(
//         ErrorDialog(
//           errorMessage: e.toString(),
//           onClose: () {
//             Get.back(); // Close error dialog
//           },
//         ),
//         barrierDismissible: false,
//       );
//     }
//   }
// }

// class ActivityObjectC {
//   ProductMaster? product;
//   TextEditingController quantityController = TextEditingController();
//   TextEditingController expenseController = TextEditingController();

//   bool validate() {
//     return product != null &&
//         quantityController.text.isNotEmpty &&
//         expenseController.text.isNotEmpty;
//   }
// }

import 'dart:developer';
import 'dart:io';

import 'package:field_asistence/app/model/master/product_master.dart';
import 'package:field_asistence/app/modules/retailer/model/retailer_model_list.dart';
import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../data/constrants/constants.dart';
import '../../../data/helpers/data/image_doctor_url.dart';
import '../../../model/master/customer_model.dart';
import '../../widgets/dialog/confirmation.dart';
import '../../widgets/dialog/error.dart';
import '../../widgets/dialog/loading.dart';
import '../../widgets/form_field/form_field.dart';
import '../../widgets/form_field/form_hader.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../../widgets/widgets.dart';
import '../components/multi_select_dropdown/customer_multi_select_dropdown.dart';
import '../components/multi_select_dropdown/product_multi_selection.dart';
import '../components/multi_select_dropdown/retailer_multiselection_dropdown.dart';
import '../components/single_select_dropdown/activity_master_dropdown.dart';
import '../controller/form_a_controller.dart';
import '../model/activity_master_model.dart';

class CreateFormCpage extends StatefulWidget {
  const CreateFormCpage({super.key});

  @override
  State<CreateFormCpage> createState() => _CreateFormCpageState();
}

class _CreateFormCpageState extends State<CreateFormCpage> {
  final _formKey = GlobalKey<FormState>();
  final FormAController _formAController = Get.put(FormAController());

  ActivityMaster? _selectedActivity;
  String? selectedPartyType;

  List<Retailer> selectedRetailers = [];
  List<Customer> selectedCustomers = [];
  List<String>? selectedPartyNameListId;
  List<ProductMaster> products = [];

  final TextEditingController quantityController = TextEditingController();
  final TextEditingController expenseController = TextEditingController();
  final TextEditingController _activityDateController = TextEditingController();
  final TextEditingController _activityLocationController =
      TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String? _selectedImagePath;
  File? attachment;
  @override
  void initState() {
    super.initState();
    _activityDateController.text =
        DateFormat('dd-MM-yyyy').format(selectedDate);
  }

  @override
  void dispose() {
    _remarksController.dispose();
    _activityDateController.dispose();
    _activityLocationController.dispose();
    quantityController.dispose();
    expenseController.dispose();
    super.dispose();
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
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomBackAppBar(
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: AppColors.kPrimary.withValues(alpha: 0.15),
        title: Text(
          'Create Dealer Stock',
          style: AppTypography.kBold24.copyWith(color: AppColors.kWhite),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            const FormImageHeader(
              tag: 'form',
              image: ImageDoctorUrl.retailerImage,
              header: 'Create Dealer Stock',
              subtitle: 'Fill in the form below to create a new dealer stock',
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
                              formType: "C",
                              onSaved: (selectedActivity) {
                                setState(() {
                                  _selectedActivity = selectedActivity;

                                  if (_selectedActivity != null) {
                                    selectedPartyType =
                                        _selectedActivity!.masterLink;
                                  }
                                  selectedCustomers.clear();
                                  selectedRetailers.clear();
                                });
                              },
                              selectedItem: _selectedActivity,
                              validator: (selectedActivity) {
                                if (selectedActivity == null) {
                                  return 'Please select an activity';
                                }
                                return null;
                              },
                            ),

                            if (_selectedActivity != null) ...[
                              SizedBox(height: 16.h),
                              Container(
                                padding: EdgeInsets.all(8.w),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.kSecondary
                                      .withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: AppColors.kSecondary
                                        .withValues(alpha: 0.5),
                                  ),
                                ),
                                child: Text(
                                  'Selected Partytype: ${_selectedActivity!.masterLink}',
                                ),
                              ),
                              SizedBox(height: 16.h),
                            ],
                            // Conditional Fields based on the selected party type
                            if (selectedPartyType == "Customer") ...[
                              CustomerMultiPleSelectionScreen(
                                onSelectionChanged: (selectedCustomersitems) {
                                  setState(() {
                                    selectedCustomers = selectedCustomersitems;
                                    selectedPartyNameListId = selectedCustomers
                                        .map((e) => e.id.toString())
                                        .toList();
                                  });
                                },
                                selectedItems: selectedCustomers,
                              ),
                            ] else if (selectedPartyType == "Retailer") ...[
                              RetailerSelectionScreen(
                                onSelectionChanged: (selectedRetailersitems) {
                                  setState(() {
                                    selectedRetailers = selectedRetailersitems;
                                    selectedPartyNameListId = selectedRetailers
                                        .map((e) => e.id.toString())
                                        .toList();
                                  });
                                },
                                selectedItems: selectedRetailers,
                              ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      PrimaryContainer(
                        child: Column(
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
                            CustomTextField(
                              labelText: 'Quantity',
                              hintText: 'Enter the product quantity',
                              icon: Icons.add,
                              controller: quantityController,
                              keyboardType: TextInputType.number,
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9]')),
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the quantity';
                                }
                                return null;
                              },
                              maxLines: 1,
                            ),
                            const SizedBox(height: 16),
                            CustomTextField(
                              labelText: 'Value',
                              hintText: 'Enter the value',
                              icon: Icons.currency_rupee,
                              controller: expenseController,
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatter: [
                                FilteringTextInputFormatter.allow(
                                    // RegExp(r'^\d*\.?\d{0,2}$')),
                                    RegExp(r'^\d+\.?\d{0,2}')),
                                LengthLimitingTextInputFormatter(10),
                              ],
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter the value';
                                }
                                if (double.tryParse(value) == null) {
                                  return 'Enter a valid number';
                                }
                                return null;
                              },
                              maxLines: 1,
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
                            Text('Upload Image:*'),
                            SizedBox(height: 8.h),
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
                                          : Colors.grey),
                                ),
                                child: _selectedImagePath == null
                                    ? Center(
                                        child: Icon(Icons.camera_alt,
                                            size: 50.sp,
                                            color: AppColors.kPrimary),
                                      )
                                    : ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        child: Image.file(
                                            File(_selectedImagePath!),
                                            fit: BoxFit.cover),
                                      ),
                              ),
                            ),
                            SizedBox(height: 16.h),
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
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.red[100],
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.red),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Delete Image',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
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
                      const SizedBox(height: 16),
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
                    if (selectedRetailers.isEmpty) {
                      Get.snackbar(
                          'Error', 'Please select at least one party.');
                      return;
                    }

                    if (!products.isNotEmpty) {
                      Get.snackbar(
                          'Error', 'Please select at least one product.',
                          snackPosition: SnackPosition.BOTTOM);
                      return;
                    }

                    if (_selectedImagePath == null) {
                      Get.snackbar("Error", "Please upload an attachment.",
                          backgroundColor: Colors.red, colorText: Colors.white);
                      return;
                    }

                    _showConfirmationDialog(context);
                  } else {
                    Get.snackbar('Error', 'Please fill all required fields.');
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
      // Prepare parameters for API submission
      Map<String, dynamic> parameters = {
        'promotional_activity_type': _selectedActivity!.id,
        'party_type': selectedPartyType,
        'remarks': _remarksController.text,
        'activity_performed_date':
            DateFormat('yyyy-MM-dd').format(selectedDate),
        'activity_performed_location': _activityLocationController.text,
        'quantity': quantityController.text,
        'expense': expenseController.text,
      };
      List<MapEntry<String, String>> fields = [];

      if (selectedPartyType == "Customer") {
        for (var id in selectedCustomers) {
          fields.add(MapEntry('party_name[]', id.id.toString()));
        }
      } else if (selectedPartyType == "Retailer") {
        for (var id in selectedRetailers) {
          fields.add(MapEntry('party_name[]', id.id.toString()));
        }
      }

      for (var product in products) {
        fields.add(MapEntry('product[]', product.materialNumber.toString()));
      }

      await _formAController.submitActivityAFormData(
        'createFormC',
        parameters,
        fields,
        imageFile:
            _selectedImagePath != null ? File(_selectedImagePath!) : null,
      );

      Get.back();
      Get.snackbar('Success', 'Form submitted successfully!');
    } catch (e) {
      Get.back();
      Get.dialog(
        ErrorDialog(
          errorMessage: e.toString(),
          onClose: () {
            Get.back();
          },
        ),
        barrierDismissible: false,
      );
    } finally {
      quantityController.clear();
      expenseController.clear();
      products.clear();
    }
  }
}
