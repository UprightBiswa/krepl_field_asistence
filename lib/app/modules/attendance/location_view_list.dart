import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart'; // Add this import
import 'controller/location_controller.dart';
import 'model/location_data_model.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

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
              color: Colors.grey.withValues(alpha: 0.5),
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
              onPressed: () async {
                // if (_controller.locations.length > 10) {
                //   await _openRouteMapWithGetRequest();
                // } else {
                //   await _openRouteMap();
                // }
                //open botm seet class view
                if (_controller.locations.length > 10) {
                  print(_controller.locations.length);
                  Get.to(() =>
                      GoogleMapOpen(locations: _controller.locations.toSet()));
                }
              },
              child: const Text('Map open'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openRouteMapWithGetRequest() async {
    const String url = 'https://maps.googleapis.com/maps/api/directions/json';
    final List<LocationDataModel> locations = _controller.locations;

    // Check if there are at least 3 locations
    if (locations.isEmpty || locations.length < 3) {
      Get.snackbar('Error', 'No sufficient locations to show on the map',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    // Define the API key here
    const String apiKey = 'AIzaSyAgD-9KU0qJ9miZPvmmZmc1NuRa5C2TPeY';

    // Ensure origin and destination are properly constructed
    final String origin =
        '${locations.first.latitude},${locations.first.longitude}';
    final String destination =
        '${locations.last.latitude},${locations.last.longitude}';

    const int maxWaypoints = 25;
    List<List<LocationDataModel>> batches = [];

    // Split the waypoints into batches of max 25 each
    for (int i = 1; i < locations.length - 1; i += maxWaypoints) {
      batches.add(locations.sublist(
          i,
          i + maxWaypoints > locations.length - 1
              ? locations.length - 1
              : i + maxWaypoints));
    }

    print('Origin: $origin');
    print('Destination: $destination');

    try {
      for (List<LocationDataModel> batch in batches) {
        // Build waypoints for each batch
        String waypoints =
            batch.map((loc) => '${loc.latitude},${loc.longitude}').join('|');

        print('Waypoints: $waypoints');

        // Construct the URL for each batch
        final String requestUrl =
            '$url?origin=$origin&destination=$destination&waypoints=$waypoints&key=$apiKey';

        print('Request URL: $requestUrl');

        final response = await Dio().get(requestUrl);

        if (response.statusCode == 200) {
          print(response.data); // Handle the response data

          // After success, open the map in Google Maps or browser
          final String googleMapsUrl = 'https://www.google.com/maps/dir/?api=1'
              '&origin=$origin'
              '&destination=$destination'
              '&waypoints=$waypoints';

          print('Google Maps URL: $googleMapsUrl');

          final Uri googleMapsUri = Uri.parse(googleMapsUrl);
          if (await canLaunchUrl(googleMapsUri)) {
            await launchUrl(googleMapsUri); // Opens in Google Maps or browser
          } else {
            throw 'Could not launch Google Maps';
          }

          Get.snackbar('Success', 'Map opened via API',
              snackPosition: SnackPosition.BOTTOM);
        } else {
          print('Error Response: ${response.data}');
          throw Exception('Failed to get directions from API');
        }
      }
    } catch (e) {
      print('Error: $e');
      Get.snackbar('Error', 'Failed to open map: $e',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> openRouteMap() async {
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

// class GoogleMapOpen extends StatelessWidget {
//   final List<LocationDataModel> locations;
//   const GoogleMapOpen({super.key, required this.locations});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Route Map')),
//       body: Container(
//         decoration: const BoxDecoration(color: Colors.white),
//         child: GoogleMap(
//           initialCameraPosition: CameraPosition(
//             target: LatLng(locations.first.latitude, locations.first.longitude),
//             zoom: 14,
//           ),
//           markers: _buildMarkers(locations),
//           polylines: _buildPolyline(locations),
//         ),
//       ),
//     );
//   }
// }

// // Create markers for the locations
// Set<Marker> _buildMarkers(List<LocationDataModel> locations) {
//   return locations.map((loc) {
//     return Marker(
//       markerId: MarkerId('${loc.latitude},${loc.longitude}'),
//       position: LatLng(loc.latitude, loc.longitude),
//       infoWindow: InfoWindow(
//         //print index of location
//         title: 'Location: ${locations.indexOf(loc) + 1}',
//         snippet: '${loc.latitude}, ${loc.longitude}',
//       ),
//     );
//   }).toSet();
// }

// // Create polyline for the route
// Set<Polyline> _buildPolyline(List<LocationDataModel> locations) {
//   List<LatLng> latLngPoints =
//       locations.map((loc) => LatLng(loc.latitude, loc.longitude)).toList();
//   return {
//     Polyline(
//       polylineId: const PolylineId('route'),
//       points: latLngPoints,
//       color: Colors.blue,
//       width: 5,
//     ),
//   };
// }
class GoogleMapOpen extends StatelessWidget {
  final Set<LocationDataModel> locations;
  const GoogleMapOpen({super.key, required this.locations});

  @override
  Widget build(BuildContext context) {
    // Print coordinates for debugging
    for (var location in locations) {
      print('Latitude: ${location.latitude}');
      print('Longitude: ${location.longitude}');
    }

    final clusters = _clusterMarkers(locations);

    return Scaffold(
      appBar: AppBar(title: const Text('Route Map')),
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            locations.first.latitude,
            locations.first.longitude,
          ),
          zoom: 14,
        ),
        markers: _buildMarkers(clusters),
        polylines: _buildPolyline(locations.toList()),
      ),
    );
  }

  // Cluster markers into groups of 30
  List<List<LocationDataModel>> _clusterMarkers(
      Set<LocationDataModel> locations) {
    const int clusterSize = 30;
    List<List<LocationDataModel>> clusters = [];
    List<LocationDataModel> locationList = List.from(locations);

    while (locationList.isNotEmpty) {
      List<LocationDataModel> cluster = locationList.take(clusterSize).toList();
      locationList = locationList.skip(clusterSize).toList();
      clusters.add(cluster);
    }

    return clusters;
  }

  // Create markers from clusters
  Set<Marker> _buildMarkers(List<List<LocationDataModel>> clusters) {
    return clusters.map((cluster) {
      final position = LatLng(
        cluster.fold<double>(0, (prev, loc) => prev + loc.latitude) /
            cluster.length,
        cluster.fold<double>(0, (prev, loc) => prev + loc.longitude) /
            cluster.length,
      );

      return Marker(
        markerId: MarkerId('${position.latitude},${position.longitude}'),
        position: position,
        infoWindow: InfoWindow(
          title: 'Cluster of ${cluster.length} locations',
          snippet: '${position.latitude}, ${position.longitude}',
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      );
    }).toSet();
  }

  // Create polyline for the route
  Set<Polyline> _buildPolyline(List<LocationDataModel> locations) {
    List<LatLng> latLngPoints = locations
        .map((loc) => LatLng(
              loc.latitude,
              loc.longitude,
            ))
        .toList();
    return {
      Polyline(
        polylineId: const PolylineId('route'),
        points: latLngPoints,
        color: Colors.blue,
        width: 5,
      ),
    };
  }
}
