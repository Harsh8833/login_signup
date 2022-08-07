import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_signup/cofig/colors.dart';
import 'package:login_signup/cofig/textstyles.dart';
import 'package:login_signup/utils/auth.dart';
import 'package:login_signup/view/pages/home_page.dart';
import 'package:login_signup/view/pages/register_page.dart';
import 'package:login_signup/view/pages/social_button.dart';
import 'package:login_signup/view/widgets/buttons.dart';
import 'package:login_signup/view/widgets/frostedBg.dart';
import 'package:login_signup/view/widgets/input_container.dart';
import 'package:login_signup/view/widgets/loading.dart';
import 'package:login_signup/view/widgets/showMessage.dart';

TextEditingController emailController = TextEditingController();
TextEditingController passController = TextEditingController();

var firebaseUser = FirebaseAuth.instance.currentUser;

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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

    final totalWidth = MediaQuery.of(context).size.width;
    final totalHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FrostedBackground(
          child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            SizedBox(
              height: totalHeight * .08,
            ),
            const Text(
              "Hello Again!",
              textAlign: TextAlign.center,
              style: AppTextStyle.displayMedium,
            ),
            SizedBox(
              height: totalHeight * .01,
            ),
            const Text(
              "Welcome back you've\nbeen missed!",
              textAlign: TextAlign.center,
              style: AppTextStyle.bodyMedium,
            ),
            SizedBox(
              height: totalHeight * .05,
            ),
            InputContainer(
              child: TextField(
                controller: emailController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Enter username',
                  labelStyle: AppTextStyle.labelStyle,
                  floatingLabelStyle: TextStyle(color: AppColor.primary),
                ),
              ),
            ),
            InputContainer(
              child: TextField(
                controller: passController,
                obscureText: true,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Password',
                    labelStyle: AppTextStyle.labelStyle,
                    floatingLabelStyle: TextStyle(color: AppColor.primary),
                    suffixIcon: Icon(
                      Icons.visibility_off_outlined,
                      size: 20,
                    )),
              ),
            ),
            SizedBox(
              height: totalHeight * .01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Recovery Password",
                    style: AppTextStyle.bodySmall,
                  ),
                ),
                const SizedBox(
                  width: 40,
                )
              ],
            ),
            SizedBox(
              height: totalHeight * .025,
            ),
            AppButton(
              text: "Sign In",
              onTap: () {
                showLoading("Signing in");
                AuthenticationHelper()
                    .signIn(
                        email: emailController.text.toString(),
                        password: passController.text.toString())
                    .then((error) {
                  if (error == null) {
                    log('User Logging In...');
                    if (AuthenticationHelper().user.emailVerified) {
                      log('Email Verified!');
                      log('Proceeding...');

                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                    } else {
                      Navigator.pop(context);
                      log('Please verify email'); //Pop up required
                      showMessage(
                          "A verification link was sent to your email. Click on it to continue login. If you have not received the link, kindly press resend.",
                          context);
                      //Ok Button
                      //Resend verification with on click methods
                    }
                  } else {
                    Navigator.pop(context);
                    showMessage(error.toString(), context); // Pop up required
                  }
                });
              },
            ),
            SizedBox(
              height: totalHeight * .02,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(width: totalWidth * 0.3, child: const Divider()),
              const Text(
                "Or continue with",
                style: AppTextStyle.bodySmall,
              ),
              SizedBox(
                height: totalHeight * 0.12,
              ),
              SizedBox(width: totalWidth * 0.3, child: const Divider()),
            ]),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              SocialButton(
                  onTap: () {},
                  icon: Image.asset(
                    'assets/google_icon.png',
                    height: 25,
                  )),
              SocialButton(
                  onTap: () {},
                  icon: Image.asset(
                    'assets/apple_icon.png',
                    height: 28,
                  )),
              SocialButton(
                  onTap: () {},
                  icon: const Icon(
                    Icons.facebook,
                    color: Colors.blue,
                    size: 32,
                  )),
            ]),
            SizedBox(
              height: totalHeight * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Not a member?", style: AppTextStyle.bodySmall),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterPage()));
                    },
                    child: const Text(
                      "Register Now",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    ))
              ],
            )
          ]),
        ),
      )),
    );
  }
}
