import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/master_controller.dart/Pest_controller.dart';
import '../../../../model/master/pest_master.dart';
import '../../../widgets/form_field.dart/dynamic_dropdown_input_field.dart';
import '../single_select_dropdown/activity_master_dropdown.dart';

class PestSelectionScreen extends StatefulWidget {
  final void Function(List<Pest>)
      onSelectionChanged; // Callback for selected items

  const PestSelectionScreen({super.key, required this.onSelectionChanged});

  @override
  State<PestSelectionScreen> createState() => _PestSelectionScreenState();
}

class _PestSelectionScreenState extends State<PestSelectionScreen> {
  final PestController pestController = Get.put(PestController());
  List<Pest> selectedPests = [];

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (pestController.isLoading.value) {
        return const ShimmerLoading();
      } else if (pestController.errorMessage.isNotEmpty) {
        return const Center(
          child: Text('Error loading Pests.'),
        );
      } else {
        return MultiSelectDropdown<Pest>(
          labelText: 'Select Pests',
          selectedItems: selectedPests,
          items: pestController.pests,
          itemAsString: (pest) => pest.pest,
          searchableFields: {
            'Name': (pest) => pest.pest,
            'code': (pest) => pest.code,
          },
          validator: (selectedPests) {
            if (selectedPests.isEmpty) {
              return 'Please select at least one Pest.';
            }
            return null;
          },
          onChanged: (items) {
            setState(() {
              selectedPests = items;
            });
            widget.onSelectionChanged(
                selectedPests); // Notify parent of selection changes
          },
        );
      }
    });
  }
}
