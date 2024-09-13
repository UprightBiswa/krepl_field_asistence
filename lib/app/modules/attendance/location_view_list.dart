
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this import
import 'controller/location_controller.dart';
import 'model/location_data_model.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  final LocationServiceController _controller =
      Get.put(LocationServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Tracker')),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (_controller.locations.isEmpty) {
                return const Center(child: Text('No locations found.'));
              }
              return ListView.builder(
                reverse: true,
                itemCount: _controller.locations.length,
                itemBuilder: (context, index) {
                  final location = _controller.locations[index];

                  return ListTile(
                    tileColor:
                        index.isEven ? Colors.grey[200] : Colors.grey[300],
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: Text(
                        'Lat: ${location.latitude}, Lon: ${location.longitude}'),
                    subtitle: Text('Time: ${location.time} - ${location.date}'),
                  );
                },
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          spacing: 8,
          alignment: WrapAlignment.spaceBetween,
          children: [
            Obx(() {
              return ElevatedButton(
                onPressed: () {
                  if (_controller.isTracking.value) {
                    _controller.stopService();
                  } else {
                    _controller.startService();
                  }
                },
                child: Text(_controller.isTracking.value
                    ? 'Stop Service'
                    : 'Start Service'),
              );
            }),
            ElevatedButton(
              onPressed: () async {
                await _controller.clearLocationData();
              },
              child: const Text('Clear Data'),
            ),
            ElevatedButton(
              onPressed: () async {
                await _controller.refreshLocations();
              },
              child: const Text('Refresh'),
            ),
            //
            ElevatedButton(
              onPressed: () {
                _openRouteMap();
              },
              child: const Text('Map open'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openRouteMap() async {
    // check  minimum number of routes to open 3
    if (_controller.locations.isEmpty || _controller.locations.length < 3) {
      Get.snackbar('Error', 'No locations to show on the map',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Get the list of locations
    final List<LocationDataModel> locations = _controller.locations;

    // Construct the Google Maps URL
    final String origin =
        '${locations.first.latitude},${locations.first.longitude}';
    final String destination =
        '${locations.last.latitude},${locations.last.longitude}';
    final String waypoints = locations
        .skip(1) // Skip the first point (origin)
        .take(locations.length -
            2) // Take all points except the last (destination)
        .map((loc) => '${loc.latitude},${loc.longitude}')
        .join('|');

    // Construct the final URL
    final String googleMapsUrl = 'https://www.google.com/maps/dir/?api=1'
        '&origin=$origin'
        '&destination=$destination'
        '&waypoints=$waypoints';
    // for ios, we need to

    final Uri googleMapsUri = Uri.parse(googleMapsUrl);

    try {
      if (await canLaunchUrl(googleMapsUri)) {
        await launchUrl(googleMapsUri);
      } else {
        throw 'Could not launch Google Maps';
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to open map: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
