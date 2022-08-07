import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_signup/cofig/colors.dart';
import 'package:login_signup/view/pages/onboarding_page.dart';

Future<void> main() async {
  runApp(const MyApp());
  //await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login/Sign up',
        theme: ThemeData(
            primaryColor: AppColor.primary,
            backgroundColor: AppColor.background,
            fontFamily: "Poppins"),
        home: const OnBoardingPage());
  }
}
