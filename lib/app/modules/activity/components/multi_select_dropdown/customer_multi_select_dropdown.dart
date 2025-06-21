import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/master_controller/customer_controller.dart';
import '../../../../model/master/customer_model.dart';
import '../../../widgets/form_field/dynamic_dropdown_input_field.dart';
import '../single_select_dropdown/activity_master_dropdown.dart';

class CustomerMultiPleSelectionScreen extends StatefulWidget {
  final void Function(List<Customer>) onSelectionChanged;
  final List<Customer> selectedItems;
  const CustomerMultiPleSelectionScreen({
    super.key,
    required this.onSelectionChanged,
    required this.selectedItems,
  });

  @override
  State<CustomerMultiPleSelectionScreen> createState() =>
      _CustomerMultiPleSelectionScreenState();
}

class _CustomerMultiPleSelectionScreenState
    extends State<CustomerMultiPleSelectionScreen> {
  final CustomerController customerController = Get.put(CustomerController());
  List<Customer> selectedCustomers = [];

  @override
  void initState() {
    super.initState();
    selectedCustomers = widget.selectedItems;
    customerController.loadcustomer(); // Fetch customer data on init
  }

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
          itemAsString: (customers) {
            return '${customers.customerName} (${customers.customerNumber})';
          },
          searchableFields: {
            'name': (customers) => customers.customerName,
            'code': (customers) => customers.customerNumber,
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
