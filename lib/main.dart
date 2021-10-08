import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ilift/Screens/login_check.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'Custom Widgets/notificationservice.dart';

bool isWeb = false;
int currentIndex = 0;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  NotificationService().initNotification();
  if (kIsWeb) {
    isWeb = true;
  } else {
    isWeb = false;
  }
  runApp(const LoginCheck()); // Program Entry Point
}