// ignore_for_file: file_names

import 'dart:async';

import 'package:dayshez_pt/Orders/domain/blocs/bloc/orders_bloc.dart';
import 'package:dayshez_pt/Orders/ui/widgets/list_orders.dart';
import 'package:dayshez_pt/core/injection_container.dart';
import 'package:dayshez_pt/core/utils.dart';
import 'package:dayshez_pt/Orders/ui/widgets/drawer_navigation.dart';
import 'package:dayshez_pt/Orders/ui/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Page page() => const MaterialPage<void>(child: HomeScreen());

  static Route<void> route() {
    return MaterialPageRoute(builder: (context) => const HomeScreen());
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  ScrollController? _scrollController;
  String query = '';
  Timer? debouncer;
  bool canSearch = false;

  Future searchBook(String query) async => debounce(() async {
        if (!mounted) return;

        setState(() {
          this.query = query;
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
    _scrollController = ScrollController();
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
            ? SearchWidget(
                text: query,
                hintText: search,
                onChanged: searchBook,
              )
            : Text(
                titleHome,
                style: TextStyle(
                    color: blackColor,
                    fontSize: 18.sp,
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
      body: BlocBuilder<OrdersBloc, OrdersState>(
        bloc: serviceLocation<OrdersBloc>()..add(LoadOrders(query: query)),
        builder: (_, state) {
          return Container(
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
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: state is OrdersLoading
                          ? Center(
                              child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                  Text(
                                    loading,
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        color: blackColor,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  horizontalSpaceMedium,
                                  const CircularProgressIndicator.adaptive()
                                ]))
                          : state is OrdersLoaded
                              ? SmartRefresher(
                                  controller: _refreshController,
                                  enablePullDown: true,
                                  header: WaterDropMaterialHeader(
                                    backgroundColor: primaryColor,
                                    color: whiteColor,
                                    distance:
                                        MediaQuery.of(context).size.height *
                                            0.05,
                                    semanticsLabel: loading,
                                  ),
                                  onRefresh: () async {
                                    setState(() {});
                                    _refreshController.refreshCompleted();
                                  },
                                  child: ListOrders(
                                      orders: state.orders,
                                      scrollController: _scrollController),
                                )
                              : const Center(
                                  child: Text('Erro al cargar ordenes'),
                                )),
                ],
              ));
        },
      ),
    );
  }
}
