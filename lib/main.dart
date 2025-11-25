import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untitled/features/auth/views/login_view.dart';
import 'package:untitled/root.dart';
import 'package:untitled/splash_screen.dart';

import 'features/auth/views/signup_view.dart';

void main() async{
  // WidgetsFlutterBinding.ensureInitialized();
  // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName:(context)=>SplashScreen(),
        LoginView.routeName:(context)=>LoginView(),
        SignUpView.routeName:(context)=>SignUpView(),
        Root.routeName:(context)=>Root(),
      },
    );
  }
}

