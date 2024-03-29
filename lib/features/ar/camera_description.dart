import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "MyCamera",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.black,
          textTheme: TextTheme(
              titleLarge:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              bodyLarge: TextStyle(color: Colors.white, fontSize: 20),
              titleMedium: TextStyle(color: Colors.grey, fontSize: 20))),
    );
  }
}
