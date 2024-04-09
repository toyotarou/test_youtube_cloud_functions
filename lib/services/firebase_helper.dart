import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../firebase_options.dart';
import '../models/user.dart';
import '../screens/home_screen.dart';
import '../screens/signup_screen.dart';

class FirebaseHelper {
  const FirebaseHelper._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///
  static Future<void> setupFirebase() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(alert: true, sound: true);
  }

  ///
  static Future<bool> saveUser({required String email, required String password, required String name}) async {
    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    if (credential.user == null) {
      return false;
    }

    final userRef = _db.collection('users').doc(credential.user!.uid);
    final createdAt = DateTime.now().yyyymmdd;

    final token = await FirebaseMessaging.instance.getToken();

    if (token == null) {
      return false;
    }

    final userModel = UserModel(
      uid: credential.user!.uid,
      name: name,
      platform: Platform.operatingSystem,
      token: token,
      createdAt: createdAt,
    );

    await userRef.set(userModel.toJson());

    return true;
  }

  ///
  static Stream<QuerySnapshot<Map<String, dynamic>>> get buildViews => _db.collection('users').snapshots();

  ///
  static Widget get homeScreen {
    if (_auth.currentUser != null) {
      return const HomeScreen();
    }

    return const SignupScreen();
  }

  ///
  static Future<void> testHealth() async {
    final callable = FirebaseFunctions.instance.httpsCallable('checkHealth');

    final response = await callable.call();

    if (response.data != null) {
      print(response.data);
    }
  }

  ///
  static Future<void> _onBackgroundMessage(RemoteMessage message) async {
    await setupFirebase();

    print('We have received a notification ${message.notification}');
  }

  ///
  static Future<String?> uploadImage(File file) async {
    final storageRef = FirebaseStorage.instance.ref();

    Reference? imageRef = storageRef.child('images/token_image.jpg');

    try {
      await imageRef.putFile(file);
      return await imageRef.getDownloadURL();
    } catch (e) {
      print(e);
      return null;
    }
  }

  ///
  static Future<bool> sendNotification({required String title, required String body, required String token, String? image}) async {
    final callable = FirebaseFunctions.instance.httpsCallable('sendNotification');

    try {
      final response = await callable.call(<String, dynamic>{'title': title, 'body': body, 'image': image, 'token': token});

      print('result is ${response.data ?? 'No data came back'}');

      if (response.data == null) {
        return false;
      }

      return true;
    } catch (e) {
      print(e);

      return false;
    }
  }
}
