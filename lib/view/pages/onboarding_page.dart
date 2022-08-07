import 'package:flutter/material.dart';
import 'package:login_signup/cofig/colors.dart';
import 'package:login_signup/cofig/dimens.dart';
import 'package:login_signup/cofig/textstyles.dart';
import 'package:login_signup/view/pages/login_page.dart';
import 'package:login_signup/view/pages/register_page.dart';
import 'package:login_signup/view/widgets/frostedBg.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalWidth = MediaQuery.of(context).size.width;
    final totalHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: FrostedBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Center(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.asset(
                      "assets/onImg.png",
                    ),
                  ),
                ),
                SizedBox(
                  height: totalHeight * .08,
                ),
                const Text(
                  "Discover your\nDream job Here",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.displayLarge,
                ),
                SizedBox(
                  height: totalHeight * .02,
                ),
                const Text(
                  "Explore all the most exciting jobs roles\nbased on your intrest And study major",
                  textAlign: TextAlign.center,
                  style: AppTextStyle.displaySmall,
                ),
                SizedBox(
                  height: totalHeight * .07,
                ),
                Container(
                  height: 52,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColor.white, width: 2)),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const RegisterPage()));
                        },
                        color: AppColor.white,
                        height: 52,
                        minWidth: totalWidth * .4,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppDimens.cornerRadius)),
                        elevation: 0,
                        highlightElevation: 0,
                        child: const Text(
                          "Register",
                          style: AppTextStyle.buttonDark,
                        ),
                      ),
                      MaterialButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()));
                        },
                        height: 52,
                        minWidth: totalWidth * .4,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppDimens.cornerRadius)),
                        child: const Text(
                          "Sign In",
                          style: AppTextStyle.buttonDark,
                        ),
                      ),
                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
