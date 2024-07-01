import 'package:bloc/bloc.dart';
import 'package:dayshez_pt/Log/data/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'login_email_password_state.dart';

class LoginEmailPasswordCubit extends Cubit<LoginEmailPasswordState> {
  final AuthenticationRepository _authenticationRepository;

  LoginEmailPasswordCubit(this._authenticationRepository)
      : super(LoginEmailPasswordState.initial());

  void emailChanged(String value) {
    emit(
        state.copyWith(email: value, status: LoginEmailPasswordStatus.initial));
  }

  void passwordChange(String value) {
    emit(state.copyWith(
        password: value, status: LoginEmailPasswordStatus.initial));
  }

  Future<String?> loginWithEmailAndPasswordCredentials() async {
    if (state.status == LoginEmailPasswordStatus.submitting) return '';
    emit(state.copyWith(status: LoginEmailPasswordStatus.submitting));
    try {
      var e = await _authenticationRepository.loginWithEmailAndPassword(
          email: state.email, password: state.password);
      debugPrint('CUBIT $e');
      emit(state.copyWith(status: LoginEmailPasswordStatus.success));
      return e;
    } catch (e) {
      emit(state.copyWith(status: LoginEmailPasswordStatus.error));
      return '';
    }
  }
}
