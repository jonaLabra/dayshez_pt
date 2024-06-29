import 'package:dayshez_pt/LoadingScreen.dart';
import 'package:dayshez_pt/SplashScreen.dart';
import 'package:dayshez_pt/screens/Home/HomeScreen.dart';
import 'package:dayshez_pt/screens/Login/ChangePasswordScreen.dart';
import 'package:dayshez_pt/screens/Login/CodeVerificationScreen.dart';
import 'package:dayshez_pt/screens/Login/LoginScreen.dart';
import 'package:dayshez_pt/screens/Login/RecoverAccountScreen.dart';
import 'package:dayshez_pt/screens/Login/VerifyEmailScreen.dart';
import 'package:dayshez_pt/screens/SignUp/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dayshez_pt/ .env';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: URL_SUPABASE,
    anonKey: API_KEY_SUPABASE,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        title: 'Dayshes',
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
          ScreenUtil.init(context);
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: const TextScaler.linear(1.0)),
              child: child!);
        },
        routes: {
          '/': (context) => const SplasScreen(),
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/home': (context) => const HomeScreen(),
          '/verifyEmail': (context) => const VerifyEmailScreen(),
          '/codeVerify': (context) => const CodeVerificationScreen(),
          '/recoverAccount': (context) => const RecoverAccountScreen(),
          '/changePassword': (context) => const ChangePasswordScreen(),
          '/loading': (context) => const LoadingScreen(),
        },
      ),
    );
  }
}
