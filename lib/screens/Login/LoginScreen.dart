// ignore_for_file: file_names

import 'package:dayshez_pt/utils.dart';
import 'package:dayshez_pt/widgets/button.dart';
import 'package:dayshez_pt/widgets/header.dart';
import 'package:dayshez_pt/widgets/text_field.dart';
import 'package:dayshez_pt/widgets/text_link.dart';
import 'package:dayshez_pt/widgets/toast.dart';
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
                    textInputType: TextInputType.name,
                    labelText: userName,
                    icon: Icons.alternate_email),
                TextFieldBox(
                    textInputType: TextInputType.visiblePassword,
                    icon: Icons.lock_outline,
                    labelText: password),
                Button(
                    buttonStyle: const ButtonStyle(
                        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                            EdgeInsets.all(15)),
                        backgroundColor:
                            MaterialStatePropertyAll<Color>(primaryColor)),
                    title: initSession,
                    onTap: () {
                      var isValid = formKey.currentState!.validate();
                      if (isValid) {
                        fToast.showToast(
                            child: const CustomToast(
                              iconTitle: Icons.supervisor_account_sharp,
                              title: confirmLogin,
                              color: greenColor,
                            ),
                            gravity: ToastGravity.BOTTOM,
                            toastDuration: const Duration(seconds: 2),
                            positionedToastBuilder: (_, child) {
                              return Positioned(
                                top: 25.0,
                                left: 40.0,
                                child: child,
                              );
                            });
                        Future.delayed(
                            const Duration(milliseconds: 2200),
                            () => Navigator.pushReplacementNamed(
                                context, '/home'));
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
