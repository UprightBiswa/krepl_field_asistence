import 'package:field_asistence/app/modules/widgets/containers/primary_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../data/constrants/constants.dart';
import '../model/attendance_data_model.dart';
import 'dart:math' as math;


class AttendanceListItem extends StatelessWidget {
  final AttendanceData data;

  const AttendanceListItem({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    bool isDarkMode(BuildContext context) =>
        Theme.of(context).brightness == Brightness.dark;

    return PrimaryContainer(
      padding: EdgeInsets.zero,
      radius: 8,
      height: 50,
      margin: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50,
            decoration: const BoxDecoration(
              gradient: SweepGradient(
                center: FractionalOffset.center,
                colors: <Color>[
                  AppColors.kPrimary,
                  AppColors.kPrimary2,
                  AppColors.kAccent1,
                  AppColors.kAccent2,
                  AppColors.kPrimary,
                ],
                stops: <double>[0.0, 0.25, 0.5, 0.75, 1.0],
                transform: GradientRotation(math.pi / 4),
              ),
              color: AppColors.kPrimary,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('E').format(DateTime.parse(data.checkinDate!)),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    DateFormat('dd').format(DateTime.parse(data.checkinDate!)),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Check In",
                  style: AppTypography.kMedium10.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.kWhite
                        : AppColors.kDarkHint,
                  ),
                ),
                Text(
                  data.checkinTime ?? '',
                  style: AppTypography.kBold12.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.kWhite
                        : AppColors.kDarkHint,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Check Out",
                  style: AppTypography.kMedium10.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.kWhite
                        : AppColors.kDarkHint,
                  ),
                ),
                Text(
                  data.checkoutTime ?? '',
                  style: AppTypography.kBold12.copyWith(
                    color: isDarkMode(context)
                        ? AppColors.kWhite
                        : AppColors.kDarkHint,
                  ),
                ),
              ],
            ),
          ),
          // if (data.attendanceSummaries.length > 2)
          IconButton(
            onPressed: () {
              print(data.attendanceSummaries.length);
              if (data.attendanceSummaries.length > 2) {
                // _openRouteMap(data.attendanceSummaries);
                Get.to(() =>
                    GoogleMapOpen(locations: data.attendanceSummaries.toSet()));
              }
            },
            icon: const Icon(
              AppAssets.kLocation,
            ),
            iconSize: 24,
            splashRadius: 8,
          ),
        ],
      ),
    );
  }

//   Future<void> _openRouteMap(List<AttendanceSummary> locations) async {
//     // check  minimum number of routes to open 3
//     if (locations.isEmpty || locations.length < 3) {
//       Get.snackbar('Error', 'No locations to show on the map',
//           snackPosition: SnackPosition.BOTTOM);
//       return;
//     }

//     // Construct the Google Maps URL
//     final String origin =
//         '${locations.first.latitude},${locations.first.longitude}';
//     final String destination =
//         '${locations.last.latitude},${locations.last.longitude}';
//     final String waypoints = locations
//         .skip(1) // Skip the first point (origin)
//         .take(locations.length -
//             2) // Take all points except the last (destination)
//         .map((loc) => '${loc.latitude},${loc.longitude}')
//         .join('|');

//     // Construct the final URL
//     final String googleMapsUrl = 'https://www.google.com/maps/dir/?api=1'
//         '&origin=$origin'
//         '&destination=$destination'
//         '&waypoints=$waypoints';
//     // for ios, we need to

//     final Uri googleMapsUri = Uri.parse(googleMapsUrl);

//     try {
//       if (await canLaunchUrl(googleMapsUri)) {
//         await launchUrl(googleMapsUri);
//       } else {
//         throw 'Could not launch Google Maps';
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to open map: $e',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
// }
}

// class GoogleMapOpen extends StatelessWidget {
//   final Set<AttendanceSummary> locations;
//   const GoogleMapOpen({super.key, required this.locations});

//   @override
//   Widget build(BuildContext context) {
//     final clusters = _clusterMarkers(locations);
//     for (var locations in locations) {
//       print('Latitude: ${locations.latitude}');
//       print('Longitude: ${locations.longitude}');
//     }
//     return Scaffold(
//       appBar: AppBar(title: const Text('Route Map')),
//       body: GoogleMap(
//         myLocationEnabled: true,
//         myLocationButtonEnabled: true,
//         initialCameraPosition: CameraPosition(
//           target: LatLng(
//             double.tryParse(locations.first.latitude) ?? 0.0,
//             double.tryParse(locations.first.longitude) ?? 0.0,
//           ),
//           zoom: 14,
//         ),
//         markers: _buildMarkers(clusters),
//         polylines: _buildPolyline(locations.toList()),
//       ),
//     );
//   }

