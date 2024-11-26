import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../activity/components/single_select_dropdown/activity_master_dropdown.dart';
import '../controller/expense_type_controller.dart';
import '../model/expense_type_model.dart';
import '../../widgets/form_field.dart/single_selected_dropdown.dart';

class ExpenseTypeDropdown<T> extends StatefulWidget {
  final T? selectedItem;
  final ValueChanged<ExpenseType?> onItemSelected;

  const ExpenseTypeDropdown({
    super.key,
    required this.selectedItem,
    required this.onItemSelected,
  });

  @override
  State<ExpenseTypeDropdown> createState() => _ExpenseTypeDropdownState();
}

class _ExpenseTypeDropdownState extends State<ExpenseTypeDropdown> {
  final ExpenseTypeController controller = Get.put(ExpenseTypeController());
  ExpenseType? _selectedItem;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Fetch expense types when the widget is initialized
    controller.fetchExpenseTypes();
    _selectedItem = widget.selectedItem as ExpenseType?;
  }

  void _validateSelection() {
    if (_selectedItem == null) {
      setState(() {
        _errorMessage = "Please select an expense type.";
      });
    } else {
      setState(() {
        _errorMessage = null; // Clear error if a valid selection is made
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const ShimmerLoading();
      } else if (controller.isError.value) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              controller.errorMessage.value,
              style: const TextStyle(color: Colors.red, fontSize: 16),
            ),
          ),
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleSelectDropdown<ExpenseType>(
              labelText: "Select Expense Type",
              items: controller.expenseTypes,
              selectedItem: _selectedItem,
              itemAsString: (item) => item.expenseType,
              onChanged: (selectedItem) {
                setState(() {
                  _selectedItem = selectedItem;
                });
                widget.onItemSelected(selectedItem); // Notify parent widget
                _validateSelection(); // Validate the selection
              },
              searchableFields: {
                'expense_type': (item) => item.expenseType,
                'id': (item) => item.id.toString(),
              },
            ),
            if (_errorMessage != null) // Show error message if present
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      }
    });
  }
}
