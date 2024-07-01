// ignore_for_file: must_be_immutable, avoid_print

import 'package:dayshez_pt/Log/domain/cubits/email_password/login_email_password_cubit.dart';
import 'package:dayshez_pt/widgets/toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dayshez_pt/core/utils.dart';
import 'package:dayshez_pt/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ButtonLoginEmailPassword extends StatelessWidget {
  ButtonLoginEmailPassword(
      {super.key, required this.formKey, required this.fToast});
  GlobalKey<FormState>? formKey;
  FToast? fToast;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginEmailPasswordCubit, LoginEmailPasswordState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == LoginEmailPasswordStatus.submitting
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
                    padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                        EdgeInsets.all(15)),
                    backgroundColor:
                        MaterialStatePropertyAll<Color>(primaryColor)),
                title: initSession,
                onTap: () async {
                  var isValid = formKey!.currentState!.validate();
                  if (isValid == true) {
                    try {
                      var e = await context
                          .read<LoginEmailPasswordCubit>()
                          .loginWithEmailAndPasswordCredentials();
                      debugPrint('BOTON LOGIN $e');
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
                    } catch (e) {
                      print('Error en el boton login $e');
                      fToast!.showToast(
                          child: const CustomToast(
                            iconTitle: Icons.no_accounts_sharp,
                            title: errorLogin,
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
                  } else {
                    print('Fallo al loguearse con email y password');
                  }
                },
                styleTextButton: const TextStyle(color: whiteColor));
      },
    );
  }
}
