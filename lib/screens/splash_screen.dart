import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:innovate_2/screens/teacher_homepage.dart';
import 'package:innovate_2/screens/user_type_selec.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AnimatedSplashScreen(
        splash: Column(
          children: [
            Center(
              child: LottieBuilder.asset("assets/Lottie/Animation - 2.json"),
            )
          ],
        ),
        nextScreen: UserTypeSelectionPage(),
        splashIconSize: 300,
        backgroundColor: Color.fromRGBO(99, 151, 255, 1),
      ),
    );
  }
}