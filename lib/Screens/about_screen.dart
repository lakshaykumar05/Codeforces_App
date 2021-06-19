import 'package:flutter/material.dart';




class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text('Hey This a Codeforces App , it can be used to track user Competitive programming progress on Codeforces. It is made by using Official Codeforces API',style:
              TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.w600
              ),
            // maxLines: 3,
            ),
          ),
        ),
      ),
    );
  }
}
