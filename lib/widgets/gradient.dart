import 'package:flutter/material.dart';

class Widgets {
  gradient() {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 86, 191, 245),
        Color.fromARGB(255, 25, 90, 189),
      ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
    );
  }
}
