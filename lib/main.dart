import 'package:flutter/material.dart';
import 'package:weather_api/views/screens/homepage.dart';
import 'package:weather_api/views/screens/splashscreen.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(context)=>HomePage(),
        'splash_screen' :(context)=>Splash(),
      },
    );
  }
}
