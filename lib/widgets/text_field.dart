// ignore_for_file: must_be_immutable

import 'package:dayshez_pt/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';

class TextFieldBox extends StatelessWidget {
  TextFieldBox(
      {super.key,
      required this.textInputType,
      required this.icon,
      required this.labelText,
      required this.controller});
  TextInputType? textInputType;
  IconData? icon;
  String? labelText = '';
  TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 25),
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28.0),
            border: Border.all(color: blackColor12),
            color: whiteColor,
            boxShadow: const [
              BoxShadow(
                  color: blackColor12,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 4,
                  spreadRadius: 1)
            ]),
        child: textInputType == TextInputType.visiblePassword
            ? TextFormField(
                controller: controller,
                keyboardType: textInputType!,
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(icon),
                    labelText: labelText,
                    contentPadding: const EdgeInsets.all(10),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.visibility),
                      onPressed: () {},
                    )),
                onChanged: (valor) {},
                autofillHints: const [AutofillHints.password],
                onEditingComplete: () => TextInput.finishAutofillContext(),
                validator: (value) {
                  return (value!.isEmpty ? requiredField(labelText!) : null);
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
              )
            : textInputType == TextInputType.emailAddress
                ? TextFormField(
                    controller: controller,
                    keyboardType: textInputType!,
                    decoration: InputDecoration(
                      icon: Icon(icon),
                      labelText: labelText,
                      contentPadding: const EdgeInsets.all(10),
                      border: InputBorder.none,
                    ),
                    onChanged: (valor) {},
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      return (value!.isEmpty
                          ? requiredField(labelText!)
                          : _validateEmail(value));
                    })
                : textInputType == TextInputType.phone
                    ? TextFormField(
                        controller: controller,
                        keyboardType: textInputType!,
                        decoration: InputDecoration(
                          icon: Icon(icon),
                          labelText: labelText,
                          contentPadding: const EdgeInsets.all(10),
                          border: InputBorder.none,
                        ),
                        onChanged: (valor) {},
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          return (value!.isEmpty
                              ? requiredField(labelText!)
                              : null);
                        })
                    : textInputType == TextInputType.name
                        ? TextFormField(
                            controller: controller,
                            keyboardType: textInputType!,
                            decoration: InputDecoration(
                              icon: Icon(icon),
                              labelText: labelText,
                              contentPadding: const EdgeInsets.all(10),
                              border: InputBorder.none,
                            ),
                            onChanged: (valor) {},
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return (value!.isEmpty
                                  ? requiredField(labelText!)
                                  : null);
                            })
                        : const SizedBox());
  }

  String? _validateEmail(String value) {
    bool isValid = EmailValidator.validate(value);
    return (!isValid ? validateEmail : null);
  }
}
