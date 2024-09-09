import 'package:field_asistence/app/model/master/product_master.dart';
import 'package:field_asistence/app/modules/retailer/model/retailer_model_list.dart';
import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../../data/helpers/data/image_doctor_url.dart';
import '../../../model/master/customer_model.dart';
import '../../widgets/dialog/confirmation.dart';
import '../../widgets/dialog/error.dart';
import '../../widgets/dialog/loading.dart';
import '../../widgets/form_field.dart/form_field.dart';
import '../../widgets/form_field.dart/form_hader.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../../widgets/widgets.dart';
import '../components/expanded_object.dart';
import '../components/multi_select_dropdown/customer_multi_select_dropdown.dart';
import '../components/multi_select_dropdown/retailer_multiselection_dropdown.dart';
import '../components/single_select_dropdown/activity_master_dropdown.dart';
import '../components/single_select_dropdown/product_selection_autofill.dart';
import '../controller/form_a_controller.dart';
import '../model/activity_master_model.dart';

class CreateFormCpage extends StatefulWidget {
  const CreateFormCpage({super.key});

  @override
  State<CreateFormCpage> createState() => _CreateFormCpageState();
}

class _CreateFormCpageState extends State<CreateFormCpage> {
  final FormAController _formAController = Get.put(FormAController());
  final _formKey = GlobalKey<FormState>();
  List<ActivityObjectC> activityObjectsC = [ActivityObjectC()];
  final TextEditingController _remarksController = TextEditingController();

  ActivityMaster? _selectedActivity;
  String? selectedPartyType;

  List<Retailer> selectedRetailers = [];
  List<Customer> selectedCustomers = [];
  List<String>? selectedPartyNameListId;

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  void addNewObject() {
    setState(() {
      activityObjectsC.add(ActivityObjectC());
    });
  }

  // Remove an ActivityObject
  void removeObject(int index) {
    setState(() {
      activityObjectsC.removeAt(index);
    });
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
          'Create Dealer Stock',
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
                              text: 'Activity\'s Basic Details',
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
                                  color: AppColors.kSecondary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color:
                                        AppColors.kSecondary.withOpacity(0.5),
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
                      ...activityObjectsC.asMap().entries.map(
                        (entry) {
                          final index = entry.key;
                          final activityObject = entry.value;
                          return ExpandedObject(
                            title: 'Product\'s Details ${index + 1}',
                            onDismissed: () => removeObject(index),
                            isExpanded: true,
                            onExpansionChanged: (isExpanded) => true,
                            children: [
                              Column(
                                children: [
                                  ProductMasterSelector(
                                    labelText: 'Select Products',
                                    icon: Icons.arrow_drop_down,
                                    onChanged: (selectedProduct) {
                                      setState(() {
                                        activityObject.product =
                                            selectedProduct;
                                      });
                                    },
                                    selectedItem: activityObject.product,
                                    itemAsString: (product) =>
                                        product.materialDescription,
                                  ),
                                  const SizedBox(height: 16),
                                  CustomTextField(
                                    labelText: 'Quantity',
                                    hintText: 'Enter the product quantity',
                                    icon: Icons.add,
                                    controller:
                                        activityObject.quantityController,
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
                                    labelText: 'Expense',
                                    hintText: 'Enter the expense',
                                    icon: Icons.currency_rupee,
                                    controller:
                                        activityObject.expenseController,
                                    keyboardType: TextInputType.number,
                                    inputFormatter: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp(r'^\d+\.?\d{0,2}'),
                                      ),
                                      LengthLimitingTextInputFormatter(10),
                                    ],
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

                      // Add New Product Button
                      PrimaryButton(
                        text: 'Add More Products',
                        color: AppColors.kSecondary,
                        isBorder: true,
                        onTap: () {
                          bool allValid = true;
                          for (var activityObject in activityObjectsC) {
                            if (!activityObject.validate()) {
                              allValid = false;
                              Get.snackbar('Error',
                                  'Please complete all fields before adding more.',
                                  snackPosition: SnackPosition.BOTTOM);
                              break;
                            }
                          }
                          if (allValid) addNewObject();
                        },
                      ),

                      const SizedBox(height: 16),
                      PrimaryContainer(
                        child: Column(
                          children: [
                            CustomHeaderText(
                              text: 'Remarks',
                              fontSize: 20.sp,
                            ),
                            const SizedBox(height: 16),
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
                    for (var activityObject in activityObjectsC) {
                      if (!activityObject.validate()) {
                        Get.snackbar('Error',
                            'Please complete all fields before submitting.',
                            snackPosition: SnackPosition.BOTTOM);
                        return;
                      }
                    }
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
      // Prepare parameters for API submission
      Map<String, dynamic> parameters = {
        'promotional_activity_type': _selectedActivity!.id,
        'party_type': selectedPartyType,
        'remarks': _remarksController.text,
      };
      List<MapEntry<String, String>> fields = [];

      if (selectedPartyType == "Customer") {
        for (var id in selectedCustomers) {
          fields.add(MapEntry('party_name[]', id.id.toString()));
        }
        // parameters['party_name[]'] = selectedCustomers.map((e) => e.id.toString()).toList();
      } else if (selectedPartyType == "Retailer") {
        for (var id in selectedRetailers) {
          fields.add(MapEntry('party_name[]', id.id.toString()));
        }
        // parameters['party_name[]'] = selectedRetailers.map((e) => e.id.toString()).toList();
      }

      for (var activity in activityObjectsC) {
        fields.add(
            MapEntry('product[]', activity.product!.materialNumber.toString()));
        fields.add(MapEntry('quantity[]', activity.quantityController.text));
        fields.add(MapEntry('expense[]', activity.expenseController.text));
      }

      await _formAController.submitActivityAFormData(
        'createFormC',
        parameters,
        fields,
      );

      Get.back(); // Close loading dialog
      Get.snackbar('Success', 'Form submitted successfully!');
    } catch (e) {
      Get.back(); // Close loading dialog
      Get.dialog(
        ErrorDialog(
          errorMessage: e.toString(),
          onClose: () {
            Get.back(); // Close error dialog
          },
        ),
        barrierDismissible: false,
      );
    }
  }
}

class ActivityObjectC {
  ProductMaster? product;
  TextEditingController quantityController = TextEditingController();
  TextEditingController expenseController = TextEditingController();

  bool validate() {
    return product != null &&
        quantityController.text.isNotEmpty &&
        expenseController.text.isNotEmpty;
  }
}
