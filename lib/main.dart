import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/navigator.dart';

import 'screens/onboarding.dart';
import 'screens/Home.dart';
import 'screens/contacts.dart';
import 'screens/settings.dart';
import 'screens/calls.dart';
import 'screens/navigator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TransLync',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        primarySwatch: Colors.orange,
      ),
      home: AuthGate(), // Dynamically shows the correct screen
    );
  }
}

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    // Check if user is logged in
    if (user == null) {
      return WelcomeScreen(); // Not logged in
    } else {
      return BottomNavController(); // Logged in
    }
  }
}
