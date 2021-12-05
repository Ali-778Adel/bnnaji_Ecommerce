
import 'package:bnnaji/cubit_states/AppHomePageStates.dart';
import 'package:bnnaji/screens/CategoryScreen.dart';
import 'package:bnnaji/screens/ProductsScreen.dart';
import 'package:bnnaji/screens/cart_screen.dart';
import 'package:bnnaji/screens/favourite_screen.dart';
import 'package:bnnaji/screens/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AppHomePageCubit extends Cubit<AppHomePageState> {
  AppHomePageCubit() : super(AppHomePageIntialState());
  static AppHomePageCubit get(context) => BlocProvider.of(context);

  int currentInex = 0;
List<Widget>screens=
[
  CategoryScreen(),
  CartScreen(),
  FavouriteScreen(),
];

List<String>titles=[
  'Category',
  'Cart',
  'Favourite',

];


  Map<String, dynamic> category = {};
  Map<String, dynamic> products = {};

  void onBottomNavBarTapped(int index ) {

    currentInex = index;

    emit(BottomNavBarState());
  }

//when Category Item Tapped in dart file named Gid Tile Category Item
  onCatggoryItemTapped({@required int id,context}) async {
     Navigator.push(context,MaterialPageRoute(builder: (BuildContext context)=>ProductsScreen())).catchError((error){print('error${error.toString()}');});
     emit(OnCategoryItemTapped());
//     getProductsDataFromServer(id: id);



  }
  /*
  List<int>ids=[
11,8,16,7,12,9,10,14,15,13
  ];
void getproductsbyid({int id,BuildContext context} ) async{
    for(int i =0;i<10;i++){
      await DioHelper.getData(url:'bn_naji/public/api/products/cat' ,quarey:{'id':'${ids[id]}]'} ).then((value) {
        print('hello');
        print (value.data.runtimeType);
        print(value.data.toString());
        products=value.data;
        print(products['data'][0]['market']['media'][0]['thumb']);
      }).catchError((error){
        print('error${error.toString()}');
      });

      emit(getProductsDataFromServerState());
    }


}

*/

  Database database;
  void createDatabase() async {
    database = await openDatabase('home.db', version: 1,
        onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE categories (id INT PRIMARY KEY , catImage TEXT,catName Text)')
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
      {@required int id,@required String catImage, @required String catName}) async {
    await database.transaction((txn) {
      return txn.rawInsert('INSERT INTO categories (catImage,catName) VALUES'
          '("$catImage","$catName")');
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
