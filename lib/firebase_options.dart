// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCC4ZQDHDxoMhGRjei_rsxG1ViV6-CpTpM',
    appId: '1:889061256254:web:5d9414a8ca32055ca6756f',
    messagingSenderId: '889061256254',
    projectId: 'flutter-bootstrap-e6b14',
    authDomain: 'flutter-bootstrap-e6b14.firebaseapp.com',
    storageBucket: 'flutter-bootstrap-e6b14.appspot.com',
    measurementId: 'G-173CZKDERT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAeI8UemWpXhiLESDsOu310eUC1hDA61bU',
    appId: '1:889061256254:android:cbfb80d9b3ed2161a6756f',
    messagingSenderId: '889061256254',
    projectId: 'flutter-bootstrap-e6b14',
    storageBucket: 'flutter-bootstrap-e6b14.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCwv_hlHn7mTZeoxyWHeXllYwIFDuvj3fY',
    appId: '1:889061256254:ios:c0bc208010ca5aaca6756f',
    messagingSenderId: '889061256254',
    projectId: 'flutter-bootstrap-e6b14',
    storageBucket: 'flutter-bootstrap-e6b14.appspot.com',
    iosClientId: '889061256254-md1avtcbl053masqond8lnrvqarbpk4j.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterBootstrap',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCwv_hlHn7mTZeoxyWHeXllYwIFDuvj3fY',
    appId: '1:889061256254:ios:3c1174f3d9402731a6756f',
    messagingSenderId: '889061256254',
    projectId: 'flutter-bootstrap-e6b14',
    storageBucket: 'flutter-bootstrap-e6b14.appspot.com',
    iosClientId: '889061256254-m3earnulb9c18nl0b5h26fp4b5uvbps2.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterBootstrap.RunnerTests',
  );
}
