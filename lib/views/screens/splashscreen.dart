import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 4),
      () => Navigator.pushReplacementNamed(context, '/'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe3eff7),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Image.asset(
              "assets/images/splash.gif",
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: 130,
            ),
            Text(
              "Weather App",
              style: GoogleFonts.openSans(
                textStyle: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff364f74),
                ),
              ),
            ),
          ],
        ),
      ),
      // Image(
      //   image: AssetImage(
      //     "asstes/images/splash.gif",
      //   ),
      //   fit: BoxFit.fill,
      // ),
    );
  }
}
