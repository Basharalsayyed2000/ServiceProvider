import 'package:flutter/material.dart';

class RequestComponent extends StatefulWidget {
  static String id='RequestComponent';
  @override
  _RequestComponentState createState() => _RequestComponentState();
}

class _RequestComponentState extends State<RequestComponent> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text('Welcome in details'),
      ),
    );
  }
}