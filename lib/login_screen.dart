import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Your login widgets here
            Text('Login Screen'),
            // Button to navigate to Meeting Screen after login
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/meeting');
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
