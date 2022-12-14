import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_signup/cofig/colors.dart';
import 'package:login_signup/cofig/textstyles.dart';
import 'package:login_signup/utils/services.dart';
import 'package:login_signup/view/widgets/buttons.dart';
import 'package:login_signup/view/widgets/frostedBg.dart';
import 'package:login_signup/view/widgets/input_container.dart';

TextEditingController emailResetController = TextEditingController();

class PwdResetPage extends StatelessWidget {
  PwdResetPage({Key? key}) : super(key: key);
  final _firebaseService = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FrostedBackground(
          child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: -10,
              right: -100,
              child: SvgPicture.asset(
                "assets/Frame1.svg",
                color: AppColor.primary.withOpacity(0.15),
                height: 200,
              ),
            ),
            Column(children: [
              const SizedBox(
                height: 150,
              ),
              const Text(
                "Reset your password",
                style: AppTextStyle.displayLarge,
              ),
              const Text(
                "Enter your e-mail and we'll send an e-mail with reset link",
                style: AppTextStyle.bodySmall,
              ),
              const SizedBox(
                height: 50,
              ),
              InputContainer(
                child: TextField(
                  controller: emailResetController,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Enter email',
                    labelStyle: AppTextStyle.labelStyle,
                    floatingLabelStyle: TextStyle(color: AppColor.primary),
                  ),
                ),
              ),
              AppButton(
                  text: "Continue",
                  onTap: () async {
                    _firebaseService.pwdReset(
                        email: emailResetController.text.toString(),
                        context: context);
                  }),
              const SizedBox(
                height: 400,
              )
            ]),
          ],
        ),
      )),
    );
  }
}
