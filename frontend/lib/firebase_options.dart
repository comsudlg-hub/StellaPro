// Configuração Firebase para StellaPro - CHAVES REAIS
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
        throw UnsupportedError('DefaultFirebaseOptions have not been configured for macos');
      case TargetPlatform.windows:
        throw UnsupportedError('DefaultFirebaseOptions have not been configured for windows');
      case TargetPlatform.linux:
        throw UnsupportedError('DefaultFirebaseOptions have not been configured for linux');
      default:
        throw UnsupportedError('DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  // ✅ CONFIGURAÇÃO WEB - SUAS CHAVES REAIS
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyD7-RmJznojDajvv1jDh7bD22sdbUaCn7Q',
    appId: '1:884545560488:web:ca23f5fc29c0430c4f479d',
    messagingSenderId: '884545560488',
    projectId: 'stellapro',
    authDomain: 'stellapro.firebaseapp.com',
    storageBucket: 'stellapro.firebasestorage.app',
  );

  // ✅ CONFIGURAÇÃO ANDROID - Use as mesmas chaves ou configure separado
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD7-RmJznojDajvv1jDh7bD22sdbUaCn7Q',
    appId: '1:884545560488:android:ca23f5fc29c0430c4f479d',
    messagingSenderId: '884545560488',
    projectId: 'stellapro',
    storageBucket: 'stellapro.firebasestorage.app',
  );

  // ✅ CONFIGURAÇÃO iOS - Use as mesmas chaves ou configure separado
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD7-RmJznojDajvv1jDh7bD22sdbUaCn7Q',
    appId: '1:884545560488:ios:ca23f5fc29c0430c4f479d',
    messagingSenderId: '884545560488',
    projectId: 'stellapro',
    storageBucket: 'stellapro.firebasestorage.app',
    iosBundleId: 'com.stellapro.app',
  );
}
