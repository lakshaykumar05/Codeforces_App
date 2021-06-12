import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper{
  NetworkHelper(this.url);
  final String url;
  Future getData() async{
 //   print(24);
    http.Response response= await http.get(url);
 //   print(response.statusCode);
    if(response.statusCode==200){
      var data=response.body;
    //  print(123);
    //  print(data);
   //   print(response.body);
      return jsonDecode(data);
    }
    else{
      print(response.statusCode);
    }
  }
}