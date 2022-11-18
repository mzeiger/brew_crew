import 'package:brew_crewirebase/services/auth.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: const Text('Brew Crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                await _auth.signOut();
              },
              child: Row(
                children: const <Widget>[
                  Icon(Icons.person),
                  Text('Logout'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
