

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:islam/components/cache_helper.dart';
import 'package:islam/home/main_page.dart';
import 'package:islam/screens/on_boarding/on_boarding.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Widget home;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  Widget nextScreen()
  {
    if (onBoarding != null) {
      home = MainPage();
    } else {
      home = const OnBoarding();
    }
    return home;
  }
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
            () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => nextScreen())));
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png',),
              fit: BoxFit.cover
            ),
          ),
        ),
        Positioned(
          top: 214,
          left: 0,
          child: Image.asset('assets/images/left_shape.png'),
        ),
        Positioned(
          bottom: 113,
          right: 0,
          child: Image.asset('assets/images/right_shape.png'),
        ),
        Positioned(
          top: 57,
          left:70,
          right: 70,
          child: Image.asset('assets/images/mosque.png',),
        ),
        Positioned(
          top: 0,
          right:13,
          child: Image.asset('assets/images/glow.png',),
        ),
        Center(child: Image.asset('assets/images/logo.png',)),
      ],
    );
  }
}
