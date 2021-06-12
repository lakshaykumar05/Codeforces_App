import 'package:flutter/material.dart';
//
class Values{

  TextStyle fun(int val){
    if(val<=1100) {
      return TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
    }
      else if(val<1400){
      return TextStyle(
        color: Colors.green,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
    }
      else if(val<1600){
      return TextStyle(
        color: Colors.lightBlueAccent,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
    }
      else if(val<1900){
      return TextStyle(
        color: Colors.blue,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
    }
    else if(val<2200){
      return TextStyle(
        color: Colors.purple,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
    }
    return TextStyle(
      color: Colors.red,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }


  TextStyle ranking(String val){
    if(val=='newbie') {
      return TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
    }
    else if(val=='pupil'){
      return TextStyle(
        color: Colors.green,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
    }
    else if(val=='specialist'){
      return TextStyle(
        color: Colors.lightBlueAccent,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
    }
    else if(val=='expert'){
      return TextStyle(
        color: Colors.blue,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
    }
    else if(val=='candidate master'){
      return TextStyle(
        color: Colors.purple,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      );
    }
    return TextStyle(
      color: Colors.red,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );
  }
}


const kstyleTextStyle = TextStyle(
//  fontFamily: 'Pacifico',
  fontSize: 24,
  fontWeight: FontWeight.bold,
);