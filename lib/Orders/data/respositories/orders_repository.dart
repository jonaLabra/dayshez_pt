import 'package:dayshez_pt/Orders/data/datasource/remote/orders_remote_data_source.dart';
import 'package:dayshez_pt/Orders/domain/entities/order.dart';
import 'package:dayshez_pt/Orders/domain/respositories/abstract_orders_repository.dart';

class OrdersRepository extends AbstractOrdersRepository {
  OrdersRemoteDataSource ordersRemoteDataSource;

  OrdersRepository({required this.ordersRemoteDataSource});

  @override
  Stream<List<Order>>? getAllOrders(String query) {
    return ordersRemoteDataSource.getGuidesRemote(query);
  }
}
