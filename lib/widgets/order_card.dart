import 'package:dayshez_pt/models/order.dart';
import 'package:dayshez_pt/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({super.key, required this.order, required this.onTap});
  final Order? order;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .20,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 3,
                child: Hero(
                  tag: order!.name!,
                  transitionOnUserGestures: true,
                  child: CircleAvatar(
                      backgroundColor: whiteColor,
                      radius: MediaQuery.of(context).size.height * .07,
                      child: Image.asset(
                        order!.pathImage!,
                        fit: BoxFit.cover,
                      )),
                )),
            Expanded(
                flex: 7,
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                        flex: 7,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Text(
                                  order!.name!,
                                  style: TextStyle(
                                      color: blackColor,
                                      fontSize: 18.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${order!.numArticles} articulos ·',
                                  style: TextStyle(
                                      color: greyColor, fontSize: 16.sp),
                                ),
                                Text(
                                  '${order!.price}',
                                  style: TextStyle(
                                      color: greyColor, fontSize: 16.sp),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  order!.company!,
                                  style: TextStyle(
                                      color: greyColor, fontSize: 16.sp),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  '${order!.date!.month} ${order!.date!.day} · ',
                                  style: TextStyle(
                                      color: greyColor, fontSize: 16.sp),
                                ),
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
                                          : greyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w900),
                                )
                              ],
                            )
                          ],
                        )),
                    Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(order!.iconPath!),
                                  const Icon(Icons.arrow_forward_ios)
                                ])
                          ],
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
