// ignore_for_file: non_constant_identifier_names

import 'package:dayshez_pt/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

AppBar HeaderHome(BuildContext context) => AppBar(
      backgroundColor: whiteColor,
      centerTitle: true,
      title: const Text(
        titleHome,
        style: TextStyle(
            color: blackColor, fontSize: 25, fontWeight: FontWeight.bold),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Icon(FontAwesomeIcons.bars),
        )
      ],
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: blackColor),
            child: IconButton(
              icon: Icon(Icons.adaptive.arrow_back, color: whiteColor),
              onPressed: () => Navigator.pop(context),
            )),
      ),
    );
