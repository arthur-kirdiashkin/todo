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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        return web;
        // throw UnsupportedError(
        //   'DefaultFirebaseOptions have not been configured for windows - '
        //   'you can reconfigure this by running the FlutterFire CLI again.',
        // );
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
    apiKey: 'AIzaSyAB8dZwCGATbWeGdpm0JwLzmG0ABmXL4tk',
    appId: '1:839957518751:web:b911cc2c7b3e9844f845aa',
    messagingSenderId: '839957518751',
    projectId: 'todotest-9bc35',
    authDomain: 'todotest-9bc35.firebaseapp.com',
    storageBucket: 'todotest-9bc35.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBvGC4sDdXyyb-rvtRo3vPF6yRm8SAoPbw',
    appId: '1:839957518751:android:70ab0f13764e6630f845aa',
    messagingSenderId: '839957518751',
    projectId: 'todotest-9bc35',
    storageBucket: 'todotest-9bc35.appspot.com',
  );
}
