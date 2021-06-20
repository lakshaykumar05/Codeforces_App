import 'package:codeforces_app/Constants/colors.dart';
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
import 'package:heatmap_calendar/heatmap_calendar.dart';
import 'package:heatmap_calendar/time_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';



class DisplayScreen extends StatefulWidget {
  @override
  DisplayScreen({this.userDetails,this.userAllInfo});
  final userDetails;
  final userAllInfo;
  _DisplayScreenState createState() => _DisplayScreenState();
}

class _DisplayScreenState extends State<DisplayScreen> {
  var char;



  @override
  void initState() {
    super.initState();
    updateUI(widget.userDetails);
    calc_values(widget.userAllInfo);
  }

  Map<DateTime,int>everyday_Data={};
  Map<DateTime,int>temp={};

  Map<String,double>countTags={};

  Map<String,double>countRating={};
  Map<String,double>tempRating={};

  Map<String,double>countVerdict={};

  Map<String,double>finalCountTagMap={};

  Map<String,double>finalMap={};

  Map<String,double>finalCountRating={};

  int total=0;
  int ch;

  String toCapital(String S){
    String S1=S[0].toUpperCase()+S.substring(1);
    return S1;
  }

  String toAllCapital(String S){
    // String S1=S[0].toUpperCase()+S.substring(1);
    return S.toUpperCase();
  }

