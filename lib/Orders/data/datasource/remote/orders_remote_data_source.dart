import 'package:dayshez_pt/Orders/domain/entities/order.dart';

abstract class OrdersRemoteDataSource {
  Stream<List<Order>> getGuidesRemote(String query);
}
