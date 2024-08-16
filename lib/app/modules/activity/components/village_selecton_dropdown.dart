import 'package:field_asistence/app/model/master/villages_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/master_controller.dart/Village_controller.dart';
import '../../widgets/form_field.dart/dynamic_dropdown_input_field.dart';

class VillageSelectionScreen extends StatefulWidget {
  final void Function(List<Village>) onSelectionChanged;

  const VillageSelectionScreen({super.key, required this.onSelectionChanged});

  @override
  State<VillageSelectionScreen> createState() => _VillageSelectionScreenState();
}

class _VillageSelectionScreenState extends State<VillageSelectionScreen> {
  final VillageController villageController = Get.put(VillageController());
  List<Village> selectedVillages = [];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (villageController.isLoading.value) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (villageController.error.isNotEmpty) {
        return const Center(
          child: Text('Error loading Villages.'),
        );
      } else {
        return MultiSelectDropdown<Village>(
          labelText: 'Select Villages',
          selectedItems: selectedVillages,
          items: villageController.villages,
          itemAsString: (village) => village.villageName,
          searchableFields: {
            'villageName': (village) => village.villageName,
            'villageCode': (village) => village.villageCode,
          },
          validator: (selectedVillages) {
            if (selectedVillages.isEmpty) {
              return 'Please select at least one Village.';
            }
            return null;
          },
          onChanged: (items) {
            setState(() {
              selectedVillages = items;
            });
            widget.onSelectionChanged(
                selectedVillages); // Notify parent of selection changes
          },
        );
      }
    });
  }
}
