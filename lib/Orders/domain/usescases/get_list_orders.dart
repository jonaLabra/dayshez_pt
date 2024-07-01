import 'package:dayshez_pt/Orders/domain/entities/order.dart';
import 'package:dayshez_pt/Orders/domain/respositories/abstract_orders_repository.dart';

class GetOrder {
  final AbstractOrdersRepository orderRepository;

  GetOrder(this.orderRepository);

  Stream<List<Order>>? call({required String query}) =>
      orderRepository.getAllOrders(query);
}
