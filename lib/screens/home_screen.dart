import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/firebase_helper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseHelper.buildViews,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const CircularProgressIndicator();
            }

            final users = <UserModel>[];
            final docs = snapshot.data?.docs;
            if (docs == null || docs.isEmpty) {
              return const Text('No Data');
            }

            for (final doc in docs) {
              if (doc.data() != null) {
                users.add(UserModel.fromJson(doc.data()! as Map<String, dynamic>));
              }
            }

            return Text(users.first.name);
          },
        ),
      ),
    );
  }
}