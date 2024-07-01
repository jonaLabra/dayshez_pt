import 'package:dayshez_pt/LoadingScreen.dart';
import 'package:dayshez_pt/Log/Login/ui/LoginScreen.dart';
import 'package:dayshez_pt/Log/SignUp/ui/SignUpScreen.dart';
import 'package:dayshez_pt/Log/data/provider/show_password.dart';
import 'package:dayshez_pt/Log/data/repositories/authentication_repository.dart';
import 'package:dayshez_pt/SplashScreen.dart';
import 'package:dayshez_pt/Orders/ui/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/injection_container.dart' as dependency_injection;
import 'package:dayshez_pt/ .env';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: URL_SUPABASE,
    anonKey: API_KEY_SUPABASE,
  );
  await dependency_injection.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ShowPassword>.value(
          value: ShowPassword(),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(430, 932),
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
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return MaterialPageRoute(
                    settings: settings,
                    builder: (context) => SplashScreen(
                        authenticationRepository: AuthenticationRepository()));
              case '/login':
                return MaterialPageRoute(
                    settings: settings,
                    builder: (context) => const LoginScreen());
              case '/signup':
                return MaterialPageRoute(
                    settings: settings,
                    builder: (context) => const SignUpScreen());
              case '/home':
                return MaterialPageRoute(
                    settings: settings,
                    builder: (context) => const HomeScreen());
              case '/loading':
                return MaterialPageRoute(
                    settings: settings,
                    builder: (context) => const LoadingScreen());
              default:
                return MaterialPageRoute(
                    settings: settings,
                    builder: (context) => const Scaffold(
                          body: Center(
                            child: Text('Page notFound'),
                          ),
                        ));
            }
          },
        ),
      ),
    );
  }
}
