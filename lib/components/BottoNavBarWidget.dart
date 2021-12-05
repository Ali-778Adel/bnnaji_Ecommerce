import 'package:bnnaji/cubit/AppHomePageCubit.dart';
import 'package:bnnaji/cubit_states/AppHomePageStates.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget BottomNavBar({BuildContext context}){



  return BlocConsumer<AppHomePageCubit,AppHomePageState>(
    listener: (context,state){},
    builder: (context,state){
      AppHomePageCubit cubit=AppHomePageCubit.get(context);
    return BottomNavigationBar(
        currentIndex: cubit.currentInex,
       onTap: (index){
          cubit.onBottomNavBarTapped(index);

       },
      items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home'),
      BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart),label: 'Cart'),
      BottomNavigationBarItem(icon: Icon(Icons.favorite_border),label: 'favourite'),
      BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'setting'),
    ]);}
  );
}