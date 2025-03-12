import 'package:flutter/material.dart';
import 'package:mobile/constants/app_routes.dart';

class UserLogin extends StatelessWidget {
  const UserLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[

            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              style: TextStyle(color: Colors.black),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              style: TextStyle(color: Colors.black),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.survey);
              },
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}