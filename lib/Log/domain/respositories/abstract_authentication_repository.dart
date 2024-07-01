import 'package:dayshez_pt/Log/domain/entities/user.dart';

abstract class AbstractAuthenticationRepository {
  Stream<Userdata> get user;

  Future<String?> signUp({
    String email,
    String password,
    String username,
  });

  Future<String?> loginWithGoogle();

  Future<String?> loginWithEmailAndPassword({String? email, String? password});

  Future<void> logout();
}
