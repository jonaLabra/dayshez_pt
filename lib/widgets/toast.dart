import 'package:dayshez_pt/utils.dart';
import 'package:flutter/material.dart';

class CustomToast extends StatelessWidget {
  const CustomToast(
      {super.key,
      this.onPressed,
      this.iconButton,
      required this.iconTitle,
      required this.title,
      required this.color});
  final VoidCallback? onPressed;
  final IconData? iconButton, iconTitle;
  final String? title;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: color!),
          color: whiteColor),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            iconTitle!,
            color: color,
          ),
          horizontalSpaceSmall,
          Text(title!),
          iconButton != null
              ? IconButton(onPressed: onPressed, icon: Icon(iconButton))
              : const SizedBox()
        ],
      ),
    );
  }
}