// REGISTER VIEW PAGE
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:notes/constants/routes.dart';
import 'package:notes/utilities/show_error_dialog.dart';

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
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on FirebaseAuthException catch (e) {
                devtools.log(e.toString());

                ///USE THIS
                if (e.code == 'weak-password') {
                  await showErrorDialog(context, e.toString());
                } else if (e.code == 'email-already-in-use') {
                  await showErrorDialog(context, e.toString());
                  // devtools.log(e.code.toString());
                } else if (e.code == 'invalid-email') {
                  await showErrorDialog(context, e.toString());
                } else {
                  await showErrorDialog(context, e.toString());
                }
                // OR
                //  showErrorDialog(context, e.toString());
              } catch (e) {
                await showErrorDialog(context, e.toString());
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
