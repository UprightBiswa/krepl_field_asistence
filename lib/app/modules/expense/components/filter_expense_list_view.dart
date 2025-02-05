import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';

import '../controller/expense_lsit_controller.dart';


class DateFilterBottomSheet extends StatelessWidget {
  final ExpenseController controller = Get.find<ExpenseController>();

  DateFilterBottomSheet({super.key});

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isFromDate
          ? (controller.fromDate.value ?? DateTime.now())
          : DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: isFromDate
          ? (controller.toDate.value ?? DateTime.now())
          : DateTime.now(),
    );

    if (pickedDate != null) {
      isFromDate
          ? controller.setFromDate(pickedDate)
          : controller.setToDate(pickedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Filter by Date",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context, true),
                  child: Obx(() => _buildDateField(
                        label: "From Date",
                        date: controller.fromDate.value,
                      )),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () => _selectDate(context, false),
                  child: Obx(() => _buildDateField(
                        label: "To Date",
                        date: controller.toDate.value,
                      )),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.clearFilters();
                  Get.back(); // Close BottomSheet
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                child:
                    const Text("Clear", style: TextStyle(color: Colors.white)),
              ),
              ElevatedButton(
                onPressed: () {
                  controller.applyDateFilter();
                  Get.back();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("Apply Filter",
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDateField({required String label, DateTime? date}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date != null ? DateFormat("dd-MMM-yy").format(date) : label,
            style: TextStyle(
                fontSize: 16, color: date != null ? Colors.black : Colors.grey),
          ),
          const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
        ],
      ),
    );
  }
}
