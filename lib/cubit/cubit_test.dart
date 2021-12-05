

import 'dart:io';
import 'package:http/http.dart' as http;


import 'package:bnnaji/cashe/cashe_manger_controller.dart';
import 'package:bnnaji/cashe/cashe_manger_demo.dart';
import 'package:bnnaji/cubit_states/test_state.dart';
import 'package:bnnaji/network/DioHelper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class Cubit_Test extends Cubit<TestStates> {
  Cubit_Test() : super(TestIntialState());
  static Cubit_Test get(context) => BlocProvider.of(context);

//  Map<String, dynamic> category = {};
//  List<Map<String,dynamic>>addlistitems=[];
//  Future<Response> getCategoryDataFromsever() async {
//    emit(TestcashedataState());
//    CacheManager().downloadFile('bn_naji/public/api/categories').then((value) {
//      emit(TestcashedataState());
//      print (value.file.toString());
//      print ('ali ');
//      print(category['data'][0]['id']);
//      print(category.toString());
//    }).catchError((error) {
//      print('error${error.toString()}');
//
//    });


//    await DioHelper.getData(url: 'bn_naji/public/api/categories').then((value) {
//
//
//      emit(TestcashedataState());
//      print(category['data'][0]['id']);
//      print(category.toString());
//    }).catchError((error) {
//      print('error${error.toString()}');
//
//    });
//  }
//  CacheManager cacheManager =new CacheManager();
//  getcachedData(String url){
//    cacheManager.downloadFile(url).then((value) {
//      print('good evening with cash click double 2');
//      print (value.toString() );
//    }).catchError((error){
//      print('eroor${error.toString()}');
//    });
//  }

//  Map<String,dynamic>map={};
//  Future<dynamic> getSingleFile(String url)async{
//   var file =await DefaultCacheManager().getSingleFile(url);
//   var res =await file.readAsString()  ;
//   print('========================');
//
//   print (res.runtimeType);
//   emit(TestcashedataState());
//   return res.toString();
//
//  }
//
//
//  Future<FileInfo> getdata(String url)async{
//    return await DefaultCacheManager().getFileFromCache(url).then((value) {
//      print('-----------------------------');
//      print (value.file.toString());
//      emit(TestcashedataformcacheState());
//    }).catchError((error){print('error${error.toString()}');});
//
//
//  }

   Future<FileFetcherResponse> myHttpGetter(String url,
      {Map<String, String> headers}) async {
    HttpFileFetcherResponse response;
    // Do things with headers, the url or whatever.
    try {
      var res = await http.get(Uri.parse(url), headers: headers);
      // add a custom response header
      // to regulate the caching time
      // when the server doesn't provide cache-control
      res.headers.addAll({'cache-control': 'private, max-age=120'});
      response = HttpFileFetcherResponse(res);
      print(response.runtimeType);
      print(res.body.toString());
    } on SocketException {
      print('No internet connection');
    }
    emit(TestcashedataformcacheState());
    return response;
  }



}
