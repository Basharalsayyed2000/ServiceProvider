import 'package:flutter/material.dart';

import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/User/ServiceRequest.dart';

class Recommended extends StatefulWidget {
  static String id = 'Recommended';

  @override
  _RecommendedState createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        title: Text("Providers"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          buildCard("Said", "Plumber"),
          buildCard("Bashar", "Electrician"),
          buildCard("Bassam", "Carpenter"),
          buildCard("Ahmad", "Painter"),
          buildCard("Nour", "Conditioning"),
          buildCard("Wael", "Smith"),
          buildCard("Yehya", "Parcket"),
          buildCard("Said", "Plumber"),
          buildCard("Said", "Plumber"),
        ],
      ),
    );
  }

  Card buildCard(String title, String subtitle) {
    return Card(
      child: GestureDetector(
            onTap: () => Navigator.pushNamed(context, ServiceRequest.id),
              child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            leading: Image.asset("Assets/images/noprofile.png"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.phone),
                PopupMenuButton<String>(
                  onSelected: handleClick2,
                  itemBuilder: (BuildContext context) {
                    return {'Edit', 'Settings'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            )),
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
