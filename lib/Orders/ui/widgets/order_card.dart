import 'package:dayshez_pt/Orders/domain/entities/order.dart';
import 'package:dayshez_pt/core/utils.dart';
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
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                flex: 3,
                child: Hero(
                  tag: '${order!.name!}${order!.id}',
                  transitionOnUserGestures: true,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.network(
                        height: 100.h,
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
                                  order!.subCompany!,
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
                                      : order!.status == OrderStatus.error
                                          ? STATUS_ERROR
                                          : order!.status == OrderStatus.show
                                              ? STATUS_SHOW
                                              : order!.status ==
                                                      OrderStatus.noShow
                                                  ? STATUS_NO_SHOW
                                                  : STATUS_UNDEFINED,
                                  style: TextStyle(
                                      color:
                                          order!.status == OrderStatus.error ||
                                                  order!.status ==
                                                      OrderStatus.noShow
                                              ? redColor
                                              : greenColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w900),
                                )
                              ],
                            )
                          ],
                        )),
                    Expanded(
                        flex: 3,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    order!.status == OrderStatus.success ||
                                            order!.status == OrderStatus.error
                                        ? SvgPicture.asset(
                                            item1,
                                            fit: BoxFit.contain,
                                          )
                                        : SvgPicture.asset(
                                            item2,
                                            fit: BoxFit.cover,
                                          ),
                                    const Icon(Icons.arrow_forward_ios)
                                  ])
                            ],
                          ),
                        ))
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
