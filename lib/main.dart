import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ilift/Screens/login_check.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const LoginCheck()); // Program Entry Point
}