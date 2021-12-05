import 'package:bnnaji/Shared/SheredPref.dart';
import 'package:bnnaji/cubit/AthenticationCubit.dart';
import 'package:bnnaji/cubit_states/AthenticationStates.dart';
import 'package:bnnaji/screens/OnBoaringScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoScreen extends StatelessWidget {
  String name= SharedPref_Helper.getDataFromShareprefrences(key: 'name');
  String email=SharedPref_Helper.getDataFromShareprefrences(key: 'email');
  String phone=SharedPref_Helper.getDataFromShareprefrences(key: 'phoneNumber');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationCubit, AuthenticationStates>(
        builder: (context, state) {
          AuthenticationCubit cubit = AuthenticationCubit.get(context);



          return Scaffold(
            appBar: AppBar(
              title: Text(''),
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  name,
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  phone,
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  email,
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
                Spacer(),
                Row(
                  children: [
                    Spacer(),
                    TextButton(
                      child: Row(
                        children: [
                          Text(
                            'Log out',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                          SizedBox(width: 10),
                          Icon(Icons.logout, size: 20, color: Colors.black),
                        ],
                      ),
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.grey.withOpacity(0.5)),
                          shadowColor: MaterialStateProperty.all<Color>(
                              Colors.grey.withOpacity(0.9))),
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Are you sure?'),
                                content: Text('Do you want to log out?'),
                                actions: [
                                  TextButton(
                                    child: Text("No"),
                                    onPressed: () => Navigator.of(context).pop(),
                                  ),
                                  TextButton(
                                      child: Text("Yes"),
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    OnBoardingScreen()),
                                            (route) => false);
                                      }),
                                ],
                              );
                            });
                      },
                    ),
                    SizedBox(width: 40,)
                  ],
                ),
                SizedBox(
                  height: 60,
                )
              ],
            ),
          );
        },
        listener: (context, state) {});
  }
}
