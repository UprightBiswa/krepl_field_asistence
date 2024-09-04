import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/master_controller.dart/customer_controller.dart';
import '../../../widgets/form_field.dart/dynamic_dropdown_input_field.dart';
import '../single_select_dropdown/activity_master_dropdown.dart';

class CustomerMultiPleSelectionScreen extends StatefulWidget {
  final void Function(List<Customer>)
      onSelectionChanged; // Callback for selected items

  const CustomerMultiPleSelectionScreen(
      {super.key, required this.onSelectionChanged});

  @override
  State<CustomerMultiPleSelectionScreen> createState() =>
      _CustomerMultiPleSelectionScreenState();
}

class _CustomerMultiPleSelectionScreenState
    extends State<CustomerMultiPleSelectionScreen> {
  final CustomerController customerController = Get.put(CustomerController());
  List<Customer> selectedCustomers = [];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (customerController.isLoading.value) {
        return const ShimmerLoading();
      } else if (customerController.error.isNotEmpty) {
        return const Center(
          child: Text('Error loading Customers.'),
        );
      } else {
        return MultiSelectDropdown<Customer>(
          labelText: 'Select Customers',
          selectedItems: selectedCustomers,
          items: customerController.customer,
          itemAsString: (customers) => customers.name,
          searchableFields: {
            'name': (customers) => customers.name,
            'code': (customers) => customers.code,
          },
          validator: (selectedDoctors) {
            if (selectedDoctors.isEmpty) {
              return 'Please select at least one Customers.';
            }
            return null;
          },
          onChanged: (items) {
            setState(() {
              selectedCustomers = items;
            });
            widget.onSelectionChanged(selectedCustomers);
          },
        );
      }
    });
  }
}
