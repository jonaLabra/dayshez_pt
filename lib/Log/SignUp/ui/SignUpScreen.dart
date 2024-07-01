// ignore_for_file: file_names
import 'dart:async';

import 'package:dayshez_pt/Log/Login/ui/LoginScreen.dart';
import 'package:dayshez_pt/Log/SignUp/ui/widgets/box_inputs_signup.dart';
import 'package:dayshez_pt/Log/SignUp/ui/widgets/button_signup.dart';
import 'package:dayshez_pt/Log/data/repositories/authentication_repository.dart';
import 'package:dayshez_pt/Log/domain/cubits/signup/signup_cubit.dart';
import 'package:dayshez_pt/Orders/ui/HomeScreen.dart';
import 'package:dayshez_pt/core/utils.dart';
import 'package:dayshez_pt/Orders/ui/widgets/header.dart';
import 'package:dayshez_pt/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static Page page() => const MaterialPage<void>(child: SignUpScreen());
  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const SignUpScreen());
  }

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var formKey = GlobalKey<FormState>();
  late final StreamSubscription<AuthState> _authStateSubscription;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _usernameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _verifypasswordController;
  bool _redirecting = false;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    _phoneController = TextEditingController();
    _verifypasswordController = TextEditingController();
    _authStateSubscription =
        Supabase.instance.client.auth.onAuthStateChange.listen(
      (data) {
        if (_redirecting) return;
        final session = data.session;
        if (session != null) {
          _redirecting = true;
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          );
        }
      },
      onError: (error) {
        if (error is AuthException) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(error.message),
              backgroundColor: Theme.of(context).colorScheme.error));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Ocurrio un error vuelva a intentar'),
              backgroundColor: Theme.of(context).colorScheme.error));
        }
      },
    );
  }

  @override
  void dispose() {
    fToast.removeCustomToast();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: MultiBlocProvider(
            providers: [
              BlocProvider<SignupCubit>(
                create: (_) =>
                    SignupCubit(context.read<AuthenticationRepository>()),
              )
            ],
            child: Container(
                // margin: const EdgeInsets.only(left: 30, right: 30, top: 0),
                padding: const EdgeInsets.all(50),
                child: SingleChildScrollView(
                  child: BlocListener<SignupCubit, SignupState>(
                    listener: (context, state) {
                      if (state.status == SignUpStatus.error) {}
                    },
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Hedaer(pathLogo: assetLogo, title: initSession),
                          verticalSpaceMedium,
                          //Container inputs
                          BoxInputSignUp(
                            formKey: formKey,
                            emailController: _emailController,
                            passwordController: _passwordController,
                            usernameController: _usernameController,
                            phoneController: _phoneController,
                            verifypasswordController: _verifypasswordController,
                          ),

                          //Button SignUp
                          ButtonSignUp(
                            formKey: formKey,
                            fToast: fToast,
                          ),

                          TextLink(
                              title: haveAccountYet,
                              textRedirect: initSession,
                              onTap: () => Navigator.pushReplacement(
                                  context, LoginScreen.route()))
                        ],
                      ),
                    ),
                  ),
                )),
          ),
        ));
  }
}
