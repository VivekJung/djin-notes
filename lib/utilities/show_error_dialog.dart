import 'package:flutter/material.dart';

Future<void> showErrorDialog(
  BuildContext context,
  String text,
) {
  // Future.delayed(const Duration(seconds: 1));
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Oops! An error has occured'),
          content: Text(text),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Ok'),
            ),
          ],
        );
      });
}
