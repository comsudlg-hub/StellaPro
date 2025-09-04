// Arquivo: lib/firebase_options.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD7-RmJznojDajvv1jDh7bD22sdbUaCn7Q', // SUBSTITUIR COM SUA CHAVE REAL
    appId: '1:884545560488:web:ca23f5fc29c0430c4f479d', // SUBSTITUIR COM SEU APP ID REAL
    messagingSenderId: '884545560488',
    projectId: 'stellapro',
    authDomain: 'stellapro.firebaseapp.com',
    storageBucket: 'stellapro.firebasestorage.app',
    measurementId: 'G-DUMMYMEASUREMENT', // SUBSTITUIR COM SEU MEASUREMENT ID
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDummyAndroidKey', // SUBSTITUIR COM SUA CHAVE ANDROID
    appId: '1:884545560488:android:dummyandroidid', // SUBSTITUIR COM SEU APP ID ANDROID
    messagingSenderId: '884545560488',
    projectId: 'stellapro',
    storageBucket: 'stellapro.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDummyIOSKey', // SUBSTITUIR COM SUA CHAVE iOS
    appId: '1:884545560488:ios:dummyiosid', // SUBSTITUIR COM SEU APP ID iOS
    messagingSenderId: '884545560488',
    projectId: 'stellapro',
    storageBucket: 'stellapro.firebasestorage.app',
    iosBundleId: 'com.example.stellapro',
  );
}






