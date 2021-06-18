import 'package:flutter/material.dart';
//
class Values{

  TextStyle fun(int val){
    if(val<=1100) {
      return TextStyle(
        color: Colors.grey,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Ubuntu',
      );
    }
      else if(val<1400){
      return TextStyle(
        color: Colors.green,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Ubuntu',
      );
    }
      else if(val<1600){
      return TextStyle(
        color: Colors.lightBlueAccent,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Ubuntu',
      );
    }
      else if(val<1900){
      return TextStyle(
        color: Colors.blue,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Ubuntu',
      );
    }
    else if(val<2200){
      return TextStyle(
        color: Colors.purple,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Ubuntu',
      );
    }
    return TextStyle(
      color: Colors.red,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Ubuntu',
    );
  }


  TextStyle ranking(String val){
    if(val=='Unrated') {
      return TextStyle(
        color: Colors.grey,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Ubuntu',
      );
    }
    else if(val=='newbie') {
      return TextStyle(
        color: Colors.black,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Ubuntu',
      );
    }
    else if(val=='pupil'){
      return TextStyle(
        color: Colors.green,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Ubuntu',
      );
    }
    else if(val=='specialist'){
      return TextStyle(
        color: Colors.lightBlueAccent,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Ubuntu',
      );
    }
    else if(val=='expert'){
      return TextStyle(
        color: Colors.blue,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Ubuntu',
      );
    }
    else if(val=='candidate master'){
      return TextStyle(
        color: Colors.purple,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        fontFamily: 'Ubuntu',
      );
    }
    return TextStyle(
      color: Colors.red,
      fontSize: 24,
      fontWeight: FontWeight.bold,
      fontFamily: 'Ubuntu',
    );
  }
}


const kstyleTextStyle = TextStyle(
//  fontFamily: 'Pacifico',
  fontSize: 24,
  fontWeight: FontWeight.w700,
  fontFamily: 'Ubuntu',
);