// ignore_for_file: file_names

import 'package:dayshez_pt/utils.dart';
import 'package:dayshez_pt/widgets/button.dart';
import 'package:dayshez_pt/widgets/header.dart';
import 'package:dayshez_pt/widgets/text_field.dart';
import 'package:dayshez_pt/widgets/text_link.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
          margin: const EdgeInsets.only(left: 30, right: 30, top: 70),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const Hedaer(pathLogo: assetLogo, title: initSession),
                verticalSpaceMedium,
                //Contenedor elementos
                TextFieldBox(
                    textInputType: TextInputType.name,
                    labelText: userName,
                    icon: Icons.alternate_email),

                TextFieldBox(
                    textInputType: TextInputType.emailAddress,
                    labelText: email,
                    icon: Icons.email_outlined),

                TextFieldBox(
                    textInputType: TextInputType.phone,
                    labelText: phone,
                    icon: Icons.phone_outlined),

                TextFieldBox(
                    textInputType: TextInputType.visiblePassword,
                    labelText: password,
                    icon: Icons.lock_outline_sharp),

                TextFieldBox(
                    textInputType: TextInputType.visiblePassword,
                    labelText: verifyPassword,
                    icon: Icons.lock_outline_sharp),

                Button(
                    title: createAccountButton,
                    styleTextButton:
                        const TextStyle(color: whiteColor, fontSize: 18),
                    buttonStyle: const ButtonStyle(
                        elevation: MaterialStatePropertyAll<double>(0),
                        padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                            EdgeInsets.all(15)),
                        backgroundColor: MaterialStatePropertyAll(blackColor)),
                    onTap: () {
                      Navigator.pushReplacementNamed(context, '/codeVerify');
                    }),

                TextLink(
                  title: haveAccountYet,
                  textRedirect: initSession,
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                )
              ],
            ),
          )),
    ));
  }
}
