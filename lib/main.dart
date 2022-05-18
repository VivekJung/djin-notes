import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/views/login_view.dart';
import 'package:notes/views/register_view.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
    // initialRoute: '/',
    routes: {
      '/login/': (context) => const LoginView(),
      '/register/': (context) => const RegisterView(),
      // '/': (context) => const HomePage(),
    },
  ));
}

//creating dedicated homepage stateless widget
// this will route the page according to user cache
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<Object>(
          // stream: null,
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            // showing the status of firebase initialization
            switch (snapshot.connectionState) {
              case ConnectionState.done:
                // final user = (FirebaseAuth.instance.currentUser);
                // final isemailVerified = user?.emailVerified ?? false;
                // print(user);
                // // if the value exists, take the left one or else take another one
                // if (isemailVerified) {
                //   print('You are verified');
                // } else {
                //   return const VerifyEmailView();
                // }
                // return const Text('Done');
                return const LoginView();
              default:
                return const CircularProgressIndicator();
            }
          }),
    );
  }
}
