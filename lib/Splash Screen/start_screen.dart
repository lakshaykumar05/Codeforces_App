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

  Future<List<Contest>> update_upcoming_contest() async {

    // print(123);

    var contest_data = await CodeForces().getContestData();

    //  print(contest_data);

    List<Contest> Upcoming_contests = [];

    List<Contest> Running_contest = [];

    List<Contest> Previous_contest = [];

    List<Contest> mainList = [];

    for(int i=0;i<20;i++){

      //   print(contest_data['result'][i]['startTimeSeconds'].runtimeType);

      int timestamp = contest_data['result'][i]['startTimeSeconds'];

      var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp*1000000);

      //   print(date)

      final DateFormat formatter = DateFormat('dd-MM-yyyy  hh:mm');
      final String formatted = formatter.format(date);

      //   print(formatted);

      contest_data['result'][i]['startTimeSeconds'] = formatted;

////////

      // int time_stamp= contest_data['result'][i]['durationSeconds'];
      //
      // var dur = new DateTime.fromMicrosecondsSinceEpoch(time_stamp*1000000);
      //
      // final DateFormat formatter_dur = DateFormat('hh:mm');
      // final String formatted_dur = formatter_dur.format(dur);
      //
      // contest_data['result'][i]['durationSeconds'] = formatted_dur+formatted;
      // //
      // print(contest_data['result'][i]['durationSeconds']);

      //
      // //    print(contest_data['result'][i]['startTimeSeconds']);

      Contest contest = Contest(contest_data['result'][i]['name'], contest_data['result'][i]['startTimeSeconds'] , contest_data['result'][i]['durationSeconds'],contest_data['result'][i]['id']);

      if(contest_data['result'][i]['phase']=='BEFORE'){
        Upcoming_contests.add(contest);
      }
      else if(contest_data['result'][i]['phase']=='RUNNING'){
        Running_contest.add(contest);
      }
      else{
        Previous_contest.add(contest);
      }
      // Upcoming_contests.add(contest);
    }

    Iterable inReversed =  Running_contest.reversed;
    var Running_contests_reverse = inReversed.toList();

    Iterable in_Reversed =  Upcoming_contests.reversed;
    var Upcoming_contests_reverse = in_Reversed.toList();

    Iterable in__Reversed =  Previous_contest.reversed;
    var Previous_contests_reverse = in__Reversed.toList();


    mainList = Running_contests_reverse + Upcoming_contests_reverse;
    // mainList = new List.from(Running_contests_reverse)..addAll(Upcoming_contests_reverse);
    // print(Upcoming_contests);
    //  print(mainList);

    return mainList;
  }

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
