import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'AIzaSyCV5IhwFW-KENgZgT5DHODe7d_oNQ0esKE',
    appId: '1:501471934575:web:243a8a023d8a91899e759a',
    messagingSenderId: '501471934575',
    projectId: 'quantum-muscle',
    authDomain: 'quantum-muscle.firebaseapp.com',
    storageBucket: 'quantum-muscle.appspot.com',
    measurementId: 'G-D3ZXLFQNKP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBi6FepJE7C-MmnBU6Z1C3TjAzZdIrvP4Y',
    appId: '1:501471934575:android:19c8e8993bc3d2729e759a',
    messagingSenderId: '501471934575',
    projectId: 'quantum-muscle',
    storageBucket: 'quantum-muscle.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAB6RZmChUDnuXOI1610A84OOTyb_J1fYs',
    appId: '1:501471934575:ios:1ab097a9d30f04949e759a',
    messagingSenderId: '501471934575',
    projectId: 'quantum-muscle',
    storageBucket: 'quantum-muscle.appspot.com',
    androidClientId:
        '501471934575-tqmmr3dldftupfah68oddruuj6inlvfk.apps.googleusercontent.com',
    iosClientId:
        '501471934575-de0h49hqshq36gcoq7nsbad694c319u0.apps.googleusercontent.com',
    iosBundleId: 'com.example.quantumMuscle',
  );
}
