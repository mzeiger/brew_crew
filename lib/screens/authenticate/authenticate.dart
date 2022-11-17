import 'package:brew_crewirebase/services/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => AuthenticateState();
}

class AuthenticateState extends State<Authenticate> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: const Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: ElevatedButton(
          onPressed: () async {
            dynamic result = await _auth.signInAnon();
            if (result == null) {
              if (kDebugMode) {
                print('Error with anonymous sign in');
              }
            }
          },
          child: const Text('Sign In Anonymously'),
        ),
      ),
    );
  }
}
