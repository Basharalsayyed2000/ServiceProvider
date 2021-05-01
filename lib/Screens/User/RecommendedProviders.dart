import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/Service.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/User/ServiceRequest.dart';
import 'package:service_provider/Services/user.dart';

class Recommended extends StatefulWidget {
  static String id = 'Recommended';

  @override
  _RecommendedState createState() => _RecommendedState();
}

class _RecommendedState extends State<Recommended> {
  Service service;
  final _user= UserStore();
  @override
  Widget build(BuildContext context) {
    service = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        title: Text("Providers"),
        centerTitle: true,
      ),
      body:  StreamBuilder<QuerySnapshot>(
        stream: _user.loadProvider(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Providers> _providers = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              if(data[KServiceId]==service.sId){
              _providers.add(Providers(
               pName: data[KProviderName],
               pbirthDate: data[KProviderBirthDate],
               pAddDate: data[KProviderAddDate],
               pphoneNumber: data[KProviderPhoneNumber],
               pEmail: data[KProviderEmail],
               pPassword: data[KProviderPassword],
               pImageUrl: data[KProviderImageUrl],
               pId: data[KProviderId],
               pProvideService: data[KServiceId],
               pProviderDescription: data[KProviderDescription],
              ));
             }
            }
            return ListView.builder(
              primary: false,
              itemBuilder: (context, index) => Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, ServiceRequest.id,arguments: _providers[index]),
                    child: buildCard(//_providers[index].pName
                    '${_providers[index].pName}','${service.sName}'),
                    ),
                ],
              ),
              itemCount: _providers.length,
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


  // ListView(
  //       children: [
  //         buildCard("Said", "Plumber"),
  //         buildCard("Bashar", "Electrician"),
  //         buildCard("Bassam", "Carpenter"),
  //         buildCard("Ahmad", "Painter"),
  //         buildCard("Nour", "Conditioning"),
  //         buildCard("Wael", "Smith"),
  //         buildCard("Yehya", "Parcket"),
  //         buildCard("Said", "Plumber"),
  //         buildCard("Said", "Plumber"),
  //       ],
  //     ),
}
