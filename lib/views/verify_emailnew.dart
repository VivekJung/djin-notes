import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('')),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: Text('Please verify your email')),
          ),
          TextButton(
            //sending email verification upon pressing this button
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              print('${user?.email} from VERIFICATION PAGE');
              await user?.sendEmailVerification();
            },
            child: const Text('Send email verification code'),
          ),
          TextButton(
            //sending email verification upon pressing this button
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              print('${user?.email} from Sign Out section');
              await FirebaseAuth.instance.signOut();
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
