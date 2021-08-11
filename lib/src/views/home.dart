import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:myshop/src/controllers/category_controller.dart';
import 'package:myshop/src/models/product.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CategoryController categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'MyShop',
                    style: TextStyle(
                        fontFamily: 'avenir',
                        fontSize: 27,
                        fontWeight: FontWeight.w900),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.view_list_rounded), onPressed: () {}),
                IconButton(icon: Icon(Icons.grid_view), onPressed: () {}),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (categoryController.isLoading.value)
                return Center(child: CircularProgressIndicator());
              else
                return ListView.builder(
                  itemCount: categoryController.categoryList.length,
                  itemBuilder: (context, index) {
                    return CategoryList(categoryController.categoryList[index]);
                  },
                );
            }),
          )
        ],
      ),
    ));
  }
}

class CategoryList extends StatelessWidget {
  final Category category;
  CategoryList(this.category);

  @override
  Widget build(BuildContext context) {
    if (category.products.isEmpty) return ListTile(title: Text(category.name));
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            category.name,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 200.0,
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: category.products.length,
              itemBuilder: (BuildContext context, int index) => Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(
                    width: 100.0,
                    height: 100.0,
                    child: Card(),
                  ),
                  Center(
                    child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Text(category.products[index].name),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
