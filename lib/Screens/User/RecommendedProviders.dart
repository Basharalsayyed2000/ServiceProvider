import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/NeededData.dart';
import 'package:service_provider/Models/Service.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/Screens/Request/ServiceRequest.dart';
import 'package:service_provider/Screens/User/ServiceDetails.dart';
import 'package:service_provider/Services/UserStore.dart';

class RecommendedProviders extends StatefulWidget {
  static String id = 'Recommended';

  @override
  _RecommendedProvidersState createState() => _RecommendedProvidersState();
}

class _RecommendedProvidersState extends State<RecommendedProviders> {
  ServiceModel service;
  final _user = UserStore();
  String uId = "";
  List<String> userFavorateProvider = [];
  @override
  void initState() {
    getcurrentid();
    super.initState();
  }

  void getcurrentid() async {
    String _userId = (await FirebaseAuth.instance.currentUser()).uid;
    setState(() {
      uId = _userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    service = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        title: Text("Providers"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _user.loadProvider(),
        // ignore: missing_return
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
            return (_providers.isNotEmpty)? Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    primary: false,
                    itemBuilder: (context, index) => Stack(
                      children: <Widget>[
                        buildCard(
                            '${_providers[index].pName}',
                            '${service.sName}',
                            '${_providers[index].pImageUrl}',
                            _providers[index]),
                      ],
                    ),
                    itemCount: _providers.length,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom:Kminimumpadding * 8),
                      child: CustomButton(
                        onPressed: () {
                          Navigator.pushNamed(
                          context, ServiceRequest.id,
                          arguments: NeededData(serviceRequestId: service.sId,isRequestActive: true,isRequestPublic: true)
                          );
                        },
                        textValue: "public Now",
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                     Container(
                      margin: EdgeInsets.only(bottom:Kminimumpadding * 8),
                       child: CustomButton(
                        onPressed: () {
                          Navigator.pushNamed(
                          context, ServiceRequest.id,
                          arguments: NeededData(serviceRequestId: service.sId,isRequestActive: false,isRequestPublic: true)
                          );
                        },
                        textValue: "public Later",
                    ),
                     ),
                  ],
                ),
              ],
            ):Center(
              child: Text("No Provider provide this service"),
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
            // subtitle: Text(subtitle),
            subtitle: Row(children: [
              Icon(Icons.star, size: 30, color: Colors.yellow),
              Icon(Icons.star, size: 30, color: Colors.yellow),
              Icon(Icons.star, size: 30, color: Colors.yellow),
              Icon(Icons.star, size: 30, color: Colors.yellow),
              Icon(Icons.star, size: 30, color: Colors.yellow),
            ]),
            leading: CircleAvatar(
              backgroundImage: imageurl == ''
                  ? AssetImage('Assets/images/provider.jpg')
                  : NetworkImage(imageurl),
              radius: MediaQuery.of(context).size.height * 0.037,
            ),
            trailing: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.favorite,
                          size: 32,
                          color: (_provider.myFavorateList.contains(uId))
                              ? Colors.red
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
                          await _user.updatefavorateList(
                              _provider.myFavorateList, _provider.pId);
                          // await _user.updateFvorateUser(uId, userFavorateProvider);
                        }),
                  ],
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
