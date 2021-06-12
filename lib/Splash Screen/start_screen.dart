import 'package:codeforces_app/Screens/display_screen.dart';
import 'package:flutter/material.dart';
import '../Screens/contest_screen.dart';
import 'dart:async';

class startScreen extends StatefulWidget {
  const startScreen({Key key}) : super(key: key);

  @override
  _startScreenState createState() => _startScreenState();
}

class _startScreenState extends State<startScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => DisplayScreen())));

    var assetImage = new AssetImage('images/codeforces_logo.png');

    var image= new Image(image: assetImage,height: 200,);

    return Container(
      decoration: new BoxDecoration(color: Colors.black),
      child: Center(
        child: image,
      ),
    );
  }
}
