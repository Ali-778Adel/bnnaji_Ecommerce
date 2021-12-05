import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:rxdart/rxdart.dart';

class WebHelper{
  ///Download the file from the url
  Stream<FileResponse> downloadFile(String url,
      {String key,
        Map<String, String> authHeaders,
        bool ignoreMemCache = false}) {
    key ??= url;

     var subject = BehaviorSubject<FileResponse>();


    return subject.stream;
  }
}