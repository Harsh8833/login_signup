import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:login_signup/cofig/colors.dart';
import 'package:login_signup/cofig/textstyles.dart';
import 'package:login_signup/view/widgets/buttons.dart';
import 'package:login_signup/view/widgets/frostedBg.dart';
import 'package:login_signup/view/widgets/input_container.dart';

TextEditingController emailC = TextEditingController();
TextEditingController nameC = TextEditingController();
TextEditingController phoneC = TextEditingController();
TextEditingController passC = TextEditingController();
TextEditingController rePassC = TextEditingController();
TextEditingController regNoC = TextEditingController();

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
              AppButton(text: "Register", onTap: () {})
            ],
          )),
    )));
  }
}
