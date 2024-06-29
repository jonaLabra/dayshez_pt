// ignore_for_file: file_names

import 'dart:async';

import 'package:dayshez_pt/models/order.dart';
import 'package:dayshez_pt/screens/Home/DetailOrder.dart';
import 'package:dayshez_pt/screens/Home/OrderScreen.dart';
import 'package:dayshez_pt/service/database.dart';
import 'package:dayshez_pt/utils.dart';
import 'package:dayshez_pt/widgets/drawer_navigation.dart';
import 'package:dayshez_pt/widgets/order_card.dart';
import 'package:dayshez_pt/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Order> orders = [];
  String query = '';
  Timer? debouncer;
  bool canSearch = false;

  void _refresh() async {
    Future.delayed(const Duration(milliseconds: 1500), () async {
      await Database().getOrders(query);
      _refreshController.refreshCompleted();
      setState(() {});
    });
  }

  Widget buildSearch() => SearchWidget(
        text: query,
        hintText: search,
        onChanged: searchBook,
      );

  Future searchBook(String query) async => debounce(() async {
        final orders = await Database().getOrders(query);

        if (!mounted) return;

        setState(() {
          this.query = query;
          this.orders = orders;
        });
      });

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer!.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  @override
  void initState() {
    super.initState();
    Database().getOrders(query).then((orders) {
      setState(() => this.orders = orders);
    });
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        centerTitle: true,
        title: canSearch
            ? buildSearch()
            : const Text(
                titleHome,
                style: TextStyle(
                    color: blackColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
        actions: [
          canSearch
              ? IconButton(
                  onPressed: () => setState(() {
                        canSearch = false;
                        FocusScope.of(context).requestFocus(FocusNode());
                      }),
                  icon: const Icon(Icons.cancel))
              : IconButton(
                  onPressed: () => setState(() {
                        canSearch = true;
                      }),
                  icon: const Icon(Icons.search)),
        ],
      ),
      drawer: const DrawerNavigation(),
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
                      : SmartRefresher(
                          controller: _refreshController,
                          enablePullDown: true,
                          header: WaterDropMaterialHeader(
                            backgroundColor: primaryColor,
                            color: whiteColor,
                            distance: MediaQuery.of(context).size.height * 0.05,
                            semanticsLabel: loading,
                          ),
                          onRefresh: _refresh,
                          child: ListView.separated(
                              itemBuilder: (_, index) {
                                return OrderCard(
                                    order: orders[index],
                                    onTap: () => orders[index].status ==
                                                OrderStatus.success ||
                                            orders[index].status ==
                                                OrderStatus.error
                                        ? Navigator.push(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (_) => OrderScreen(
                                                  order: orders[index]),
                                            ))
                                        : Navigator.push(
                                            context,
                                            MaterialPageRoute<void>(
                                              builder: (_) => DetailOrder(
                                                  order: orders[index]),
                                            )));
                              },
                              separatorBuilder: (context, index) =>
                                  const Divider(),
                              itemCount: orders.length),
                        )),
            ],
          )),
    );
  }
}
