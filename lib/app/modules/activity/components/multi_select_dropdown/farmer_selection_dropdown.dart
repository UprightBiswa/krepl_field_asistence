import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../farmer/controller/farmer_list_view_controller.dart';
import '../../../farmer/model/farmer_list.dart';
import '../../../widgets/form_field.dart/dynamic_dropdown_input_field.dart';
import '../single_select_dropdown/activity_master_dropdown.dart';

class FarmerSelectionScreen extends StatefulWidget {
  final void Function(List<Farmer>) onSelectionChanged;
  final List<Farmer> selectedItems;

  const FarmerSelectionScreen({
    super.key,
    required this.onSelectionChanged,
    required this.selectedItems,
  });

  @override
  State<FarmerSelectionScreen> createState() => _FarmerSelectionScreenState();
}

class _FarmerSelectionScreenState extends State<FarmerSelectionScreen> {
  final FarmerListController farmerController = Get.put(FarmerListController());
  late List<Farmer> selectedFarmers;

  @override
  void initState() {
    super.initState();
    selectedFarmers = widget.selectedItems;
    farmerController.fetchAllFarmers(); // Fetch farmer data on init
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (farmerController.isLoading.value) {
        return const ShimmerLoading();
      } else if (farmerController.errorMessage.isNotEmpty) {
        return const Center(
          child: Text('Error loading farmer.'),
        );
      } else {
        return MultiSelectDropdown<Farmer>(
          labelText: 'Select farmer',
          selectedItems: selectedFarmers,
          items: farmerController.allFarmer,
          itemAsString: (farmers) => farmers.farmerName ?? '',
          searchableFields: {
            'farmersName': (farmers) => farmers.farmerName ?? '',
            'mobileNumber': (farmers) => farmers.mobileNo ?? '',
          },
          validator: (selectedFarmers) {
            if (selectedFarmers.isEmpty) {
              return 'Please select at least one farmer.';
            }
            return null;
          },
          onChanged: (items) {
            setState(() {
              selectedFarmers = items;
            });
            widget.onSelectionChanged(
                selectedFarmers); // Notify parent of selection changes
          },
        );
      }
    });
  }
}
