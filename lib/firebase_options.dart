// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCdzWQjwJHEOYP_fdpAS0UwATMecOoSxoQ',
    appId: '1:62096811307:web:809589b661769b2c50516e',
    messagingSenderId: '62096811307',
    projectId: 'kreplfieldasistence',
    authDomain: 'kreplfieldasistence.firebaseapp.com',
    storageBucket: 'kreplfieldasistence.appspot.com',
    measurementId: 'G-53D094FX3X',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAW54rszVf8lSyTr0slvfxLWCjrOaYqcz4',
    appId: '1:62096811307:android:a6f77163cae87cef50516e',
    messagingSenderId: '62096811307',
    projectId: 'kreplfieldasistence',
    storageBucket: 'kreplfieldasistence.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCs8NZO5sgB6I_EP1XtOEDjBerBC4j8Ofg',
    appId: '1:62096811307:ios:4d210c3e684d700a50516e',
    messagingSenderId: '62096811307',
    projectId: 'kreplfieldasistence',
    storageBucket: 'kreplfieldasistence.appspot.com',
    iosBundleId: 'com.example.fieldAsistence',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCs8NZO5sgB6I_EP1XtOEDjBerBC4j8Ofg',
    appId: '1:62096811307:ios:4d210c3e684d700a50516e',
    messagingSenderId: '62096811307',
    projectId: 'kreplfieldasistence',
    storageBucket: 'kreplfieldasistence.appspot.com',
    iosBundleId: 'com.example.fieldAsistence',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCdzWQjwJHEOYP_fdpAS0UwATMecOoSxoQ',
    appId: '1:62096811307:web:195fba24a55d0dc050516e',
    messagingSenderId: '62096811307',
    projectId: 'kreplfieldasistence',
    authDomain: 'kreplfieldasistence.firebaseapp.com',
    storageBucket: 'kreplfieldasistence.appspot.com',
    measurementId: 'G-9JHT6THZ0N',
  );
}