import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyDjXWg9_Z9lC4zxmIBl28jHBp-6qAppK6c",
            authDomain: "solar-playground-b685e.firebaseapp.com",
            projectId: "solar-playground-b685e",
            storageBucket: "solar-playground-b685e.firebasestorage.app",
            messagingSenderId: "989431883047",
            appId: "1:989431883047:web:2d4730c439a7412a027502",
            measurementId: "G-DJJC1RFVXR"));
  } else {
    await Firebase.initializeApp();
  }
}
