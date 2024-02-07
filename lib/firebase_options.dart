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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAB30cAB8CGu5wsJ6st-w_NEGakQhUyZM8',
    appId: '1:965774781654:android:5ca686e356db7786b02d77',
    messagingSenderId: '965774781654',
    projectId: 'timeless-d8c41',
    storageBucket: 'timeless-d8c41.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBVurADhfh-LqGqfB8hmVsEf7BadUjITGc',
    appId: '1:965774781654:ios:8f6a6d07ab1d4d4cb02d77',
    messagingSenderId: '965774781654',
    projectId: 'timeless-d8c41',
    storageBucket: 'timeless-d8c41.appspot.com',
    androidClientId: '965774781654-g1u88lpm0v3avj170e9ak1e9rjbgjliu.apps.googleusercontent.com',
    iosClientId: '965774781654-o1h2lnc9727t7lhopuvji9gsv1havbm1.apps.googleusercontent.com',
    iosBundleId: 'com.terabit.timeless.timeless',
  );
}