import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterOption<T> {
  final String label;
  final T value;

  FilterOption({required this.label, required this.value});
}

class FilterController<T> extends GetxController {
  final List<FilterOption<T>> filterOptions;
  Rx<T> selectedOrderBy;
  RxInt order = 1.obs;

  FilterController({
    required this.filterOptions,
    required T initialOrderBy,
  }) : selectedOrderBy = Rx<T>(initialOrderBy);

  void setOrderBy(T orderBy) {
    selectedOrderBy.value = orderBy;
  }

  void setOrder(int sortOrder) {
    order.value = sortOrder;
  }

  void applyFilters(Function onApply) {
    onApply();
  }
}

class FilterBottomSheet<T> extends StatefulWidget {
  final FilterController<T> controller;
  final Function onApply;
  final Function onClear;

  const FilterBottomSheet({
    super.key,
    required this.controller,
    required this.onApply,
    required this.onClear,
  });

  @override
  _FilterBottomSheetState<T> createState() => _FilterBottomSheetState<T>();
}

class _FilterBottomSheetState<T> extends State<FilterBottomSheet<T>> {
  late T orderBy;
  late int order;

  @override
  void initState() {
    super.initState();
    orderBy = widget.controller.selectedOrderBy.value;
    order = widget.controller.order.value;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: PrimaryContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Filter Options',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
            SizedBox(height: 20.h),
            DropdownButton<T>(
              value: orderBy,
              items:
                  widget.controller.filterOptions.map((FilterOption<T> option) {
                return DropdownMenuItem<T>(
                  value: option.value,
                  child: Text(option.label),
                );
              }).toList(),
              onChanged: (T? newValue) {
                setState(() {
                  orderBy = newValue as T;
                  widget.controller.setOrderBy(orderBy);
                });
              },
            ),
            Slider(
              value: order.toDouble(),
              min: -1,
              max: 1,
              divisions: 1,
              label: order == -1 ? 'Descending' : 'Ascending',
              onChanged: (double value) {
                setState(() {
                  order = value.toInt();
                  widget.controller.setOrder(order);
                });
              },
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.onClear();
                  },
                  child: const Text('Clear'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    widget.controller.applyFilters(widget.onApply);
                  },
                  child: const Text('Apply Filters'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
