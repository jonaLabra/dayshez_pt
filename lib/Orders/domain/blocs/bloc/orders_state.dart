part of 'orders_bloc.dart';

sealed class OrdersState extends Equatable {
  const OrdersState();

  @override
  List<Object> get props => [];
}

final class OrdersLoading extends OrdersState {}

final class OrdersLoaded extends OrdersState {
  final List<Order> orders;

  const OrdersLoaded({this.orders = const <Order>[]});

  @override
  List<Object> get props => [orders];
}
