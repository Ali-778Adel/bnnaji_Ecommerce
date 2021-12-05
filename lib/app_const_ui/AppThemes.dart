
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

 var lightTheme= ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(

      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white10
          ,statusBarIconBrightness: Brightness.dark
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0.0,
      titleTextStyle: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold)
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.deepOrange,
      elevation: 0.0,
      unselectedIconTheme: IconThemeData(color: Colors.black)
  ),
  primarySwatch: Colors.blue,
);


var darkTheme=ThemeData(
  scaffoldBackgroundColor: Colors.black54,
  appBarTheme: AppBarTheme(

      backwardsCompatibility: false,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black54
          ,statusBarIconBrightness: Brightness.light
      ),
      backgroundColor: Colors.black54,
      centerTitle: true,
      elevation: 0.0,
      titleTextStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold)
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(

      backgroundColor: Colors.black54,
      selectedItemColor: Colors.deepOrange,
      elevation: 0.0,
      unselectedIconTheme: IconThemeData(color: Colors.grey)
  ),


  primarySwatch: Colors.deepOrange,

);

