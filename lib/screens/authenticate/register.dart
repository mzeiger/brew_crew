import 'package:brew_crewirebase/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  const Register({Key? key, required this.toggleView}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  // text field state
  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0,
        title: const Text('Register for Brew Crew'),
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
                  Text('Sign In'),
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
                //validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                validator: (val) => EmailValidator.validate(val!) ? null : 'Enter a valid email',
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              TextFormField(
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
                    dynamic result =
                        await _auth.registerWithEmailAndPassword(email, password);
                    if (result == null) {
                      setState(() {
                        error = "Registration failed!!!";
                      });
                    }
                  } else {
                    setState(() => error = "");
                  }
                },
                child: const Text(
                  'Register',
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