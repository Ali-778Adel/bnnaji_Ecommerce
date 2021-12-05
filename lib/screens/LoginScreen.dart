import 'package:bnnaji/Layout/AppHomePageLayout.dart';

import 'package:bnnaji/components/ToastMessage.dart';
import 'package:bnnaji/cubit/AthenticationCubit.dart';
import 'package:bnnaji/cubit/category_cubit.dart';
import 'package:bnnaji/cubit/proucts_cubit.dart';
import 'package:bnnaji/cubit_states/AthenticationStates.dart';
import 'package:bnnaji/cubit_states/products_states.dart';
import 'package:bnnaji/cubit_states/products_states.dart';

import 'package:bnnaji/screens/RegisterScreen.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  void checkState(AuthenticationStates state ,Function function) {
    if (state is LoginSccessState) {
      if (state.authModel.status) {
        HandleToastMeaasge.showToastMessage(
            message: state.authModel.message, enumState: EnumState.SUCCESS);

      }
    } else if (state is LoginFailureState) {
      if (state.authModel.status) {
        HandleToastMeaasge.showToastMessage(
            message: state.authModel.message, enumState: EnumState.WARNING);
      } else {
        HandleToastMeaasge.showToastMessage(
            message: state.authModel.message, enumState: EnumState.WARNING);
      }
    }
  }

  var emaiController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<AuthenticationCubit, AuthenticationStates>(

          builder: (context, state) {
            AuthenticationCubit cubit = AuthenticationCubit.get(context);
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Text(
                        'Log In',
                        style: (Theme.of(context).textTheme.headline4)
                            .copyWith(color: Colors.black87),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'log in to get our hot offers',
                        style: (Theme.of(context).textTheme.headline6)
                            .copyWith(color: Colors.teal),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //email
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(0, 2))
                            ]),
                        child: TextFormField(
                          controller: emaiController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.email),
                            labelText: 'Email',
                            hintText: 'Enter your email here ',
                          ),
                          validator: (String message) {
                            if (emaiController.text.isEmpty) {
                              return message = "email musn't be empty";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      //password
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10),
                                topLeft: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(0, 2))
                            ]),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: cubit.IconData,
                              onPressed: () {
                                cubit.onPasswordSuffixIconTaped();
                              },
                            ),
                            labelText: 'Password',
                            hintText: 'Enter your passsord here ',
                          ),
                          obscureText: cubit.obsecureText,
                          validator: (String message) {
                            if (message.isEmpty) {
                              return message = "password musn't be empty";
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: ConditionalBuilder(
                          condition: state is! LoginLoadingState,
                          builder: (context) {
                            return ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    cubit
                                        .sendLoginUserData(
                                        email: emaiController.text,
                                        password: passwordController.text);


                                  }
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.grey.withOpacity(0.5)),
                                    shadowColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.grey.withOpacity(0.9))),
                                child: Text(
                                  'Log in',
                                  style: (Theme.of(context).textTheme.headline6)
                                      .copyWith(color: Colors.blue),
                                ));
                          },
                          fallback: (context) => CircularProgressIndicator(),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Don't have an account ?",
                            style: (Theme.of(context).textTheme.headline6)
                                .copyWith(color: Colors.grey, fontSize: 18),
                          ),
                          SizedBox(
                            width: 0,
                          ),
                          TextButton(
                            child: Text(
                              'REGISTER NOW',
                              style: (Theme.of(context).textTheme.headline6)
                                  .copyWith(color: Colors.blue, fontSize: 18),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()));
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
          listener: (context, state) {
            if (state is LoginSccessState) {
              if (state.authModel.status) {
                HandleToastMeaasge.showToastMessage(
                    message: state.authModel.message,
                    enumState: EnumState.SUCCESS);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AppHomePageLayout()),
                );

              }else {
                HandleToastMeaasge.showToastMessage(
                    message: state.authModel.message,
                    enumState: EnumState.WARNING);
              }
            } else if (state is LoginFailureState) {
              if (state.authModel.status) {
                HandleToastMeaasge.showToastMessage(
                    message: state.authModel.message,
                    enumState: EnumState.WARNING);
              } else {
                HandleToastMeaasge.showToastMessage(
                    message: state.authModel.message,
                    enumState: EnumState.WARNING);
              }
            }
          },
        ));
  }
}
