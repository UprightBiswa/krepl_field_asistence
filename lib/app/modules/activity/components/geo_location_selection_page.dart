import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../data/constrants/constants.dart';

class LocationData {
  final double latitude;
  final double longitude;
  final String address;

  LocationData(
      {required this.latitude, required this.longitude, required this.address});
}

class GeoLocationInputField extends StatefulWidget {
  final Function(LocationData) onLocationSelected;

  const GeoLocationInputField({
    super.key,
    required this.onLocationSelected,
  });

  @override
  State<GeoLocationInputField> createState() => _GeoLocationInputFieldState();
}

class _GeoLocationInputFieldState extends State<GeoLocationInputField> {
  final TextEditingController _controller = TextEditingController();
  LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    await _checkLocationPermission();
    await _getCurrentLocation();
  }

  bool isDarkMode(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _initializeLocation();
      },
      child: AbsorbPointer(
        child: TextFormField(
          controller: _controller,
          style: const TextStyle(
            fontSize: 16,
          ),
          decoration: InputDecoration(
            labelText: 'Location',
            labelStyle: const TextStyle(color: Colors.grey),
            prefixIcon:
                const Icon(Icons.location_on, color: AppColors.kPrimary),
            filled: true,
            fillColor: isDarkMode(context)
                ? AppColors.kContentColor
                : AppColors.kInput,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusTen),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusTen),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppSpacing.radiusTen),
              borderSide: const BorderSide(color: Colors.blue),
            ),
          ),
          readOnly: true,
        ),
      ),
    );
  }

  Future<void> _checkLocationPermission() async {
    var status = await Permission.locationWhenInUse.status;
    if (!status.isGranted) {
      status = await Permission.locationWhenInUse.request();
      if (!status.isGranted) {
        _showPermissionDialog();
        return;
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    bool isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isLocationServiceEnabled) {
      // _showPermissionDialog();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enable location services.'),
        ),
      );
      return;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      String fullAddress = '';
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        fullAddress =
            "${place.name}, ${place.thoroughfare}, ${place.locality}, ${place.postalCode}, ${place.country}";
      }

      setState(() {
        _currentLocation = LocationData(
          latitude: position.latitude,
          longitude: position.longitude,
          address: fullAddress,
        );
        _controller.text = fullAddress;
      });

      widget.onLocationSelected(_currentLocation!);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get current location.'),
        ),
      );
    }
  }

  void _showPermissionDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location Permission Required'),
          content: const Text(
              'This app needs location access to provide the desired functionality. Please enable location access in the app settings.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Open Settings'),
              onPressed: () {
                openAppSettings();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
