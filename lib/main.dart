import 'package:codeforces_app/Screens/display_screen.dart';
import 'package:flutter/material.dart';
import 'Screens/front_screen.dart';
import 'Screens/loading_screen.dart';
import 'Screens/contest_screen.dart';
import 'Splash Screen/start_screen.dart';
// static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  static final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey: NavigationService.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContestScreen(),
    );
  }
}

