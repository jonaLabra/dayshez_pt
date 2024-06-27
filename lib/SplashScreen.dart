// ignore_for_file: file_names

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:dayshez_pt/screens/Login/LoginScreen.dart';
import 'package:dayshez_pt/utils.dart';
import 'package:flutter/material.dart';

class SplasScreen extends StatelessWidget {
  const SplasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
        animationCurve: Curves.linear,
        backgroundColor: whiteColor,
        nextScreen: const LoginScreen(),
        childWidget: SizedBox(
          height: 200,
          width: 200,
          child: Image.asset("assets/images/logo.png"),
        ));
  }
}
