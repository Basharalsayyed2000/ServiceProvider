import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/Service.dart';
import 'package:service_provider/MyTools/Constant.dart';

class MyFavorateProviders extends StatefulWidget {
  static String id = "MyFavorateProviders";
  @override
  _MyFavorateProvidersState createState() => _MyFavorateProvidersState();
}

class _MyFavorateProvidersState extends State<MyFavorateProviders> {
  ServiceModel service;
  String uId = "";
  List<String> userFavorateProvider = [];
  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  _getUserId() async {
    String _userId = (await FirebaseAuth.instance.currentUser()).uid;
    setState(() {
      uId = _userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Favorate Providers"),
        backgroundColor: KprimaryColor,
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection(KUserCollection)
              .document(uId)
              .collection(KFavorateProviderListCollection)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return new Center(child: new CircularProgressIndicator());
            if (!snapshot.hasData) {
              return new CircularProgressIndicator();
            }
            List<String> providersId = [];
            for (var doc in snapshot.data.documents) {
            //  var data = doc.data;
              String providerId = doc.documentID.toString();
              providersId.add(providerId);
              //print(providerId);
            }
           
            return  (providersId.isNotEmpty)? ListView.builder(
              primary: false,
              itemBuilder: (context, index) => Stack(
                children: <Widget>[
                  StreamBuilder(
                      stream: Firestore.instance
                          .collection(
                              KProviderCollection) //document1[KFavorateProviderId]
                          .document(providersId[index]) //ID OF DOCUMENT
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return new Center(
                              child: new CircularProgressIndicator());
                        else if (!snapshot.hasData) {
                          return new CircularProgressIndicator();
                        }
                        var document2 = snapshot.data;
                        return buildCard(context, '${document2[KProviderName]}',
                            '${document2[KProviderImageUrl]}');
                      })
                ],
              ),
              itemCount: providersId.length,
            ):Center(child:Text("No Favorate Providers"));
          }),
    );
  }
}

Card buildCard(context, String title, String imageurl) {
  return Card(
    child: GestureDetector(
      onTap: () {},
      // Navigator.pushNamed(context, ServiceDetails.id, arguments: _provider),
      child: ListTile(
          title: Text(title),
          leading: CircleAvatar(
            backgroundImage: imageurl == ''
                ? AssetImage('Assets/images/provider.jpg')
                : NetworkImage(imageurl),
            radius: MediaQuery.of(context).size.height * 0.037,
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [],
          )),
    ),
  );
}

//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting)
//             return new Center(child: new CircularProgressIndicator());
//           else if (snapshot.hasData) {
//             var document1 = snapshot.data;
//               return StreamBuilder(
//                   stream: Firestore.instance
//                   .collection(KProviderCollection)
//                   .document(document1[KProviderId]) //ID OF DOCUMENT
//                   .snapshots(),
//                   builder: (context, snapshot) {
//                 if (!snapshot.hasData) {
//                    return new CircularProgressIndicator();
//                 }
//             var document2 = snapshot.data;
//             return ListView.builder(
//               primary: false,
//               itemBuilder: (context, index) => Stack(
//                 children: <Widget>[
//                   buildCard('${_providers[index].pName}', '${service.sName}',
//                       '${_providers[index].pImageUrl}', _providers[index]),
//                 ],
//               ),
//               itemCount: _providers.length,
//             );
//           } else {
//             return Center(
//               child: Text('no provider provide this service'),
//             );
//           }
//         },
//       ),

//  return StreamBuilder(
//                   stream: Firestore.instance
//                       .collection(KProviderCollection)//document1[KFavorateProviderId]
//                       .document(document1[KFavorateProviderId]) //ID OF DOCUMENT
//                       .snapshots(),
//                   builder: (context, snapshot) {
//                     if (snapshot.connectionState == ConnectionState.waiting)
//                       return new Center(child: new CircularProgressIndicator());
//                     else if (!snapshot.hasData) {
//                       return new CircularProgressIndicator();
//                     }
//                     else{
//                     var document2 = snapshot.data;
//                     return Text(
//                       "${document2[KProviderName]}",
//                       style: TextStyle(fontSize: 16, color: KprimaryColorDark),
//                     );
//                     }
//                   });
