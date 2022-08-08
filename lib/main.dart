import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login_signup/cofig/colors.dart';
import 'package:login_signup/firebase_options.dart';
import 'package:login_signup/view/pages/home_page.dart';
import 'package:login_signup/view/pages/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _isLogin = false;
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    try {
      User? firebaseUserr = FirebaseAuth.instance.currentUser;
      var user = firebaseUserr ?? null;
      print(user);
      if (user != null) {
        _isLogin = true;
      }
    } catch (e) {
      log(e.toString());
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login/Sign up',
      theme: ThemeData(
          primaryColor: AppColor.primary,
          backgroundColor: AppColor.background,
          fontFamily: "Poppins"),
      home: (_isLogin) ? HomePage() : const OnBoardingPage(),
    );
  }
}
