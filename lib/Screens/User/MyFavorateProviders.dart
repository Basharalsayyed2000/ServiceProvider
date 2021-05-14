import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/Service.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/User/ServiceDetails.dart';
import 'package:service_provider/Services/UserStore.dart';
import 'package:service_provider/Services/auth.dart';

class MyFavorateProviders extends StatefulWidget {
  static String id = "MyFavorateProviders";
  @override
  _MyFavorateProvidersState createState() => _MyFavorateProvidersState();
}

class _MyFavorateProvidersState extends State<MyFavorateProviders> {
  String _userId;
  Auth _auth = Auth();
  ServiceModel service;
  final _user = UserStore();
  String uId = "";
  List<String> userFavorateProvider = [];
  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  _getUserId() async {
    String value = await _auth.getCurrentUserId();
    setState(() {
      _userId = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Favorate"),
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
          if (snapshot.hasData) {
            List<ProviderModel> _providers = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              if (data[KServiceId] == service.sId) {
                _providers.add(ProviderModel(
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
                  certificateImages: List.from(data[KImageCartificateUrlList]),
                  locationId: data[KProviderLocationId],
                  myFavorateList: (data[KMyFavorateList] == null)
                      ? []
                      : List.from(data[KMyFavorateList]),
                ));
              }
            }
            return ListView.builder(
              primary: false,
              itemBuilder: (context, index) => Stack(
                children: <Widget>[
                  buildCard('${_providers[index].pName}', '${service.sName}',
                      '${_providers[index].pImageUrl}', _providers[index]),
                ],
              ),
              itemCount: _providers.length,
            );
          } else {
            return Center(
              child: Text('no provider provide this service'),
            );
          }
        },
      ),
    );
  }

  Card buildCard(
      String title, String subtitle, String imageurl, ProviderModel _provider) {
    return Card(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, ServiceDetails.id,
            arguments: _provider),
        child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            leading: CircleAvatar(
              backgroundImage: imageurl == ''
                  ? AssetImage('Assets/images/provider.jpg')
                  : NetworkImage(imageurl),
              radius: MediaQuery.of(context).size.height * 0.037,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.star,
                      size: 32,
                      color: (_provider.myFavorateList.contains(uId))
                          ? Colors.yellow
                          : Colors.grey,
                    ),
                    onPressed: () async {
                      if (_provider.myFavorateList.contains(uId)) {
                        setState(() {
                          _provider.myFavorateList.remove(uId);
                          //userFavorateProvider.remove(_provider.pId);
                          _user.deleteFavorateProvider(_provider.pId, uId);
                        });
                      } else {
                        setState(() {
                          _provider.myFavorateList.add(uId);
                          //userFavorateProvider.add(_provider.pId);
                          _user.addFavorateProvider(_provider.pId, uId);
                        });
                      }
                      await _user.updateProvider(_provider, _provider.pId);
                      // await _user.updateFvorateUser(uId, userFavorateProvider);
                    }),
              ],
            )),
      ),
    );
  }
}
