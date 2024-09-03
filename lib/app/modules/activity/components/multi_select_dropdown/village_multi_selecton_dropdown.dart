import 'package:field_asistence/app/model/master/villages_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/master_controller.dart/Village_controller.dart';
import '../../../widgets/form_field.dart/dynamic_dropdown_input_field.dart';
import '../single_select_dropdown/activity_master_dropdown.dart';

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
  void initState() {
    super.initState();
    villageController.fetchVillageMasterData(); // Fetch village data on init
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (villageController.isLoading.value) {
        return const ShimmerLoading();
        // } else if (villageController.isError.value) {
        //   return const Center(
        //     child: Text('Error loading Villages. Please try again later.'),
        //   );
        // }
      } else if (villageController.isError.value) {
        return Center(
          child: Text(
            villageController.errorMessage.value,
            style: const TextStyle(color: Colors.red),
          ),
        ); // Show error message
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
            widget.onSelectionChanged(selectedVillages);
          },
        );
      }
    });
  }
}
