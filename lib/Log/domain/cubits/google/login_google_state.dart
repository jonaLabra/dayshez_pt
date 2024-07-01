part of 'login_google_cubit.dart';

enum LoginGoogleStatus { initial, submitting, success, error }

class LoginGoogleState extends Equatable {
  final LoginGoogleStatus status;

  const LoginGoogleState({required this.status});

  factory LoginGoogleState.initial() {
    return const LoginGoogleState(status: LoginGoogleStatus.initial);
  }

  @override
  List<Object> get props => [status];

  LoginGoogleState copyWith({LoginGoogleStatus? status}) {
    return LoginGoogleState(status: status ?? this.status);
  }
}
