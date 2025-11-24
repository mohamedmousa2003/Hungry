import 'package:flutter/material.dart';
import 'package:untitled/features/auth/views/login_view.dart';
import 'package:untitled/root.dart';
import 'package:untitled/splash_screen.dart';

import 'features/auth/views/signup_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: Root(),
    );
  }
}

