import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_signup/cofig/colors.dart';
import 'package:login_signup/cofig/textstyles.dart';
import 'package:login_signup/utils/auth.dart';
import 'package:login_signup/view/widgets/buttons.dart';
import 'package:login_signup/view/widgets/frostedBg.dart';
import 'package:login_signup/view/widgets/input_container.dart';
import 'package:login_signup/view/widgets/loading.dart';
import 'package:login_signup/view/widgets/showMessage.dart';

TextEditingController emailC = TextEditingController();
TextEditingController nameC = TextEditingController();
TextEditingController phoneC = TextEditingController();
TextEditingController passC = TextEditingController();
TextEditingController rePassC = TextEditingController();
TextEditingController regNoC = TextEditingController();

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
      log('You Are Set! A verification email has been sent to your email address. Kindly click on it.');
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FrostedBackground(
            child: SafeArea(
      child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              GestureDetector(
                onTap: () {
                  //do what you want here
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      // backgroundImage:
                      //     const AssetImage("assets/images/profile-icon.png"),
                      backgroundColor: Colors.transparent,
                    ),
                    Positioned(
                      bottom: -10,
                      right: -10,
                      child: MaterialButton(
                        child: const Icon(
                          Icons.edit,
                          color: AppColor.primary,
                        ),
                        onPressed: () {}, // Display Picture Button,
                        shape: const CircleBorder(side: BorderSide.none),
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
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
                        AuthenticationHelper()
                            .signUp(
                                email: emailC.text.toString(),
                                password: passC.text.toString())
                            .then((error) {
                          if (error == null) {
                            uploadFile(context);
                          } else {
                            log('Error : $error');
                            showMessage(error, context);
                          }
                        });
                      } else {
                        log("Passwords don't match!");
                        showMessage("Passwords don't match!", context);
                      }
                    } else {
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
