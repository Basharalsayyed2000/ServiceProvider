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
  String _userId;
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
              .document(_userId)
              .collection(KFavorateProviderListCollection)
              .document()
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return new Center(child: new CircularProgressIndicator());
            else if (!snapshot.hasData) {
              return new CircularProgressIndicator();
            } else {
              var document1 = snapshot.data;
              return StreamBuilder(
                  stream: Firestore.instance
                      .collection(KProviderCollection)//document1[KFavorateProviderId]
                      .document() //ID OF DOCUMENT
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return new Center(child: new CircularProgressIndicator());
                    if (!snapshot.hasData) {
                      return new CircularProgressIndicator();
                    }
                    var document2 = snapshot.data;
                    return Text(
                      "${document2[KProviderName]}",
                      style: TextStyle(fontSize: 16, color: KprimaryColorDark),
                    );
                  });
            }
          }),
    );
  }
}

//   Card buildCard(
//       String title, String subtitle, String imageurl, ProviderModel _provider) {
//     return Card(
//       child: GestureDetector(
//         onTap: () => Navigator.pushNamed(context, ServiceDetails.id,
//             arguments: _provider),
//         child: ListTile(
//             title: Text(title),
//             subtitle: Text(subtitle),
//             leading: CircleAvatar(
//               backgroundImage: imageurl == ''
//                   ? AssetImage('Assets/images/provider.jpg')
//                   : NetworkImage(imageurl),
//               radius: MediaQuery.of(context).size.height * 0.037,
//             ),
//             trailing: Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                     icon: Icon(
//                       Icons.star,
//                       size: 32,
//                       color: (_provider.myFavorateList.contains(uId))
//                           ? Colors.yellow
//                           : Colors.grey,
//                     ),
//                     onPressed: () async {
//                       if (_provider.myFavorateList.contains(uId)) {
//                         setState(() {
//                           _provider.myFavorateList.remove(uId);
//                           //userFavorateProvider.remove(_provider.pId);
//                           _user.deleteFavorateProvider(_provider.pId, uId);
//                         });
//                       } else {
//                         setState(() {
//                           _provider.myFavorateList.add(uId);
//                           //userFavorateProvider.add(_provider.pId);
//                           _user.addFavorateProvider(_provider.pId, uId);
//                         });
//                       }
//                       await _user.updatefavorateList(
//                           _provider.myFavorateList, _provider.pId);
//                       // await _user.updateFvorateUser(uId, userFavorateProvider);
//                     }),
//               ],
//             )),
//       ),
//     );
//   }
// }

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
