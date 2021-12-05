import 'package:bnnaji/components/ProductsItem.dart';
import 'package:bnnaji/components/bottomnavbartest.dart';
import 'package:bnnaji/components/loading_gif_widget.dart';
import 'package:bnnaji/cubit/AppHomePageCubit.dart';
import 'package:bnnaji/cubit/cart_cubit.dart';
import 'package:bnnaji/cubit/faourite_cubit.dart';
import 'package:bnnaji/cubit/proucts_cubit.dart';
import 'package:bnnaji/cubit_states/AppHomePageStates.dart';
import 'package:bnnaji/cubit_states/products_states.dart';
import 'package:bnnaji/screens/favourite_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cart_screen.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Products'),
        ),
        body: index(context),
        bottomNavigationBar: BlocBuilder<AppHomePageCubit, AppHomePageState>(
          builder: (context, state) {
            return bottom(
                currentIndex: context.read<AppHomePageCubit>().currentInex,
                function: (index) => context
                    .read<AppHomePageCubit>()
                    .onBottomNavBarTapped(index));
          },
        ));
  }
}

Widget index(BuildContext context) {
  return BlocBuilder<AppHomePageCubit, AppHomePageState>(
      builder: (context, state) {
        print('look products builder');
        if (context.read<AppHomePageCubit>().currentInex == 0) {
          return productsLaunch();
        } else if (context.read<AppHomePageCubit>().currentInex == 1) {
          return CartScreen();
        } else if (context.read<AppHomePageCubit>().currentInex == 2) {
          return FavouriteScreen();
        }
        ;
      });
}

Widget productsLaunch() {
  return BlocBuilder<Products_Cubit, Products_States>(
      builder: (context, state) {
        Products_Cubit cubit = Products_Cubit.get(context);
        var map = cubit.products;
        if (state is GetproductsLoadingState) {
          return Center(child: loadinGifWidget(text: ''));
        } else {
          print('see');
          return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 2 / 3, mainAxisExtent: 360),
              itemCount: (map['data']).length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return ProductItem(
                    context: context,
                    id: map['data'][index]['id'],
                    imageUrl: map['data'][index]['market']['media'][0]['thumb'],
                    productName: map['data'][index]['name'],
                    price: map['data'][index]['price'],
                    index: index,
                    cartfunction: () {
                      context.read<Cart_Cubit>().onCartGestureDetectorTaped(
                          index: index, id: map['data'][index]['id'],context: context);
                      context.read<Cart_Cubit>().showcartList(context);
                    },
                  favouritefunction: (){
                    context.read<Faourite_Cubit>().onFavouriteGestureDetectorTaped(
                        index: index, id: map['data'][index]['id'],context: context);
                    context.read<Faourite_Cubit>().showFavouritetList(context);
                  }

                    );
              });
        }
      });
}
