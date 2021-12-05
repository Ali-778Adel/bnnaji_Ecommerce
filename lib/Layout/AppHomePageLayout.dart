import 'package:bnnaji/components/bottomnavbartest.dart';
import 'package:bnnaji/cubit/AppHomePageCubit.dart';
import 'package:bnnaji/cubit_states/AppHomePageStates.dart';
import 'package:bnnaji/screens/user_setting_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppHomePageLayout extends StatelessWidget {
  Widget build(BuildContext context) {
    return BlocConsumer<AppHomePageCubit, AppHomePageState>(
        listener: (context, state) {},
        builder: (context, state) {
          AppHomePageCubit cubit = AppHomePageCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child:Text(
                  cubit.titles[cubit.currentInex],
                  style:TextStyle(
                     //customize depth here
                    color: Colors.black, //customize color here
                  ),

                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),

                    child: IconButton(
                      icon: Icon(
                        Icons.person,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserInfoScreen()));
                      },
                    ),
                  ),

              ],
            ),
            body: IndexedStack(
              index: cubit.currentInex,
              children: cubit.screens,
            ),
            bottomNavigationBar: bottom(
                currentIndex: cubit.currentInex,
                function: (index) => cubit.onBottomNavBarTapped(index)),
          );
        });
  }
}
