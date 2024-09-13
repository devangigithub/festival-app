

import 'package:flutter/material.dart';
import 'package:pr_7_festival_app/screens/Splash_screen.dart';
import 'package:pr_7_festival_app/screens/detail_screen.dart';
import 'package:pr_7_festival_app/screens/home_screen.dart';


void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
       initialRoute: 'splash',
      routes: {

         '/': (context){return SplashScreen();},
        'home':(context){return HomePage();},
        'detail':(context){return DetailPage();},
      },
    ),
  );
}
