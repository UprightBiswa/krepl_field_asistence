import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/master_controller.dart/crop_controller.dart';
import '../../../model/master/crop_model.dart';
import '../../widgets/form_field.dart/dynamic_dropdown_input_field.dart';

class CropSelectionScreen extends StatefulWidget {
  final void Function(List<Crop>)
      onSelectionChanged; // Callback for selected items

  const CropSelectionScreen({super.key, required this.onSelectionChanged});

  @override
  State<CropSelectionScreen> createState() => _CropSelectionScreenState();
}

class _CropSelectionScreenState extends State<CropSelectionScreen> {
  final CropController cropController = Get.put(CropController());
  List<Crop> selectedCrops = [];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (cropController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (cropController.error.isNotEmpty) {
        return const Center(
          child: Text('Error loading crops.'),
        );
      } else {
        return MultiSelectDropdown<Crop>(
          labelText: 'Select Crops',
          selectedItems: selectedCrops,
          items: cropController.crops,
          itemAsString: (crop) => crop.name,
          searchableFields: {
            'Name': (crop) => crop.name,
            'code': (crop) => crop.code.toString(),
          },
          validator: (selectedCrops) {
            if (selectedCrops.isEmpty) {
              return 'Please select at least one crop.';
            }
            return null;
          },
          onChanged: (items) {
            setState(() {
              selectedCrops = items;
            });
            widget.onSelectionChanged(
                selectedCrops); // Notify parent of selection changes
          },
        );
      }
    });
  }
}
