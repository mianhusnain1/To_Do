import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
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
      body: Stack(
        children: [
          Container(
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
                    padding: const EdgeInsets.all(3.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/images/Logo.jpg",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                LottieBuilder.asset(
                  "assets/lottie/loading.json",
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 80,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white.withOpacity(0.9)),
                child: const Center(
                  child: Text(
                    "Powered by: Mian Husnain",
                    style: TextStyle(
                        fontFamily: "Montserrat - Bold",
                        color: Color.fromARGB(255, 0, 110, 201),
                        fontSize: 16),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
