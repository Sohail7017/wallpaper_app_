
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/data/remote/api_exceptions.dart';


class ApiHelper{
  Future<dynamic> getWallpaperApi({required String url}) async{
    var uri = Uri.parse(url);

    try{
      var res = await http.get(uri, headers: {
        "Authorization" : "zrwcAKqJF00NoHbphOfHggVVTjtKQ0JbE0cxjnQcBLkHMqRYsIXoD7kf",
      });
      return returnJsonResponse(res);
    }on SocketException catch(e){
      throw (FetchDataException(errorMsg: "No Internet!!"));
    }
  }

    dynamic returnJsonResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        {
          var mData =jsonDecode(response.body);
          return mData;
        }
      case 400:
        throw BadRequestException(errorMsg: response.body.toString());
      case 401:
      case 403:
        throw UnAuthorisedException(errorMsg: response.body.toString());
      case 500:
      default:
        throw FetchDataException(errorMsg: 'Error occurred while communication with server with statusCode : ${response.statusCode}');
    }
    }


}