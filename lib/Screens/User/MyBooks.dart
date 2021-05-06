import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/Request/RequestComponent.dart';
import 'package:service_provider/Services/auth.dart';
import 'package:service_provider/Services/store.dart';

class MyBooks extends StatefulWidget {
  static String id = 'MyBooks';

  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  final _store = Store();
  final _auth =Auth();
  String _userId;
  @override
  void initState() {
    super.initState();
    _getUserId();
  }
    _getUserId()async{
      String value=await _auth.getCurrentUserId();
      setState(() {
        _userId=value;
      });
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        title: Text("My Book"),
        centerTitle: true,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadRequest(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<RequestModel> _requests = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              String requestId=doc.documentID;
               if(data[KRequestUserId]==_userId){
              _requests.add(RequestModel(
                rProblem: data[KRequestProblem],
                rDescription: data[KRequestDescription],
                rAddDate: data[KRequestAddDate],
                requestDate: data[KRequestDate],
                 requestTime: data[KRequestTime],
                requestId: requestId,
                providerId: data[KRequestProviderId],
                userId: _userId,
                isAccepted: data[KRequestIsAccepted],
                isActive: data[KRequestIsActive],
                isComplete: data[KRequestIsCompleted],
              ));
              }
            }
            return  ListView.builder(
              primary: false,
              itemBuilder: (context, index) => Stack(
                children: <Widget>[
                  buildCard('${_requests[index].providerId}', '${_requests[index].userId}',
                       _requests[index]),
                ],
              ),
              itemCount: _requests.length,
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

 Card buildCard(
      String title, String subtitle,RequestModel _request) {
    return Card(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, RequestComponent.id,
            arguments: _request),
        child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            leading: CircleAvatar(
              backgroundImage:
                  AssetImage('Assets/images/provider.jpg'),
                 
              radius: MediaQuery.of(context).size.height * 0.037,
            ),
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
