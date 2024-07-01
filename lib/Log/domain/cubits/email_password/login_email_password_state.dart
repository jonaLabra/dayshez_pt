part of 'login_email_password_cubit.dart';

enum LoginEmailPasswordStatus { initial, submitting, success, error }

class LoginEmailPasswordState extends Equatable {
  final String email;
  final String password;
  final LoginEmailPasswordStatus status;

  const LoginEmailPasswordState(
      {required this.email, required this.password, required this.status});

  factory LoginEmailPasswordState.initial() {
    return const LoginEmailPasswordState(
        email: '', password: '', status: LoginEmailPasswordStatus.initial);
  }

  @override
  List<Object> get props => [email, password, status];

  LoginEmailPasswordState copyWith(
      {String? email, String? password, LoginEmailPasswordStatus? status}) {
    return LoginEmailPasswordState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status);
  }
}
