// ignore_for_file: avoid_print

import 'package:bloc/bloc.dart';
import 'package:dayshez_pt/Log/data/repositories/authentication_repository.dart';
import 'package:equatable/equatable.dart';

part 'login_google_state.dart';

class LoginGoogleCubit extends Cubit<LoginGoogleState> {
  final AuthenticationRepository _authenticationRepository;

  LoginGoogleCubit(this._authenticationRepository)
      : super(LoginGoogleState.initial());

  Future<String?> loginWithGoogleCredentials() async {
    if (state.status == LoginGoogleStatus.submitting) return '';
    emit(state.copyWith(status: LoginGoogleStatus.submitting));
    try {
      var e = await _authenticationRepository.loginWithGoogle();
      emit(state.copyWith(status: LoginGoogleStatus.success));
      return e;
    } catch (e) {
      print('Error en el cubit de google $e');
      emit(state.copyWith(status: LoginGoogleStatus.error));
      return '';
    }
  }
}
