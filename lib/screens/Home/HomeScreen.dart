// ignore_for_file: file_names

import 'package:dayshez_pt/models/order.dart';
import 'package:dayshez_pt/screens/Home/OrderScreen.dart';
import 'package:dayshez_pt/utils.dart';
import 'package:dayshez_pt/widgets/header_home.dart';
import 'package:dayshez_pt/widgets/order_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderHome(context, true),
      body: Container(
          margin: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                    color: blackColor12,
                    offset: Offset(0.0, 2.0),
                    blurRadius: 10,
                    spreadRadius: 1)
              ]),
          child: Column(
            children: [
              Expanded(
                  child: ListView.separated(
                      itemBuilder: (_, index) {
                        return OrderCard(
                            order: orders[index],
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (_) =>
                                      OrderScreen(order: orders[index]),
                                )));
                      },
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: orders.length)),
            ],
          )),
    );
  }
}
