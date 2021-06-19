import 'package:codeforces_app/Screens/front_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Networking/code_forces.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'about_screen.dart';
import 'tempContest_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class ContestScreen extends StatefulWidget {
  const ContestScreen({Key key}) : super(key: key);

  @override
  _ContestScreenState createState() => _ContestScreenState();
}

class _ContestScreenState extends State<ContestScreen> {

 @override
  void initState() {
    super.initState();
  }

  int currentIndex=0;
  String url;
  int contestNumber;
  Size size;

  List<Widget>screens=[
    TempContestScreen(),
    FrontScreen(),
    AboutScreen(),
  ];

 GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  @override

  Widget build(BuildContext context) {
   size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldState,
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //   centerTitle: true,
      //   title: Text('Running/Upcoming Contests',
      //   style: TextStyle(
      //     color: Colors.white,
      //   ),),
      // ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blueAccent,
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[500],
        iconSize: 29.0,
        items: [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.calendarWeek),
            // Icon(Icons.calendar_today_sharp,color: Colors.white,),
            title: Text('Contest',style: TextStyle(color: Colors.grey[900]),),
            // backgroundColor: Colors.red,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.userAlt),
            // Icon(Icons.account_circle),
            title: Text('Profile',style: TextStyle(color: Colors.grey[900]),),
            // backgroundColor: Colors.blue,
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.infoCircle),
            // Icon(Icons.account_balance),
            title: Text('About',style: TextStyle(color: Colors.grey[900]),),
            // backgroundColor: Colors.blue,
          ),
        ],
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
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

/*
FutureBuilder(
        future: update_upcoming_contest(),
        builder: (BuildContext context , AsyncSnapshot snapshot){
      //    print(snapshot.data);
          if(snapshot.data==null){
            return Container(
              child: Center(
                child: Text('Loading...',style: TextStyle(
                  color: Colors.black,
                ),),
              ),
            );
          }
          else {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Divider(
                  thickness: 5,
                  color: Colors.black,
                );
                return ListTile(
            //      title: Text("Upcoming"),
                  title: Text(snapshot.data[index].name,style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),),
                  subtitle: Text(snapshot.data[index].start_time),
                  onTap: (){
                    contestNumber=snapshot.data[index].number;
                    url='https://codeforces.com/contests/$contestNumber';
                    launch(url);
                  },
                );
              },
            );
          }
        },
      ),
 */