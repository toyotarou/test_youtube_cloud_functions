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
    apiKey: 'AIzaSyDGMt5mtpUK8W7sPTTPw8wRCJ0hIbYvQTg',
    appId: '1:1082842985559:web:aa47e614634373be471f12',
    messagingSenderId: '1082842985559',
    projectId: 'hideyuki-firebase',
    authDomain: 'hideyuki-firebase.firebaseapp.com',
    storageBucket: 'hideyuki-firebase.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDSlSYSeoa9fA43KGdCPov3LtAMeXQZ0BY',
    appId: '1:1082842985559:android:a92a25e160385f27471f12',
    messagingSenderId: '1082842985559',
    projectId: 'hideyuki-firebase',
    storageBucket: 'hideyuki-firebase.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB-N8lZNZRZl5PCVMAhxTkA_edocgPYm7Q',
    appId: '1:1082842985559:ios:06a52a3a3d5518ec471f12',
    messagingSenderId: '1082842985559',
    projectId: 'hideyuki-firebase',
    storageBucket: 'hideyuki-firebase.appspot.com',
    androidClientId: '1082842985559-a0lh8n0fi1ohs49v0n991jg5ui6flo2v.apps.googleusercontent.com',
    iosClientId: '1082842985559-vragurnfmf9hn5h81fsh9ekmarj5m5ju.apps.googleusercontent.com',
    iosBundleId: 'com.example.testYoutubeCloudFunctions',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB-N8lZNZRZl5PCVMAhxTkA_edocgPYm7Q',
    appId: '1:1082842985559:ios:d2862167e89ec320471f12',
    messagingSenderId: '1082842985559',
    projectId: 'hideyuki-firebase',
    storageBucket: 'hideyuki-firebase.appspot.com',
    androidClientId: '1082842985559-a0lh8n0fi1ohs49v0n991jg5ui6flo2v.apps.googleusercontent.com',
    iosClientId: '1082842985559-0a6l0fh2msth4gphpgj19f2037r5hg0u.apps.googleusercontent.com',
    iosBundleId: 'com.example.testYoutubeCloudFunctions.RunnerTests',
  );
}
