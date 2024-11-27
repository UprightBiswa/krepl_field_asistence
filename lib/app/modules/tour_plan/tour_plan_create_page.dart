import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../data/constrants/constants.dart';
import '../../repository/auth/auth_token.dart';
import '../activity/components/expanded_object.dart';
import '../activity/components/single_select_dropdown/activity_master_dropdown.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/dialog/confirmation.dart';
import '../widgets/form_field.dart/custom_datepicker_filed.dart';
import '../widgets/form_field.dart/custom_dropdown_field.dart';
import '../widgets/form_field.dart/custom_text_field.dart';
import '../widgets/form_field.dart/single_selected_dropdown.dart';
import '../widgets/texts/custom_header_text.dart';
import '../widgets/widgets.dart';
import 'controller/tour_plan_create_controller.dart';
import 'controller/expense_type_controller.dart';
import 'model/expense_type_model.dart';

class TourPlanCreatePage extends StatefulWidget {
  const TourPlanCreatePage({super.key});

  @override
  State<TourPlanCreatePage> createState() => _TourPlanCreatePageState();
}

class _TourPlanCreatePageState extends State<TourPlanCreatePage> {
  final ExpenseCreateController controller = Get.put(ExpenseCreateController());
  final AuthState authState = AuthState();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ExpenseTypeController expenseTypeController =
      Get.put(ExpenseTypeController());

  // Controllers for text fields
  final TextEditingController workPlaceCodeController = TextEditingController();
  final TextEditingController workPlaceNameController = TextEditingController();
  final TextEditingController hrEmployeeCodeController =
      TextEditingController();
  final TextEditingController employeeNameController = TextEditingController();

  List<ExpenseItem> expenseObjects = [ExpenseItem()];
  @override
  void initState() {
    super.initState();
    initializeControllers();
    expenseTypeController.fetchExpenseTypes();
  }

  void addNewObject() {
    setState(() {
      expenseObjects.add(ExpenseItem());
    });
  }

  void removeObject(int index) {
    setState(() {
      expenseObjects[index].disposeControllers();
      expenseObjects.removeAt(index);
    });
  }

  Future<void> initializeControllers() async {
    final workplaceCode = await authState.getWorkplaceCode();
    final workplaceName = await authState.getWorkplaceName();
    final hrEmployeeCode = await authState.getHrEmployeeCode();
    final employeeName = await authState.getEmployeeName();

    workPlaceCodeController.text = workplaceCode ?? '';
    workPlaceNameController.text = workplaceName ?? '';
    hrEmployeeCodeController.text = hrEmployeeCode ?? '';
    employeeNameController.text = employeeName ?? '';
  }

