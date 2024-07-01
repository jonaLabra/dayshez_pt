import 'package:dayshez_pt/Orders/domain/entities/order.dart';
import 'package:dayshez_pt/Orders/ui/DetailOrder.dart';
import 'package:dayshez_pt/Orders/ui/OrderScreen.dart';
import 'package:dayshez_pt/core/utils.dart';
import 'package:dayshez_pt/Orders/ui/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ListOrders extends StatelessWidget {
  const ListOrders(
      {super.key, required this.orders, required this.scrollController});
  final List<Order> orders;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        controller: scrollController,
        thickness: 10.0,
        child: orders.isEmpty
            ? Center(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      emptyOrders,
                      style: TextStyle(
                          color: blackColor,
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w800),
                    ),
                    horizontalSpaceMedium,
                    Icon(
                      FontAwesomeIcons.faceSadCry,
                      color: yellowColor,
                      size: 25.spMin,
                    )
                  ],
                ),
              )
            : ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (_, index) {
                  return OrderCard(
                      order: orders[index],
                      onTap: () =>
                          orders[index].status == OrderStatus.success ||
                                  orders[index].status == OrderStatus.error
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (_) =>
                                        OrderScreen(order: orders[index]),
                                  ))
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute<void>(
                                    builder: (_) =>
                                        DetailOrder(order: orders[index]),
                                  )));
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: orders.length));
  }
}
