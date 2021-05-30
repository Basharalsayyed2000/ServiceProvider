import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/SlidableTile.dart';
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
        elevation: 0,
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
              // ignore: deprecated_member_use
              
              if(data[KRequestUserId]==_userId){
                //List<dynamic> requestUrl=[];

               
              //  if(!(data[KRequestImageUrl]==null)){
              //  requestUrl= List.of(data[KRequestImageUrl]);
              // }
               


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
                rImageUrl:data[KRequestImageUrl]==null? []:data[KRequestImageUrl].map<String>((i)=> i as String).toList() ,
              ));
              }
            }
            var profile = "https://am3pap003files.storage.live.com/y4mo7WDu-vFo78fggCLw9NZxp02tlFBN9obvHx5qpT7f7PHWLo-x2Yz5lTI1550vW53xyuYyHEOEfctpjPI5IbYkGvfJKd1KhYHF8shP98AC_NdfOHLtYKlmQo37oXMgW-8CTskyEnYuU-3EjkY2peQ_FvkE_wkloeXkhTp1xynY4tDJqvl9ZeijER1B01oCtw31Mk8ggKyPL0Y5TZXSCH0pw/bashar.jpeg?psid=1&width=720&height=718";
            return  ListView.separated(
              primary: false,
              itemBuilder: (context, index) => Container(margin: EdgeInsets.only(top: (index == 0) ? 8 : 0), child: SlidableTile(profile: profile, user: "Bashar alsayyed Adnan", title: _requests.elementAt(index).rProblem, schedule: "${_requests.elementAt(index).requestDate.substring(0, 10)} ${_requests.elementAt(index).requestTime.substring(10, 16)}", distance: "${0.5+index}"),),
              itemCount: _requests.length, 
              separatorBuilder: (BuildContext context, int index) { 
                return Divider(
                  thickness: 1,
                  // height: 1,
                );
              },
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
