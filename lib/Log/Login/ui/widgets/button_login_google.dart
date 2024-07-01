// ignore_for_file: must_be_immutable

import 'package:dayshez_pt/Log/domain/cubits/google/login_google_cubit.dart';
import 'package:dayshez_pt/core/utils.dart';
import 'package:dayshez_pt/widgets/button.dart';
import 'package:dayshez_pt/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ButtonLoginWithGoogle extends StatelessWidget {
  ButtonLoginWithGoogle({super.key, required this.fToast});
  FToast? fToast;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginGoogleCubit, LoginGoogleState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == LoginGoogleStatus.submitting
            ? const Center(
                child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(loadingSession,
                      style: TextStyle(
                          color: blackColor, fontWeight: FontWeight.w700)),
                  horizontalSpaceMedium,
                  CircularProgressIndicator.adaptive(
                    backgroundColor: primaryColor,
                  ),
                ],
              ))
            : Button(
                buttonStyle: const ButtonStyle(
                    elevation: MaterialStatePropertyAll<double>(0),
                    side: MaterialStatePropertyAll<BorderSide>(
                        BorderSide(color: blackColor26)),
                    padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                        EdgeInsets.all(15)),
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(whiteColor)),
                title: sessionGoogle,
                onTap: () async {
                  var e = await context
                      .read<LoginGoogleCubit>()
                      .loginWithGoogleCredentials();
                  debugPrint('GOOGLE $e');
                  if (e == 'success') {
                    Fluttertoast.showToast(
                      webPosition: "center",
                      msg: confirmLogin,
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 2,
                      backgroundColor: greenColor,
                      textColor: whiteColor,
                      fontSize: 16.0,
                    );
                  } else {
                    fToast!.showToast(
                        child: CustomToast(
                          iconTitle: Icons.no_accounts_sharp,
                          title: e,
                          color: redColor,
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
                },
                styleTextButton: const TextStyle(
                    color: blackColor, fontWeight: FontWeight.w700),
                pathIcon: googleIconSVG,
              );
      },
    );
  }
}
