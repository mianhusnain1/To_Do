import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:to_do/screens/home.dart';
import 'dart:ui';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 25, 90, 189),
          Color.fromARGB(255, 86, 191, 245)
        ], begin: Alignment.bottomLeft, end: Alignment.topRight)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 80,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: ClipRRect(
                  child: Image.asset("assets/images/Logo.png"),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SpinKitFadingCircle(color: Colors.white),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "App is loading...",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }
}
