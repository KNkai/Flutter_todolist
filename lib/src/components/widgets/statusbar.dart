import 'package:flutter/material.dart';

class StatusBarCustom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Icon(Icons.wifi, size: 15,)
          ),
          Expanded(
            flex: 2,
            child: Center(child: Text("12:00:00"))
          ),
          Expanded(
            flex: 1,
            child: Icon(Icons.battery_std, size: 15,)
          ),
        ],
      ),
    );
  }
}