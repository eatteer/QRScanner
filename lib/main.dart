import 'package:flutter/material.dart';
import 'package:qrscanner/src/screens/home.dart';
import 'package:qrscanner/src/screens/map.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QRScanner',
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => Home(),
        'my_map': (BuildContext context) => MyMap()
      },
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
    );
  }
}
