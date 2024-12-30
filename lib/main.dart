//packages
import 'package:flutter/material.dart';

//page
import './pages/splash_page.dart';
import './pages/login_page.dart';
import './pages/home_page.dart';
import './pages/register_page.dart';
//services
import './services/navigation_service.dart';

//provider
import 'package:provider/provider.dart';
import './provider/authentication_provider.dart';

void main() {
  runApp(
    SplashPage(
      key: UniqueKey(),
      onInitializationComplete: () {
        runApp(
          const MainApp(),
        );
      },
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthenticationProvider>(
            create: (BuildContext context) {
          return AuthenticationProvider();
        })
      ],
      child: MaterialApp(
        title: 'Chatify',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromRGBO(36, 35, 49, 1),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Color.fromRGBO(30, 29, 37, 1.0),
          ),
        ),
        initialRoute: '/login',
        routes: {
          '/login': (BuildContext context) {
            return const LoginPage();
          },
          '/home': (BuildContext context) {
            return const HomePage();
          },
          '/register': (BuildContext context) {
            return const RegisterPage();
          }
        },
        navigatorKey: NavigationService.navigatorKey,
      ),
    );
  }
}
