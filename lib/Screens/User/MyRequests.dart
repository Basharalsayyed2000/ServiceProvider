import 'package:flutter/material.dart';

import 'package:service_provider/MyTools/Constant.dart';

class MyRequests extends StatefulWidget {
  static String id = 'MyRequests';

  @override
  _MyRequestsState createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        title: Text("My Request"),
        centerTitle: true,
      ),
      body: Column(
         children: [
           Text('There is no request'),
         ],
      ),
    );
  }

 

  void handleClick2(String value) {
    switch (value) {
      case 'Edit':
        break;
      case 'Settings':
        break;
    }
  }
}
