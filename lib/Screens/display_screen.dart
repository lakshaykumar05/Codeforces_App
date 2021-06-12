import 'package:codeforces_app/Constants/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../Networking/code_forces.dart';
import 'loading_screen.dart';
import 'package:codeforces_app/Constants/constants.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:collection';
import 'package:pie_chart/pie_chart.dart';
import 'dart:math';



class DisplayScreen extends StatefulWidget {
  @override
  DisplayScreen({this.userDetails,this.userAllInfo});
  final userDetails;
  final userAllInfo;
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {


  @override
  void initState() {
    super.initState();
    updateUI(widget.userDetails);
    calc_values(widget.userAllInfo);
  }

  Map<String,double>countTags={};

  Map<String,double>countRating={};
  Map<String,double>tempRating={};

  Map<String,double>countVerdict={};

  Map<String,double>finalCountTagMap={};

  Map<String,double>finalMap={};

  Map<String,double>finalCountRating={};

  int total=0;

  void calc_values(Map user_Info){
    // print(user_Info);

    for(int i=0;i<user_Info['result'].length;i++) {

      // For verdict

      String verdict = user_Info['result'][i]['verdict'];

      if(countVerdict.containsKey(verdict)){
        countVerdict[verdict]+=1.0;
      }
      else{
        countVerdict[verdict]=1.0;
      }

      Map<String,double>.from(countVerdict);

      // print(countVerdict.runtimeType);
      // For problem rating

      // print(user_Info['result'][i]['problem']['rating'].runtimeType);

      int rating = user_Info['result'][i]['problem']['rating'];

      String Rating = rating.toString();

      // if(rating!=null)
      // countRating[rating]++;

      if(verdict=='OK' && Rating!="null"){
        if(countRating.containsKey(Rating)){
          countRating[Rating]++;
        }
        else{
          countRating[Rating]=1;
        }
      }

      Map<String,double>.from(countRating);


      // print(countRatingMap);


      // print(rating.runtimeType);

      // For problem tags

      if(verdict=='OK'){

        List<dynamic> tags = user_Info['result'][i]['problem']['tags'];

        for (int j = 0; j < tags.length; j++) {
          if (countTags.containsKey(tags[j])) {
            countTags[tags[j]]++;
          }
          else
            countTags[tags[j]] = 1;
        }
      }

    }

    Map<String,double>.from(countRating);

    var sortedKeys1 = countRating.keys.toList(growable:false)
      ..sort((k1, k2) => countRating[k1].compareTo(countRating[k2]));
    LinkedHashMap sortedMap1 = new LinkedHashMap
        .fromIterable(sortedKeys1, key: (k) => k, value: (k) => countRating[k]);

    final countRatingMap = LinkedHashMap.fromEntries(sortedMap1.entries.toList().reversed);

    print(countRatingMap);

    var keysss=List.from(countRatingMap.keys);

    for(int i=0;i<min(15,keysss.length);i++){
      finalCountRating[keysss[i]]=countRatingMap[keysss[i]];
    }

    // Map<String,double>.from(finalCountRating);
   // print(finalCountRating);




    // print(countTags);
    Map<String,double>.from(countTags);

    // print(countRating);
    var sortedKeys = countTags.keys.toList(growable:false)
      ..sort((k1, k2) => countTags[k1].compareTo(countTags[k2]));
    LinkedHashMap sortedMap = new LinkedHashMap
        .fromIterable(sortedKeys, key: (k) => k, value: (k) => countTags[k]);

    // sortedMap.forEach((key, value) {
    //   temp[value]=key;
    // });
    //
    // print(temp);

    final reverseM = LinkedHashMap.fromEntries(sortedMap.entries.toList().reversed);
    // print(reverseM);

    // print(reverseM.keys);

    var keyss=List.from(reverseM.keys);

    // List<dynamic>tempList=[];


    for(int i=0;i<min(15,reverseM.length);i++){
      finalCountTagMap[keyss[i]]=reverseM[keyss[i]];
    }

    // for(int i=0;i<tempList.length;i++){
    //
    // }

    // print(tempMap);

    // print(reverseM);
  }

  @override
  String rank;
  int rating;
  String photo;
  String userName;
  int contribution;
  String mailId;
  String maxRank;
  int maxRating;
  int friends;

  void updateUI(dynamic userData) {
  //  print(userAllInfo);
    userName=userData['result'][0]['handle'];
    photo=userData['result'][0]['titlePhoto'];
    contribution=userData['result'][0]['contribution'];
    rank = userData['result'][0]['rank'];
    mailId=userData['result'][0]['email'];
    rating=userData['result'][0]['rating'];
    maxRating=userData['result'][0]['maxRating'];
    maxRank=userData['result'][0]['maxRank'];
    friends=userData['result'][0]['friendOfCount'];
  }

  _printProperties(String text){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        text,
        style: kstyleTextStyle,
      ),
    );
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text('Profile',
          style: TextStyle(
            color: Colors.white,
          ),),
        ),
        body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
        overScroll.disallowGlow();
        return;
        },
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(11.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Image.network(photo,
                              height: 200,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child:
                          // Column(
                          //   children: [
                              Padding(
                                padding: const EdgeInsets.only(left:30.0,top: 10),
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      _printProperties('Username:'),
                                      _printProperties('MaxRating:'),
                                      _printProperties('Rating:'),
                                      _printProperties('MaxRank:'),
                                      _printProperties('Rank:'),
                                      _printProperties('Contribution:'),
                                      _printProperties('Friends:'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                              Expanded(
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      FittedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text('$userName',style: Values().fun(rating),),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text('$maxRating',style: Values().fun(maxRating),),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text('$rating',style: Values().fun(rating),),
                                      ),
                                      FittedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text('$maxRank',style: Values().ranking(maxRank),),
                                        ),
                                      ),
                                      FittedBox(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text('$rank',style: Values().ranking(rank),),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text('$contribution',style: kstyleTextStyle,),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                                        child: Text('$friends',style: kstyleTextStyle,),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        // ),
                      ],
                    ),
                  // ],
                ),
              SizedBox(
                height: 15,
              ),
              // ),
                  Container(
                    width: size.width,
                    // height: size.height,
                    child: Column(
               //      mainAxisSize: MainAxisSize.min,
                      children: <Widget> [
                        Text(
                          'Problem Tags',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                        SizedBox(height: 100.0,),
                        PieChart(
                          // colorList: [Colors.blue,Colors.blue,Colors.blue,Colors.red,Colors.blue,Colors.blue,Colors.blue,Colors.blue,Colors.blue,Colors.yellow,Colors.blue,Colors.blue,Colors.blue,Colors.blue,Colors.blue],
                          dataMap: finalCountTagMap,
                          colorList: DifferentColors().problemTag(finalCountTagMap.length),
                          animationDuration: Duration(seconds: 4),
                          chartLegendSpacing: 120,
                          chartRadius: MediaQuery.of(context).size.width / 3.2,
                         // colorList: colorList,
                          initialAngleInDegree: 0,
                          chartType: ChartType.ring,
                          ringStrokeWidth: 200,
                        //  centerText: "HYBRID",
                          legendOptions: LegendOptions(
                            showLegendsInRow: true,
                            legendPosition: LegendPosition.bottom,
                            showLegends: true,
                            legendShape: BoxShape.circle,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: false,
                            showChartValues: false,
                            showChartValuesInPercentage: false,
                            showChartValuesOutside: false,
                            // chartValueStyle: TextStyle(
                            // )
                          ),
                        ),
                      ],
                    ),
                  ),
              Container(
                width: size.width,
                // height: size.height,
                child: Column(
                  //      mainAxisSize: MainAxisSize.min,
                  children: <Widget> [
                    Text(
                      'Verdict',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                    SizedBox(height: 100.0,),
                    PieChart(
                      dataMap: countVerdict,
                      animationDuration: Duration(seconds: 4),
                      chartLegendSpacing: 120,
                      chartRadius: MediaQuery.of(context).size.width / 3.2,
                      colorList: DifferentColors().Verdict(countVerdict.length),
                      initialAngleInDegree: 0,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 200,
                      //  centerText: "HYBRID",
                      legendOptions: LegendOptions(
                        showLegendsInRow: true,
                        legendPosition: LegendPosition.bottom,
                        showLegends: true,
                        legendShape: BoxShape.circle,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      chartValuesOptions: ChartValuesOptions(
                        showChartValueBackground: false,
                        showChartValues: false,
                        showChartValuesInPercentage: false,
                        showChartValuesOutside: false,
                        chartValueStyle: TextStyle(
                          wordSpacing: 5,
                        )
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: size.width,
                height: size.height,
                child: Column(
                  //      mainAxisSize: MainAxisSize.min,
                  children: <Widget> [
                    Text(
                      'Problem Rating',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                    SizedBox(height: 100.0,),
                    PieChart(
                      dataMap: finalCountRating,
                      animationDuration: Duration(seconds: 4),
                      chartLegendSpacing: 120,
                      chartRadius: MediaQuery.of(context).size.width / 3.2,
                      colorList: DifferentColors().Rating(finalCountRating.length),
                      initialAngleInDegree: 0,
                      chartType: ChartType.ring,
                      ringStrokeWidth: 200,
                      //  centerText: "HYBRID",
                      legendOptions: LegendOptions(
                        showLegendsInRow: true,
                        legendPosition: LegendPosition.bottom,
                        showLegends: true,
                        legendShape: BoxShape.circle,
                        legendTextStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      chartValuesOptions: ChartValuesOptions(
                        showChartValueBackground: false,
                        showChartValues: false,
                        showChartValuesInPercentage: false,
                        showChartValuesOutside: false,
                        // chartValueStyle: TextStyle(
                        // )
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






// Column(
// children: <Widget>[
// Row(
// children: <Widget>[
// Expanded(
// child: Padding(
// padding: const EdgeInsets.all(5.0),
// child: Image.network(photo,
// height: 200,
// ),
// ),
// ),
// ],
// ),
// Container(
// child: Column(
// children: <Widget>[
// Text('Username: $userName',
// style: kstyleTextStyle,
// ),
// SizedBox(
// height: 5,
// ),
// Text('MaxRating: $maxRating',
// style: kstyleTextStyle,
// ),
// SizedBox(
// height: 5,
// ),
// Text('MaxRank: $maxRank',
// style: kstyleTextStyle,
// ),
// SizedBox(
// height: 5,
// ),
// Text('Rank: $rank',
// style: kstyleTextStyle,
// ),
// SizedBox(
// height: 5,
// ),
// Text('Rating: $rating',
// style: kstyleTextStyle,
// ),
// SizedBox(
// height: 5,
// ),
// Text('Contribution: $contribution',
// style: kstyleTextStyle,
// ),
// SizedBox(
// height: 5,
// ),
// Text('Friends: $friends',
// style: kstyleTextStyle,
// ),
// ],
// ),
// ),
// Padding(
// padding: const EdgeInsets.all(8.0),
// child: Container(
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children: <Widget> [
// Text(
// 'Time spent on daily tasks',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
// SizedBox(height: 10.0,),
// Flexible(
// child: charts.PieChart(
// _seriesPieData,
// animate: true,
// animationDuration: Duration(seconds: 5),
// // defaultRenderer: new charts.ArcRendererConfig(
// //   arcWidth: 100,
// //   arcRendererDecorators: [
// //     new charts.ArcLabelDecorator(
// //       labelPosition: charts.ArcLabelPosition.inside,
// //     ),
// //   ],
// // ),
// ),
// ),
// ],
// ),
// ),
// ),
// ],
// ),
//
//
//


/*
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
             Padding(
               padding: EdgeInsets.all(8.0),
               child: ListView(
                 children:<Widget>[
                   Padding(
                     padding: const EdgeInsets.all(8.0),
             //        child: Image.network(photo),
                   )
                 ],
               ),
             )
            ],
 */


// Verdicts -> wrong_answer, ok, time_limit_exceeded

class Task{
  String task;
  int taskValue;
  Color colorVal;

  Task(this.task,this.taskValue,this.colorVal);
}





                // Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Container(
                //       child: Column(
                //         mainAxisSize: MainAxisSize.min,
                //         children: <Widget> [
                //           Text(
                //             'Time spent on daily tasks',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold),),
                //           SizedBox(height: 10.0,),
                //           Flexible(
                //             child: charts.PieChart(
                //               _seriesPieData,
                //               animate: true,
                //               animationDuration: Duration(seconds: 5),
                //               // defaultRenderer: new charts.ArcRendererConfig(
                //               //   arcWidth: 100,
                //               //   arcRendererDecorators: [
                //               //     new charts.ArcLabelDecorator(
                //               //       labelPosition: charts.ArcLabelPosition.inside,
                //               //     ),
                //               //   ],
                //               // ),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),

/*
FittedBox(
                                child: Text.rich(
                                  // textAlign: TextAlign.center,
                                  TextSpan(children: <TextSpan>[
                                    TextSpan(
                                      text: 'Username: ',
                                      style: kstyleTextStyle,
                                    ),
                                    TextSpan(
                                      text: '$userName',
                                      style: Values().fun(rating),
                                    ),
                                  ]),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                child: Text.rich(
                                  TextSpan(children: <TextSpan>[
                                    TextSpan(
                                      text: 'MaxRating: ',
                                      style: kstyleTextStyle,
                                    ),
                                    TextSpan(
                                      text: '$maxRating',
                                      style: Values().fun(rating),
                                    ),
                                  ]),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                child: Text.rich(
                                  TextSpan(children: <TextSpan>[
                                    TextSpan(
                                      text: 'MaxRank: ',
                                      style: kstyleTextStyle,
                                    ),
                                    TextSpan(
                                      text: '$maxRank',
                                      style: Values().ranking(maxRank),
                                    ),
                                  ]),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                child: Text.rich(
                                  TextSpan(children: <TextSpan>[
                                    TextSpan(
                                      text: 'Rank: ',
                                      style: kstyleTextStyle,
                                    ),
                                    TextSpan(
                                      text: '$rank',
                                      style: Values().ranking(rank),
                                    ),
                                  ]),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                child: Text.rich(
                                  TextSpan(children: <TextSpan>[
                                    TextSpan(
                                      text: 'Rating: ',
                                      style: kstyleTextStyle,
                                    ),
                                    TextSpan(
                                      text: '$rating',
                                      style: Values().fun(rating),
                                    ),
                                  ]),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                child: Text('Contribution: $contribution',
                                  style: kstyleTextStyle,
                                  // textAlign: TextAlign.end,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              FittedBox(
                                child: Text('Friends: $friends',
                                  style: kstyleTextStyle,
                                ),
                              ),
 */