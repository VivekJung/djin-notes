//Login View PAGE
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<Object>(
            // stream: null,
            future: Firebase.initializeApp(
              options: DefaultFirebaseOptions.currentPlatform,
            ),
            builder: (context, snapshot) {
              // creating loading while future is building
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return Column(
                    children: [
                      //UNAME
                      TextField(
                        controller: _email,
                        enableSuggestions: false,
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            const InputDecoration(hintText: 'Your e-mail here'),
                      ),
                      //PASSWORD
                      TextField(
                        controller: _password,
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: const InputDecoration(
                            hintText: 'Your password here'),
                      ),
                      TextButton(
                        //we put async as it will take some time to execute
                        onPressed: () async {
                          final email = _email.text;
                          final password = _password.text;
                          try {
                            final userCredential = await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            print(userCredential);
                          } on FirebaseAuthException catch (e) {
                            e.code == 'user-not-found'
                                ? print('The user is not yet registered')
                                : print('User found');
                            e.code == 'wrong-password'
                                ? print('Password wrong')
                                : print('Password okay');
                          }
                          // catch (e) {
                          //   print('SOME ERROR OCCURED');
                          //   print(e.runtimeType);
                          // }
                        },
                        child: const Text('Login'),
                      ),
                    ],
                  );
                default:
                  return const Text('Loading...');
              }
            }),
      ),
    );
  }
}
