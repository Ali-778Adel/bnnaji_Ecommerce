import 'package:bnnaji/cubit/cart_cubit.dart';
import 'package:bnnaji/cubit/faourite_cubit.dart';
import 'package:bnnaji/cubit/proucts_cubit.dart';
import 'package:bnnaji/cubit_states/cart_states.dart';
import 'package:bnnaji/cubit_states/favourite_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget ProductItem(
    {@required BuildContext context,
    @required String imageUrl,
    @required String productName,
    @required var price,
    @required int id,
    @required int index,
    @required Function cartfunction,
    @required Function favouritefunction,
    }) {
//  Cart_Cubit cart_cubit=Cart_Cubit().get(context);
  Color color = Colors.black87;
  Products_Cubit cubit = Products_Cubit.get(context);

  final Key formKey = GlobalObjectKey<AnimatedWidgetBaseState>(id);
  return  Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(
      height: 400,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 3,
                spreadRadius: 6,
                offset: Offset(0, 2))
          ]),
      child:  Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: Container(
              padding: EdgeInsets.all(8),
              height: 120,
              width: 120,
              margin: EdgeInsets.all(10),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              )),
        ),
        Expanded(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    productName,
                    style: TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 2),
                    child: Text(
                      '$price EGP',
                      style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepOrange),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BlocBuilder<Faourite_Cubit, Favourite_States>(
                          builder: (context, state) {
                        return
                          icon_Button(
                            index: index,
                            iconData: Icons.favorite_border,
                            color: context
                                        .read<Faourite_Cubit>()
                                        .favouriteSelectedIndexList
                                        .contains(index) &&
                                    context
                                        .read<Faourite_Cubit>()
                                        .favouriteselectedid
                                        .contains(id)
                                ? Colors.deepOrange
                                : Colors.black87,
                            function: favouritefunction)


                        ;
                      }),
//                          icon_Button(index: index, iconData: Icons.add_shopping_cart,
//                             color:Cart_Cubit.get(context).selectedIndexList.contains(index)&&Cart_Cubit.get(context).selectedid.contains(id)?Colors.deepOrange:Colors.black87,
//                             function: function
//                         ),
                      BlocBuilder<Cart_Cubit, Cart_States>(
                          builder: (context, state) {
                        return  icon_Button(
                            index: index,
                            iconData: Icons.add_shopping_cart,
                            color: context
                                        .read<Cart_Cubit>()
                                        .selectedIndexList
                                        .contains(index) &&
                                    context
                                        .read<Cart_Cubit>()
                                        .selectedid
                                        .contains(id)
                                ? Colors.deepOrange
                                : Colors.black87,
                            function: cartfunction);

                      })
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ]),
    ),
  );
}

Widget icon_Button({
  @required int index,
  @required IconData iconData,
  @required Color color,
  @required Function function,
}) {
  return IconButton(
      key: ValueKey(index),
      icon: Icon(
        iconData,
        color: color,
      ),
      onPressed: function);
}
