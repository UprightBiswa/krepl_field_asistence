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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Filter Options',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
          //devider
          const Divider(
            color: Colors.grey,
            thickness: 1,
            height: 25,
          ),

          //label sort by order
          Text('Sort By Order',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp)),
          //do same thing for dropdown dont use  make list select option items with slected order
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.controller.filterOptions.length,
            itemBuilder: (BuildContext context, int index) {
              final FilterOption<T> option =
                  widget.controller.filterOptions[index];
              return ListTile(
                title: Text(option.label),
                onTap: () {
                  setState(() {
                    orderBy = option.value;
                    widget.controller.setOrderBy(orderBy);
                  });
                },
                selected: orderBy == option.value,
              );
            },
          ),

          // do wrpe list of options same like dropdown fileds
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FilterOption(
                label: 'Descending',
                value: -1,
              ),
              FilterOption(
                label: 'Ascending',
                value: 1,
              ),
            ]
                .map(
                  (FilterOption<int> option) => FilterChip(
                    label: Text(option.label),
                    selected: order == option.value,
                    onSelected: (bool selected) {
                      setState(() {
                        order = option.value;
                        widget.controller.setOrder(order);
                      });
                    },
                  ),
                )
                .toList(),
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
    );
  }
}
