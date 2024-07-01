// ignore_for_file: file_names

import 'package:dayshez_pt/Orders/domain/entities/order.dart';
import 'package:dayshez_pt/core/utils.dart';
import 'package:dayshez_pt/widgets/button.dart';
import 'package:dayshez_pt/Orders/ui/widgets/header_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DetailOrder extends StatefulWidget {
  const DetailOrder({super.key, required this.order});
  final Order? order;

  static Route<void> route(Order order) {
    return MaterialPageRoute(builder: (context) => DetailOrder(order: order));
  }

  @override
  State<DetailOrder> createState() => _DetailOrderState();
}

class _DetailOrderState extends State<DetailOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderHome(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: '${widget.order!.name!}${widget.order!.id}',
              child: Container(
                  margin: const EdgeInsets.all(10),
                  height: MediaQuery.of(context).size.height * .30,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(widget.order!.pathImage!),
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
                            widget.order!.name!,
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
                          widget.order!.status == OrderStatus.success
                              ? STATUS_COMPLETE
                              : widget.order!.status == OrderStatus.error
                                  ? STATUS_ERROR
                                  : widget.order!.status == OrderStatus.show
                                      ? STATUS_SHOW
                                      : widget.order!.status ==
                                              OrderStatus.noShow
                                          ? STATUS_NO_SHOW
                                          : STATUS_UNDEFINED,
                          style: TextStyle(
                              color: widget.order!.status ==
                                          OrderStatus.noShow ||
                                      widget.order!.status == OrderStatus.error
                                  ? redColor
                                  : widget.order!.status ==
                                              OrderStatus.success ||
                                          widget.order!.status ==
                                              OrderStatus.show
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
                              '${DateFormat.yMMMMd().format(widget.order!.date!)} ${DateFormat('HH:mm a').format(widget.order!.date!)} ·',
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
                            yourOrder,
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
                              'Reserva a ${widget.order!.subCompany!}',
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
                              totalPaid,
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
                          const Text(paymentMethod),
                          SvgPicture.asset(
                            visa,
                            height: 20,
                          ),
                          const Column(
                            children: [Text(typeCard), Text(numCard)],
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
