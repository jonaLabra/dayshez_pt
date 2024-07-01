import 'package:dayshez_pt/Orders/data/datasource/remote/orders_remote_data_source.dart';
import 'package:dayshez_pt/Orders/domain/entities/order.dart';
import 'package:dayshez_pt/Orders/data/service/database.dart';

class CloudSupabaseOrders extends OrdersRemoteDataSource {
  @override
  Stream<List<Order>> getGuidesRemote(String query) {
    return Database().getOrders(query).asStream();
  }
}
