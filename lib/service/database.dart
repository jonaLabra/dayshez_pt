// ignore_for_file: non_constant_identifier_names

import 'package:dayshez_pt/models/order.dart';
import 'package:dayshez_pt/utils.dart';
import 'package:dayshez_pt/widgets/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:dayshez_pt/ .env';

class Database {
  late SupabaseClient? SUPABASE_CLIENT;
  Database() {
    SUPABASE_CLIENT = Supabase.instance.client;
  }

  Future<bool> signInWithEmailPassword(
      String email, String password, FToast toast) async {
    try {
      await SUPABASE_CLIENT!.auth
          .signInWithPassword(password: password.trim(), email: email.trim())
          .whenComplete(() {});
      return true;
    } on AuthException catch (error) {
      toast.showToast(
          child: CustomToast(
            iconTitle: Icons.no_accounts_sharp,
            title: error.message,
            color: yellowColor,
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
          positionedToastBuilder: (_, child) {
            return Positioned(
              top: 25.0,
              left: 40.0,
              child: child,
            );
          });
      return false;
    } catch (error) {
      toast.showToast(
          child: CustomToast(
            iconTitle: Icons.error,
            title: '$errorLogin $error',
            color: redColor,
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
          positionedToastBuilder: (_, child) {
            return Positioned(
              top: 25.0,
              left: 40.0,
              child: child,
            );
          });
      return false;
    }
  }

  Future<bool> signUp(
      String email, String password, String username, FToast toast) async {
    try {
      await SUPABASE_CLIENT!.auth.signUp(
          password: password.trim(),
          email: email.trim(),
          emailRedirectTo: kIsWeb ? null : REDIRECT_URL,
          data: {'displayName': username.trim()}).whenComplete(() => null);
      toast.showToast(
          child: const CustomToast(
            iconTitle: Icons.account_circle_sharp,
            title: confirmSignUp,
            color: greenColor,
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
          positionedToastBuilder: (_, child) {
            return Positioned(
              top: 25.0,
              left: 40.0,
              child: child,
            );
          });
      return true;
    } on AuthException catch (error) {
      debugPrint('AuthException $error');
      toast.showToast(
          child: CustomToast(
            iconTitle: Icons.no_accounts_sharp,
            title: error.message,
            color: yellowColor,
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
          positionedToastBuilder: (_, child) {
            return Positioned(
              top: 25.0,
              left: 40.0,
              child: child,
            );
          });
      return false;
    } catch (error) {
      debugPrint('catch $error');
      toast.showToast(
          child: CustomToast(
            iconTitle: Icons.error,
            title: '$errorLogin $error',
            color: redColor,
          ),
          gravity: ToastGravity.BOTTOM,
          toastDuration: const Duration(seconds: 2),
          positionedToastBuilder: (_, child) {
            return Positioned(
              top: 25.0,
              left: 40.0,
              child: child,
            );
          });
      return false;
      //throw Exception(error);
    }
  }

  Future<bool> logout(BuildContext context) async {
    try {
      await SUPABASE_CLIENT!.auth.signOut();
      return true;
    } on AuthException catch (error) {
      debugPrint('Auth ${error.message}');
      return false;
    } catch (error) {
      debugPrint('Catch $error');
      return false;
    }
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
