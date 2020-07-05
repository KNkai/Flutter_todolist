import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:todolist_sqflite/src/Models/category_model.dart';
import 'package:todolist_sqflite/src/Services/todo_services.dart';
import 'package:todolist_sqflite/src/components/widgets/appbar.dart';
import 'package:todolist_sqflite/src/components/widgets/drawer_navigation.dart';
import 'package:todolist_sqflite/src/screens/Todos/todo_detail_page.dart';
import 'package:todolist_sqflite/src/services/categories_service.dart';

class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  final GlobalKey<ScaffoldState> _categoriesScaffoldKey =
      new GlobalKey<ScaffoldState>();

  var _titleCateEditingController = TextEditingController();
  var _desCateEditingController = TextEditingController();
  var _categories_service = CategoriesService();
  var _category = Category();
  var _todoService = TodoService();

  List<Category> _modelCat = List<Category>();

  @override
  void initState() {
    super.initState();
    _getAllCategories();
  }

  _getAllCategories() async {
    var listCate = await _categories_service.getCategory();
    listCate.forEach((cat) {
      setState(() {
        var mod = Category();
        mod.id = cat['id'].hashCode;
        mod.title = cat['title'];
        mod.description = cat['description'];
        _modelCat.add(mod);
      });
    });
  }

  _deleteCategory(int id) async {
    await _categories_service.deleteCategory(id);
  }

  _deleteTodoByIdCate(int id) async {
    await _todoService.deleteTodoByIdCate(id);
  }

  _showFormDialog(BuildContext context, Category category) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (param) {
          if (category != null) {
            _titleCateEditingController.text = category.title;
            _desCateEditingController.text = category.description;
          }
          return AlertDialog(
            title: Text("Category form"),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _titleCateEditingController,
                    decoration: InputDecoration(
                      labelText: "Category Name",
                      hintText: "Write category name!",
                    ),
                  ),
                  TextField(
                    controller: _desCateEditingController,
                    decoration: InputDecoration(
                      labelText: "Category Description",
                      hintText: "Write category description!",
                    ),
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.check_circle,
                  color: Colors.green,
                  size: 30,
                ),
                onPressed: () {
                  if (category != null) {
                    setState(() async {
                      category.title = _titleCateEditingController.text;
                      category.description = _desCateEditingController.text;
                      var result =
                          await _categories_service.updateCategory(category);
                      _modelCat.clear();
                      _getAllCategories();
                      print(100);
                      print(result);
                      _titleCateEditingController.clear();
                      _desCateEditingController.clear();
                      Navigator.pop(context);
                    });
                  } else {
                    setState(() async {
                      _category.title = _titleCateEditingController.text;
                      _category.description = _desCateEditingController.text;
                      var result =
                          await _categories_service.saveCategory(_category);
                      _modelCat.clear();
                      _getAllCategories();
                      print(100);
                      print(result);
                      _titleCateEditingController.clear();
                      _desCateEditingController.clear();
                      Navigator.pop(context);
                    });
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.close, color: Colors.red, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _categoriesScaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarCustom(
          openDrawer: () {
            Navigator.pop(context);
          },
          title: "Categories",
        ),
      ),
      body: Container(
          // color: Colors.black12,
          child: ListView(
              scrollDirection: Axis.vertical,
              children: List.generate(_modelCat.length, (index) {
                return Column(
                  children: <Widget>[
                    Card(
                      child: ListTile(
                        leading: Text(_modelCat[index].id.toString()),
                        title: Text(_modelCat[index].title),
                        subtitle: Text(_modelCat[index].description),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            setState(() {
                              _deleteCategory(_modelCat[index].id);
                              _deleteTodoByIdCate(_modelCat[index].id);
                              _modelCat.clear();
                              _getAllCategories();
                            });
                          },
                        ),
                        onLongPress: () {
                          var cat = Category();
                          cat.id = _modelCat[index].id;
                          cat.title = _modelCat[index].title;
                          cat.description = _modelCat[index].description;
                          _showFormDialog(context, cat);
                        },
                        onTap: () {
                          var cat = Category();
                          cat.id = _modelCat[index].id;
                          cat.title = _modelCat[index].title;
                          cat.description = _modelCat[index].description;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TodoDetail(
                                        category: cat,
                                      )));
                        },
                      ),
                    )
                  ],
                );
              }))),
      drawer: DrawerNavigationCustom(
        heightSize: MediaQuery.of(context).size.height,
        currentWidget: CategoriesPage(),
        closeDrawer: () {
          _categoriesScaffoldKey.currentState.openEndDrawer();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context, null);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
