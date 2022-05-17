// REGISTER VIEW PAGE
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/firebase_options.dart';

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
      appBar: AppBar(
        title: const Text('Register'),
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
                                .createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            print(userCredential);
                          } on FirebaseAuthException catch (e) {
                            print(e);
                            if (e.code == 'weak-password') {
                              // dialogBox();
                              print(e.code);
                            }
                            if (e.code == 'email-already-in-use') {
                              print(e.code);
                            } else if (e.code == 'invalid-email') {
                              print(e.code);
                            }
                          }
                        },
                        child: const Text('Register'),
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
