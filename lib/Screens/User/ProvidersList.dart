import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/Services.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Services/store.dart';

class ProvidersList extends StatefulWidget {
  @override
  _ProvidersListState createState() => _ProvidersListState();
}

class _ProvidersListState extends State<ProvidersList> {
  final _store = Store();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Providers"),
        backgroundColor: KprimaryColor,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadService(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Services> _services = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;

              _services.add(Services(
                sName: data[KServiceName],
                sDesc: data[KServiceDesc],
                sImageUrl: data[KServicesImageUrl],
                sAddDate: data[KServiceAddDate],
              ));
            }
            return GridView.builder(
              primary: false,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) => Stack(
                children: <Widget>[
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          _services[index].sImageUrl,
                          height: 130,
                        ),
                        Text(
                          _services[index].sName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              itemCount: _services.length,
            );
          } else {
            return Center(
              child: Text('Loading'),
            );
          }
        },
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }
}
