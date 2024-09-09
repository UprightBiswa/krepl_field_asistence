import 'package:field_asistence/app/modules/home/components/search_field.dart';
import 'package:flutter/material.dart';

import '../../../data/constrants/constants.dart';

class SingleSelectDropdown<T> extends StatefulWidget {
  final String labelText;
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemAsString;
  final void Function(T) onChanged;
  final Map<String, String Function(T)> searchableFields;
  final IconData icon;
  final String? Function(T?)? validator;

  const SingleSelectDropdown({
    required this.labelText,
    required this.items,
    this.selectedItem,
    required this.itemAsString,
    required this.onChanged,
    required this.searchableFields,
    this.icon = Icons.arrow_drop_down,
    this.validator,
    super.key,
  });

  @override
  _SingleSelectDropdownState<T> createState() =>
      _SingleSelectDropdownState<T>();
}

class _SingleSelectDropdownState<T> extends State<SingleSelectDropdown<T>> {
  String? validationError;

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    print('${validationError}jdshf');
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
                color: validationError != null ? Colors.red : Colors.grey,
              ),
              color: isDarkMode(context)
                  ? AppColors.kContentColor
                  : AppColors.kInput,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: [
                Expanded(
                  child: widget.selectedItem != null
                      ? Text(
                          widget.itemAsString(widget.selectedItem!),
                        )
                      : Text(
                          widget.labelText,
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

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) {
        return SingleSelectModal<T>(
          title: widget.labelText,
          items: widget.items,
          selectedItem: widget.selectedItem,
          itemAsString: widget.itemAsString,
          onChanged: (T selected) {
            setState(() {
              widget.onChanged(selected);
              _validateSelection(selected);
            });
            Navigator.pop(context);
          },
          searchableFields: widget.searchableFields,
        );
      },
    );
  }

  void _validateSelection(T? selectedItem) {
    if (widget.validator != null) {
      setState(() {
        validationError = widget.validator!(selectedItem);
      });
    }
  }
}

class SingleSelectModal<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final T? selectedItem;
  final String Function(T) itemAsString;
  final void Function(T) onChanged;
  final Map<String, String Function(T)> searchableFields;

  const SingleSelectModal({
    required this.title,
    required this.items,
    this.selectedItem,
    required this.itemAsString,
    required this.onChanged,
    required this.searchableFields,
    super.key,
  });

  @override
  _SingleSelectModalState<T> createState() => _SingleSelectModalState<T>();
}

class _SingleSelectModalState<T> extends State<SingleSelectModal<T>> {
  late List<T> filteredItems;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
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
    final selectedItem = widget.selectedItem;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: AppTypography.kBold14),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchField(
              controller: searchController,
              onChanged: _filterItems,
              hintText: "Search ${widget.title}",
              isEnabled: true,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                final isSelected = item == selectedItem;

                return ListTile(
                  title: Text(widget.itemAsString(item)),
                  trailing: isSelected
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.radio_button_unchecked),
                  onTap: () {
                    widget.onChanged(item);
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
