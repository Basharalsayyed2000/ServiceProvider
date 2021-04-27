import 'package:flutter/material.dart';

import 'package:service_provider/MyTools/Constant.dart';

class MyBooks extends StatefulWidget {
  static String id = 'MyBooks';

  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        title: Text("My Book"),
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
