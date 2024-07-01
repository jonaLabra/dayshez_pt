part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationUserChange extends AuthenticationEvent {
  const AuthenticationUserChange(this.user);
  final Userdata user;

  @override
  List<Object> get props => [];
}

class AuthenticationLogoutRequest extends AuthenticationEvent {}
