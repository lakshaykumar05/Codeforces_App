import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Networking/code_forces.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';



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

 // List<Contest> Running_contest = [];

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
   Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text('Running/Upcoming Contests',
        style: TextStyle(
          color: Colors.white,
        ),),
      ),
      body: FutureBuilder(
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
                    int contestNumber=snapshot.data[index].number;
                    String url='https://codeforces.com/contests/$contestNumber';
                    launch(url);
                  },
                );
              },
            );
          }
        },
      ),
      // body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       RaisedButton(
      //         color: Colors.redAccent,
      //         onPressed: () async {
            //     contest_data = await codeForces().getContestData();
            //  //   print(contest_data.runtimeType);
            // //  print(contest_data['result'][0]['phase']);
            //     Map<String, dynamic>.from(contest_data);
            //
            //     print(contest_data.runtimeType);
            //
            //     List<Map<String,dynamic>> upcoming = List<Map<String,dynamic>>();
            //
            //     List<Map<String,dynamic>> running = List<Map<String,dynamic>>();
            //
            //     for(int i=0;i<50;i++){
            //       if(contest_data['result'][i]['phase']=="BEFORE"){
            //           upcoming.add(contest_data['result'][i]);
            //       }
            //       else if(contest_data['result'][i]['phase']=="CODING") {
            //           running.add(contest_data['result'][i]);
            //       }
            //     }
            //       print(upcoming);
            //
           //     for(int i=1;i<upcoming.length;i++)



            //   },
            // ),

    //       ],
    //     ),
    //   ),
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


// //
// Widget running(){
//   FutureBuilder(
//     future: update_running_contest(),
//     builder: (BuildContext context , AsyncSnapshot snapshot){
//       //    print(snapshot.data);
//       if(snapshot.data==null){
//         return Container(
//           child: Center(
//             child: Text('Loading'),
//           ),
//         );
//       }
//       else {
//         // for(int i=0;i<10;i++){
//         //
//         // }
//         return ListView.builder(
//           itemCount: snapshot.data.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               title: Text("Upcoming"),
//               subtitle: Text(snapshot.data[index].name),
//             );
//           },
//         );
//       }
//     },
//   );
// }
