import 'package:dayshez_pt/Orders/data/datasource/remote/orders_remote_data_source.dart';
import 'package:dayshez_pt/Orders/data/datasource/remote/supabase/cloud_supabase_orders_db.dart';
import 'package:dayshez_pt/Orders/data/respositories/orders_repository.dart';
import 'package:dayshez_pt/Orders/domain/blocs/bloc/orders_bloc.dart';
import 'package:dayshez_pt/Orders/domain/respositories/abstract_orders_repository.dart';
import 'package:dayshez_pt/Orders/domain/usescases/get_list_orders.dart';
import 'package:get_it/get_it.dart';

final serviceLocation = GetIt.instance;

Future<void> init() async {
  // Features - Orders
  initFeaturesOrders();
}

void initFeaturesOrders() {
  serviceLocation
      .registerFactory(() => OrdersBloc(getOrder: serviceLocation()));

  serviceLocation.registerLazySingleton(() => GetOrder(serviceLocation()));

  serviceLocation.registerLazySingleton<AbstractOrdersRepository>(
      () => OrdersRepository(ordersRemoteDataSource: serviceLocation()));

  serviceLocation.registerLazySingleton<OrdersRemoteDataSource>(
      () => CloudSupabaseOrders());
}
