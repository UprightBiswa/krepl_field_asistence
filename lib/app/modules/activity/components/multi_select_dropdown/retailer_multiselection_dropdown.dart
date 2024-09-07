import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../retailer/controller/retailer_controller.dart';
import '../../../retailer/model/retailer_model_list.dart';
import '../../../widgets/form_field.dart/dynamic_dropdown_input_field.dart';
import '../single_select_dropdown/activity_master_dropdown.dart';

class RetailerSelectionScreen extends StatefulWidget {
  final void Function(List<Retailer>) onSelectionChanged;
  final List<Retailer> selectedItems;

  const RetailerSelectionScreen({
    super.key,
    required this.onSelectionChanged,
    required this.selectedItems,
  });

  @override
  State<RetailerSelectionScreen> createState() => _RetailerSelectionScreenState();
}

class _RetailerSelectionScreenState extends State<RetailerSelectionScreen> {
  final RetailerController retailerController = Get.put(RetailerController());
  late List<Retailer> selectedRetailers;

  @override
  void initState() {
    selectedRetailers = widget.selectedItems;
    retailerController.fetchAllRetailers(); // Fetch Retailer data on init
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (retailerController.isLoading.value) {
        return const ShimmerLoading();
      } else if (retailerController.isErrorAllRetailer.value) {
        return const Center(
          child: Text('Error loading Retailers.'),
        );
      } else {
        return MultiSelectDropdown<Retailer>(
          labelText: 'Select Retailers',
          selectedItems: selectedRetailers,
          items: retailerController.allRetailer,
          itemAsString: (retailers) => retailers.retailerName,
          searchableFields: {
            'retailerName': (retailers) => retailers.retailerName,
            'mobileNumber': (retailers) => retailers.mobileNumber,
          },
          validator: (selectedRetailers) {
            if (selectedRetailers.isEmpty) {
              return 'Please select at least one Retailer.';
            }
            return null;
          },
          onChanged: (items) {
            setState(() {
              selectedRetailers = items;
            });
            widget.onSelectionChanged(
                selectedRetailers); // Notify parent of selection changes
          },
        );
      }
    });
  }
}
