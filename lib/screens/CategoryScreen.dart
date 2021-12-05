
import 'package:bnnaji/components/GrigTileCategoryItem.dart';
import 'package:bnnaji/cubit/category_cubit.dart';
import 'package:bnnaji/cubit_states/category_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Category_Cubit, Category_States>(
        builder: (context, state) {
          Category_Cubit cubit = Category_Cubit.get(context);
          var map = cubit.category;
          var dbmap = cubit.dbCategory;

          Widget categoryLaunch() {
            if (map['data'] == null) {
              if (dbmap.length == 0) {
                return Center(child: CircularProgressIndicator());
              } else {
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2 / 3,
                        mainAxisExtent: 240),
                    itemCount: (dbmap).length,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GridTileCategoryItem(
                        id: dbmap[index]['id'],
                        imageUrl: dbmap[index]['catImage'],
                        categoryName: dbmap[index]['catName'],
                      );
                    });
              }
            } else {
              return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2 / 2,
                      mainAxisExtent: 240),
                  itemCount: (map['data']).length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return GridTileCategoryItem(
                        id: map['data'][index]['id'],
                        imageUrl: map['data'][index]['media'][0]['thumb'],
                        categoryName: map['data'][index]['name'],
                        function: () {
                          cubit.onCatggoryItemTapped(
                              id: map['data'][index]['id'], context: context);
                        });
                  });
            }
          }

          return categoryLaunch();
        },
        listener: (context, state) {});
  }
}
