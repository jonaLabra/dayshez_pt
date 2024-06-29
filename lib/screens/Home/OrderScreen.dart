// ignore_for_file: file_names

import 'package:dayshez_pt/models/order.dart';
import 'package:dayshez_pt/operations/operations_orders.dart';
import 'package:dayshez_pt/utils.dart';
import 'package:dayshez_pt/widgets/button.dart';
import 'package:dayshez_pt/widgets/header_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key, required this.order});
  final Order order;
  final MathOperations mathOp = MathOperations();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderHome(context),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Hero(
                tag: '${order.name!}${order.id}',
                child: Container(
                    margin: const EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * .30,
                    decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(order.pathImage!),
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
                            order.name!,
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
                          order.status == OrderStatus.success
                              ? STATUS_COMPLETE
                              : order.status == OrderStatus.error
                                  ? STATUS_ERROR
                                  : order.status == OrderStatus.show
                                      ? STATUS_SHOW
                                      : order.status == OrderStatus.noShow
                                          ? STATUS_NO_SHOW
                                          : STATUS_UNDEFINED,
                          style: TextStyle(
                              color: order.status == OrderStatus.error
                                  ? redColor
                                  : order.status == OrderStatus.success
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
                            FittedBox(
                              child: Text(
                                '${DateFormat.yMMMMd().format(order.date!)} ${DateFormat('HH:mm a').format(order.date!)} ·',
                                softWrap: true,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                    color: greyColor, fontSize: 12.sp),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.place,
                          color: greyColor,
                        ),
                        FittedBox(
                          child: Text(
                            order.location!,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                                color: greyColor, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),

                    //Tu Pedido
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                yourOrder,
                                style: TextStyle(
                                    color: blackColor,
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: order.orders!
                                .map((item) => Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                  flex: 1,
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        pinkColor50,
                                                    child: Text(
                                                      'X${item.amount}',
                                                      style: const TextStyle(
                                                          color: primaryColor),
                                                    ),
                                                  )),
                                              Expanded(
                                                  flex: 7,
                                                  child: Text(
                                                      textAlign:
                                                          TextAlign.start,
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      item.name!)),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.originalPrice
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: greyColor,
                                                        fontSize: 13.sp,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                  )),
                                              Expanded(
                                                  flex: 1,
                                                  child: Text(
                                                    item.priceDiscount
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontSize: 13.sp,
                                                        color: blackColor,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )),
                                            ],
                                          ),
                                        ),
                                        const Divider()
                                      ],
                                    ))
                                .toList(),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    totalArticles,
                                    style: TextStyle(fontSize: 18.sp),
                                  ),
                                  Text(
                                    '${mathOp.getTotalArticle(order.orders)}',
                                    style: TextStyle(fontSize: 18.sp),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    discount,
                                    style: TextStyle(
                                        color: greenColor, fontSize: 18.sp),
                                  ),
                                  Text(
                                    '$discountPrice',
                                    style: TextStyle(
                                        fontSize: 18.sp, color: greenColor),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(send, style: TextStyle(fontSize: 18.sp)),
                                  Text('$sendPrice',
                                      style: TextStyle(fontSize: 18.sp))
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(tip, style: TextStyle(fontSize: 18.sp)),
                                  Text('$tipPrice',
                                      style: TextStyle(fontSize: 18.sp))
                                ],
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    totalPaid,
                                    style: TextStyle(
                                        color: blackColor,
                                        fontSize: 21.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('${mathOp.getTotalPaid()}',
                                      style: TextStyle(
                                          fontSize: 21.sp,
                                          color: blackColor,
                                          fontWeight: FontWeight.bold))
                                ],
                              )
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
                                  padding: MaterialStatePropertyAll<
                                      EdgeInsetsGeometry>(EdgeInsets.all(15)),
                                  backgroundColor:
                                      MaterialStatePropertyAll<Color>(
                                          primaryColor)),
                              title: reorder,
                              onTap: () {},
                              styleTextButton: TextStyle(
                                  color: whiteColor, fontSize: 20.sp)),
                          Button(
                            buttonStyle: const ButtonStyle(
                                elevation: MaterialStatePropertyAll<double>(0),
                                side: MaterialStatePropertyAll<BorderSide>(
                                    BorderSide(color: blackColor26)),
                                padding: MaterialStatePropertyAll<
                                    EdgeInsetsGeometry>(EdgeInsets.all(15)),
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        whiteColor)),
                            title: invocie,
                            onTap: () {},
                            styleTextButton: TextStyle(
                                color: blackColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
