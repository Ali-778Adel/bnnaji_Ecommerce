import 'package:bnnaji/Layout/AppHomePageLayout.dart';
import 'package:bnnaji/components/ToastMessage.dart';
import 'package:bnnaji/cubit/AthenticationCubit.dart';
import 'package:bnnaji/cubit_states/AthenticationStates.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bnnaji/screens/LoginScreen.dart';

class RegisterScreen extends StatelessWidget {
  var fullNameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
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
                          'Register',
                          style: (Theme.of(context).textTheme.headline4)
                              .copyWith(color: Colors.black87),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Rgister to get our hot offers',
                          style: (Theme.of(context).textTheme.headline6)
                              .copyWith(color: Colors.teal),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        //firstName
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
                            controller: fullNameController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.title),
                              labelText: 'FullName',
                              hintText: 'Enter your full name here ',
                            ),
                            validator: (String message) {
                              if (message.isEmpty) {
                                return " name musn't be empty";
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //lastName
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
                            controller: phoneController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.phone),
                              labelText: 'Phone number',
                              hintText: 'Enter your phone number here ',
                            ),
                            validator: (String message) {
                              if (emailController.text.isEmpty) {
                                return "phone number musn't be empty";
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                            controller: emailController,
                            decoration: InputDecoration(
                              icon: Icon(Icons.email),
                              labelText: 'Email',
                              hintText: 'Enter your email here ',
                            ),
                            validator: (String message) {
                              if (emailController.text.isEmpty) {
                                return "email musn't be empty";
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                                return " password musn't be empty ";
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) {
                              return ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState.validate()) {
                                      cubit.sendregisterUserData(
                                          name: fullNameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phoneController.text);

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
                                    'Register',
                                    style:
                                        (Theme.of(context).textTheme.headline6)
                                            .copyWith(color: Colors.blue),
                                  ));
                            },
                            fallback: (context) {
                              return CircularProgressIndicator();
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Already have an account ?",
                              style: (Theme.of(context).textTheme.headline6)
                                  .copyWith(color: Colors.grey, fontSize: 18),
                            ),
                            TextButton(
                              child: Text(
                                'LOG IN ',
                                style: (Theme.of(context).textTheme.headline6)
                                    .copyWith(color: Colors.blue, fontSize: 18),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginScreen()));
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              );
            },   listener: (context, state) {
          if (state is RegisterSuccessState) {
            if (state.authModel.status) {
              HandleToastMeaasge.showToastMessage(
                  message: state.authModel.message,
                  enumState: EnumState.SUCCESS);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AppHomePageLayout()),
                      (route) => false);

            } else {
              HandleToastMeaasge.showToastMessage(
                  message: state.authModel.message,
                  enumState: EnumState.WARNING);
            }
          } else if (state is RegisterFailureState) {
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
