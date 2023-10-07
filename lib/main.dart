import 'package:flutter/material.dart';
import 'dashboard_screen.dart';
import 'user_profile_screen.dart';
import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/dashboard': (context) => DashboardScreen(),
        '/user_profile': (context) => UserProfileScreen(),
        '/login': (context) => LoginScreen(), 
      },
    );
  }
}
