import 'package:flutter/material.dart';

class Dialogss {
  static Future<void> showAlertDialog(
      BuildContext context, String title, message) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.blue,
            title: Text(
              title,
              style: const TextStyle(
                  fontFamily: 'Montserrat - Bold', color: Colors.white),
            ),
            content: Text(
              message,
              style: const TextStyle(
                  color: Colors.white, fontFamily: 'Montserrat - Regular'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.white.withOpacity(0.1)),
                ),
                child: const Text(
                  "OK",
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Montserrat - Bold'),
                ),
              )
            ],
          );
        });
  }
}
