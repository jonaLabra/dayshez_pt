part of 'orders_bloc.dart';

sealed class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object> get props => [];
}

final class LoadOrders extends OrdersEvent {
  final String? query;

  const LoadOrders({this.query});

  @override
  List<Object> get props => [query!];
}

class UpdateOrders extends OrdersEvent {
  final List<Order>? orders;

  const UpdateOrders(this.orders);

  @override
  List<Object> get props => [orders!];
}
