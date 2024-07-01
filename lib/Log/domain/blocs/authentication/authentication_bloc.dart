import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dayshez_pt/Log/data/repositories/authentication_repository.dart';
import 'package:dayshez_pt/Log/domain/entities/user.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _authenticationRepository;
  StreamSubscription<Userdata>? _userSubscription;

  AuthenticationBloc(
      {required AuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.currentUser.isNotEmpty
            ? AuthenticationState.authenticated(
                authenticationRepository.currentUser)
            : const AuthenticationState.unauthenticated()) {
    on<AuthenticationUserChange>(_userChanged);
    on<AuthenticationLogoutRequest>(_logoutRequest);

    _userSubscription = _authenticationRepository.user.listen((user) {
      add(AuthenticationUserChange(user));
    });
  }

  void _userChanged(
      AuthenticationUserChange event, Emitter<AuthenticationState> emitt) {
    emitt(event.user.isNotEmpty
        ? AuthenticationState.authenticated(event.user)
        : const AuthenticationState.unauthenticated());
  }

  void _logoutRequest(event, Emitter<AuthenticationState> emitt) {
    unawaited(_authenticationRepository.logout());
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
