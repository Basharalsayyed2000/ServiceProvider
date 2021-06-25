import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/Address.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/ProviderCardWidget.dart';
import 'package:service_provider/Services/auth.dart';

class MyFavorateProviders extends StatefulWidget {
  static String id = "MyFavorateProviders";
  final List<String> userFavorateProviderList;
  MyFavorateProviders({this.userFavorateProviderList});

  @override
  State<StatefulWidget> createState() {
    return _MyFavorateProvidersState(
        userFavorateProviderList: userFavorateProviderList);
  }
}

class _MyFavorateProvidersState extends State<MyFavorateProviders> {
  Auth auth = Auth();
  String uId = "";
  final List<String> userFavorateProviderList;
  _MyFavorateProvidersState({this.userFavorateProviderList});
  @override
  void initState() {
    super.initState();
    _getUserId();
  }

  _getUserId() async {
    auth.getCurrentUserId().then((value) {
      setState(() {
        uId = value;
      });
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
      body: (userFavorateProviderList!=null)
          ? StreamBuilder(
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
                  String providerId = doc.documentID.toString();
                  providersId.add(providerId);
                }

                return (providersId.isNotEmpty)
                    ? ListView.builder(
                        primary: false,
                        itemBuilder: (context, index) => Stack(
                          children: <Widget>[
                            StreamBuilder(
                                stream: Firestore.instance
                                    .collection(
                                        KProviderCollection) //document1[KFavorateProviderId]
                                    .document(
                                        providersId[index]) //ID OF DOCUMENT
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting)
                                    return new Center(
                                        child: new CircularProgressIndicator());
                                  else if (!snapshot.hasData) {
                                    return new CircularProgressIndicator();
                                  }
                                  var document1 = snapshot.data;

                                  ProviderModel providerModel =
                                      new ProviderModel(
                                    pName: document1[KProviderName],
                                    pAddDate: document1[KProviderAddDate],
                                    pphoneNumber:
                                        document1[KProviderPhoneNumber],
                                    pEmail: document1[KProviderEmail],
                                    pPassword: document1[KProviderPassword],
                                    pImageUrl: document1[KProviderImageUrl],
                                    pId: document1[KProviderId],
                                    pProvideService: document1[KServiceId],
                                    isAdmin: document1[KProviderIsAdmin],
                                    isvarified: document1[KProviderIsVerified],
                                    rate: document1[KProviderTotalRate],
                                    isMale: document1[KProviderIsMale],
                                    numberOfRequestRated: document1[
                                        KProviderNumberOfRatedRequest],
                                    pProviderDescription:
                                        document1[KProviderDescription],
                                    price: document1[KProviderPrice],
                                    certificateImages: List.from(
                                        document1[KImageCartificateUrlList]),
                                    locationId: document1[KProviderLocationId],
                                    myFavorateList:
                                        (document1[KMyFavorateList] == null)
                                            ? []
                                            : List.from(
                                                document1[KMyFavorateList]),
                                  );

                                  return StreamBuilder(
                                      stream: Firestore.instance
                                      .collection(KLocationCollection)
                                      .document(providerModel
                                          .locationId) //ID OF DOCUMENT
                                      .snapshots(),
                                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) { 
                                          if (snapshot.connectionState ==
                                        ConnectionState.waiting)
                                      return new Center(
                                          child:
                                              new CircularProgressIndicator());
                                    if (!snapshot.hasData) {
                                      return new Center(
                                          child:
                                              new CircularProgressIndicator());
                                    }
                                    else{
                                       var document2 = snapshot.data;
                                      AddressModel addressModel = AddressModel(
                                        latitude: document2[KLocationLatitude],
                                        longgitude:
                                            document2[KLocationlonggitude],
                                        country: document2[KLocationCountry],
                                        city: document2[KLocationCity],
                                        street: document2[KLocationStreet],
                                      );
                                      return ProviderCard(
                                        providerModel: providerModel,
                                        uId: uId,
                                        address: addressModel,
                                        userFavorateProviderList:
                                            userFavorateProviderList,
                                        fromSearch: false, 
                                        fromForword: false,   
                                      );
                                    }
                                      },
                                     
                                  );
                                })
                          ],
                        ),
                        itemCount: providersId.length,
                      )
                    : Center(child: Text("No Favorate Providers"));
              })
          : Center(child: Text("No Favorate Providers")),
    );
  }
}


