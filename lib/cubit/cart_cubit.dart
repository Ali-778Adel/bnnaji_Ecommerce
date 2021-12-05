import 'package:bnnaji/cubit/proucts_cubit.dart';
import 'package:bnnaji/cubit_states/cart_states.dart';
import 'package:bnnaji/models/cart_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class Cart_Cubit extends Cubit<Cart_States> {
  Cart_Cubit() : super(Cart_IntialState());
  BuildContext context;

  static Cart_Cubit get(context) => BlocProvider.of(context);

  List<int> selectedIndexList = [];
  List<int> selectedid = [];
  void onCartGestureDetectorTaped(
      {@required int index, int id, BuildContext context}) {
    if (!selectedIndexList.contains(index) && !selectedid.contains(id)) {
      selectedIndexList.add(index);
      selectedid.add(id);
      addItemToList(index: index, context: context).then((value) {
        print(value.toString());
        emit(onCartIconTappedState());
      });
      print('indexadded');
    } else {
      selectedIndexList.remove(index);
      selectedid.remove(id);
      print('indexremoved');
      removeFromList(index: index, context: context).then((value) {
        print('aliadelali');
        print(value);
        emit(onCartIconTappedState());
      }).catchError((error) {
        print('error${error.toString()}');
      });
    }
  }
//on favourite icon tapped
//  List<int> favouriteSelectedIndexList = [];
//  List<int> favouriteselectedid = [];
//  void onFavouriteGestureDetectorTaped(
//      {@required int index, int id, BuildContext context}) {
//    if (!favouriteselectedid.contains(index) && !favouriteselectedid.contains(id)) {
//      favouriteSelectedIndexList.add(index);
//      favouriteselectedid.add(id);
//      addItemToList(index: index, context: context).then((value) {
//        print(value.toString());
//        emit(onCartIconTappedState());
//      });
//      print('indexadded');
//    } else {
//      favouriteSelectedIndexList.remove(index);
//      favouriteselectedid.remove(id);
//      print('indexremoved');
//      removeFromList(index: index, context: context).then((value) {
//        print('aliadelali');
//        print(value);
//        emit(onCartIconTappedState());
//      }).catchError((error) {
//        print('error${error.toString()}');
//      });
//    }
//  }

  List<CartModel> modelList = [];
  Map<String,dynamic>products_info={};

  Future<dynamic> addItemToList({int index, BuildContext context,}) async {
    products_info=Products_Cubit.get(context).products;
    await modelList.add(CartModel(
        id: '${products_info['data'][index]['id']}',
        name: '${products_info['data'][index]['name']}',
        price: '${products_info['data'][index]['price']}',
        imageUrl: '${products_info['data'][0]['market']['media'][0]['thumb']}'));
//    cartdb.add({
//      'id': '${products['data'][index]['id']}',
//      'productName': '${products['data'][index]['name']}',
//      'price':'${products['data'][index]['price']}'
//    });
    insertCartdbData(
        id: '${products_info['data'][index]['id']}',
        productName:'${products_info['data'][index]['name']}',
        price: '${products_info['data'][index]['price']}',
       imageUrl :'${products_info['data'][0]['market']['media'][0]['thumb']}'
    );
    getDataFromDatabase(database);
    print('addcarrtitemdata ${products_info['data'][index]['id'].runtimeType}');

    emit(addCartListState());
  }

  Future<bool> removeFromList({int index,int id, BuildContext context}) async {
    await modelList.removeWhere((element) =>
        element.id ==
        '${Products_Cubit.get(context).products['data'][index]['id']}');
    deleteFromCartDatabase(id: id);
    getDataFromDatabase(database);
    emit(removeCartListState());
  }

  List<CartModel> carItemtList;
  void showcartList(BuildContext context) {
    carItemtList = modelList;
    print('cart item list price is${carItemtList[0].price} ');
    emit(ShowCartList());
  }

  Database database;
  void createCartDataBase() async {
    database = await openDatabase('cart.db', version: 1,
        onCreate: (database, version) async {
      await database
          .execute(
              'CREATE TABLE cartItems(id INT ,productName TEXT,price TEXT,imageUrl TEXT)')
          .then((value) {
        print('cartdb created successfully');
        emit(CreateCartDatabase());
      }).catchError((error) {
        print(('error${error.toString()}'));
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('cartdb opened successfully');
      emit(OpenCartDatabase());
    });
  }

  Future<int> insertCartdbData(
      {String id, String productName, var price, String imageUrl, String amount}) async {
    await database.transaction((txn) {
      return txn
          .rawInsert('INSERT INTO cartItems(id,productName,price,imageUrl) VALUES'
              '("$id","$productName","$price","$imageUrl")')
          .then((value) {
        print(' raw $value added successfully');
        emit(InsertIntoCartDatabase());
      }).catchError((error) {
        print('error ${error.toString()}');
      });
    });
  }

  List<Map<String, dynamic>> cartdb = [];
  void getDataFromDatabase(database) async {
    await database.rawQuery('SELECT * FROM cartItems').then((value) {
      cartdb = value;
      print(cartdb.toString());
      print(cartdb[0]['productName']);
      emit(GetDataFromCartDatabase());
    }).catchError((error) {
      print('error ${error.toString()}');
    });
  }

  void deleteFromCartDatabase({int id}) async {
    await database
        .rawDelete('DELETE FROM cartItems WHERE id = ?', [id]).then((value) {
      print('$value  deleted  successfully');
      getDataFromDatabase(database);
      emit(DeleteFromCartDatbase());
      print('item of id $id deleted successfully');
    }).catchError((error) {
      print('error ${error.toString()}');
    });
  }
}
