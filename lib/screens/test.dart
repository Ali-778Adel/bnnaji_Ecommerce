import 'package:bnnaji/components/GrigTileCategoryItem.dart';
import 'package:bnnaji/components/ToastMessage.dart';
import 'package:bnnaji/cubit/category_cubit.dart';
import 'package:bnnaji/cubit/cubit_test.dart';
import 'package:bnnaji/cubit_states/category_states.dart';
import 'package:bnnaji/cubit_states/test_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Cubit_Test, TestStates>(builder: (context, state) {
      return Center(
        child: TextButton(
            child: (Text(
              'get Data',
              style: TextStyle(),
            )),
            onPressed: () {
              Cubit_Test.get(context).myHttpGetter(
                  'https://mobileaders.com/bn_naji/public/api/categories');

            }),
      );
    });
  }
}
