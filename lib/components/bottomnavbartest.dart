import 'package:bnnaji/components/badge.dart';
import 'package:flutter/material.dart';

Widget bottom ({@required int currentIndex,@required Function (int) function}){

  return BottomNavigationBar(
      currentIndex: currentIndex,
       onTap:function


      ,items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
        BottomNavigationBarItem(icon:Badge(value: '2',color:Colors.white ,child: Icon(Icons.add_shopping_cart),),label: 'Cart'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: 'favourite'),
      ]);
}

//Stack Icon(Icons.add_shopping_cart),label: 'Cart'