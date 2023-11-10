import 'package:flutter/material.dart';
import 'dashboard_page.dart';
import 'login_screen.dart';
import 'settings_page.dart';
import 'home_page.dart';
import 'stats.dart';
import 'filter.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/dashboard': (context) => DashboardPage(),
        '/login': (context) => LoginScreen(onLogin: () {
          Navigator.pushReplacementNamed(context, '/home');
        }),
        '/settings': (context) => SettingsPage(),
        '/home': (context) => HomePage(),
         '/Statistics': (context) => StatisticsPage(),
          '/filter': (context) => FilterPage(),

      },
    );
  }
}
