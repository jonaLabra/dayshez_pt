// ignore_for_file: file_names

import 'dart:async';

import 'package:dayshez_pt/service/database.dart';
import 'package:dayshez_pt/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late final StreamSubscription<AuthState> _authStateSubscription;
  bool _redirecting = false;

  @override
  void initState() {
    super.initState();
    _authStateSubscription =
        Database().SUPABASE_CLIENT!.auth.onAuthStateChange.listen(
      (data) {
        if (_redirecting) return;
        final session = data.session;
        if (session != null) {
          _redirecting = true;
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pushReplacementNamed(context, '/login');
        }
      },
      onError: (error) {
        if (error is AuthException) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(error.message),
              backgroundColor: Theme.of(context).colorScheme.error));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Ocurrio un error vuelva a intentar'),
              backgroundColor: Theme.of(context).colorScheme.error));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _authStateSubscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(loading,
            style: TextStyle(
                fontSize: 25, color: blackColor, fontWeight: FontWeight.w700)),
        CircularProgressIndicator.adaptive(),
      ],
    )));
  }
}
