import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtools show log;

import 'package:notes/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify your e-mail')),
      body: Column(
        children: [
          const Text(
              "We've sent you an email verification. Please open it to verify your account.\n"),
          TextButton(
            //sending email verification upon pressing this button
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              devtools.log('${user?.email.toString()} from VERIFICATION PAGE');
              await user?.sendEmailVerification();
            },
            child: const Text(
                "Not received your verification mail yet? Re-send by tapping here"),
          ),
          TextButton(
              //sending email verification upon pressing this button
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Icon(Icons.restart_alt_rounded)),
        ],
      ),
    );
  }
}
