import 'package:flutter/material.dart';

class AppBarCustom extends StatefulWidget {
  final String title;
  final Function openDrawer;

  const AppBarCustom({Key key, this.title, this.openDrawer}) : super(key: key);
  
  @override
  _AppBarCustomState createState() => _AppBarCustomState();
}

class _AppBarCustomState extends State<AppBarCustom> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: widget.title == "Home Page" ? Icon(Icons.menu) : Icon(Icons.arrow_back),
        onPressed: (){
          widget.openDrawer();
        },
      ),
      centerTitle: true,
      title: Text(widget.title==null? "Title Page" : widget.title),
      
    );
  }
}