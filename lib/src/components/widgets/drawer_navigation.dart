import 'package:flutter/material.dart';
import 'package:todolist_sqflite/src/screens/Categories/categories_page.dart';
import 'package:todolist_sqflite/src/screens/Home/home_page.dart';

class DrawerNavigationCustom extends StatefulWidget {
  final double heightSize;
  final Widget currentWidget;
  final Function closeDrawer;

  const DrawerNavigationCustom({Key key, this.heightSize, this.currentWidget, this.closeDrawer}) : super(key: key);
  @override
  _DrawerNavigationCustomState createState() => _DrawerNavigationCustomState();
}

class _DrawerNavigationCustomState extends State<DrawerNavigationCustom> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        semanticLabel: "semantic Label",
        child: ListView(
          children: <Widget>[
            Container(
              height: widget.heightSize/4,
              child: ListView(
                children:<Widget> [
                  Container(
                    height: (widget.heightSize/4)/2,
                    color: Colors.blue,
                    child: Center(
                      child: GestureDetector(
                        child: CircleAvatar(
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: (widget.heightSize/4)/4,
                    child: Text(
                      "KNkai", 
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    height: (widget.heightSize/4)/4,
                    child: Text(
                      "phuochai0168@gmail.com",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              child: ListTile(
                title: Text("Home",),
                leading: Icon(Icons.home),
                onTap: (){
                  if(widget.currentWidget.toString() != "HomePage"){
                    Navigator.of(context).push(new MaterialPageRoute(builder: (context) => HomePage()));
                  } 
                  widget.closeDrawer();
                },
              ),
            ),
            Divider(thickness: 1,),
            Container(
              height: 50,
              child: ListTile(
                title: Text("Categories",),
                leading: Icon(Icons.list),
                onTap: (){
                  if(widget.currentWidget.toString() != "CategoriesPage"){
                    widget.closeDrawer();
                    Navigator.of(context).push(new MaterialPageRoute(builder: (context) => CategoriesPage()));
                  }
                  widget.closeDrawer();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}