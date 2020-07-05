import 'package:flutter/material.dart';
import 'package:todolist_sqflite/src/components/widgets/appbar.dart';
import 'package:todolist_sqflite/src/components/widgets/drawer_navigation.dart';
// import 'package:todolist_sqflite/src/components/widgets/statusbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _homeScaffoldKey = new GlobalKey<ScaffoldState>();
  
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children:<Widget> [
          Align(
            child: Scaffold(
              key: _homeScaffoldKey,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: AppBarCustom(
                  openDrawer: (){
                    _homeScaffoldKey.currentState.openDrawer();
                  },
                  title: "Home Page", 
                ),
              ),
              body: Center(
                child: Text("Home Page"),
              ),
              drawer: DrawerNavigationCustom(
                heightSize: MediaQuery.of(context).size.height, 
                currentWidget: HomePage(),
                closeDrawer: (){
                  _homeScaffoldKey.currentState.openEndDrawer();
                },
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.topCenter,
          //   child: StatusBarCustom(),
          // ),
        ],
      ),
    );
  }
}