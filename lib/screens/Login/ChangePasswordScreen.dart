// ignore_for_file: file_names

import 'package:dayshez_pt/utils.dart';
import 'package:dayshez_pt/widgets/button.dart';
import 'package:dayshez_pt/widgets/text_field.dart';
import 'package:dayshez_pt/widgets/text_link.dart';
import 'package:dayshez_pt/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late FToast fToast;

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
        body: Container(
      margin: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          const Image(image: AssetImage(assetLogo)),
          verticalSpaceLarge,
          const Text(
            changePasswordTitle,
            style: TextStyle(
                color: blackColor, fontSize: 30, fontWeight: FontWeight.w700),
          ),
          verticalSpaceLarge,
          //Contenedor elementos
          TextFieldBox(
              controller: TextEditingController(),
              textInputType: TextInputType.visiblePassword,
              labelText: newPassword,
              icon: Icons.lock_outline_sharp),
          TextFieldBox(
              controller: TextEditingController(),
              textInputType: TextInputType.visiblePassword,
              labelText: verifyNewPassword,
              icon: Icons.lock_outline_sharp),
          Button(
              buttonStyle: const ButtonStyle(
                  padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                      EdgeInsets.all(15)),
                  backgroundColor: MaterialStatePropertyAll<Color>(blackColor)),
              title: changePasswordButton,
              onTap: () async {
                fToast.showToast(
                    child: const CustomToast(
                      iconTitle: Icons.mark_email_read_sharp,
                      title: confirmChangePass,
                      color: greenColor,
                    ),
                    gravity: ToastGravity.BOTTOM,
                    toastDuration: const Duration(seconds: 5),
                    positionedToastBuilder: (_, child) {
                      return Positioned(
                        top: 25.0,
                        left: 40.0,
                        child: child,
                      );
                    });
              },
              styleTextButton:
                  const TextStyle(color: whiteColor, fontSize: 20)),
          TextLink(
            title: ignoreMessage,
            textRedirect: returnLogin,
            onTap: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
    ));
  }
}
