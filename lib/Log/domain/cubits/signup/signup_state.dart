part of 'signup_cubit.dart';

enum SignUpStatus { initial, success, submitting, error }

class SignupState extends Equatable {
  final String email;
  final String password;
  final String name;
  final String confirmPass;
  final String phone;
  final SignUpStatus status;

  const SignupState(
      {required this.name,
      required this.email,
      required this.phone,
      required this.password,
      required this.confirmPass,
      required this.status});

  factory SignupState.initial() {
    return const SignupState(
        phone: '',
        confirmPass: '',
        name: '',
        email: '',
        password: '',
        status: SignUpStatus.initial);
  }

  SignupState copyWith(
      {String? name,
      String? email,
      String? phone,
      String? password,
      SignUpStatus? status,
      String? confirmPass}) {
    return SignupState(
        phone: phone ?? this.phone,
        confirmPass: confirmPass ?? this.confirmPass,
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status);
  }

  @override
  List<Object> get props => [name, email, phone, password, status, confirmPass];
}
