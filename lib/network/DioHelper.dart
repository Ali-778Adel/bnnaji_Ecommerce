import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class DioHelper {
  static Dio dio;

  static void init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://mobileaders.com/', receiveDataWhenStatusError: true,));
  }

  static Future<Response> getData(
  {
    @required String url,
    Map<String,dynamic>quarey
})async{
  return await dio.get(url,queryParameters: quarey);
  }

  static Future<FileInfo> getCatData(
      {
        @required String url,
        Map<String,dynamic>quarey
      })async{
    return await dio.get(url,queryParameters: quarey) as FileInfo;
  }
}
