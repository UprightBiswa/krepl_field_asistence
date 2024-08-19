 import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:connectivity_plus_platform_interface/src/enums.dart';

// class ConnectivityService {
//   Future<bool> checkInternet() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult != ConnectivityResult.none;
//   }
// }

class ConnectivityService {
  final Connectivity _connectivity = Connectivity();

  Stream<List<ConnectivityResult>> get connectivityStream =>
      _connectivity.onConnectivityChanged;

  Future<bool> checkInternet() async {
    final result = await _connectivity.checkConnectivity();
    return result != [ConnectivityResult.none];
  }
}
