import 'package:bnnaji/components/faourite_item.dart';
import 'package:bnnaji/components/loading_gif_widget.dart';
import 'package:bnnaji/cubit/faourite_cubit.dart';
import 'package:bnnaji/cubit_states/favourite_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Faourite_Cubit, Favourite_States>(
        builder: (context, state) {
          Faourite_Cubit cart_cubit = Faourite_Cubit.get(context);
          Widget launchCartWidget() {
            if (cart_cubit.cartdb == null) {
              return loadinGifWidget(text: 'Your Cart is Empty ');
            }else{
              return ListView.builder(
                  itemCount: cart_cubit.cartdb.length,
                  itemBuilder: (context,index){
                    return FavouriteItem(
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
