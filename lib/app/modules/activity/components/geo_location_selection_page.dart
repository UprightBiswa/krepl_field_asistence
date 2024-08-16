import 'package:flutter/material.dart';

import 'location_searchPage.dart';

class GeoLocationInputField extends StatefulWidget {
  final String? initialAddress;
  final Function(String) onLocationSelected;

  const GeoLocationInputField({
    super.key,
    this.initialAddress,
    required this.onLocationSelected,
  });

  @override
  State<GeoLocationInputField> createState() => _GeoLocationInputFieldState();
}

class _GeoLocationInputFieldState extends State<GeoLocationInputField> {
  final TextEditingController _controller = TextEditingController();
  String? _selectedAddress;

  @override
  void initState() {
    super.initState();
    if (widget.initialAddress != null) {
      _selectedAddress = widget.initialAddress;
      _controller.text = widget.initialAddress!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final selectedAddress = await showModalBottomSheet<String>(
          context: context,
          isScrollControlled: true,
          builder: (context) => const LocationSearchPage(),
        );

        if (selectedAddress != null) {
          setState(() {
            _selectedAddress = selectedAddress;
            _controller.text = selectedAddress;
          });
          widget.onLocationSelected(selectedAddress);
        }
      },
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: 'Location',
          suffixIcon: const Icon(Icons.location_on),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.all(16.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
        readOnly: true,
      ),
    );
  }
}
