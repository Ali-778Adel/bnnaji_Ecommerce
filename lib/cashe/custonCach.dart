
import 'dart:io';

import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
class CustomCacheManager {
  static const key = 'customCacheKey';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 20,
      fileService: HttpFileService(),
    ),
  );
  static Future<FileFetcherResponse> _myHttpGetter(String url,
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
    } on SocketException {
      print('No internet connection');
    }
    return response;
  }

}