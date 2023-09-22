import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 30.0),
            ElevatedButton(
              onPressed: () {
                // TODO: Implement login logic
                // For simplicity, let's just print a message for now
                Navigator.pushNamedAndRemoveUntil(
                    context, 'home', (_) => false);
              },
              child: Text('Login'),
            ),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Or if you don't have an account, ",
                  style: TextStyle(fontSize: 12.0),
                ),
                InkWell(
                  onTap: () {
                    // TODO: Navigate to the Sign Up screen
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'signup', (_) => false);
                  },
                  child: Text(
                    'Sign up!',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.blue, // Change the color as desired
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
