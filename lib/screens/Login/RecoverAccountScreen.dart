// ignore_for_file: file_names

import 'package:dayshez_pt/utils.dart';
import 'package:dayshez_pt/widgets/button.dart';
import 'package:dayshez_pt/widgets/text_field.dart';
import 'package:dayshez_pt/widgets/text_link.dart';
import 'package:flutter/material.dart';

class RecoverAccountScreen extends StatelessWidget {
  const RecoverAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Image(image: AssetImage(assetLogo)),
          verticalSpaceLarge,
          const Text(
            recoverYourAccount,
            style: TextStyle(
                color: blackColor, fontSize: 30, fontWeight: FontWeight.w700),
          ),
          verticalSpaceLarge,
          //Contenedor elementos
          TextFieldBox(
              controller: TextEditingController(),
              textInputType: TextInputType.emailAddress,
              labelText: emailRecover,
              icon: Icons.person_outline_outlined),
          Button(
              buttonStyle: const ButtonStyle(
                  padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                      EdgeInsets.all(15)),
                  backgroundColor: MaterialStatePropertyAll<Color>(blackColor)),
              iconData: Icons.adaptive.arrow_forward,
              title: recover,
              onTap: () {
                Navigator.pushNamed(context, '/changePassword');
              },
              styleTextButton:
                  const TextStyle(color: whiteColor, fontSize: 20)),
          TextLink(
            title: notHaveAccount,
            textRedirect: signUp,
            onTap: () {
              Navigator.pushReplacementNamed(context, '/signup');
            },
          ),
        ],
      ),
    ));
  }
}
