import 'package:flutter/material.dart';
import 'package:login_ui/routes/app_route.dart';

import './screens/login_screen.dart';
import './screens/home_screen.dart';
import './utils/login_manager.dart';
import './screens/register_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginState();
  }

  void checkLoginState() async {
    bool isLoggedIn = await LoginManager.isLoggedIn();

    setState(() {
      _isLoggedIn = isLoggedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: _isLoggedIn ? AppRoute.home : AppRoute.login,
      routes: {
        AppRoute.home: (context) => const HomeScreen(),
        AppRoute.login: (context) => const LoginScreen(),
        AppRoute.register: (context) => const RegisterScreen(),
      },
    );
  }
}
