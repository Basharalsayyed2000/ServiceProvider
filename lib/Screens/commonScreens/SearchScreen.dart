import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/ProviderCardWidget.dart';
import 'package:service_provider/Services/UserStore.dart';

class SearchPage extends StatefulWidget {
  static String id = "SearchPage";
  final String uid;
  final List<String> userFavorateProviders;
  SearchPage({
    this.uid,
    this.userFavorateProviders,
  });

  @override
  _SearchPageState createState() =>
      _SearchPageState(userFavorateProviders: userFavorateProviders, uid: uid);
}

class _SearchPageState extends State<SearchPage> {
  var queryResultSet = [];
  List<ProviderModel> tempSearchStore = [];
  UserStore userStore = new UserStore();
  final String uid;
  final List<String> userFavorateProviders;
  _SearchPageState({
    this.uid,
    this.userFavorateProviders,
  });

  initiateSearch(String value) {
    if (value.length == 0) {
      setState(() {
        queryResultSet = [];
        tempSearchStore = [];
      });
    }
    //
    if (queryResultSet.length == 0 && value.length == 1) {
      userStore.searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.documents.length; ++i) {
          queryResultSet.add(docs.documents[i].data);
          ProviderModel p1 = ProviderModel(
            pName: docs.documents[i].data[KProviderName],
            pAddDate: docs.documents[i].data[KProviderAddDate],
            pphoneNumber: docs.documents[i].data[KProviderPhoneNumber],
            pEmail: docs.documents[i].data[KProviderEmail],
            pPassword: docs.documents[i].data[KProviderPassword],
            pImageUrl: docs.documents[i].data[KProviderImageUrl],
            pId: docs.documents[i].data[KProviderId],
            pProvideService: docs.documents[i].data[KServiceId],
            isAdmin: docs.documents[i].data[KProviderIsAdmin],
            isvarified: docs.documents[i].data[KProviderIsVerified],
            rate: docs.documents[i].data[KProviderTotalRate],
            isMale: docs.documents[i].data[KProviderIsMale],
            numberOfRequestRated:
                docs.documents[i].data[KProviderNumberOfRatedRequest],
            pProviderDescription: docs.documents[i].data[KProviderDescription],
            price: docs.documents[i].data[KProviderPrice],
            country: docs.documents[i].data[KproviderCountry],
            certificateImages:
                List.from(docs.documents[i].data[KImageCartificateUrlList]),
            locationId: docs.documents[i].data[KProviderLocationId],
            myFavorateList: (docs.documents[i].data[KMyFavorateList] == null)
                ? []
                : List.from(docs.documents[i].data[KMyFavorateList]),
          );
          setState(() {
            tempSearchStore.add(p1);
          });
        }
      });
    } else {
      setState(() {
        tempSearchStore = [];
      });
      queryResultSet.forEach((element) {
        if (element[KProviderName]
                .toLowerCase()
                .contains(value.toLowerCase()) ==
            true) {
          if (element[KProviderName]
                  .toLowerCase()
                  .indexOf(value.toLowerCase()) ==
              0) {
            ProviderModel p1 = ProviderModel(
              pName: element[KProviderName],
              pAddDate: element[KProviderAddDate],
              pphoneNumber: element[KProviderPhoneNumber],
              pEmail: element[KProviderEmail],
              pPassword: element[KProviderPassword],
              pImageUrl: element[KProviderImageUrl],
              pId: element[KProviderId],
              pProvideService: element[KServiceId],
              isAdmin: element[KProviderIsAdmin],
              isvarified: element[KProviderIsVerified],
              rate: element[KProviderTotalRate],
              isMale: element[KProviderIsMale],
              numberOfRequestRated: element[KProviderNumberOfRatedRequest],
              pProviderDescription: element[KProviderDescription],
              price: element[KProviderPrice],
              country: element[KproviderCountry],
              certificateImages: List.from(element[KImageCartificateUrlList]),
              locationId: element[KProviderLocationId],
              myFavorateList: (element[KMyFavorateList] == null)
                  ? []
                  : List.from(element[KMyFavorateList]),
            );
            setState(() {
              tempSearchStore.add(p1);
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: Text('Search providers'),
          centerTitle: true,
          backgroundColor: KprimaryColor,
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (val) {
                initiateSearch(val);
              },
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 25.0),
                  hintText: 'Search by name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4.0))),
            ),
          ),
          SizedBox(height: 12.0),
          (tempSearchStore.isNotEmpty)
              ? Expanded(
                  child: ListView.separated(
                    itemCount: tempSearchStore.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: ProviderCard(
                          providerModel: tempSearchStore[index],
                          fromSearch: true,
                          uId: uid,
                          fromForword: false,
                          userFavorateProviderList: userFavorateProviders,
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: KprimaryColorDark,
                        indent: 10,
                        endIndent: 10,
                        height: 15,
                      );
                    },
                  ),
                )
              : Container(
                  child: Text("EMPTY"),
                )
        ]));
  }
}
