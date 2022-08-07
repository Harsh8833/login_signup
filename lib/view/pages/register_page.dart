import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_signup/cofig/colors.dart';
import 'package:login_signup/cofig/textstyles.dart';
import 'package:login_signup/utils/auth.dart';
import 'package:login_signup/view/pages/login_page.dart';
import 'package:login_signup/view/pages/onboarding_page.dart';
import 'package:login_signup/view/widgets/buttons.dart';
import 'package:login_signup/view/widgets/frostedBg.dart';
import 'package:login_signup/view/widgets/input_container.dart';
import 'package:login_signup/view/widgets/showMessage.dart';

TextEditingController emailC = TextEditingController();
TextEditingController nameC = TextEditingController();
TextEditingController phoneC = TextEditingController();
TextEditingController passC = TextEditingController();
TextEditingController rePassC = TextEditingController();

var firebaseUser = FirebaseAuth.instance.currentUser;
final firestoreInstance = FirebaseFirestore.instance;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Future uploadFile(context) async {
    await firestoreInstance.collection("users").doc(firebaseUser!.uid).set({
      "name": nameC.text.toString(),
      "phone": phoneC.text.toString(),
      "email": emailC.text.toString(),
    }).then((_) {
      showMessage(
          'You Are Set! A verification email has been sent to your email address. Kindly click on it.',
          context);
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    Future showLoading(text) async {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Container(
              height: 100,
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircularProgressIndicator(
                    color: AppColor.primary,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(text),
                ],
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
        body: FrostedBackground(
            child: SafeArea(
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              const Text(
                "Sign Up",
                style: AppTextStyle.displayLarge,
              ),
              const Text(
                "Let's innovate together",
                style: AppTextStyle.displayMedium,
              ),
              const SizedBox(
                height: 25,
              ),
              InputContainer(
                child: TextField(
                  controller: nameC,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Name',
                    labelStyle: AppTextStyle.labelStyle,
                    floatingLabelStyle: TextStyle(color: AppColor.primary),
                  ),
                ),
              ),
              InputContainer(
                child: TextField(
                  controller: emailC,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Email',
                    labelStyle: AppTextStyle.labelStyle,
                    floatingLabelStyle: TextStyle(color: AppColor.primary),
                  ),
                ),
              ),
              InputContainer(
                child: TextField(
                  controller: phoneC,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Phone',
                    labelStyle: AppTextStyle.labelStyle,
                    floatingLabelStyle: TextStyle(color: AppColor.primary),
                  ),
                ),
              ),
              InputContainer(
                child: TextField(
                  controller: passC,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Password',
                    labelStyle: AppTextStyle.labelStyle,
                    floatingLabelStyle: TextStyle(color: AppColor.primary),
                  ),
                ),
              ),
              InputContainer(
                child: TextField(
                  controller: rePassC,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Re-enter Password',
                    labelStyle: AppTextStyle.labelStyle,
                    floatingLabelStyle: TextStyle(color: AppColor.primary),
                  ),
                ),
              ),
              AppButton(
                  text: "Register",
                  onTap: () async {
                    if (emailC.text.toString() != "" &&
                        passC.text.toString() != "" &&
                        nameC.text.toString() != "" &&
                        phoneC.text.toString() != "" &&
                        rePassC.text.toString() != "") {
                      if (phoneC.text.toString().length < 10) {
                        if (phoneC.text.toString().isEmpty) {
                          log('Are you sure you want to continue without phone number');
                          return;
                        } else {
                          log('Please enter a correct phone number');
                        }
                      }
                      if (passC.text.toString() == rePassC.text.toString()) {
                        showLoading("Registering");
                        AuthenticationHelper()
                            .signUp(
                                email: emailC.text.toString(),
                                password: passC.text.toString())
                            .then((error) {
                          if (error == null) {
                            uploadFile(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const OnBoardingPage()));
                            resetFeilds();
                            showMessage(
                                "Verification e-mail has been sent to given e-mail address please verify and Sign in using your e-mail and password.",
                                context);
                          } else {
                            Navigator.pop(context);
                            log('Error : $error');
                            showMessage(error.toString(), context);
                          }
                        });
                      } else {
                        Navigator.pop(context);

                        log("Passwords don't match!");
                        showMessage("Passwords don't match!", context);
                      }
                    } else {
                      Navigator.pop(context);

                      log('Please fill all fields to continue');
                      showMessage(
                          'Please fill all fields to continue', context);
                    }
                  })
            ],
          )),
    )));
  }
}
