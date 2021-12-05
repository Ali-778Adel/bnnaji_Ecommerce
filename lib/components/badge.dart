import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final Widget child;
  final String value;
  final Color color;

  const Badge({

    @required this.value,
    this.color,
    @required this.child
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      clipBehavior: Clip.hardEdge,
      children: [
        child,
        Positioned(
          right:10 ,
          top: 10,
          child: Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: color!=null? color:Theme.of(context).accentColor,
            ),
            constraints: BoxConstraints(
              minHeight: 10,
              minWidth: 10,
            ),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10,color: Colors.black),
            ),
          ),
        )
      ],
    );
  }
}
