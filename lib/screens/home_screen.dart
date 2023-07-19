import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../routes/app_route.dart';
import '../utils/login_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? name;
  @override
  void initState() {
    fetchProfiledata();
    super.initState();
  }

  fetchProfiledata() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Screen'),
          actions: [
            TextButton(
              child: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () async {
                await LoginManager.logout();
                if (!mounted) return;
                Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoute.login, (Route<dynamic> route) => false);
              },
            )
          ],
        ),
        body: Center(
          child: Text('Home Screen, $name'),
        ));
  }
}
