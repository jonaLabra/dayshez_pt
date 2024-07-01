import 'package:dayshez_pt/core/utils.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  const TextLink(
      {super.key,
      required this.title,
      required this.textRedirect,
      required this.onTap});
  final String? title;
  final String? textRedirect;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return RichText(
        overflow: TextOverflow.fade,
        text: TextSpan(children: [
          TextSpan(text: title!, style: const TextStyle(color: blackColor)),
          TextSpan(
              style: const TextStyle(color: primaryColor),
              text: textRedirect,
              recognizer: TapGestureRecognizer()..onTap = onTap)
        ]));
  }
}
