import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_signup/cofig/colors.dart';
import 'package:login_signup/cofig/textstyles.dart';
import 'package:login_signup/utils/auth.dart';
import 'package:login_signup/view/pages/onboarding_page.dart';
import 'package:login_signup/view/pages/register_page.dart';
import 'package:login_signup/view/widgets/buttons.dart';
import 'package:login_signup/view/widgets/frostedBg.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 250,
              ),
              Text(
                "Hey you are logged in ",
                style: AppTextStyle.displayLarge,
              ),
              const SizedBox(
                height: 50,
              ),
              AppButton(
                  text: "Logout",
                  onTap: () async {
                    showLoading("Logging out");
                    AuthenticationHelper().signOut().then((value) =>
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const OnBoardingPage())));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
