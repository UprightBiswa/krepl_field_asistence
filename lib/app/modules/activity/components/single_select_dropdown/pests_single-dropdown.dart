import 'package:field_asistence/app/model/master/pest_master.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/master_controller/pest_controller.dart';
import '../../../widgets/form_field/single_selected_dropdown.dart';
import 'activity_master_dropdown.dart';

class PestSingleSelectionWidget<T> extends StatefulWidget {
  final Pest? selectedItem;
  final ValueChanged<Pest?> onPestSelected;
  final String? Function(Pest?)? validator;

  const PestSingleSelectionWidget({
    super.key,
    required this.selectedItem,
    required this.onPestSelected,
    this.validator,
  });

  @override
  State<PestSingleSelectionWidget> createState() =>
      _PestSingleSelectionWidgetState();
}

class _PestSingleSelectionWidgetState extends State<PestSingleSelectionWidget> {
  final PestController pestController = Get.put(PestController());

  @override
  void initState() {
    super.initState();
    pestController.loadPests();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (pestController.isLoading.value) {
        return const ShimmerLoading(); // Show shimmer loading effect while data is being fetched
      } else if (pestController.isError.value ||
          pestController.errorMessage.isNotEmpty) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Error loading pests'),
          ),
        );
      } else {
        return SingleSelectDropdown<Pest>(
          labelText: "Select Pest",
          items: pestController.pests,
          selectedItem: widget.selectedItem,
          itemAsString: (pest) => pest.pest,
          onChanged: (selected) {
             WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.onPestSelected(selected);
             });
          },
          searchableFields: {
            "pest_name": (pest) => pest.pest,
            "pest_code": (pest) => pest.code,
          },
          validator: widget.validator,
        );
      }
    });
  }
}
