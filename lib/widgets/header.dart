import 'package:dayshez_pt/utils.dart';
import 'package:flutter/material.dart';

class Hedaer extends StatelessWidget {
  const Hedaer({super.key, required this.pathLogo, required this.title});
  final String? pathLogo, title;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      //Logo
      Image(image: AssetImage(pathLogo!)),
      verticalSpaceSmall,
      Text(
        title!,
        style: const TextStyle(
            color: blackColor, fontSize: 30, fontWeight: FontWeight.w700),
      ),
    ]);
  }
}
