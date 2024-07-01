// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:dayshez_pt/Log/data/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  final AuthenticationRepository _authenticationRepository;

  SignupCubit(this._authenticationRepository) : super(SignupState.initial());

  void nameChanged(String value) {
    emit(state.copyWith(name: value, status: SignUpStatus.initial));
  }

  void emilChanged(String value) {
    emit(state.copyWith(email: value, status: SignUpStatus.initial));
  }

  void phoneChanged(String value) {
    emit(state.copyWith(phone: value, status: SignUpStatus.initial));
  }

  void passwordChange(String value) {
    emit(state.copyWith(password: value, status: SignUpStatus.initial));
  }

  void confirmPasswordChange(String value) {
    emit(state.copyWith(password: value, status: SignUpStatus.initial));
  }

  Future<String?> signUpFromSubmitted() async {
    if (state.status == SignUpStatus.submitting) return '';
    emit(state.copyWith(status: SignUpStatus.submitting));
    try {
      debugPrint('SIGNUP ${state.email} ${state.password} ${state.name}');
      var e = await _authenticationRepository.signUp(
          username: state.name,
          email: state.email,
          password: state.password,
          phone: state.phone);
      emit(state.copyWith(status: SignUpStatus.success));
      return e;
    } catch (e) {
      return '$e';
    }
  }
}
