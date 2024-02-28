import 'package:flutter/material.dart';

class GlobalVariables {
  static const Gradient primaryGradient = LinearGradient(
      colors: [Color.fromRGBO(99, 151, 255, 1), Color.fromRGBO(31, 68, 255, 1)],
      stops: [0.1, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);
  static const fontsize = 33;

  static String Url =
      'https://f38e-2402-3a80-4194-875a-9b67-184f-fee2-36c1.ngrok-free.app';
}
