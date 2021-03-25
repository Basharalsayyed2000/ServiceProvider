import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  static final route = '/home';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.open_with),
            onPressed: (){},
          ),
         
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Text(
              'Hello Besho',
              // ignore: deprecated_member_use
              style: Theme.of(context).textTheme.headline,
            ),
          
          ],
        ),
      ),
    );
  }
}

