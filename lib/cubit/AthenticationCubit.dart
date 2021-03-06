import 'package:bnnaji/Shared/SheredPref.dart';
import 'package:bnnaji/constants/Eenpoints.dart';
import 'package:bnnaji/cubit_states/AthenticationStates.dart';
import 'package:bnnaji/models/auth_model.dart';
import 'package:bnnaji/network/Authentication_DioHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthenticationCubit extends Cubit<AuthenticationStates> {
  AuthenticationCubit() : super(AthenticationIntialState());

  static AuthenticationCubit get(context) => BlocProvider.of(context);
  AuthModel authModel;
  var IconData = Icon(Icons.visibility_off_outlined);
  bool obsecureText = true;
  void onPasswordSuffixIconTaped() {
    if (obsecureText) {
      IconData = Icon(Icons.visibility_outlined);
      obsecureText = false;
    } else {
      IconData = Icon(Icons.visibility_off_outlined);
      obsecureText = true;
    }
    emit(PasswordsVisibilityState());
  }

  //login data
  Future<dynamic> sendLoginUserData(
      {String name, String email, String password}) async {
    emit(LoginLoadingState());
    await AuthenticationDioHelper.sendUserData(
            url: Login,
            data: {
              'name': name,
              'email': email,
              'password': password,
            },
            lang: 'ar')
        .then((value) {
      authModel = AuthModel.fromJson(value.data);
      emit(LoginSccessState(authModel));
      print(authModel.toString());
     setuerDataToShared(token: true,name: authModel.data.name,email: email,phoneNumber: authModel.data.phone);

      print(authModel.data.name);
      print(authModel.data.token);
    }).catchError((error) {
      print('error error error error error ${error.toString()}');
      emit(LoginFailureState(authModel));
    });
  }

  Future<dynamic> sendregisterUserData(
      {@required String name, @required String email, @required String password, @required String phone}) async {
    emit(RegisterLoadingState());
    await AuthenticationDioHelper.sendUserData(url: Register, data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone
    }).then((value) {
      authModel = AuthModel.fromJson(value.data);
      print(authModel.toString());
      setuerDataToShared(token: true,name: name,email: email,phoneNumber: phone);

      emit(RegisterSuccessState(authModel));
    }).catchError((error) {
      print('error${error.toString()}');
      emit(RegisterFailureState(authModel));
    });
  }

void setuerDataToShared({bool token,String name,String,email,String phoneNumber})async{
    await SharedPref_Helper.setDataToSharePref(key: 'token', value: token).then((value) => print('token added with $value'));
    await SharedPref_Helper.setDataToSharePref(key: 'name', value: name).then((value) => print('name added with $value'));;
    await SharedPref_Helper.setDataToSharePref(key: 'email', value: email).then((value) => print('email added with $value'));;
    await SharedPref_Helper.setDataToSharePref(key: 'phoneNumber', value: phoneNumber).then((value) => print('phoneNumber added with $value'));;

}

void getDatafromShareprref({bool token,String name,String,email,String phoneNumber})async{
  await SharedPref_Helper.getDataFromSharepref(key: 'token').then((value) => print('token get with $value'));
  await SharedPref_Helper.getDataFromSharepref(key: 'name').then((value) => print('name get with $value'));
  await SharedPref_Helper.getDataFromSharepref(key: 'email').then((value) => print('email get with $value'));
  await SharedPref_Helper.getDataFromSharepref(key: 'phoneNumber').then((value) => print('phoneNumber get with $value'));

  }



}