  void calc_values(Map user_Info){
    // print(user_Info);

    for(int i=0;i<user_Info['result'].length;i++) {

      // For HeatMap

      int timestamp = user_Info['result'][i]['creationTimeSeconds'];

      var date = new DateTime.fromMicrosecondsSinceEpoch(timestamp*1000000);

      final DateFormat formatter = DateFormat('dd-MM-yyyy');
      final String formatted = formatter.format(date);

      String dd=date.toString();

      // print(date);
      DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(dd);
      //   print(date.runtimeType);
      if(everyday_Data.containsKey(tempDate)){
        everyday_Data[tempDate]++;
      }
      else{
        everyday_Data[tempDate]=1;
      }
      // everyday_Data[date]++;

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
          String S=toAllCapital(tags[j]);
          if (countTags.containsKey(S)) {
            countTags[S]++;
          }
          else
            countTags[S] = 1;
        }
      }

    }

    Map<String,double>.from(countRating);

    var sortedKeys1 = countRating.keys.toList(growable:false)
      ..sort((k1, k2) => countRating[k1].compareTo(countRating[k2]));
    LinkedHashMap sortedMap1 = new LinkedHashMap
        .fromIterable(sortedKeys1, key: (k) => k, value: (k) => countRating[k]);

    final countRatingMap = LinkedHashMap.fromEntries(sortedMap1.entries.toList().reversed);

    // print(countRatingMap);

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

    for(int i=0;i<min(15,reverseM.length);i++){
      finalCountTagMap[keyss[i]]=reverseM[keyss[i]];
    }

    countVerdict.forEach((key, value) {
      if(key=="OK"){
        key="ACCEPTED";
      }
    });

    finalCountTagMap.forEach((key, value) {
      key=toCapital(key);
    });

    // print(TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 33))));
    //   TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 2))): 35,
    //   TimeUtils.removeTime(DateTime.now().subtract(Duration(days: 1))): 14,

    // print(everyday_Data);
    // print(tempMap);
    // print(reverseM);
  }

  String rank;
  String _rank;
  int rating;
  String photo;
  String userName;
  String _userName;
  int contribution;
  String mailId;
  String maxRank;
  String _maxRank;
  int maxRating;
  int friends;

  List<String>values=[];

  void updateUI(dynamic userData) {
  //  print(userAllInfo);
    _userName=userData['result'][0]['handle'];
    friends=userData['result'][0]['friendOfCount'];
    photo=userData['result'][0]['titlePhoto'];
    contribution=userData['result'][0]['contribution'];
    _maxRank=userData['result'][0]['maxRank'];

    if(_maxRank==null){
      rank="Unrated";
      maxRank="Unrated";
      rating=0;
      maxRating=0;
      return;
    }

    _rank = userData['result'][0]['rank'];
    rating=userData['result'][0]['rating'];
    maxRating=userData['result'][0]['maxRating'];
    _maxRank=userData['result'][0]['maxRank'];

    userName=toCapital(_userName);
    rank=toCapital(_rank);
    maxRank=toCapital(_maxRank);

    // print(userName);
    // print(rank);
    // values.add(userName);  values.add(maxRating.toString()); values.add(rating.toString()); values.add(maxRank); values.add(rank); values.add(contribution.toString()); values.add(friends.toString());
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

  List<String>labels=['Username','Maxrating','Rating','Maxrank','Rank','Contribution','Friends'];

  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(11.0),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Center(
                            child: CachedNetworkImage(
                              imageUrl: photo,
                              placeholder: (context, url) => CircularProgressIndicator(),
                              errorWidget: (context, url, error) => Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    // row= column , column=widget , widget=label,value
                    children: <Widget>[
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(fit: BoxFit.scaleDown,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:10.0,left: 20),
                                    child: Text(labels[0],style: kstyleTextStyle,),
                                  )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(fit: BoxFit.scaleDown,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 10,left: 20),
                                    child: Text('$userName',style: Values().fun(rating),),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                padding: const EdgeInsets.only(top:10.0,left: 20),
                                child: Text(labels[1],style: kstyleTextStyle,),
                              )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                padding: const EdgeInsets.only(top:10.0,left: 20),
                                child: Text(maxRating.toString(),style: Values().fun(maxRating),),
                              )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              // color: Colors.brown/,
                              child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                padding: const EdgeInsets.only(top:10.0,left: 20),
                                child: Text(labels[2],style: kstyleTextStyle,),
                              )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              // color: Colors.yellowAccent,
                              child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                padding: const EdgeInsets.only(top:10.0,left: 20),
                                child: Text(rating.toString(),style: Values().fun(rating),),
                              )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              // color: Colors.brown,
                              child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                padding: const EdgeInsets.only(top:10.0,left: 20),
                                child: Text(labels[3],style: kstyleTextStyle,),
                              )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              // color: Colors.yellowAccent/,
                              child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                padding: const EdgeInsets.only(top:10.0,left: 20),
                                child: Text(maxRank,style: Values().ranking(maxRank),),
                              )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              // color: Colors.brown,
                              child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                padding: const EdgeInsets.only(top:10.0,left: 20),
                                child: Text(labels[4],style: kstyleTextStyle,),
                              )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              // color: Colors.yellowAccent,
                              child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                padding: const EdgeInsets.only(top:10.0,left: 20),
                                child: Text(rank,style: Values().ranking(rank),),
                              )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              // color: Colors.brown,
                              child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                padding: const EdgeInsets.only(top:10.0,left: 20),
                                child: Text(labels[5],style: kstyleTextStyle,),
                              )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              // color: Colors.yellowAccent,
                              child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                padding: const EdgeInsets.only(top:10.0,left: 20),
                                child: Text(contribution.toString(),style: kstyleTextStyle,),
                              )),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              // color: Colors.brown,
                              child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                padding: const EdgeInsets.only(top:10.0,left: 20),
                                child: Text(labels[6],style: kstyleTextStyle,),
                              )),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.centerLeft,
                              // color: Colors.yellowAccent,
                              child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                padding: const EdgeInsets.only(top:10.0,left: 20),
                                child: Text(friends.toString(),style:kstyleTextStyle,),
                              )),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // ),
                  SizedBox(
                    height: 45,
                  ),
                  // ),
                  chartOfProblemTag(finalCountTagMap, size, context),
                  SizedBox(
                    height: 30,
                  ),
                  chartOfVerdict(countVerdict, size, context),
                  SizedBox(
                    height: 30,
                  ),
                  chartOfRating(finalCountRating, size, context),
                  SizedBox(
                    height: 30,
                  ),
                  submissionHeatmap(everyday_Data, size, context),
                ],
              ),
              // ],
            ),
          ),
          ),
        ),
    );
  }
}

