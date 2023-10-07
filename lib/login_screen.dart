import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isValidCredentials(String username, String password) {
    return username == 'Leah' &&
        password == 'Leah'; 
  }

  void _handleLogin(BuildContext context) {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (isValidCredentials(username, password)) {
      Navigator.pushReplacementNamed(context, '/dashboard');
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
                'Username & Password: Leah',
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
                  labelText:
                      'Enter your username/email',
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText:
                      'Enter your password', 
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
