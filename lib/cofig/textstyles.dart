import 'package:flutter/material.dart';
import 'package:login_signup/cofig/colors.dart';

class AppTextStyle {
  static const buttonLight = TextStyle(fontSize: 20, color: AppColor.white);
  static const buttonDark = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColor.black,
  );
  static const displayLarge = TextStyle(
      fontSize: 24,
      color: AppColor.black,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.9);
  static const displaySmall = TextStyle(
    fontSize: 14,
    color: AppColor.black,
    fontWeight: FontWeight.normal,
  );
}