  @override
  void dispose() {
    workPlaceCodeController.dispose();
    workPlaceNameController.dispose();
    hrEmployeeCodeController.dispose();
    employeeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackAppBar(
        spaceBar: true,
        leadingCallback: () {
          Get.back<void>();
        },
        iconColor: AppColors.kPrimary.withOpacity(0.15),
        title: Text(
          'Create Expense',
          style: AppTypography.kBold14.copyWith(
            color: AppColors.kDarkContiner,
          ),
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 18.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                PrimaryContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomHeaderText(
                        text: 'User\'s Basic Details',
                        fontSize: 20.sp,
                      ),
                      SizedBox(height: 16.h),
                      CustomTextField(
                        readonly: true,
                        labelText: "Employee Name",
                        hintText: "Enter the employee name",
                        icon: Icons.person,
                        controller: employeeNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the employee name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        readonly: true,
                        labelText: "HR Employee Code",
                        hintText: "Enter the HR employee code",
                        icon: Icons.badge,
                        controller: hrEmployeeCodeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the HR employee code';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        readonly: true,
                        labelText: "Work Place Code",
                        hintText: "Enter the work place code",
                        icon: Icons.work,
                        controller: workPlaceCodeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the work place code';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      CustomTextField(
                        readonly: true,
                        labelText: "Work Place Name",
                        hintText: "Enter the work place name",
                        icon: Icons.business,
                        controller: workPlaceNameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the work place name';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                // Add expense items dynamically

                ...expenseObjects.asMap().entries.map((entry) {
                  final index = entry.key;
                  final expense = entry.value;
                  return ExpandedObject(
                    title: 'Expense ${index + 1}',
                    onDismissed: () {
                      if (expenseObjects.length > 1) {
                        removeObject(index);
                      }
                    },
                    isExpanded: true,
                    onExpansionChanged: (isExpanded) {
                      return true;
                    },
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(() {
                            if (expenseTypeController.isLoading.value) {
                              return const ShimmerLoading();
                            } else if (expenseTypeController.isError.value) {
                              return Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.red[100],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    expenseTypeController.errorMessage.value,
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 16),
                                  ),
                                ),
                              );
                            } else {
                              return SingleSelectDropdown<ExpenseType>(
                                labelText: "Select Expense Type",
                                items: expenseTypeController.expenseTypes,
                                selectedItem: expense.expenseType,
                                itemAsString: (item) => item.expenseType,
                                onChanged: (selectedItem) {
                                  WidgetsBinding.instance
                                      .addPostFrameCallback((_) {
                                    setState(() {
                                      expense.expenseType = selectedItem;
                                    });
                                  });
                                },
                                searchableFields: {
                                  'expense_type': (item) => item.expenseType,
                                  'id': (item) => item.id.toString(),
                                },
                              );
                            }
                          }),
                          const SizedBox(height: 20),
                          // Month Picker
                          CustomDatePicker(
                            labelText: 'Month',
                            hintText: "Select month",
                            icon: Icons.calendar_today,
                            onDateSelected: (context) async {
                              final selectedMonth = await showMonthPicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2020),
                                lastDate: DateTime(2030),
                              );
                              if (selectedMonth != null) {
                                expense.monthController.text =
                                    "${selectedMonth.month.toString().padLeft(2, '0')}-${selectedMonth.year}";
                              }
                            },
                            textEditingController: expense.monthController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field is required';
                              }
                              return null;
                            },
                          ),

                          const SizedBox(height: 20),
                          // Financial Year Dropdown
                          CustomDropdownField(
                            labelText: "Financial Year",
                            icon: Icons.calendar_today,
                            items: controller.getFinancialYears(),
                            onChanged: (value) {
                              if (value != null) {
                                expense.financialYearController.text = value;
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Field is required';
                              }
                              return null;
                            },
                            value:
                                expense.financialYearController.text.isNotEmpty
                                    ? expense.financialYearController.text
                                    : null,
                          ),

                          const SizedBox(height: 20),
                          CustomTextField(
                            labelText: "Amount",
                            hintText: "Enter amount",
                            icon: Icons.currency_rupee_rounded,
                            inputFormatter: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'^\d+\.?\d{0,2}'),
                              ),
                              LengthLimitingTextInputFormatter(10),
                            ],
                            controller: expense.amountController,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value?.isEmpty ?? true) {
                                return 'Field is required';
                              }
                              if (double.tryParse(value!) == null ||
                                  double.parse(value) <= 0) {
                                return 'Enter a valid amount';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ],
                  );
                }),
                // Add New Expense Button
                PrimaryButton(
                  color: AppColors.kSecondary,
                  isBorder: true,
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Check if all expense objects are valid
                      bool allValid = expenseObjects.every((expense) {
                        return expense.expenseType != null &&
                            expense.monthController.text.isNotEmpty &&
                            expense.financialYearController.text.isNotEmpty &&
                            expense.amountController.text.isNotEmpty;
                      });
                      if (!allValid) {
                        Get.snackbar('Error',
                            'Please fill all fields for each expense item.');
                        return;
                      }
                      addNewObject();
                    } else {
                      Get.snackbar(
                        'Error',
                        'Please fill all the fields',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  text: 'Add New Expense',
                ),

                const SizedBox(height: 20),
              ],
            ),
          )),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: AppColors.kPrimary2,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: PrimaryButton(
          onTap: () {
            if (_formKey.currentState?.validate() ?? false) {
              // Check if all expense objects are valid
              bool allValid = expenseObjects.every((expense) {
                return expense.expenseType != null &&
                    expense.monthController.text.isNotEmpty &&
                    expense.financialYearController.text.isNotEmpty &&
                    expense.amountController.text.isNotEmpty;
              });

              if (!allValid) {
                Get.snackbar(
                    'Error', 'Please fill all fields for each expense item.');
                return;
              }
              _formKey.currentState?.save();
              _showConfirmationDialog(context);
            } else {
              Get.snackbar(
                'Error',
                'Please fill all the fields',
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          },
          text: "Submit",
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

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      // Check if all expense objects are valid
      bool allValid = expenseObjects.every((expense) {
        return expense.expenseType != null &&
            expense.monthController.text.isNotEmpty &&
            expense.financialYearController.text.isNotEmpty &&
            expense.amountController.text.isNotEmpty;
      });

      if (!allValid) {
        Get.snackbar('Error', 'Please fill all fields for each expense item.');
        return;
      }

      // Show loading dialog
      Get.dialog(
        const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );

      List<MapEntry<String, String>> fields = [];

      // Add list fields
      for (var item in expenseObjects) {
        fields.addAll([
          MapEntry('expense_type[]', item.expenseType?.id.toString() ?? ''),
          MapEntry('month[]', item.monthController.text.trim()),
          MapEntry(
              'financial_year[]', item.financialYearController.text.trim()),
          MapEntry('amount[]', item.amountController.text.trim()),
        ]);
      }

      // Proceed with submission
      controller
          .submitForm(
        workplaceCode: workPlaceCodeController.text,
        workplaceName: workPlaceNameController.text,
        hrEmployeeCode: hrEmployeeCodeController.text,
        employeeName: employeeNameController.text,
        fields: fields,
      )
          .then((_) {
        // Close loading dialog
        Get.back();

        if (controller.isError.value) {
          // Show error dialog
          Get.dialog(
            AlertDialog(
              title: const Text('Error'),
              content: Text(controller.errorMessage.value),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back(); // Close dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          // Show success dialog
          Get.dialog(
            AlertDialog(
              title: const Text('Success'),
              content: const Text('Expense submitted successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Get.back(); // Close dialog
                    Get.back(); // Return to previous screen
                    //claeer all the fields object
                    Get.back();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      }).catchError((error) {
        Get.back(); // Close loading dialog
        // Handle unexpected errors
        Get.dialog(
          AlertDialog(
            title: const Text('Error'),
            content: Text('An unexpected error occurred: $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Get.back(); // Close dialog
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
    }
  }
}
