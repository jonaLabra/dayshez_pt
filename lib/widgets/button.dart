// ignore_for_file: prefer_const_constructors_in_immutables
import 'package:dayshez_pt/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Button extends StatelessWidget {
  Button(
      {super.key,
      required this.title,
      required this.onTap,
      required this.styleTextButton,
      this.pathIcon,
      this.iconData,
      required this.buttonStyle});
  final VoidCallback? onTap;
  final String? pathIcon;
  final String? title;
  final TextStyle? styleTextButton;
  final ButtonStyle? buttonStyle;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      child: ElevatedButton(
        style: buttonStyle!,
        onPressed: onTap,
        child: pathIcon != null
            ? Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset(
                    pathIcon!,
                    height: 30,
                  ),
                  Text(
                    title!,
                    style: styleTextButton,
                  )
                ],
              )
            : iconData != null
                ? Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title!,
                        style: styleTextButton,
                      ),
                      Icon(
                        iconData,
                        color: whiteColor,
                      )
                    ],
                  )
                : Text(
                    title!,
                    style: styleTextButton,
                  ),
      ),
    );
  }
}
