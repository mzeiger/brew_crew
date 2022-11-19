import 'package:brew_crewirebase/services/auth.dart';
import 'package:brew_crewirebase/shared/loading.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../../shared/constants.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;

  const SignIn({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? const Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: const Text('Sign In to Brew Crew'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: InkWell(
              onTap: () {
                widget.toggleView();
              },
              child: Row(
                children: const <Widget>[
                  Icon(Icons.person),
                  Text('Register'),
                ],
              ),
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 50,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: 'Email',
                ),
                validator: (val) =>
                    EmailValidator.validate(val!) ? null : 'Enter a valid email',
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: "Passwords",
                ),
                validator: (val) =>
                    val!.length < 6 ? 'Enter an password 6+ characters long' : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => loading = true);
                    dynamic result =
                        await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = "Sign In Failed!!!";
                        loading = false;
                      });
                    }
                  } else {
                    setState(() => error = "");
                  }
                },
                child: const Text(
                  'Sign In',
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                error,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
