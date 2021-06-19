import 'package:codeforces_app/Screens/display_screen.dart';
import 'package:codeforces_app/Screens/front_screen.dart';
import 'package:flutter/material.dart';
import '../Screens/contest_screen.dart';
import 'dart:async';
import 'package:codeforces_app/Networking/code_forces.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';



class startScreen extends StatefulWidget {
  const startScreen({Key key}) : super(key: key);

  @override
  _startScreenState createState() => _startScreenState();
}

class _startScreenState extends State<startScreen> {
  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  int contestNumber;
  String url;

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 3),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => ContestScreen())));

    var assetImage = new AssetImage('images/codeforces.png');

    var image= new Image(image: assetImage,height: 200,);

    return Container(
      decoration: new BoxDecoration(color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: image,
        ),
      ),
    );
  }
}


class Contest{
  final String name;
  final String start_time;
  final int duration;
  final int number;

  Contest(this.name,this.start_time,this.duration,this.number);
}
