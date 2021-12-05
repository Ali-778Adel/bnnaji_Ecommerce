
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget GridTileCategoryItem({int id ,String imageUrl ,String categoryName,Function function} ){

  return Padding(
    padding: EdgeInsets.all(8),
    child:  Container(
   constraints: BoxConstraints(maxHeight: double.infinity),
      child: Card(
        child: InkWell(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 3,
                  spreadRadius: 3,
                  offset: Offset(0, 2)
                )] ),
            child: Padding(
              padding: EdgeInsets.all(2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 120,
                    width: 120,
                    margin: EdgeInsets.all(10),
                    child:CachedNetworkImage(
                      imageUrl: imageUrl,
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                      Expanded(
                        flex: 0,
                        child:   Container(
                           margin: EdgeInsets.only(left: 5,top: 4,bottom: 4),
                          child: Text( categoryName,style: TextStyle(fontSize: 18,fontStyle: FontStyle.italic,fontWeight: FontWeight.w600),),),
                      )
                ],
              ),
            ),
          ),
          onTap: function
        ),
      ),
    ),
  );


}