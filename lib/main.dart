import 'package:bnnaji/cashe/custonCach.dart';
import 'package:bnnaji/screens/LoginScreen.dart';
import 'package:bnnaji/screens/OnBoaringScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'Layout/AppHomePageLayout.dart';
import 'Shared/SheredPref.dart';
import 'app_const_ui/AppThemes.dart';
import 'constants/Bloc_Observer.dart';
import 'cubit/AppHomePageCubit.dart';
import 'cubit/AthenticationCubit.dart';
import 'cubit/cart_cubit.dart';
import 'cubit/category_cubit.dart';
import 'cubit/cubit_test.dart';
import 'cubit/faourite_cubit.dart';
import 'cubit/proucts_cubit.dart';
import 'network/Authentication_DioHelper.dart';
import 'network/DioHelper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  AuthenticationDioHelper.initAuthDio();
  await SharedPref_Helper.initSharedPref();
  Bloc.observer = MyBlocObserver();
  CustomCacheManager.instance;
  bool onBoarding =
      await SharedPref_Helper.getDataFromSharepref(key: 'onBoarding');
  bool token = await SharedPref_Helper.getDataFromSharepref(key: 'token');
  print(token);
  String name = await SharedPref_Helper.getDataFromShareprefrences(key: 'name');
  print('shared name==$name');
  runApp(MyApp(
    onBoarding: onBoarding,
    token: token,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final bool onBoarding;
  final bool token;
  MyApp({this.onBoarding, this.token});
  Widget Home() {
    if (onBoarding) {
      if (token) {
        return AppHomePageLayout();
      } else {
        return LoginScreen();
      }
    } else {
      return OnBoardingScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthenticationCubit()),
          BlocProvider(create: (context) => AppHomePageCubit()),
          BlocProvider(
              create: (context) =>
                  Category_Cubit()..getCategoryDataFromsever()),
          BlocProvider(create: (context) => Products_Cubit()),
          BlocProvider(create: (context) => Cart_Cubit()..createCartDataBase()),
          BlocProvider(create: (context) => Cubit_Test()),
          BlocProvider(
              create: (context) => Faourite_Cubit()..createCartDataBase()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: Home()));
  }
}
