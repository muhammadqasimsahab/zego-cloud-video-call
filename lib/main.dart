import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zegowith_asif/video_calling.dart';
import 'package:zegowith_asif/views/auth/login.dart';
import 'package:zegowith_asif/views/auth/signup.dart';
import 'package:zegowith_asif/views/home/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Zego Video Calling",
      theme: ThemeData(fontFamily: GoogleFonts.ibmPlexSans().fontFamily),
      home: FirebaseAuth.instance.currentUser == null
          ? const LoginPage()
          : const HomePage(),
    );
  }
}
