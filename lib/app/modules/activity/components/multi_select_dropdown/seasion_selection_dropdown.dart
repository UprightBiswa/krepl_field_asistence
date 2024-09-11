import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/master_controller.dart/season_controller.dart';
import '../../../../model/master/season_model.dart';
import '../../../widgets/form_field.dart/dynamic_dropdown_input_field.dart';
import '../single_select_dropdown/activity_master_dropdown.dart';

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
      } else if (seasonController.errorMessage.isNotEmpty) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.red),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Error loading Season.'),
          ),
        );
      } else {
        return MultiSelectDropdown<Season>(
          labelText: 'Select Season',
          selectedItems: selectedSeason,
          items: seasonController.seasons,
          itemAsString: (season) => '${season.season} - ${season.code}',
          searchableFields: {
            'season': (season) => season.season,
            'code': (season) => season.code,
          },
          validator: (selectedSeason) {
            if (selectedSeason.isEmpty) {
              return 'Please select at least one season.';
            }
            return null;
          },
          onChanged: (items) {
            setState(() {
              selectedSeason = items;
            });
            widget.onSelectionChanged(selectedSeason);
          },
        );
      }
    });
  }
}
