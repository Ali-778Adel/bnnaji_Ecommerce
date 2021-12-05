import 'package:bnnaji/cubit_states/products_states.dart';
import 'package:bnnaji/models/cart_model.dart';
import 'package:bnnaji/network/DioHelper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Products_Cubit extends Cubit<Products_States> {
  Products_Cubit() : super(Products_IntialState());

  static Products_Cubit get(context) => BlocProvider.of(context);

  Map<String, dynamic> products = {};
  Future<Response> getProductsDataFromServer({int id}) async {
emit(GetproductsLoadingState());
    await DioHelper.getData(
        url: 'bn_naji/public/api/products/cat',
        quarey: {'id': '$id'}).then((value) {
      print('hello');
      print(value.data.runtimeType);
      print(value.data.toString());
      products = value.data;
      emit(getProductsDataFromServerState());
      print(products['data'][0]['market']['media'][0]['thumb']);
    }).catchError((error) {
      emit(GetprouctsFaillureState());
      print('error${error.toString()}');
    });
  }

  List<int> selectedIndexList = new List<int>();
  List<int>selectedid=new List<int>();
  void onGestureDetectorTaped({@required int index,int id}) {
    if (!selectedIndexList.contains(index)&&!selectedid.contains(id)) {
      selectedIndexList.add(index);
      selectedid.add(id);
      addItemToList(index: index).then((value) {
        print(value.toString());
        emit(onCartIconTappedState());
      });
      print('indexadded');

    } else {
      selectedIndexList.remove(index);
      selectedid.remove(id);
      print('indexremoved');
      removeFromList(index: index).then((value) {
        print('aliadelali');
        print(value);
        emit(onCartIconTappedState());
      }).catchError((error) {
        print('error${error.toString()}');

      });
    }
  }

  

  
  List<CartModel>modelList=[];
  Future<dynamic>addItemToList({int index})async{
   await modelList.add(CartModel(
       id:'${products['data'][index]['id']}',
       name:'${products['data'][index]['name']}',
       price:'${products['data'][index]['price']}',
       imageUrl:'${products['data'][index]['market']['media'][0]['thumb']}'
   ));

  emit(addCartListState());
  }
  Future<bool>removeFromList({int index})async{
    await modelList.removeWhere((element) => element.id=='${products['data'][index]['id']}');
    emit(removeCartListState());
  }


}