Container chartOfProblemTag(Map<String,double> finalCountTagMap,Size size,BuildContext context){
  return Container(
    width: size.width,
    // height: size.height,
    child: Column(
      //      mainAxisSize: MainAxisSize.min,
      children: <Widget> [
        Text(
          'Problem Tags',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,fontFamily: 'Ubuntu',),),
        SizedBox(height: 120.0,),
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
  );
}


Container chartOfVerdict(Map<String,double> countVerdict,Size size,BuildContext context){
  return Container(
    width: size.width,
    // height: size.height,
    child: Column(
      //      mainAxisSize: MainAxisSize.min,
      children: <Widget> [
        Text(
          'Verdict',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,fontFamily: 'Ubuntu',),),
        SizedBox(height: 120.0,),
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
  );
}


Container chartOfRating(Map<String,double> finalCountRating,Size size,BuildContext context){
  return  Container(
    width: size.width,
    // height: size.height,
    child: Column(
      //      mainAxisSize: MainAxisSize.min,
      children: <Widget> [
        Text(
          'Problem Rating',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,fontFamily: 'Ubuntu',),),
        SizedBox(height: 120.0,),
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
  );
}


Container submissionHeatmap(Map<DateTime,int> everyday_Data,Size size,BuildContext context){
  return Container(
    width: size.width,
    child: Column(
      children: <Widget>[
        FittedBox(
          child: Text('Submission Heatmap ',style:
            TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.bold,
            ),),
        ),
        SizedBox(
          height: 35,
        ),
        HeatMapCalendar(
          input: everyday_Data,
          colorThresholds: {
            1: Colors.green[200],
            4: Colors.green[400],
            10: Colors.green[500],
            18: Colors.green[700],
            100: Colors.green[900],
          },
          weekDaysLabels: ['S', 'M', 'T', 'W', 'T', 'F', 'S'],
          monthsLabels: [
            "",
            "Jan",
            "Feb",
            "Mar",
            "Apr",
            "May",
            "Jun",
            "Jul",
            "Aug",
            "Sep",
            "Oct",
            "Nov",
            "Dec",
          ],
          squareSize: 16.0,
          textOpacity: 0.3,
          labelTextColor: Colors.blueGrey,
          dayTextColor: Colors.blue[500],
        ),
      ],
    ),
  );
}

/*
ListView(
            cacheExtent: 1000,
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
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: photo,
                                  placeholder: (context, url) => CircularProgressIndicator(),
                                  errorWidget: (context, url, error) => Icon(Icons.error),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                     // row= column , column=widget , widget=label,value
                      children: <Widget>[
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: FittedBox(fit: BoxFit.scaleDown,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:10.0,left: 20),
                                      child: Text(labels[0],style: kstyleTextStyle,),
                                    )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: FittedBox(fit: BoxFit.scaleDown,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10,left: 20),
                                      child: Text('$userName',style: Values().fun(rating),),
                                    )),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                  padding: const EdgeInsets.only(top:10.0,left: 20),
                                  child: Text(labels[1],style: kstyleTextStyle,),
                                )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                  padding: const EdgeInsets.only(top:10.0,left: 20),
                                  child: Text(maxRating.toString(),style: Values().fun(maxRating),),
                                )),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.brown/,
                                child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                  padding: const EdgeInsets.only(top:10.0,left: 20),
                                  child: Text(labels[2],style: kstyleTextStyle,),
                                )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.yellowAccent,
                                child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                  padding: const EdgeInsets.only(top:10.0,left: 20),
                                  child: Text(rating.toString(),style: Values().fun(rating),),
                                )),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.brown,
                                child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                  padding: const EdgeInsets.only(top:10.0,left: 20),
                                  child: Text(labels[3],style: kstyleTextStyle,),
                                )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.yellowAccent/,
                                child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                  padding: const EdgeInsets.only(top:10.0,left: 20),
                                  child: Text(maxRank,style: Values().ranking(maxRank),),
                                )),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.brown,
                                child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                  padding: const EdgeInsets.only(top:10.0,left: 20),
                                  child: Text(labels[4],style: kstyleTextStyle,),
                                )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.yellowAccent,
                                child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                  padding: const EdgeInsets.only(top:10.0,left: 20),
                                  child: Text(rank,style: Values().ranking(rank),),
                                )),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.brown,
                                child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                  padding: const EdgeInsets.only(top:10.0,left: 20),
                                  child: Text(labels[5],style: kstyleTextStyle,),
                                )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.yellowAccent,
                                child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                  padding: const EdgeInsets.only(top:10.0,left: 20),
                                  child: Text(contribution.toString(),style: kstyleTextStyle,),
                                )),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.brown,
                                child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                  padding: const EdgeInsets.only(top:10.0,left: 20),
                                  child: Text(labels[6],style: kstyleTextStyle,),
                                )),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerLeft,
                                // color: Colors.yellowAccent,
                                child: FittedBox(fit: BoxFit.scaleDown,child: Padding(
                                  padding: const EdgeInsets.only(top:10.0,left: 20),
                                  child: Text(friends.toString(),style:kstyleTextStyle,),
                                )),
                              ),
                            ),
                          ],
                        ),
                            ],
                          ),
                        // ),
                      ],
                    ),
                  // ],
                ),
              SizedBox(
                height: 25,
              ),
              // ),
              chartOfProblemTag(finalCountTagMap, size, context),
              SizedBox(
                height: 20,
              ),
              chartOfVerdict(countVerdict, size, context),
              SizedBox(
                height: 20,
              ),
              chartOfRating(finalCountRating, size, context),
              SizedBox(
                height: 30,
              ),
              submissionHeatmap(everyday_Data, size, context),
            ],
          ),
 */