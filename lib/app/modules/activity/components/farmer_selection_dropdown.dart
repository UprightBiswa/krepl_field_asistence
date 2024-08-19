
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../farmer/controller/farmer_controller.dart';
import '../../farmer/model/farmer_list.dart';
import '../../widgets/form_field.dart/dynamic_dropdown_input_field.dart';

class FarmerSelectionScreen extends StatefulWidget {
  final void Function(List<Farmer>)
      onSelectionChanged; // Callback for selected items

  const FarmerSelectionScreen({super.key, required this.onSelectionChanged});

  @override
  State<FarmerSelectionScreen> createState() => _FarmerSelectionScreenState();
}

class _FarmerSelectionScreenState extends State<FarmerSelectionScreen> {
  final FarmerController farmerController = Get.put(FarmerController());
  List<Farmer> selectedFarmers = [];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (farmerController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (farmerController.errorMessage.isNotEmpty) {
        return const Center(
          child: Text('Error loading farmer.'),
        );
      } else {
        return MultiSelectDropdown<Farmer>(
          labelText: 'Select farmer',
          selectedItems: selectedFarmers,
          items: farmerController.filteredFarmers,
          itemAsString: (farmers) => farmers.farmersName,
          searchableFields: {
            'farmersName': (farmers) => farmers.farmersName,
            'mobileNumber': (farmers) => farmers.mobileNumber,
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