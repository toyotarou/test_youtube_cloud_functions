import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../extensions/extensions.dart';
import '../models/user.dart';

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
}
