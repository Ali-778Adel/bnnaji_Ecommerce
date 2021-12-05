import 'package:bnnaji/cashe/cashe_manger_controller.dart';
import 'package:bnnaji/components/ToastMessage.dart';
import 'package:bnnaji/cubit/proucts_cubit.dart';
import 'package:bnnaji/cubit_states/category_states.dart';
import 'package:bnnaji/network/DioHelper.dart';
import 'package:bnnaji/screens/ProductsScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class Category_Cubit extends Cubit<Category_States> {
  Category_Cubit() : super(Category_IntialState());
  static Category_Cubit get(context) => BlocProvider.of(context);

  Map<String, dynamic> category = {};
  List<Map<String,dynamic>>addlistitems=[];
  Future<Response> getCategoryDataFromsever() async {
    emit(getCategoryDataFromServerLoadingState());
    await DioHelper.getData(url: 'bn_naji/public/api/categories').then((value) {
      category=value.data;
      print(category['data'][0]['id']);
      print(category.toString());
      emit(getCategoryDataFromServerState());
    }).catchError((error) {
      print('error1 ${error.toString()}');
      HandleToastMeaasge.showToastMessage(message: 'check network connection', enumState: EnumState.ERROR);
      emit(getCategoryDataFromServerFailureState());

    });
  }

//when Category Item Tapped in dart file named Gid Tile Category Item

  onCatggoryItemTapped({@required int id, context}) async {
    Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ProductsScreen()))
        .catchError((error) {
      print('error${error.toString()}');
    });
    emit(OnCategoryItemTapped());
    Products_Cubit.get(context).getProductsDataFromServer(id: id);
  }

  Database database;
  void createDatabase() async {
    database = await openDatabase('home.db', version: 1,
        onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE categories (id INT PRIMARY KEY,imgeUrl TEXT,catName Text)')
          .then((value) {
        print('databas created successfully');
        emit(CreateDatabaseState());
      }).catchError((error) {
        print('error${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('databaseopene Successfully');
      emit(OpenDatabaseState());
    });
  }

  Future<int> insertIntoDatabase(
      { int id,
       String catImage,
       String catName,
       int index
      }) async {

    await database.transaction((txn) {
      return txn.rawInsert('INSERT INTO categories (id,imgeUrl,catName) VALUES'
          '("$id}","$catImage}","$catName")');
    }).then((value) {
      print('$value added successfully');
      emit(InsertItoDatabaseState());
    }).catchError((error) {
      print('error ${error.toString()}');
    });
  }

  List<Map<String, dynamic>> dbCategory = [];
  void getDataFromDatabase(database) async {
    await database.rawQuery('SELECT * FROM categories').then((value) {
      dbCategory = value;
      print(dbCategory);
      emit(GetDataFroDatabaseState());
    }).catchError((error) {
      print('error ${error.toString()}');
    });
  }
}
