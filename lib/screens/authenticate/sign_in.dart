import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: const Text('Sign In to Brew Crew'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: ElevatedButton(
          onPressed: () async {},
          child: const Text('Sign In Anon'),
        ),
      ),
    );
  }
}
