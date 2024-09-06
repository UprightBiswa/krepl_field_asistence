import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/master_controller.dart/crop_stage_controller.dart';
import '../../../../model/master/crop_stage.dart';
import '../../../widgets/form_field.dart/single_selected_dropdown.dart';
import 'activity_master_dropdown.dart';

class CropStageSingleSelectionWidget<T> extends StatefulWidget {
  final T? selectedItem;
  final ValueChanged<CropStage?> onCropStageSelected;
  final String? Function(CropStage?)? validator;

  const CropStageSingleSelectionWidget({
    super.key,
    required this.selectedItem,
    required this.onCropStageSelected,
    this.validator,
  });

  @override
  State<CropStageSingleSelectionWidget> createState() =>
      _CropStageSingleSelectionWidgetState();
}

class _CropStageSingleSelectionWidgetState
    extends State<CropStageSingleSelectionWidget> {
  final CropStageController _cropStageController =
      Get.put(CropStageController());
  CropStage? _selectedCropStage;
  @override
  void initState() {
    _cropStageController.loadCropStages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_cropStageController.isLoading.value) {
        return const ShimmerLoading(); // Show shimmer loading effect while data is being fetched
      } else if (_cropStageController.isError.value ||
          _cropStageController.errorMessage.isNotEmpty) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Error loading crop stages'),
          ),
        );
      } else {
        return SingleSelectDropdown<CropStage>(
          labelText: "Select Crop Stage",
          items: _cropStageController.cropStages,
          selectedItem: _selectedCropStage ?? widget.selectedItem,
          itemAsString: (cropStage) => cropStage.name,
          onChanged: (selected) {
            setState(() {
              _selectedCropStage = selected;
            });
            widget.onCropStageSelected(selected);
          },
          searchableFields: {
            "name": (cropStage) => cropStage.name,
            "code": (cropStage) => cropStage.code,
          },
          validator: (selected) {
            final error = widget.validator?.call(selected);
            return error ??
                (selected == null ? "Please select a cropStage" : null);
          },
        );
      }
    });
  }
}