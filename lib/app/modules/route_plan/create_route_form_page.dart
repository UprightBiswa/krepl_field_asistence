import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/constrants/constants.dart';
import '../../model/employee/employee_model.dart';
import '../../model/master/villages_model.dart';
import '../../model/workplace/workplace_model.dart';
import '../activity/components/multi_select_dropdown/village_multi_selecton_dropdown.dart';
import '../widgets/containers/primary_container.dart';
import '../widgets/form_field/form_field.dart';
import '../widgets/widgets.dart';
import '../widgets/form_field/dynamic_dropdown_input_field.dart';

class RouteFormPage extends StatefulWidget {
  const RouteFormPage({super.key});

  @override
  State<RouteFormPage> createState() => _RouteFormPageState();
}

class _RouteFormPageState extends State<RouteFormPage> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers
  final TextEditingController routeNameController = TextEditingController();
  final TextEditingController stateNameController = TextEditingController();
  final TextEditingController districtNameController = TextEditingController();
  final TextEditingController subDistNameController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController officeNameController = TextEditingController();
  final TextEditingController fromDateController = TextEditingController();
  final TextEditingController toDateController = TextEditingController();

  // Selected values
  List<Employee> selectedEmployees = [];
  List<WorkPlace> selectedWorkPlaces = [];
  List<Village> selectedVillages = [];

  DateTime? fromDate;
  DateTime? toDate;

  Future<void> _selectDateRange(BuildContext context) async {
    DateTimeRange? newDateRange = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2017, 1),
      lastDate: DateTime(2025, 12),
      helpText: 'Select Date Range',
    );

    if (newDateRange != null) {
      setState(() {
        fromDate = newDateRange.start;
        toDate = newDateRange.end;
        fromDateController.text =
            "${fromDate!.day}-${fromDate!.month}-${fromDate!.year}";
        toDateController.text =
            "${toDate!.day}-${toDate!.month}-${toDate!.year}";
      });
    }
  }

  bool _validateSelections() {
    bool employeesValid = selectedEmployees.isNotEmpty;
    bool workPlacesValid = selectedWorkPlaces.isNotEmpty;
    bool villagesValid = selectedVillages.isNotEmpty;
    if (!employeesValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one employee.')),
      );
    }

    if (!workPlacesValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one workplace.')),
      );
    }

    if (!villagesValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one village.')),
      );
    }

    return employeesValid && workPlacesValid && villagesValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Route Form'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.h),
          child: PrimaryContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  labelText: 'Route Name',
                  hintText: 'Enter route name',
                  icon: Icons.route,
                  controller: routeNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the route name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                MultiSelectDropdown<Employee>(
                  labelText: 'Employees',
                  // icon: Icons.people,
                  selectedItems: selectedEmployees,
                  items:
                      employeesList, // Assuming employeesList is your data source
                  // itemAsString: (Employee employee) => employee.empName,
                  itemAsString: (Employee emp) =>
                      "${emp.empCode} - ${emp.empName}",
                  searchableFields: {
                    'empCode': (Employee emp) => emp.empCode,
                    'empName': (Employee emp) => emp.empName,
                  },
                  validator: (selectedEmployees) {
                    if (selectedEmployees.isEmpty) {
                      return 'Please select at least one employee.';
                    }
                    return null;
                  },
                  // isRequired: true, // Make it required
                  // validationMessage: 'Please select at least one employee.',
                  onChanged: (List<Employee> items) {
                    setState(() {
                      selectedEmployees = items;
                    });
                  },
                ),
                SizedBox(height: 16.h),
                MultiSelectDropdown<WorkPlace>(
                  labelText: 'Workplaces',
                  // icon: Icons.work,
                  selectedItems: selectedWorkPlaces,
                  items:
                      workPlacesList, // Assuming workPlacesList is your data source
                  itemAsString: (WorkPlace workPlace) =>
                      workPlace.workPlaceName,
                  searchableFields: {
                    'workPlaceName': (WorkPlace workPlace) =>
                        workPlace.workPlaceName,
                    'workPlaceCode': (WorkPlace workPlace) =>
                        workPlace.workPlaceCode,
                  },
                  validator: (selectedWorkPlaces) {
                    if (selectedWorkPlaces.isEmpty) {
                      return 'Please select at least one workplace.';
                    }
                    return null;
                  },
                  // isRequired: true, // Make it required
                  // validationMessage: 'Please select at least one workplace.',
                  onChanged: (List<WorkPlace> items) {
                    setState(() {
                      selectedWorkPlaces = items;
                    });
                  },
                ),
                SizedBox(height: 16.h),
                VillageSelectionScreen(
                  onSelectionChanged: (List<Village> items) {
                    setState(() {
                      selectedVillages = items;
                    });
                  },
                  selectedItems: selectedVillages,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  labelText: 'State Name',
                  hintText: 'Enter state name',
                  icon: Icons.map,
                  controller: stateNameController,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  labelText: 'District Name',
                  hintText: 'Enter district name',
                  icon: Icons.map,
                  controller: districtNameController,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                  labelText: 'Sub-district Name',
                  hintText: 'Enter sub-district name',
                  icon: Icons.map,
                  controller: subDistNameController,
                ),
                SizedBox(height: 16.h),
                CustomTextField(
                    labelText: 'Pincode',
                    hintText: 'Enter pincode',
                    icon: Icons.pin_drop,
                    controller: pincodeController,
                    keyboardType: TextInputType.number,
                    inputFormatter: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(6),
                    ]),
                SizedBox(height: 16.h),
                CustomTextField(
                  labelText: 'Office Name',
                  hintText: 'Enter office name',
                  icon: Icons.business,
                  controller: officeNameController,
                ),
                SizedBox(height: 16.h),
                CustomDatePicker(
                  labelText: 'From Date',
                  hintText: 'select from date',
                  icon: Icons.calendar_today,
                  textEditingController: fromDateController,
                  onDateSelected: (context) => _selectDateRange(context),
                ),
                SizedBox(height: 16.h),
                CustomDatePicker(
                  labelText: 'To Date',
                  hintText: 'select to date',
                  icon: Icons.calendar_today,
                  textEditingController: toDateController,
                  onDateSelected: (context) => _selectDateRange(context),
                ),
              ],
            ),
          ),
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
                    if (_validateSelections()) {
                      // Handle form submission logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
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
