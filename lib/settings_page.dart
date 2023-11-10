import 'package:flutter/material.dart';
import 'login_screen.dart'; // Assuming you have a LoginScreen

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Colors.redAccent,

        // Add a back button to navigate back to the Home
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate to the Login Page
            Navigator.pushReplacementNamed(context, '/login');
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
          ),
          child: Text('Log Out'),
        ),
      ),
    );
  }
}
