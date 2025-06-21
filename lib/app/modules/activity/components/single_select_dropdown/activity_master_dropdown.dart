import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../../widgets/form_field/single_selected_dropdown.dart';
import '../../controller/activity_master_controller.dart';
import '../../model/activity_master_model.dart';

class ActivitySelectionWidget<T> extends StatefulWidget {
  final String formType;
  final ActivityMaster? selectedItem;
  final FormFieldSetter<ActivityMaster?> onSaved;
  final FormFieldValidator<ActivityMaster?> validator;
  const ActivitySelectionWidget({
    super.key,
    required this.formType,
    required this.selectedItem,
    required this.onSaved,
    required this.validator,
  });

  @override
  State<ActivitySelectionWidget> createState() =>
      _ActivitySelectionWidgetState();
}

class _ActivitySelectionWidgetState extends State<ActivitySelectionWidget> {
  final ActivityMasterController _activityMasterController =
      Get.put(ActivityMasterController());
  @override
  void initState() {
    super.initState();
    _activityMasterController.fetchActivityMasterData(widget.formType);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_activityMasterController.isLoading.value) {
        return const ShimmerLoading();
        // Show loading shimmer
      } else if (_activityMasterController.isError.value ||
          _activityMasterController.errorMessage.isNotEmpty) {
        // Show error message
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.red[100],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.red),
          ),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Error loading activities'),
          ),
        );
      } else {
        // Show the dropdown
        return FormField<ActivityMaster?>(
          validator: widget.validator,
          onSaved: widget.onSaved,
          builder: (FormFieldState<ActivityMaster?> field) {
            return SingleSelectDropdown<ActivityMaster>(
              labelText: "Select Activity",
              items: _activityMasterController.activityMasterList,
              selectedItem: field.value ?? widget.selectedItem,
              itemAsString: (activity) => activity.promotionalActivity,
              onChanged: (selected) {
                field.didChange(selected);
                widget.onSaved(selected);
                field.validate();
              },
              validator: widget.validator,
              searchableFields: {
                "promotional_activity": (activity) =>
                    activity.promotionalActivity,
                "Form": (activity) => activity.form,
              },
            );
          },
        );
      }
    });
  }
}

class ShimmerLoading extends StatelessWidget {
  const ShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              const Icon(Icons.search, color: Colors.grey),
              const SizedBox(width: 8.0),
              Expanded(
                child: Container(
                  height: 48.0,
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
