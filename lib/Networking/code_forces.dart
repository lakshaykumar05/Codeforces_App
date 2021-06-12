import 'package:codeforces_app/Networking/networking.dart';


class CodeForces{
  Future<dynamic> getUserData(String handle)async{
    var url = 'https://codeforces.com/api/user.info?handles=$handle';
    NetworkHelper networkHelper =NetworkHelper(url);
    var userData = await networkHelper.getData();
 //   print(userData);
    return userData;
  }

  Future<dynamic> getContestData()async{
    var url = 'https://codeforces.com/api/contest.list?';
    NetworkHelper networkHelper =NetworkHelper(url);
    var contestData = await networkHelper.getData();
   //    print(contestData);
    return contestData;
  }

  Future<dynamic> getAllInfo(String handle)async{
    var url = 'https://codeforces.com/api/user.status?handle=$handle';
    NetworkHelper networkHelper =NetworkHelper(url);
    var userData = await networkHelper.getData();
    //   print(userData);
    return userData;
  }

}