import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  Key key;
  int id;
  String imageUrl;
  String price;
  String name;
  int amount = 0;
  Function(Object)function;
  CartItem(
      {this.key,
        @required this.id,
      @required this.imageUrl,
      @required this.price,
      @required this.name,
        this.function

      });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Dismissible(
        direction: DismissDirection.horizontal,
        key: ValueKey(this.id),
        onDismissed: function,
        background: Icon(Icons.delete),
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(.2),
                    blurRadius: 3,
                    spreadRadius: 3,
                    offset: Offset(0, 2))
              ]),
          child:   Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  child: Image.network(imageUrl),
                  radius: 40,
                ),
              ),
              Column(
mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: Text(
                    name,
                    style: TextStyle(fontSize: 22, color: Colors.black87),
                  )),
                  Expanded(
                      child: Text(
                    price,
                    style: TextStyle(fontSize: 18, color: Colors.deepOrange),
                  )),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_up),
                          onPressed: () {})),
                  Text(
                    '$amount',
                    style: TextStyle(fontSize: 18, color: Colors.blue),
                  ),
                  Expanded(
                      child: IconButton(
                          icon: Icon(Icons.keyboard_arrow_down),
                          onPressed: () {}))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
