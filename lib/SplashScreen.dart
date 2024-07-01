// ignore_for_file: file_names, must_be_immutable

import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:dayshez_pt/LoadingScreen.dart';
import 'package:dayshez_pt/Log/data/repositories/authentication_repository.dart';
import 'package:dayshez_pt/Log/domain/blocs/authentication/authentication_bloc.dart';
import 'package:dayshez_pt/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key, required this.authenticationRepository});
  AuthenticationRepository? authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
        animationCurve: Curves.linear,
        backgroundColor: whiteColor,
        nextScreen: RepositoryProvider.value(
          value: authenticationRepository,
          child: BlocProvider(
              create: (context) => AuthenticationBloc(
                  authenticationRepository: authenticationRepository!),
              child: const LoadingScreen()),
        ),
        childWidget: SizedBox(
          height: MediaQuery.of(context).size.height * 0.20,
          width: MediaQuery.of(context).size.width * 0.20,
          child: Image.asset(assetLogo),
        ));
  }
}
