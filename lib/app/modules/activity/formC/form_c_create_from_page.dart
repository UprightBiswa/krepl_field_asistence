import 'package:field_asistence/app/model/master/product_master.dart';
import 'package:field_asistence/app/modules/retailer/model/retailer_model_list.dart';
import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../data/constrants/constants.dart';
import '../../../model/master/customer_model.dart';
import '../../widgets/form_field.dart/form_field.dart';
import '../../widgets/texts/custom_header_text.dart';
import '../../widgets/widgets.dart';
import '../components/multi_select_dropdown/customer_multi_select_dropdown.dart';
import '../components/multi_select_dropdown/retailer_multiselection_dropdown.dart';
import '../components/single_select_dropdown/activity_master_dropdown.dart';
import '../components/single_select_dropdown/product_selection_autofill.dart';
import '../model/activity_master_model.dart';

class CreateFormCpage extends StatefulWidget {
  const CreateFormCpage({super.key});

  @override
  State<CreateFormCpage> createState() => _CreateFormCpageState();
}

class _CreateFormCpageState extends State<CreateFormCpage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _remarksController = TextEditingController();

  ActivityMaster? _selectedActivity;
  String? selectedPartyType;

  List<Retailer> selectedRetailers = [];
  List<Customer> selectedCustomers = [];
  List<String>? selectedPartyNameListId;

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
          'Create Dealer Stock',
          style: AppTypography.kBold14.copyWith(
            color: isDarkMode(context)
                ? AppColors.kWhite
                : AppColors.kDarkContiner,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
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
                            selectedPartyType = _selectedActivity!.masterLink;
                          }
                          //clear privions selected items from
                          // List<Retailer> selectedRetailers = [];
                          // List<Customer> selectedCustomers = [];
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
                      Text(
                        'Selected Partytype: ${_selectedActivity!.masterLink}',
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
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              PrimaryContainer(
                child: Column(
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
                      icon: Icons.attach_money,
                      controller: ,
                      keyboardType: TextInputType.number,
                      inputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
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
                      icon: Icons.attach_money,
                      controller: ,
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
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              PrimaryButton(
                color: AppColors.kSecondary,
                isBorder: true,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    if (_formKey.currentState?.validate() ?? false) {
                      bool allValid = true;

                      // Validate all current activityObjects
                      for (var activityObject in activityObjects) {
                        if (!activityObject.validate()) {
                          allValid = false;
                          Get.snackbar('Error',
                              'Please complete all fields before adding more.');
                          break;
                        }
                      }

                      // If all are valid, add a new object
                      if (allValid) {
                        // setState(() {
                        //   activityObjects.add(ActivityObject());
                        // });
                        addNewObject();
                      }
                    } else {
                      Get.snackbar('Error', 'Please fill the form correctly.');
                    }
                  }
                },
                text: 'Add More Products',
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
