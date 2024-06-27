// ignore_for_file: file_names

import 'package:dayshez_pt/models/order.dart';
import 'package:dayshez_pt/utils.dart';
import 'package:dayshez_pt/widgets/button.dart';
import 'package:dayshez_pt/widgets/header_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DetailOrder extends StatelessWidget {
  const DetailOrder({super.key, required this.order});
  final Order? order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderHome(context, false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: order!.name!,
              child: Container(
                  margin: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * .30,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(order!.pathImage!),
                          fit: BoxFit.cover),
                      boxShadow: const [
                        BoxShadow(
                            color: blackColor12,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 10,
                            spreadRadius: 1)
                      ])),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(15.0),
              width: double.infinity,
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
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(children: [
                          Text(
                            order!.name!,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: blackColor,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ])
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          order!.status == OrderStatus.success
                              ? STATUS_COMPLETE
                              : order!.status == OrderStatus.loading
                                  ? STATUS_LOADING
                                  : order!.status == OrderStatus.error
                                      ? STATUS_ERROR
                                      : STATUS_UNDEFINED,
                          style: TextStyle(
                              color: order!.status == OrderStatus.error
                                  ? redColor
                                  : order!.status == OrderStatus.success
                                      ? greenColor
                                      : greyColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          ' · ',
                          style: TextStyle(
                              fontSize: 25.sp, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text(
                              '${DateFormat.yMMMMd().format(order!.date!)} ${DateFormat('HH:mm a').format(order!.date!)} ·',
                              style:
                                  TextStyle(color: greyColor, fontSize: 12.sp),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(children: [
                          Text(
                            'Tu pedido',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: blackColor,
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold),
                          ),
                        ])
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reserva a ${order!.company!}',
                              textAlign: TextAlign.left,
                              style:
                                  TextStyle(color: blackColor, fontSize: 18.sp),
                            ),
                            Text('0.00', style: TextStyle(fontSize: 18.sp))
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total pagado',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: blackColor,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text('0.00',
                                style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ],
                    ),
                    const Divider(),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Método de pago'),
                          SvgPicture.asset(
                            visa,
                            height: 20,
                          ),
                          const Column(
                            children: [
                              Text('ICIC Bank Card'),
                              Text('********5486')
                            ],
                          )
                        ],
                      ),
                    ),
                    Button(
                      buttonStyle: const ButtonStyle(
                          elevation: MaterialStatePropertyAll<double>(0),
                          side: MaterialStatePropertyAll<BorderSide>(
                              BorderSide(color: blackColor26)),
                          padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                              EdgeInsets.all(15)),
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(whiteColor)),
                      title: invocie,
                      onTap: () {},
                      styleTextButton: TextStyle(
                          color: blackColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    ),
                    Button(
                      buttonStyle: const ButtonStyle(
                          elevation: MaterialStatePropertyAll<double>(0),
                          side: MaterialStatePropertyAll<BorderSide>(
                              BorderSide(color: blackColor26)),
                          padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                              EdgeInsets.all(15)),
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(whiteColor)),
                      title: needHepl,
                      onTap: () {},
                      styleTextButton: TextStyle(
                          color: blackColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }
}