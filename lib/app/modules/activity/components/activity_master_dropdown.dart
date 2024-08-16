import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../widgets/form_field.dart/single_selected_dropdown.dart';
import '../controller/activity_master_controller.dart';
import '../model/activity_master_model.dart';

class ActivitySelectionWidget extends StatefulWidget {
  final String formType;
  final ValueChanged<ActivityMaster?> onActivitySelected;
  const ActivitySelectionWidget(
      {super.key, required this.formType, required this.onActivitySelected});

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
    _activityMasterController.fetchActivityMasterData();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_activityMasterController.isLoading.value) {
        // Show loading shimmer
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
      } else if (_activityMasterController.isError.value) {
        // Show error message
        return const Center(child: Text('Error loading activities.'));
      } else {
        var activities = _activityMasterController
            .fetchActivitiesByFormType(widget.formType);
        // Show the dropdown
        return SingleSelectDropdown<ActivityMaster>(
          labelText: "Select Activity",
          items: activities,
          selectedItem: null,
          itemAsString: (activity) => activity.activityName,
          onChanged: (selected) {
            widget.onActivitySelected(selected);
          },
          searchableFields: {
            "Activity Name": (activity) => activity.activityName,
            "Form": (activity) => activity.form,
          },
          validator: (selected) {
            if (selected == null) {
              return "Please select an activity";
            }
            return null;
          },
        );
      }
    });
  }
}
