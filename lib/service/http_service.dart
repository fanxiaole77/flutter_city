import 'package:dio/dio.dart';
import 'package:flutter_city/service/htttp_config.dart';

Future get(url,{Map<String,dynamic>?query}) async{
  try{
     Response response;
     Dio dio = Dio();
     if(token != ""){
       dio.options.headers = {
         'Content-type':"application/json",
         'Authorization':token
       };
     }
     response = await dio.get(url,queryParameters: query);
     if(response.statusCode == 200){
       return response;
     }else{
       throw Exception("后端一场");
     }
  }catch(e){
    print('error::${e}');
    return null;
  }
}

Future post(url,{data,Map<String,dynamic>?query}) async{
  try{
    Response response;
    Dio dio = Dio();
    response = await dio.post(url,data: data,queryParameters: query);
    return response;
  }catch(e){
    print('error::${e}');
    return null;
  }
}