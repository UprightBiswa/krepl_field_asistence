import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/master_controller.dart/season_controller.dart';
import '../../../model/master/season_model.dart';
import '../../widgets/form_field.dart/dynamic_dropdown_input_field.dart';
import 'activity_master_dropdown.dart';

class SeasionSelectionScreen extends StatefulWidget {
  final void Function(List<Season>)
      onSelectionChanged; // Callback for selected items

  const SeasionSelectionScreen({super.key, required this.onSelectionChanged});

  @override
  State<SeasionSelectionScreen> createState() => _SeasionSelectionScreenState();
}

class _SeasionSelectionScreenState extends State<SeasionSelectionScreen> {
  final SeasonController seasonController = Get.put(SeasonController());
  List<Season> selectedSeason = [];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (seasonController.isLoading.value) {
        return const ShimmerLoading();
      } else if (seasonController.error.isNotEmpty) {
        return const Center(
          child: Text('Error loading Season.'),
        );
      } else {
        return MultiSelectDropdown<Season>(
          labelText: 'Select Season',
          selectedItems: selectedSeason,
          items: seasonController.seasons,
          itemAsString: (crop) => crop.name,
          searchableFields: {
            'Name': (crop) => crop.name,
            'code': (crop) => crop.code.toString(),
          },
          validator: (selectedSeason) {
            if (selectedSeason.isEmpty) {
              return 'Please select at least one crop.';
            }
            return null;
          },
          onChanged: (items) {
            setState(() {
              selectedSeason = items;
            });
            widget.onSelectionChanged(
                selectedSeason); // Notify parent of selection changes
          },
        );
      }
    });
  }
}
