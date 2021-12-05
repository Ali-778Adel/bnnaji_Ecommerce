import 'package:bnnaji/components/cartItem.dart';
import 'package:bnnaji/components/loading_gif_widget.dart';
import 'package:bnnaji/cubit/cart_cubit.dart';
import 'package:bnnaji/cubit_states/cart_states.dart';
import 'package:bnnaji/models/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Cart_Cubit, Cart_States>(
        builder: (context, state) {
          Cart_Cubit cart_cubit = Cart_Cubit.get(context);

          Widget launchCartWidget() {
            if (cart_cubit.cartdb == null) {
              return loadinGifWidget(text: 'Your Cart is Empty ');
            }else{
              return ListView.builder(
                itemCount: cart_cubit.cartdb.length,
                  itemBuilder: (context,index){
                    return CartItem(
                      key: ValueKey(index),
                      id: cart_cubit.cartdb[index]['id'],
                      imageUrl: cart_cubit.cartdb[index]['imageUrl'],
                      name: cart_cubit.cartdb[index]['productName'],
                      price: cart_cubit.cartdb[index]['price'],
                      function: (DismissDirection)=>cart_cubit.deleteFromCartDatabase(id:cart_cubit.cartdb[index]['id'] ),
                    );
                  });
            }
          }

          return launchCartWidget();
        },
      );
  }
}
