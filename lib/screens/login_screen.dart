import 'package:flutter/material.dart';
import 'package:meeting/resources/auth_methods.dart';
import 'package:meeting/widgets/custom_buton.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthMethods _authMethods = AuthMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Start or Join a meeting",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 38.0),
              child: Image.asset('assets/onboarding.jpg'),
            ),
            CustomButon(
              text: "Google Sing In",
              onPressed: () async {
                bool res = await _authMethods.signInWithGoogle(context);
                if (res) {
                  Navigator.pushNamed(context, 'home');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
