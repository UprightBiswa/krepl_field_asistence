import 'package:field_asistence/app/model/master/crop_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/master_controller.dart/crop_controller.dart';
import '../../../widgets/form_field.dart/single_selected_dropdown.dart';
import 'activity_master_dropdown.dart';

class CropSingleSelectionWidget<T> extends StatefulWidget {
  final List<int> seasonId;
  final T? selectedItem;
  final FormFieldSetter<Crop?> onSaved;
  final FormFieldValidator<Crop?> validator;
  const CropSingleSelectionWidget({
    super.key,
    required this.seasonId,
    required this.selectedItem,
    required this.onSaved,
    required this.validator,
  });

  @override
  State<CropSingleSelectionWidget> createState() =>
      _CropSingleSelectionWidgetState();
}

class _CropSingleSelectionWidgetState extends State<CropSingleSelectionWidget> {
  final CropController _cropController = Get.put(CropController());
  @override
  void initState() {
    super.initState();
    if (widget.seasonId.isNotEmpty) {
      _cropController.loadCrops(widget.seasonId);
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_cropController.isLoading.value) {
        return const ShimmerLoading();
        // Show loading shimmer
      } else if (_cropController.isError.value ||
          _cropController.errorMessage.isNotEmpty) {
        // Show error message
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Error loading activities'),
          ),
        );
      } else {
        // Show the dropdown
        return FormField<Crop?>(
          validator: widget.validator,
          onSaved: widget.onSaved,
          builder: (FormFieldState<Crop?> field) {
            return SingleSelectDropdown<Crop>(
              labelText: "Select Crop",
              items: _cropController.crops,
              selectedItem: field.value ?? widget.selectedItem,
              itemAsString: (crop) => crop.name ?? '',
              onChanged: (selected) {
                field.didChange(selected);
                widget.onSaved(selected);
                field.validate();
              },
              validator: widget.validator,
              searchableFields: {
                "code": (crop) => crop.code ?? '',
                "name": (crop) => crop.name ?? '',
              },
            );
          },
        );
      }
    });
  }
}
