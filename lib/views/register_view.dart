// REGISTER VIEW PAGE
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:notes/constants/routes.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email, _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Container dialogBox() {
    return Container(
      color: Colors.amber[900],
      height: 2,
      child: const Text('Weak Password'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Column(
        children: [
          //UNAME
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Your e-mail here'),
          ),
          //PASSWORD
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration: const InputDecoration(hintText: 'Your password here'),
          ),
          TextButton(
            //we put async as it will take some time to execute
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                final userCredential =
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                devtools.log(userCredential.toString());
              } on FirebaseAuthException catch (e) {
                devtools.log(e.toString());
                if (e.code == 'weak-password') {
                  // dialogBox();
                  devtools.log(e.code.toString());
                }
                if (e.code == 'email-already-in-use') {
                  devtools.log(e.code.toString());
                } else if (e.code == 'invalid-email') {
                  devtools.log(e.code.toString());
                }
              }
            },
            child: const Text('Register'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context)
                  .pushNamedAndRemoveUntil(loginRoute, (route) => false);
            },
            child: const Text('Already registered? Tap here'),
          )
        ],
      ),
    );
  }
}
