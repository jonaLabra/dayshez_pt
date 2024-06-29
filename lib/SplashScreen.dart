// ignore_for_file: file_names

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:dayshez_pt/LoadingScreen.dart';
import 'package:dayshez_pt/utils.dart';
import 'package:flutter/material.dart';

class SplasScreen extends StatelessWidget {
  const SplasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
        animationCurve: Curves.linear,
        backgroundColor: whiteColor,
        nextScreen: const LoadingScreen(),
        childWidget: SizedBox(
          height: MediaQuery.of(context).size.height * 0.20,
          width: MediaQuery.of(context).size.width * 0.20,
          child: Image.asset(assetLogo),
        ));
  }
}
