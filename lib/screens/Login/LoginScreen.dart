// ignore_for_file: file_names

import 'package:dayshez_pt/service/database.dart';
import 'package:dayshez_pt/utils.dart';
import 'package:dayshez_pt/widgets/button.dart';
import 'package:dayshez_pt/widgets/header.dart';
import 'package:dayshez_pt/widgets/text_field.dart';
import 'package:dayshez_pt/widgets/text_link.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late FToast fToast;
  var formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  @override
  void dispose() {
    super.dispose();
    fToast.removeCustomToast();
  }

  Future<void> _signInWithEmailAndPassword(
      String email, String password) async {
    try {
      setState(() {
        _isLoading = true;
      });
      var isLoged =
          await Database().signInWithEmailPassword(email, password, fToast);
      if (isLoged) {
        _emailController.clear();
        _passwordController.clear();
        if (!mounted) return;
        Navigator.pushReplacementNamed(context, '/home');
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Hedaer(pathLogo: assetLogo, title: initSession),
                verticalSpaceSmall,
                //Contenedor elementos
                TextFieldBox(
                    controller: _emailController,
                    textInputType: TextInputType.emailAddress,
                    labelText: userName,
                    icon: Icons.alternate_email),
                TextFieldBox(
                    controller: _passwordController,
                    textInputType: TextInputType.visiblePassword,
                    icon: Icons.lock_outline,
                    labelText: password),
                Button(
                    buttonStyle: const ButtonStyle(
                        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                            EdgeInsets.all(15)),
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(primaryColor)),
                    title: _isLoading ? loadingSession : initSession,
                    onTap: _isLoading
                        ? null
                        : () async {
                            var isValid = formKey.currentState!.validate();
                            if (isValid) {
                              await _signInWithEmailAndPassword(
                                  _emailController.text,
                                  _passwordController.text);
                            }
                          },
                    styleTextButton: const TextStyle(color: whiteColor)),
                TextLink(
                  title: notHaveAccount,
                  textRedirect: signUp,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/signup');
                  },
                ),
                Divider(
                  color: Colors.grey[300],
                ),
                TextLink(
                  title: forgotPassword,
                  textRedirect: recoverYourAccount,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/recoverAccount');
                  },
                ),

                verticalSpaceXXLarge,

                Button(
                  buttonStyle: const ButtonStyle(
                      elevation: MaterialStatePropertyAll<double>(0),
                      side: MaterialStatePropertyAll<BorderSide>(
                          BorderSide(color: blackColor26)),
                      padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                          EdgeInsets.all(15)),
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(whiteColor)),
                  title: sessionAppleID,
                  onTap: () {},
                  styleTextButton: const TextStyle(
                      color: blackColor, fontWeight: FontWeight.w700),
                  pathIcon: appleIconSVG,
                ),
                Button(
                  buttonStyle: const ButtonStyle(
                      elevation: MaterialStatePropertyAll<double>(0),
                      side: MaterialStatePropertyAll<BorderSide>(
                          BorderSide(color: blackColor26)),
                      padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                          EdgeInsets.all(15)),
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(whiteColor)),
                  title: sessionGoogle,
                  onTap: () {},
                  styleTextButton: const TextStyle(
                      color: blackColor, fontWeight: FontWeight.w700),
                  pathIcon: googleIconSVG,
                ),
                Button(
                  buttonStyle: const ButtonStyle(
                      elevation: MaterialStatePropertyAll<double>(0),
                      side: MaterialStatePropertyAll<BorderSide>(
                          BorderSide(color: blackColor26)),
                      padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                          EdgeInsets.all(15)),
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(whiteColor)),
                  title: sessionFacebook,
                  onTap: () {},
                  styleTextButton: const TextStyle(
                      color: blackColor, fontWeight: FontWeight.w700),
                  pathIcon: facebookIconSVG,
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
