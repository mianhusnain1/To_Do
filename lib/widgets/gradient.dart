import 'package:flutter/material.dart';

class Widgets {
  gradient() {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color(0xFF56BFF5),
        Color(0xFF195ABD),
      ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
    );
  }
}
