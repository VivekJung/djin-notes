import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
  ));
}

//creating dedicated homepage stateless widget
// this will route the page according to user cache
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Padding(
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
                  final user = (FirebaseAuth.instance.currentUser);
                  final isemailVerified = user?.emailVerified ??
                      false; // if the value exists, take the left one or else take another one
                  if (isemailVerified) {
                    print('You are verified');
                  } else {
                    print("Your email is NOT verified");
                  }
                  return const Text('Done');
                default:
                  return const Text('Loading...');
              }
            }),
      ),
    );
  }
}
