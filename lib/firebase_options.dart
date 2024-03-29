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
    apiKey: 'AIzaSyC3bQUzMw-nfvIwTe1XPMDTrUxXGABnZJg',
    appId: '1:469319339415:web:21dcc3b812f85e640e88d2',
    messagingSenderId: '469319339415',
    projectId: 'crowfunding-app-13789',
    authDomain: 'crowfunding-app-13789.firebaseapp.com',
    storageBucket: 'crowfunding-app-13789.appspot.com',
    measurementId: 'G-6HGFW0ZBR1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBXW0ofT7hRGIdM7hWoPGeQJwwJ5Dak-Pg',
    appId: '1:469319339415:android:c0838f1d2d29a6180e88d2',
    messagingSenderId: '469319339415',
    projectId: 'crowfunding-app-13789',
    storageBucket: 'crowfunding-app-13789.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBTJFBwpDCF3pLc5qelBnVtU8-dlojXt_0',
    appId: '1:469319339415:ios:7793e1cab4c1342b0e88d2',
    messagingSenderId: '469319339415',
    projectId: 'crowfunding-app-13789',
    storageBucket: 'crowfunding-app-13789.appspot.com',
    iosBundleId: 'com.example.crowfundingAppWithBloc',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBTJFBwpDCF3pLc5qelBnVtU8-dlojXt_0',
    appId: '1:469319339415:ios:660c88e147b6da8d0e88d2',
    messagingSenderId: '469319339415',
    projectId: 'crowfunding-app-13789',
    storageBucket: 'crowfunding-app-13789.appspot.com',
    iosBundleId: 'com.example.crowfundingAppWithBloc.RunnerTests',
  );
}
