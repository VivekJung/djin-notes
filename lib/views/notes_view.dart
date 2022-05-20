import 'dart:developer' as devtools show log;
import 'package:flutter/material.dart';
import 'package:notes/constants/routes.dart';
import 'package:notes/enums/menu_action.dart';
import 'package:notes/services/auth/auth_service.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Main UI'),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                final shouldLogOut = await showLogOutDialog(context);
                // devtools.log(shouldLogOut.toString());

                if (shouldLogOut) {
                  await AuthService.firebase().logOut();
                  devtools.log(AuthService.firebase().currentUser.toString());
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (_) => false);
                }
                break;
            }
          }, itemBuilder: (context) {
            return [
              const PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Center(
                  child: Icon(
                    Icons.logout_sharp,
                    color: Colors.black,
                  ),
                ),
              ),
            ];
          })
        ],
      ),
      body: const Text('Hello World'),
    );
  }
}

//Creating dialog for logout function
Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Log out'),
        content: const Text('Do you really want to leave?'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
                //using true or false because we showing dialog in boolean format <bool>
              },
              child: const Text('No')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Yes')),
        ],
      );
    },
  ).then((value) => value ?? false);
}
