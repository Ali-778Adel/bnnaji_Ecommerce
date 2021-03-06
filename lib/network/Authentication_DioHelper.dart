import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class AuthenticationDioHelper {
  static Dio dio;

  static void initAuthDio() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,headers:{'Content-Type':'application/json'} ),

    );
  }

 static Future<Response> sendUserData({
    @required String url,
    @required Map<String,dynamic> data,
    String lang ='ar',
   String token
  }) async {
    dio.options.headers={
      'lang':lang,
      'Authorization':token
    };
   return dio.post(
        url,
        data: data
    );
  }
  static Future<Response>getuserData(
  {
  @required String email,
    @required String name
}
      )async{

  }

}
