import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppVersionWidget extends StatefulWidget {
  const AppVersionWidget({super.key});

  @override
  State<AppVersionWidget> createState() => _AppVersionWidgetState();
}

class _AppVersionWidgetState extends State<AppVersionWidget> {
  late Future<String> _appVersion;

  @override
  void initState() {
    super.initState();
    _appVersion = getAppVersion();
  }

  @override
  void dispose() {
    getAppVersion();
    super.dispose();
  }

  Future<String> getAppVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      print('app version: ${packageInfo.version}');
      return packageInfo.version;
    } catch (e) {
      print('Error getting app version: $e');
      return 'Unknown';
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _appVersion,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return const Text('0.0.0');
        } else {
          return Text(snapshot.data ?? '0.0.0');
        }
      },
    );
  }
}
