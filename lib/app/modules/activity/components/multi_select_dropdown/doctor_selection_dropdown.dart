import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../doctor/controller/doctor_controller.dart';
import '../../../doctor/model/doctor_list.dart';
import '../../../widgets/form_field/dynamic_dropdown_input_field.dart';
import '../single_select_dropdown/activity_master_dropdown.dart';

class DoctorSelectionScreen extends StatefulWidget {
  final void Function(List<Doctor>) onSelectionChanged;
  final List<Doctor> selectedItems;

  const DoctorSelectionScreen({
    super.key,
    required this.onSelectionChanged,
    required this.selectedItems,
  });

  @override
  State<DoctorSelectionScreen> createState() => _DoctorSelectionScreenState();
}

class _DoctorSelectionScreenState extends State<DoctorSelectionScreen> {
  final DoctorController doctorController = Get.put(DoctorController());
  late List<Doctor> selectedDoctors;

  @override
  void initState() {
    selectedDoctors = widget.selectedItems;
    doctorController.fetchAllDoctors(); // Fetch doctor data on init
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (doctorController.isLoading.value) {
        return const ShimmerLoading();
      } else if (doctorController.isErrorAll.value) {
        return const Center(
          child: Text('Error loading Doctors.'),
        );
      } else {
        return MultiSelectDropdown<Doctor>(
          labelText: 'Select Doctors',
          selectedItems: selectedDoctors,
          items: doctorController.allDoctor,
          itemAsString: (doctors) => doctors.name,
          searchableFields: {
            'name': (doctors) => doctors.name,
            'mobileNumber': (doctors) => doctors.mobileNumber,
          },
          validator: (selectedDoctors) {
            if (selectedDoctors.isEmpty) {
              return 'Please select at least one Doctor.';
            }
            return null;
          },
          onChanged: (items) {
            setState(() {
              selectedDoctors = items;
            });
            widget.onSelectionChanged(
                selectedDoctors); // Notify parent of selection changes
          },
        );
      }
    });
  }
}
