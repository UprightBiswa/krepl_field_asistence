import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controller/location_controller.dart';

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
                //show like reverse data
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
                    subtitle: Text('Time: ${location.timestamp}'),
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
          children: [
            //add more 2 buttion
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
          ],
        ),
      ),
    );
  }
}
