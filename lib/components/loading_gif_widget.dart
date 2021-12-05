import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget loadinGifWidget({String text}) {
  return Center(
    child: Column(
      children: [
        Image.asset('assests/cart_sand_watch/cart_sand_watch.gif'),
        SizedBox(
          height: 20,
        ),

        Text(text,style: TextStyle(fontSize: 20,color: Colors.black87),)
      ],
    ),
  );
}
