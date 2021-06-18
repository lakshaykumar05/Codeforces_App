import 'package:flutter/material.dart';
import 'package:codeforces_app/Networking/code_forces.dart';
import 'package:codeforces_app/Screens/display_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'dart:async';
import 'package:intl/intl.dart';


class FrontScreen extends StatefulWidget {
  @override
  _FrontScreenState createState() => _FrontScreenState();
}

class _FrontScreenState extends State<FrontScreen> {
  String userName;
  dynamic user_det;
  dynamic user_all_det;
  
  void fun(dynamic user_data){
    print(user_data);
  }
  @override

  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  void _doSomething() async {
    Timer(Duration(seconds: 3), () {
      _btnController.success();
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
          backgroundColor: Colors.grey,
          body: Column(
            children: <Widget>[
              Image.asset('images/codeforces.png',
              height: 150,
                width: 350,
              ),
              Center(
                child: FittedBox(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Text('Enter your Codeforces handle',
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w900,
                      //  fontFamily: 'Pacifico',
                      ),
                      ),
                    ),
                  ),
                ),
              ),
              // SizedBox(
              //   height: 10,
              // ),
              Container(
                // height: size.height/2,
                padding: EdgeInsets.all(35),
                child: TextField(
                    style: TextStyle(
                      color: Colors.black,
                    ),
                      decoration: InputDecoration(
                       fillColor: Colors.white,
                       filled: true,
                       // icon: Icon(
                       //   Icons.account_circle_rounded,
                       //   size: 75.0,
                       //   color: Colors.black,
                       // ) ,
                        hintText: 'Username',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                      ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                    ),
                    onChanged: (value) async {
                       userName = value;
                      print(value);
                //      userName= 'lakshay05' ;
                    },
                ),
              ),
              SizedBox(
                height: 19,
              ),
            //   RoundedLoadingButton(
            //     child: Text(
            //            'Search',
            //            style: TextStyle(
            //             // backgroundColor: Colors.black,
            //              fontSize: 35,
            // //               color: Colors.black,
            //            ),
            //          ),
            //     controller: _btnController,
            //     onPressed: () async {
            //       user_det = await CodeForces().getUserData(userName);
            //       user_all_det = await CodeForces().getAllInfo(userName);
            //       print(user_all_det);
            //       if (user_det == null) {
            //         showDialog(
            //           context: context,
            //           builder: (BuildContext context) => popUpDialog(context),
            //         );
            //       }
            //       else {
            //         fun(user_all_det);
            //         await Navigator.push(
            //             context, MaterialPageRoute(builder: (context) {
            //           return DisplayScreen(
            //               userDetails: user_det, userAllInfo: user_all_det);
            //         }));
            //         // }
            //       }
            //     },
            //   ),
              ElevatedButton(
                child: Text(
                  'Search',
                  style: TextStyle(
                   // backgroundColor: Colors.black,
                    fontSize: 35,
       //               color: Colors.black,
                  ),
                ),
                  onPressed: () async {
                    user_det = await CodeForces().getUserData(userName);
                    user_all_det = await CodeForces().getAllInfo(userName);
                    // print(user_all_det);
                    
                    if (user_det == null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => popUpDialog(context),
                      );
                    }
                    else {
                      fun(user_all_det);
                      await Navigator.push(
                          context, MaterialPageRoute(builder: (context) {
                        return DisplayScreen(
                            userDetails: user_det, userAllInfo: user_all_det);
                      }));
                      // }
                    }
                  },
              ),
            ],
          ),
        );
  }
}


Widget popUpDialog(BuildContext context) {
  return new AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
    title: Center(child: Text('Invalid Handle',
    style: TextStyle(
      fontSize: 22,
    ),)),
    actions: <Widget>[
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,

        child: Padding(
          padding: const EdgeInsets.only(right:108.0),
          child: Text('OK',style: TextStyle(
            fontSize: 21,
          ),),
          //FaIcon(FontAwesomeIcons.times,size: 50,)
          ),
        ),
        ],
  );
}



// FlatButton(
// onPressed: () {
//
// },
// child: Text(
// 'Search',
// style: TextStyle(
// height: 3,
// color: Colors.white,
// backgroundColor: Colors.black,
// fontSize:35,
// ),
// ),
// ),