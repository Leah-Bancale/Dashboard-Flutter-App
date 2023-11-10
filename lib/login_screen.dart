// login_screen.dart

import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onLogin; // Add the onLogin parameter

  LoginScreen({required this.onLogin});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false; // Track the visibility of the password

  bool isValidCredentials(String username, String password) {
    return username == '' && password == '';
  }

  void _handleLogin(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (isValidCredentials(username, password)) {
      widget.onLogin(); // Call the onLogin callback
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid credentials. Please try again.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.redAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 80.0),
              child: Text(
                'Welcome!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Enter your username/email',
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: TextField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible, // Toggle password visibility
                decoration: InputDecoration(
                  labelText: 'Enter your password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  _handleLogin(context);
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                ),
                child: Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
