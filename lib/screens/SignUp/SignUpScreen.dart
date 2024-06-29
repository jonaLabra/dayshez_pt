// ignore_for_file: file_names

import 'dart:async';

import 'package:dayshez_pt/service/database.dart';
import 'package:dayshez_pt/utils.dart';
import 'package:dayshez_pt/widgets/button.dart';
import 'package:dayshez_pt/widgets/header.dart';
import 'package:dayshez_pt/widgets/text_field.dart';
import 'package:dayshez_pt/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _usernameController =
      TextEditingController();
  late final TextEditingController _phoneController = TextEditingController();
  late final TextEditingController _verifypasswordController =
      TextEditingController();
  var formKey = GlobalKey<FormState>();
  late FToast fToast;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _verifypasswordController.dispose();
    _phoneController.dispose();
    fToast.removeCustomToast();
    super.dispose();
  }

  Future<void> _signUp(
      String email, String pass, String username, String phone) async {
    try {
      setState(() {
        _isLoading = true;
      });
      var confirmSignUp =
          await Database().signUp(email, pass, username, fToast);
      if (confirmSignUp) {
        _emailController.clear();
        _passwordController.clear();
        _usernameController.clear();
        _verifypasswordController.clear();
        _phoneController.clear();
      }
    } on AuthException catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(error.message),
            backgroundColor: Theme.of(context).colorScheme.error));
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: const Text('Ocurrio un error, vuelva a intentar...'),
            backgroundColor: Theme.of(context).colorScheme.error));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30, top: 70),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Hedaer(pathLogo: assetLogo, title: initSession),
                  verticalSpaceMedium,
                  //Contenedor elementos
                  TextFieldBox(
                      controller: _usernameController,
                      textInputType: TextInputType.name,
                      labelText: userName,
                      icon: Icons.alternate_email),

                  TextFieldBox(
                      controller: _emailController,
                      textInputType: TextInputType.emailAddress,
                      labelText: email,
                      icon: Icons.email_outlined),

                  TextFieldBox(
                      controller: _phoneController,
                      textInputType: TextInputType.phone,
                      labelText: phone,
                      icon: Icons.phone_outlined),

                  TextFieldBox(
                      controller: _passwordController,
                      textInputType: TextInputType.visiblePassword,
                      labelText: password,
                      icon: Icons.lock_outline_sharp),

                  TextFieldBox(
                      controller: _verifypasswordController,
                      textInputType: TextInputType.visiblePassword,
                      labelText: verifyPassword,
                      icon: Icons.lock_outline_sharp),

                  Button(
                      title: _isLoading ? loadignAccount : createAccountButton,
                      styleTextButton:
                          const TextStyle(color: whiteColor, fontSize: 18),
                      buttonStyle: const ButtonStyle(
                          elevation: MaterialStatePropertyAll<double>(0),
                          padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                              EdgeInsets.all(15)),
                          backgroundColor:
                              MaterialStatePropertyAll(blackColor)),
                      onTap: _isLoading
                          ? null
                          : () async {
                              var isValid = formKey.currentState!.validate();
                              if (isValid) {
                                await _signUp(
                                    _emailController.text,
                                    _passwordController.text,
                                    _usernameController.text,
                                    _phoneController.text);
                              }
                            }),

                  TextLink(
                      title: haveAccountYet,
                      textRedirect: initSession,
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/login'))
                ],
              ),
            ),
          )),
    ));
  }
}
