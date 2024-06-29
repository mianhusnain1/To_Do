import 'package:flutter/material.dart';

class PermissionDialog extends StatelessWidget {
  final String title;
  final String content;

  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const PermissionDialog({
    required this.title,
    required this.content,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.blue,
          fontSize: 30,
          fontFamily: 'Montserrat - Bold',
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(
          color: Color.fromARGB(255, 0, 82, 150),
          fontSize: 20,
          fontFamily: 'Montserrat - Regular',
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onCancel,
          child: const Text(
            "Cancel",
            style: TextStyle(
              color: Colors.blue,
              fontFamily: 'Montserrat - Regular',
            ),
          ),
        ),
        ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)),
            onPressed: onConfirm,
            child: const Text(
              "Approve",
              style: TextStyle(
                  fontFamily: 'Montserrat - Regular',
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ))
      ],
    );
  }
}
