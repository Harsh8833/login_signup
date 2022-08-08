import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_signup/cofig/colors.dart';
import 'package:login_signup/cofig/textstyles.dart';
import 'package:login_signup/utils/services.dart';
import 'package:login_signup/view/pages/onboarding_page.dart';
import 'package:login_signup/view/widgets/buttons.dart';
import 'package:login_signup/view/widgets/frostedBg.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final _firebaseService = FirebaseService();
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

    var user = _firebaseService.getAuth().currentUser;
    return Scaffold(
      body: FrostedBackground(
        child: Stack(
          children: [
            Positioned(
              top: -120,
              left: -180,
              child: SvgPicture.asset(
                "assets/Frame.svg",
                color: AppColor.primary.withOpacity(0.1),
                height: 300,
              ),
            ),
            Positioned(
              bottom: -10,
              right: -100,
              child: SvgPicture.asset(
                "assets/Frame1.svg",
                color: AppColor.primary.withOpacity(0.15),
                height: 200,
              ),
            ),
            Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 250,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(user!.photoURL.toString())),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Hey! ${user.displayName}",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.displayLarge,
                  ),
                  Text(
                    "${user.email}",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.buttonDark,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  AppButton(
                      text: "Logout",
                      onTap: () async {
                        showLoading("Logging out");
                        try {
                          await _firebaseService.signOut().then((value) {
                            Navigator.pop(context);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const OnBoardingPage()));
                          });
                        } catch (e) {
                          log(e.toString());
                        }
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
