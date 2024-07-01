import 'package:dayshez_pt/Orders/domain/entities/order.dart';

abstract class AbstractOrdersRepository {
  Stream<List<Order>>? getAllOrders(String query);
}
