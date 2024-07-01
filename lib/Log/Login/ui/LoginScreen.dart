// ignore_for_file: file_names

import 'package:dayshez_pt/Log/SignUp/ui/SignUpScreen.dart';
import 'package:dayshez_pt/Log/data/repositories/authentication_repository.dart';
import 'package:dayshez_pt/Log/domain/cubits/email_password/login_email_password_cubit.dart';
import 'package:dayshez_pt/Log/domain/cubits/google/login_google_cubit.dart';
import 'package:dayshez_pt/Log/Login/ui/widgets/box_input_email_password.dart';
import 'package:dayshez_pt/Log/Login/ui/widgets/button_login_email_password.dart';
import 'package:dayshez_pt/Log/Login/ui/widgets/button_login_google.dart';
import 'package:dayshez_pt/screens/Login/RecoverAccountScreen.dart';
import 'package:dayshez_pt/core/utils.dart';
import 'package:dayshez_pt/Orders/ui/widgets/header.dart';
import 'package:dayshez_pt/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static Page page() => const MaterialPage<void>(child: LoginScreen());

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const LoginScreen());
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late FToast fToast;
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    fToast.removeCustomToast();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoginEmailPasswordCubit>(
            create: (_) => LoginEmailPasswordCubit(
                context.read<AuthenticationRepository>()),
          ),
          BlocProvider<LoginGoogleCubit>(
            create: (_) =>
                LoginGoogleCubit(context.read<AuthenticationRepository>()),
          ),
        ],
        child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30, top: 70),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Hedaer(pathLogo: assetLogo, title: initSession),
                  verticalSpaceSmall,
                  //Inputs container
                  BoxInputEmailPassword(
                    emailController: _emailController,
                    passwordController: _passwordController,
                  ),

                  //Button login email and password
                  ButtonLoginEmailPassword(
                    formKey: formKey,
                    fToast: fToast,
                  ),

                  TextLink(
                    title: notHaveAccount,
                    textRedirect: signUp,
                    onTap: () {
                      Navigator.push(context, SignUpScreen.route());
                    },
                  ),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  TextLink(
                    title: forgotPassword,
                    textRedirect: recoverYourAccount,
                    onTap: () {
                      Navigator.push(context, RecoverAccountScreen.route());
                    },
                  ),

                  verticalSpaceXXLarge,
                  //Button login with google
                  ButtonLoginWithGoogle(fToast: fToast)
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
