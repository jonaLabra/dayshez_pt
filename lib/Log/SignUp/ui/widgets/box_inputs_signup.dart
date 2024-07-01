// ignore_for_file: must_be_immutable

import 'package:dayshez_pt/Log/data/provider/show_password.dart';
import 'package:dayshez_pt/Log/domain/cubits/signup/signup_cubit.dart';
import 'package:dayshez_pt/core/utils.dart';
import 'package:dayshez_pt/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BoxInputSignUp extends StatelessWidget {
  BoxInputSignUp(
      {super.key,
      required this.formKey,
      this.emailController,
      this.passwordController,
      this.usernameController,
      this.phoneController,
      this.verifypasswordController});
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? usernameController;
  TextEditingController? phoneController;
  TextEditingController? verifypasswordController;
  GlobalKey<FormState>? formKey;

  @override
  Widget build(BuildContext context) {
    var passProvider = Provider.of<ShowPassword>(context);
    return Column(
      children: [
        TextFieldBox(
            controller: usernameController!,
            textInputType: TextInputType.name,
            labelText: userName,
            icon: Icons.alternate_email,
            onChange: (username) {
              context.read<SignupCubit>().nameChanged(username);
            }),
        TextFieldBox(
            controller: emailController!,
            textInputType: TextInputType.emailAddress,
            labelText: email,
            icon: Icons.email_outlined,
            onChange: (email) {
              context.read<SignupCubit>().emilChanged(email);
            }),
        TextFieldBox(
            controller: phoneController!,
            textInputType: TextInputType.phone,
            labelText: phone,
            icon: Icons.phone_outlined,
            onChange: (phone) {
              context.read<SignupCubit>().phoneChanged(phone);
            }),
        TextFieldBox(
            controller: passwordController!,
            textInputType: TextInputType.visiblePassword,
            labelText: password,
            icon: Icons.lock_outline_sharp,
            passProvider: passProvider,
            onChange: (password) {
              context.read<SignupCubit>().passwordChange(password);
            }),
        TextFieldBox(
            controller: verifypasswordController!,
            textInputType: TextInputType.visiblePassword,
            labelText: verifyPassword,
            icon: Icons.lock_outline_sharp,
            passProvider: passProvider,
            onChange: (verifyPass) {
              context.read<SignupCubit>().confirmPasswordChange(verifyPass);
            }),
      ],
    );
  }
}
