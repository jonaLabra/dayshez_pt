// ignore_for_file: avoid_print, library_prefixes
import 'package:dayshez_pt/%20.env';
import 'package:dayshez_pt/Log/domain/entities/user.dart';
import 'package:dayshez_pt/Log/domain/respositories/abstract_authentication_repository.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supebaseAuth;
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends AbstractAuthenticationRepository {
  late final supebaseAuth.SupabaseClient _supabaseAuth;
  late final GoogleSignIn _googleSignIn;

  AuthenticationRepository(
      {supebaseAuth.SupabaseClient? supabaseAuth,
      GoogleSignIn? googleSignIn,
      h,
      SignInWithApple? signInWithApple})
      : _supabaseAuth = supabaseAuth ?? supebaseAuth.Supabase.instance.client,
        _googleSignIn = googleSignIn ??
            GoogleSignIn(
              clientId: IOS_CLIENT_ID,
              serverClientId: WEB_CLIENT_ID,
            );

  var currentUser = Userdata.empty;

  @override
  Future<String?> loginWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser!.authentication;
      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null) {
        throw 'No Access Token found.';
      }
      if (idToken == null) {
        throw 'No ID Token found.';
      }

      var response = await _supabaseAuth.auth.signInWithIdToken(
        provider: supebaseAuth.OAuthProvider.google,
        idToken: idToken,
        accessToken: accessToken,
      );
      if (response.session != null) {
        return 'success';
      } else {
        return 'error';
      }
    } on supebaseAuth.AuthException catch (e) {
      return e.message;
    } catch (e) {
      return '$e';
    }
  }

  @override
  Future<void> logout() async {
    try {
      await Future.wait([
        _supabaseAuth.auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      print('Logout Error $e');
    }
  }

  @override
  Future<String?> signUp(
      {String? email,
      String? password,
      String? username,
      String? phone}) async {
    try {
      await _supabaseAuth.auth.signUp(
          password: password!.trim(),
          email: email!.trim(),
          data: {'displayName': username!.trim()});
      return 'success';
    } on supebaseAuth.AuthException catch (e) {
      return e.message;
    } catch (e) {
      return '$e';
    }
  }

  @override
  Future<String?> loginWithEmailAndPassword(
      {String? email, String? password}) async {
    try {
      await _supabaseAuth.auth
          .signInWithPassword(email: email!, password: password!);
      return 'success';
    } on supebaseAuth.AuthException catch (e) {
      return e.message;
    } catch (e) {
      return '$e';
    }
  }

  @override
  Stream<Userdata> get user {
    return _supabaseAuth.auth.onAuthStateChange.map((supabaseUser) {
      Userdata user = supabaseUser.session == null
          ? Userdata.empty
          : Userdata(
              name: supabaseUser.session!.user.userMetadata!.values.first,
              email: supabaseUser.session!.user.email);
      currentUser = user;
      return user;
    });
  }
}
