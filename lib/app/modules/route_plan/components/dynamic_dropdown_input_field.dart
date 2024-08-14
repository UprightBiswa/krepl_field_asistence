import 'package:flutter/material.dart';

import '../../../data/constrants/constants.dart';
import '../../home/components/search_field.dart';

class MultiSelectDropdown<T> extends StatefulWidget {
  final String labelText;
  final List<T> items;
  final List<T> selectedItems;
  final String Function(T) itemAsString;
  final void Function(List<T>) onChanged;
  final Map<String, String Function(T)> searchableFields;
  final IconData icon;
  final int maxChipsToShow;
  final String? Function(List<T>)? validator;
  // final bool isRequired; // Add this
  // final String validationMessage;

  const MultiSelectDropdown({
    required this.labelText,
    required this.items,
    required this.selectedItems,
    required this.itemAsString,
    required this.onChanged,
    required this.searchableFields,
    this.icon = Icons.arrow_drop_down,
    this.maxChipsToShow = 1,
    this.validator,
    // this.isRequired = false, // Add this
    // this.validationMessage = 'Please select at least one item.', // Add this
    super.key,
  });

  @override
  _MultiSelectDropdownState<T> createState() => _MultiSelectDropdownState<T>();
}

class _MultiSelectDropdownState<T> extends State<MultiSelectDropdown<T>> {
  late List<T> selectedItems;
  String? validationError;
  @override
  void initState() {
    super.initState();
    selectedItems = List<T>.from(widget.selectedItems);
  }

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () => _showModalBottomSheet(context),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                color: validationError != null ? Colors.red : AppColors.kGrey,
                // color: AppColors.kGrey,
              ),
              color: isDarkMode(context)
                  ? AppColors.kContentColor
                  : AppColors.kInput,
              borderRadius: BorderRadius.circular(AppSpacing.radiusTen),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Wrap(
                    spacing: 8,
                    children: _buildChips(context),
                  ),
                ),
                Icon(widget.icon),
              ],
            ),
          ),
        ),
        if (validationError != null)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              validationError!,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
      ],
    );
  }

  List<Widget> _buildChips(BuildContext context) {
    List<Widget> chips = [];
    for (var i = 0; i < selectedItems.length; i++) {
      if (i < widget.maxChipsToShow) {
        chips.add(_buildChip(selectedItems[i]));
      } else {
        chips.add(_buildSeeAllChip(context));
        break;
      }
    }

    if (chips.isEmpty) {
      chips.add(Text(
        "Select ${widget.labelText}",
        style: TextStyle(color: Colors.grey[600]),
      ));
    }

    return chips;
  }

  Widget _buildChip(T item) {
    return Chip(
      label: Text(widget.itemAsString(item)),
      onDeleted: () {
        setState(() {
          selectedItems.remove(item);
          widget.onChanged(selectedItems);
          _validateSelection();
        });
      },
    );
  }

  Widget _buildSeeAllChip(BuildContext context) {
    return ActionChip(
      label: const Text("See All"),
      onPressed: () => _showModalBottomSheet(context),
    );
  }

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return MultiSelectModal<T>(
          title: widget.labelText,
          items: widget.items,
          selectedItems: selectedItems,
          itemAsString: widget.itemAsString,
          onChanged: (List<T> selected) {
            setState(() {
              selectedItems = selected;
              widget.onChanged(selected);
              _validateSelection();
            });
            Navigator.pop(context);
          },
          searchableFields: widget.searchableFields,
        );
      },
    );
  }

  void _validateSelection() {
    if (widget.validator != null) {
      setState(() {
        validationError = widget.validator!(selectedItems);
      });
    }
  }
  // bool _validateSelection() {
  //   if (widget.isRequired && selectedItems.isEmpty) {
  //     setState(() {
  //       validationError = widget.validationMessage;
  //     });
  //     return false;
  //   }
  //   setState(() {
  //     validationError = null;
  //   });
  //   return true;
  // }

  // bool validate() {
  //   return _validateSelection();
  // }
}

class MultiSelectModal<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final List<T> selectedItems;
  final String Function(T) itemAsString;
  final void Function(List<T>) onChanged;
  final Map<String, String Function(T)> searchableFields;

  const MultiSelectModal({
    required this.title,
    required this.items,
    required this.selectedItems,
    required this.itemAsString,
    required this.onChanged,
    required this.searchableFields,
    super.key,
  });

  @override
  _MultiSelectModalState<T> createState() => _MultiSelectModalState<T>();
}

class _MultiSelectModalState<T> extends State<MultiSelectModal<T>> {
  late List<T> selectedItems;
  late List<T> filteredItems;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedItems = List<T>.from(widget.selectedItems);
    filteredItems = widget.items;
  }

  void _filterItems(String query) {
    setState(() {
      filteredItems = widget.items.where((item) {
        for (var field in widget.searchableFields.keys) {
          final fieldValue = widget.searchableFields[field]!(item);
          if (fieldValue.toLowerCase().contains(query.toLowerCase())) {
            return true;
          }
        }
        return false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          TextButton(
            onPressed: () {
              widget.onChanged(selectedItems);
              // Navigator.pop(context);
            },
            child: const Text(
              "Done",
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                selectedItems.clear();
              });
            },
            child: const Text(
              "Clear",
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchField(
              controller: searchController,
              onChanged: _filterItems,
              isEnabled: true,
              hintText: 'Search',
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                final isSelected = selectedItems.contains(item);

                return ListTile(
                  title: Text(widget.itemAsString(item)),
                  trailing: isSelected
                      ? const Icon(Icons.check_box)
                      : const Icon(Icons.check_box_outline_blank),
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        selectedItems.remove(item);
                      } else {
                        selectedItems.add(item);
                      }
                    });
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
