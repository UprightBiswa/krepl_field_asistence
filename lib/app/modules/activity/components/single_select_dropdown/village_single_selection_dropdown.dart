import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/master_controller.dart/village_controller.dart';
import '../../../../model/master/villages_model.dart';
import '../../../widgets/form_field.dart/single_selected_dropdown.dart';
import 'activity_master_dropdown.dart';

class VillageSingleSelectionWidget extends StatefulWidget {
  final ValueChanged<Village?> onVillageSelected;
  final String? Function(Village?)? validator;

  const VillageSingleSelectionWidget({
    super.key,
    required this.onVillageSelected,
    this.validator,
  });

  @override
  State<VillageSingleSelectionWidget> createState() =>
      _VillageSingleSelectionWidgetState();
}

class _VillageSingleSelectionWidgetState
    extends State<VillageSingleSelectionWidget> {
  final VillageController _villageController = Get.put(VillageController());
  Village? _selectedVillage;
  @override
  void initState() {
    super.initState();
    _villageController.fetchVillageMasterData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_villageController.isLoading.value) {
        return const ShimmerLoading(); // Show shimmer loading effect while data is being fetched
      } else if (_villageController.isError.value ||
          _villageController.errorMessage.isNotEmpty) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Error loading villages'),
          ),
        );
      } else {
        return SingleSelectDropdown<Village>(
          labelText: "Select Village",
          items: _villageController.villages,
          selectedItem: _selectedVillage,
          itemAsString: (village) => village.villageName,
          onChanged: (selected) {
            setState(() {
              _selectedVillage = selected; // Update the selected village
            });
            widget.onVillageSelected(
                selected); // Pass the selected village to the parent widget
          },
          searchableFields: {
            "village_name": (village) => village.villageName,
            "village_code": (village) => village.villageCode,
          },
          validator: (selected) {
            final error = widget.validator?.call(selected);
            return error ??
                (selected == null ? "Please select a village" : null);
          },
        );
      }
    });
  }
}
