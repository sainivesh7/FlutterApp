import 'package:flutter/material.dart';
import 'package:socproject/pages/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

        home: Center(
          child: LoginPage(),
          // Assuming LoginPage doesn't require any parameters
        ),


      );
  }
}
/*
home: Scaffold(
appBar: AppBar(
backgroundColor: Colors.white,
title: Text("RealEstate App",
style: TextStyle(color: Colors.black87),
),

centerTitle: true,
),
*/





