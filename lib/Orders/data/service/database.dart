// ignore_for_file: non_constant_identifier_names

import 'package:dayshez_pt/Orders/domain/entities/order.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Database {
  late SupabaseClient? SUPABASE_CLIENT;
  Database() {
    SUPABASE_CLIENT = Supabase.instance.client;
  }

  Future<List<Order>> getOrders(String query) async {
    try {
      var ordersDB = await SUPABASE_CLIENT!.from("Orders").select(
          "created_at, name_company, image, price, location, orders, subCompany_name, status, id");
      var orderList =
          ordersDB.map((json) => Order.fromJson(json)).where((order) {
        var title = order.name!.toLowerCase();
        var status = getStatus(order.status!).toLowerCase();
        final search = query.toLowerCase();
        return title.contains(search) || status.contains(search);
      }).toList();
      orderList.sort((a, b) => a.name!.compareTo(b.name!));
      return orderList;
    } on PostgrestException catch (error) {
      debugPrint('PostgressException $error');
      return [];
    } catch (error) {
      debugPrint('catch $error');
      return [];
    }
  }
}
