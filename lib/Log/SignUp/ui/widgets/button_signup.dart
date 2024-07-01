// ignore_for_file: must_be_immutable, unrelated_type_equality_checks, avoid_print, use_build_context_synchronously

import 'package:dayshez_pt/Log/domain/cubits/signup/signup_cubit.dart';
import 'package:dayshez_pt/core/utils.dart';
import 'package:dayshez_pt/widgets/button.dart';
import 'package:dayshez_pt/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ButtonSignUp extends StatelessWidget {
  ButtonSignUp({super.key, required this.formKey, required this.fToast});
  GlobalKey<FormState>? formKey;
  FToast? fToast;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return state == SignUpStatus.submitting
            ? const Center(
                child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(loadignAccount,
                      style: TextStyle(
                          color: blackColor, fontWeight: FontWeight.w700)),
                  horizontalSpaceMedium,
                  CircularProgressIndicator.adaptive(
                    backgroundColor: primaryColor,
                  ),
                ],
              ))
            : Button(
                title: createAccountButton,
                styleTextButton:
                    const TextStyle(color: whiteColor, fontSize: 18),
                buttonStyle: const ButtonStyle(
                    elevation: MaterialStatePropertyAll<double>(0),
                    padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                        EdgeInsets.all(15)),
                    backgroundColor: MaterialStatePropertyAll(blackColor)),
                onTap: () async {
                  var isValid = formKey!.currentState!.validate();
                  if (isValid) {
                    try {
                      var e = await context
                          .read<SignupCubit>()
                          .signUpFromSubmitted();
                      debugPrint('Llamada del registro bts $e');
                      if (e == 'success') {
                        Fluttertoast.showToast(
                          webPosition: "center",
                          msg: confirmSignUp,
                          toastLength: Toast.LENGTH_LONG,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 2,
                          backgroundColor: greenColor,
                          textColor: whiteColor,
                          fontSize: 16.0,
                        );
                      } else {
                        fToast!.showToast(
                            child: const CustomToast(
                              iconTitle: Icons.no_accounts_sharp,
                              title: errorSignup,
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
                      print('Error en el boton registro $e');
                    }
                  }
                });
      },
    );
  }
}