//   // Cluster markers based on proximity
//   List<List<AttendanceSummary>> _clusterMarkers(
//       Set<AttendanceSummary> locations) {
//     const double clusterRadius = 0.01; // Adjust the cluster radius as needed
//     List<List<AttendanceSummary>> clusters = [];

//     for (var location in locations) {
//       bool added = false;

//       for (var cluster in clusters) {
//         if (_distance(cluster.first, location) < clusterRadius) {
//           cluster.add(location);
//           added = true;
//           break;
//         }
//       }

//       if (!added) {
//         clusters.add([location]);
//       }
//     }

//     return clusters;
//   }

//   // Calculate the distance between two locations
//   double _distance(AttendanceSummary a, AttendanceSummary b) {
//     const distance = latlong.Distance();
//     final pointA = latlong.LatLng(
//       double.tryParse(a.latitude) ?? 0.0,
//       double.tryParse(a.longitude) ?? 0.0,
//     );
//     final pointB = latlong.LatLng(
//       double.tryParse(b.latitude) ?? 0.0,
//       double.tryParse(b.longitude) ?? 0.0,
//     );
//     return distance.as(
//       latlong.LengthUnit.Meter,
//       pointA,
//       pointB,
//     );
//   }

//   // Create markers from clusters
//   Set<Marker> _buildMarkers(List<List<AttendanceSummary>> clusters) {
//     return clusters.map((cluster) {
//       final position = LatLng(
//         cluster.fold<double>(0,
//                 (prev, loc) => prev + (double.tryParse(loc.latitude) ?? 0.0)) /
//             cluster.length,
//         cluster.fold<double>(0,
//                 (prev, loc) => prev + (double.tryParse(loc.longitude) ?? 0.0)) /
//             cluster.length,
//       );

//       return Marker(
//         markerId: MarkerId('${position.latitude},${position.longitude}'),
//         position: position,
//         infoWindow: InfoWindow(
//           title: 'Cluster of ${cluster.length} locations',
//           snippet: '${position.latitude}, ${position.longitude}',
//         ),
//         icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
//       );
//     }).toSet();
//   }

//   // Create polyline for the route
//   Set<Polyline> _buildPolyline(List<AttendanceSummary> locations) {
//     List<LatLng> latLngPoints = locations
//         .map((loc) => LatLng(
//               double.tryParse(loc.latitude) ?? 0.0,
//               double.tryParse(loc.longitude) ?? 0.0,
//             ))
//         .toList();
//     return {
//       Polyline(
//         polylineId: const PolylineId('route'),
//         points: latLngPoints,
//         color: Colors.blue,
//         width: 5,
//       ),
//     };
//   }
// }
class GoogleMapOpen extends StatelessWidget {
  final Set<AttendanceSummary> locations;
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
            double.tryParse(locations.first.latitude) ?? 0.0,
            double.tryParse(locations.first.longitude) ?? 0.0,
          ),
          zoom: 14,
        ),
        markers: _buildMarkers(clusters),
        polylines: _buildPolyline(locations.toList()),
      ),
    );
  }

  // Cluster markers into groups of 30
  List<List<AttendanceSummary>> _clusterMarkers(
      Set<AttendanceSummary> locations) {
    const int clusterSize = 30;
    List<List<AttendanceSummary>> clusters = [];
    List<AttendanceSummary> locationList = List.from(locations);

    while (locationList.isNotEmpty) {
      List<AttendanceSummary> cluster = locationList.take(clusterSize).toList();
      locationList = locationList.skip(clusterSize).toList();
      clusters.add(cluster);
    }

    return clusters;
  }

  // Create markers from clusters
  Set<Marker> _buildMarkers(List<List<AttendanceSummary>> clusters) {
    return clusters.map((cluster) {
      final position = LatLng(
        cluster.fold<double>(0,
                (prev, loc) => prev + (double.tryParse(loc.latitude) ?? 0.0)) /
            cluster.length,
        cluster.fold<double>(0,
                (prev, loc) => prev + (double.tryParse(loc.longitude) ?? 0.0)) /
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
  Set<Polyline> _buildPolyline(List<AttendanceSummary> locations) {
    List<LatLng> latLngPoints = locations
        .map((loc) => LatLng(
              double.tryParse(loc.latitude) ?? 0.0,
              double.tryParse(loc.longitude) ?? 0.0,
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
