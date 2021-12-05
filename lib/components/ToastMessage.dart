import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HandleToastMeaasge {
  static Color color;
  static dynamic showToastMessage({@required String message,@required EnumState enumState}) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: chosseColor(state: enumState),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static Color chosseColor({@required EnumState state}) {
    switch ( state) {
      case EnumState.SUCCESS:
        {
         return color= Colors.green;
        }
        break;
      case EnumState.WARNING:
        {
        return  color =Colors.yellow;
        }
        break;
      case EnumState.ERROR:
        {
      return    color= Colors.red;
        }break;
      default:{
        return color=Colors.blue;
      }

    }
  }
}

enum EnumState { SUCCESS, WARNING, ERROR }
