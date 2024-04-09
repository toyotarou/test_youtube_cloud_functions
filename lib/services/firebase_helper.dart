import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../extensions/extensions.dart';
import '../models/user.dart';
import '../screens/home_screen.dart';
import '../screens/signup_screen.dart';

class FirebaseHelper {
  const FirebaseHelper._();

  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///
  static Future<bool> saveUser({required String email, required String password, required String name}) async {
    final credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

    if (credential.user == null) {
      return false;
    }

    final userRef = _db.collection('users').doc(credential.user!.uid);
    final createdAt = DateTime.now().yyyymmdd;

    final userModel = UserModel(
      uid: credential.user!.uid,
      name: name,
      platform: Platform.operatingSystem,
      token: '',
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
}
