import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dayshez_pt/Orders/domain/entities/order.dart';
import 'package:dayshez_pt/Orders/domain/usescases/get_list_orders.dart';
import 'package:equatable/equatable.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final GetOrder getOrder;
  StreamSubscription? _orderSubscription;

  OrdersBloc({required this.getOrder}) : super(OrdersLoading()) {
    on<LoadOrders>(_onLoadOrders);
    on<UpdateOrders>(_onUpdateOrders);
  }

  void _onLoadOrders(LoadOrders event, Emitter<OrdersState> emitt) {
    _orderSubscription?.cancel();
    _orderSubscription = getOrder(query: event.query!)!
        .listen((orders) => add(UpdateOrders(orders)));
  }

  void _onUpdateOrders(UpdateOrders event, Emitter<OrdersState> emitt) {
    emitt(OrdersLoaded(orders: event.orders!));
  }

  @override
  Future<void> close() {
    _orderSubscription!.cancel();
    return super.close();
  }
}
