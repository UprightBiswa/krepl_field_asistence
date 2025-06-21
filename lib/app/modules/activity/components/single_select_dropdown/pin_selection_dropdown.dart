import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../farmer/controller/pin_list_controller.dart';
import '../../../farmer/model/pin_model.dart';
import '../../../widgets/form_field/single_selected_dropdown.dart';
import 'activity_master_dropdown.dart';

class PinSingleSelectionWidget<T> extends StatefulWidget {
  final T? selectedItem;
  final ValueChanged<PinModel?> onPinModelSelected;
  final String? Function(PinModel?)? validator;

  const PinSingleSelectionWidget({
    super.key,
    required this.selectedItem,
    required this.onPinModelSelected,
    this.validator,
  });

  @override
  State<PinSingleSelectionWidget> createState() =>
      _PinSingleSelectionWidgetState();
}

class _PinSingleSelectionWidgetState extends State<PinSingleSelectionWidget> {
  final PinController pinController = Get.put(PinController());
  PinModel? _selectedPinModel;
  @override
  void initState() {
    super.initState();
    pinController.fetchPins();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (pinController.isLoading.value) {
        return const ShimmerLoading(); // Show shimmer loading effect while data is being fetched
      } else if (pinController.isError.value ||
          pinController.errorMessage.isNotEmpty) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Error loading Pin'),
          ),
        );
      } else {
        return SingleSelectDropdown<PinModel>(
          labelText: "Select Pin",
          items: pinController.pinList,
          selectedItem: _selectedPinModel ?? widget.selectedItem,
          itemAsString: (pinModel) => pinModel.pin,
          onChanged: (selected) {
            setState(() {
              _selectedPinModel = selected; // Update the selected PinModel
            });
            widget.onPinModelSelected(
                selected); // Pass the selected PinModel to the parent widget
          },
          searchableFields: {
            "PinModel_name": (pinModel) => pinModel.pin,
            "PinModel_code": (pinModel) => pinModel.id.toString(),
          },
          validator: (selected) {
            final error = widget.validator?.call(selected);
            return error ?? (selected == null ? "Please select a Pin" : null);
          },
        );
      }
    });
  }
}
