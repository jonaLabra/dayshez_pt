import 'package:dayshez_pt/Log/domain/blocs/authentication/authentication_bloc.dart';
import 'package:dayshez_pt/Log/Login/ui/LoginScreen.dart';
import 'package:dayshez_pt/Orders/ui/HomeScreen.dart';
import 'package:flutter/material.dart';

List<Page> onGenerateViewPages(
    AuthenticationStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AuthenticationStatus.authenticated:
      return [HomeScreen.page()];
    case AuthenticationStatus.unauthenticated:
      return [LoginScreen.page()];
  }
}
