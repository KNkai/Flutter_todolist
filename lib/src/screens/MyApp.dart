import 'package:flutter/material.dart';
import 'package:todolist_sqflite/src/screens/Home/home_page.dart';
import 'package:todolist_sqflite/src/screens/Onboard/splash_page.dart';

class MyApp extends StatelessWidget {
  int isFirst;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    isFirst = 1;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.light(),
      home: isFirst==1 ? HomePage() : SplashPage(),
    );
  }
}
