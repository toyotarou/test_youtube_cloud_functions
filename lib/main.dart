import 'package:flutter/material.dart';

import 'services/firebase_helper.dart';
import 'services/notification_service.dart';

///
late final Widget screen;

///
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

//  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await FirebaseHelper.setupFirebase();

  await NotificationService.initializeNotification();

  screen = FirebaseHelper.homeScreen;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ///
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: screen);
  }
}
