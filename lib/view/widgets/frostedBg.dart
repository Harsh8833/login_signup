import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:login_signup/cofig/colors.dart';

class FrostedBackground extends StatelessWidget {
  final Widget child;
  const FrostedBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final totalHeight = MediaQuery.of(context).size.height;
    final totalWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Positioned(
          bottom: totalHeight * .2,
          left: totalWidth * 0.2,
          child: SvgPicture.asset(
            "assets/RRect_fill.svg",
            color: AppColor.frostedBackgroundColor,
          ),
        ),
        SizedBox(
          height: totalHeight,
          width: totalWidth,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50, sigmaY: 30),
            child: SizedBox(
              height: totalHeight,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: child,
        ),
      ],
    );
  }
}
