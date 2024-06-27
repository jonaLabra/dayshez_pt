// ignore_for_file: file_names

import 'package:dayshez_pt/utils.dart';
import 'package:dayshez_pt/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CodeVerificationScreen extends StatefulWidget {
  const CodeVerificationScreen({super.key});

  @override
  State<CodeVerificationScreen> createState() => _CodeVerificationScreenState();
}

class _CodeVerificationScreenState extends State<CodeVerificationScreen> {
  late FToast fToast;

  _showToast() {
    fToast.showToast(
        child: CustomToast(
          iconButton: Icons.close,
          iconTitle: Icons.check_circle_sharp,
          title: toastCode,
          color: greenColor,
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/signup');
          },
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
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    Future.delayed(const Duration(milliseconds: 500), () {
      _showToast();
    });
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
      margin: const EdgeInsets.only(left: 30, right: 30, top: 50),
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              //Logo
              const Image(image: AssetImage(assetLogo)),
              verticalSpaceXLarge,
              const Text(
                titleCodeVerification,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: blackColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              verticalSpaceSmall,
              const Text(
                subtitleCodeVerification,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              verticalSpaceXLarge,
              SizedBox(
                height: 100,
                width: double.infinity,
                child: VerificationCode(
                  fullBorder: true,
                  textStyle: const TextStyle(
                      fontSize: 20.0,
                      color: blackColor,
                      fontWeight: FontWeight.w900),
                  keyboardType: TextInputType.number,
                  underlineColor: primaryColor,
                  length: 6,
                  cursorColor: blackColor26,
                  onCompleted: (String value) {},
                  onEditing: (bool value) {},
                ),
              ),
              verticalSpaceMedium,
              const Text(
                notHaveCodeVerification,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15),
              ),
              verticalSpaceSmall,
              const Text(
                requestAgain,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: greyColor),
              ),
              verticalSpaceSmall,
              const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Icon(Icons.access_time_rounded), Text('56sg')]),
              verticalSpaceXLarge,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(border: Border.all(color: greyColor)),
                child: const Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.support_outlined),
                    Text(
                      helpSupport,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: blackColor87),
                    )
                  ],
                ),
              )
            ]),
      ),
    ));
  }
}
