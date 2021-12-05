


import 'package:bnnaji/components/ProductsItem.dart';
import 'package:bnnaji/components/bottomnavbartest.dart';
import 'package:bnnaji/cubit/AppHomePageCubit.dart';
import 'package:bnnaji/cubit/proucts_cubit.dart';
import 'package:bnnaji/cubit_states/AppHomePageStates.dart';
import 'package:bnnaji/cubit_states/products_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cart_screen.dart';

class ProTest extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Products_Cubit, Products_States>(
        builder: (context, state) {
          Products_Cubit cubit = Products_Cubit.get(context);
          var map = cubit.products;
          Widget productsLaunch() {
            if (state is GetproductsLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if(state is getProductsDataFromServerState) {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 3,
                      mainAxisExtent: 360),
                  itemCount: (map['data']).length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ProductItem(
                        context: context,
                        id: map['data'][index]['id'],
                        imageUrl: map['data'][index]['market']['media'][0]
                        ['thumb'],
                        productName: map['data'][index]['name'],
                        price: map['data'][index]['price'],
                        index: index
                    );
                  });
            }
          }

          return BlocConsumer<AppHomePageCubit, AppHomePageState>(
            listener: (context, state) {},
            builder: (context, state) {
              AppHomePageCubit appHomePageCubit = AppHomePageCubit.get(context);
              Widget index() {
                if (appHomePageCubit.currentInex == 0) {
                  return productsLaunch();
                } else if (appHomePageCubit.currentInex == 1) {
                  return CartScreen();
                } else if (appHomePageCubit.currentInex == 2) {
                  return Scaffold();
                }
              }

              return Scaffold(
                  appBar: AppBar(
                    title: Text('Products'),
                  ),
                  body: index(),
                  bottomNavigationBar: bottom(
                      currentIndex: appHomePageCubit.currentInex,
                      function: (index) =>
                          appHomePageCubit.onBottomNavBarTapped(index)));
            },
          );
        },
        listener: (context, state) {});
  }

}