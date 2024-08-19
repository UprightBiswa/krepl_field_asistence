import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/master_controller.dart/crop_stage_controller.dart';
import '../../../model/master/crop_stage.dart';
import '../../widgets/form_field.dart/dynamic_dropdown_input_field.dart';

class CropStageSelectionScreen extends StatefulWidget {
  final void Function(List<CropStage>)
      onSelectionChanged; // Callback for selected items

  const CropStageSelectionScreen({super.key, required this.onSelectionChanged});

  @override
  State<CropStageSelectionScreen> createState() =>
      _CropStageSelectionScreenState();
}

class _CropStageSelectionScreenState extends State<CropStageSelectionScreen> {
  final CropStageController cropController = Get.put(CropStageController());
  List<CropStage> selectedCropStages = [];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (cropController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (cropController.error.isNotEmpty) {
        return const Center(
          child: Text('Error loading CropStage.'),
        );
      } else {
        return MultiSelectDropdown<CropStage>(
          labelText: 'Select CropStage',
          selectedItems: selectedCropStages,
          items: cropController.cropStages,
          itemAsString: (crop) => crop.name,
          searchableFields: {
            'Name': (crop) => crop.name,
            'code': (crop) => crop.code.toString(),
          },
          validator: (selectedCropStage) {
            if (selectedCropStages.isEmpty) {
              return 'Please select at least one CropStage.';
            }
            return null;
          },
          onChanged: (items) {
            setState(() {
              selectedCropStages = items;
            });
            widget.onSelectionChanged(selectedCropStages);
          },
        );
      }
    });
  }
}