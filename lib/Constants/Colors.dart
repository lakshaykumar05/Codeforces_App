import 'package:flutter/material.dart';

class DifferentColors{
   List<Color>allColorsOfProblemTags=[Colors.red,Colors.blue,Colors.green,Colors.yellow,Colors.purple,Colors.brown,Colors.deepOrange,Colors.blueGrey,Colors.indigoAccent,Colors.tealAccent,Colors.pink,Colors.teal,
     Colors.black12,Colors.orange,Colors.lightGreenAccent];

   List<Color> problemTag(int length){
     List<Color>ans=[];

     for(int i=0;i<length;i++){
       ans.add(allColorsOfProblemTags[i]);
     }
     return ans;
   }

   List<Color>allColorsOfVerdict=[Colors.green,Colors.pinkAccent,Colors.blueGrey,Colors.lightBlue,Colors.brown,Colors.lightGreen,Colors.teal,Colors.indigoAccent,Colors.blue];

   List<Color> Verdict(int length){
     List<Color>ans=[];

     for(int i=0;i<length;i++){
       ans.add(allColorsOfVerdict[i]);
     }

     return ans;
   }

   List<Color>allColorsOfRating=[Colors.pinkAccent,Colors.blueAccent,Colors.grey,Colors.orange,Colors.deepPurple,Colors.deepOrange,Colors.indigo,Colors.brown,Colors.greenAccent,Colors.tealAccent,Colors.blueGrey,Colors.redAccent,Colors.yellow,Colors.black26,Colors.deepPurpleAccent];

   List<Color> Rating(int length){
     List<Color>ans=[];

     for(int i=0;i<length;i++){
       ans.add(allColorsOfRating[i]);
     }
     return ans;
   }


}