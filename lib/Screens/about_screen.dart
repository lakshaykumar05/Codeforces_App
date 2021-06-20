import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            // child: Text('This a Codeforces App , it can be used to track user Competitive programming progress on Codeforces. It is made by using Official Codeforces API',style:
            //   TextStyle(
            //     color: Colors.black,
            //     fontSize: 25,
            //     fontWeight: FontWeight.w600
            //   ),
            // // maxLines: 3,
            // ),
            child: Wrap(
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text:
                        "This is a codeforces App, it can be used to track user's progress on codeforces and to know about Running/Upcoming contests on codeforces. It is made by using Codeforces Official API.\nFor more information, you can visit to ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w600)),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launch("https://codeforces.com/");
                          },
                        text: "codeforces.com",
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 25,
                            fontWeight: FontWeight.w600)),
                  ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}