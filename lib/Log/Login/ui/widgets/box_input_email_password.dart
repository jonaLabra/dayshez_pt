// ignore_for_file: must_be_immutable

import 'package:dayshez_pt/Log/data/provider/show_password.dart';
import 'package:dayshez_pt/Log/domain/cubits/email_password/login_email_password_cubit.dart';
import 'package:dayshez_pt/core/utils.dart';
import 'package:dayshez_pt/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class BoxInputEmailPassword extends StatelessWidget {
  BoxInputEmailPassword(
      {super.key, this.emailController, this.passwordController});
  TextEditingController? emailController;
  TextEditingController? passwordController;

  @override
  Widget build(BuildContext context) {
    var passProvider = Provider.of<ShowPassword>(context);
    return BlocBuilder<LoginEmailPasswordCubit, LoginEmailPasswordState>(
      builder: (context, state) {
        return Column(
          children: [
            TextFieldBox(
              controller: emailController!,
              textInputType: TextInputType.emailAddress,
              labelText: userName,
              icon: Icons.alternate_email,
              onChange: (email) {
                context.read<LoginEmailPasswordCubit>().emailChanged(email);
              },
            ),
            TextFieldBox(
              controller: passwordController!,
              textInputType: TextInputType.visiblePassword,
              icon: Icons.lock_outline,
              labelText: password,
              passProvider: passProvider,
              onChange: (password) {
                context
                    .read<LoginEmailPasswordCubit>()
                    .passwordChange(password);
              },
            ),
          ],
        );
      },
    );
  }
}
