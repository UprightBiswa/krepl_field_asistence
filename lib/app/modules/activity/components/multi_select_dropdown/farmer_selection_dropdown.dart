import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../farmer/controller/farmer_controller.dart';
import '../../../farmer/model/farmer_list.dart';
import '../../../widgets/form_field.dart/dynamic_dropdown_input_field.dart';
import '../single_select_dropdown/activity_master_dropdown.dart';

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
        return const ShimmerLoading();
      } else if (farmerController.errorMessage.isNotEmpty) {
        return const Center(
          child: Text('Error loading farmer.'),
        );
      } else {
        return MultiSelectDropdown<Farmer>(
          labelText: 'Select farmer',
          selectedItems: selectedFarmers,
          items: farmerController.allFarmers,
          itemAsString: (farmers) => farmers.farmerName??'',
          searchableFields: {
            'farmersName': (farmers) => farmers.farmerName?? '',
            'mobileNumber': (farmers) => farmers.mobileNo?? '',
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
