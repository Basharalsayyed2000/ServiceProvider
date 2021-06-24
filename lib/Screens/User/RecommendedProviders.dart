import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service_provider/Models/Address.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/ProviderCardWidget.dart';
import 'package:service_provider/Screens/User/RecommendedProviderMap.dart';
import 'package:service_provider/Screens/User/ServiceDetails.dart';
import 'package:service_provider/Services/UserStore.dart';
import 'package:service_provider/Services/auth.dart';

class RecommendedProviders extends StatefulWidget {
  static String id = 'Recommended';
  final String serviceId;
  final List<String> userFavorateProviders;
  final bool showOnlyMyCountry;
  final String myCountry;
  final String rid;
  RecommendedProviders(
      {this.serviceId,
      this.userFavorateProviders,
      this.showOnlyMyCountry,
      this.rid,
      this.myCountry});
  @override
  _RecommendedProvidersState createState() => _RecommendedProvidersState(
      serviceId: serviceId,
      showOnlyMyCountry: showOnlyMyCountry,
      myCountry: myCountry,
      rid:rid,
      userFavorateProviders:
          (userFavorateProviders == null) ? [] : userFavorateProviders);
}

class _RecommendedProvidersState extends State<RecommendedProviders> {
  final String serviceId;
  Auth auth = new Auth();
  final List<String> userFavorateProviders;
  final bool showOnlyMyCountry;
  final String myCountry;
  Set<Marker> _markers = {};
  final _user = UserStore();
  String uId, _value, _acsValue;
  final String rid;
  bool hasSort, isGender, hasData;
  List<ProviderModel> _providers = [new ProviderModel()];
  _RecommendedProvidersState(
      {this.serviceId,
      this.userFavorateProviders,
      this.showOnlyMyCountry,
      this.rid,
      this.myCountry});

  @override
  void initState() {
    hasSort = false;
    isGender = false;
    hasData = true;
    getcurrentid();
    super.initState();
  }

  void getcurrentid() async {
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
          backgroundColor: KprimaryColor,
          title: Row(
            children: [
              Text("Providers"),
              SizedBox(
                width: 10,
              ),
              (hasSort)
                  ? DropdownButton<String>(
                      icon: Icon(Icons.sort),
                      value: _acsValue,
                      items: <DropdownMenuItem<String>>[
                        new DropdownMenuItem(
                          child: new Text((!isGender) ? 'Asc' : "fmal"),
                          value: 'Ascending',
                        ),
                        new DropdownMenuItem(
                            child: new Text((!isGender) ? 'Desc' : "male"),
                            value: 'Descending'),
                      ],
                      onChanged: (String value) {
                        setState(() => _acsValue = value);
                      },
                    )
                  : Container(),
              SizedBox(
                width: 5,
              ),
              (hasData)
                  ? DropdownButton<String>(
                      icon: Icon(Icons.sort),
                      value: _value,
                      items: <DropdownMenuItem<String>>[
                        new DropdownMenuItem(
                          child: new Text('Gender'),
                          value: 'Gender',
                        ),
                        new DropdownMenuItem(
                            child: new Text('Rating'), value: 'Rating'),
                        new DropdownMenuItem(
                            child: new Text('Added Date'), value: 'Added Date'),
                        new DropdownMenuItem(
                            child: new Text('A -> z'), value: 'A -> z'),
                        new DropdownMenuItem(
                            child: new Text('Verified'), value: 'Verified'),
                        new DropdownMenuItem(
                            child: new Text('Price'), value: 'Price'),
                      ],
                      onChanged: (String value) {
                        print(value);

                        setState(() {
                          if (value == "Rating" ||
                              value == "Added Date" ||
                              value == "A -> z" ||
                              value == "Price" ||
                              value == "Gender") {
                            if (value == "Gender") {
                              isGender = true;
                            } else {
                              isGender = false;
                            }
                            hasSort = true;
                          } else {
                            hasSort = false;
                          }
                          _value = value;
                        });
                      },
                    )
                  : Container(),
            ],
          ),
        ),

        // ignore: missing_return
        body: StreamBuilder<QuerySnapshot>(
          stream: _user.loadProvider(
              (_value == null)
                  ? ""
                  : (_value == "Rating")
                      ? KProviderTotalRate
                      : (_value == "Added Date")
                          ? KProviderAddDate
                          : (_value == "A -> z")
                              ? KProviderName
                              : (_value == "Price")
                                  ? KProviderPrice
                                  : (_value == "Verified")
                                      ? KProviderIsVerified
                                      : (_value == "Gender")
                                          ? KProviderIsMale
                                          : "",
              (_acsValue == null || _acsValue == "Ascending") ? true : false,
              (showOnlyMyCountry) ? myCountry : ""),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return new Center(child: new CircularProgressIndicator());
            if (snapshot.hasData) {
              _providers = [];
              for (var doc in snapshot.data.documents) {
                var data = doc.data;
                if (data[KServiceId] == serviceId) {
                  _providers.add(ProviderModel(
                    pName: data[KProviderName],
                    pAddDate: data[KProviderAddDate],
                    pphoneNumber: data[KProviderPhoneNumber],
                    pEmail: data[KProviderEmail],
                    pPassword: data[KProviderPassword],
                    pImageUrl: data[KProviderImageUrl],
                    pId: data[KProviderId],
                    pProvideService: data[KServiceId],
                    isAdmin: data[KProviderIsAdmin],
                    isvarified: data[KProviderIsVerified],
                    rate: data[KProviderTotalRate],
                    isMale: data[KProviderIsMale],
                    numberOfRequestRated: data[KProviderNumberOfRatedRequest],
                    pProviderDescription: data[KProviderDescription],
                    price: data[KProviderPrice],
                    country: data[KproviderCountry],
                    certificateImages:
                        List.from(data[KImageCartificateUrlList]),
                    locationId: data[KProviderLocationId],
                    myFavorateList: (data[KMyFavorateList] == null)
                        ? []
                        : List.from(data[KMyFavorateList]),
                  ));
                }
              }

              return (_providers.isNotEmpty)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              primary: false,
                              itemBuilder: (context, index) => StreamBuilder(
                                  stream: Firestore.instance
                                      .collection(KLocationCollection)
                                      .document(_providers
                                          .elementAt(index)
                                          .locationId) //ID OF DOCUMENT
                                      .snapshots(),
                                  // ignore: missing_return
                                  builder: (context, snapshot) {
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
                                    if (snapshot.hasData) {
                                      var document2 = snapshot.data;
                                      AddressModel addressModel = AddressModel(
                                        latitude: document2[KLocationLatitude],
                                        longgitude:
                                            document2[KLocationlonggitude],
                                        country: document2[KLocationCountry],
                                        city: document2[KLocationCity],
                                        street: document2[KLocationStreet],
                                      );
                                      _markers.add(Marker(
                                        markerId: MarkerId(
                                            _providers.elementAt(index).pId),
                                        position: LatLng(addressModel.latitude,
                                            addressModel.longgitude),
                                        icon: BitmapDescriptor
                                            .defaultMarkerWithHue(200),
                                        infoWindow: InfoWindow(
                                            title: _providers
                                                .elementAt(index)
                                                .pName,
                                            snippet: "⭐" +
                                                _providers
                                                    .elementAt(index)
                                                    .rate
                                                    .toString(),
                                                    
                                            onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ServiceDetails(
                                                      providerModel: _providers
                                                          .elementAt(index),
                                                         
                                                    )),
                                          );
                                        },        
                                                    ),
                                        
                                      ));
                                      return ProviderCard(
                                        providerModel: _providers[index],
                                        uId: uId,
                                        address: addressModel,
                                        userFavorateProviderList:
                                            userFavorateProviders,
                                            fromSearch: false,
                                         rid: rid,   
                                      );
                                    }
                                  }),
                              itemCount: _providers.length,
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return Divider(
                                  thickness: 1,
                                  // height: 1,
                                );
                              },
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    top: Kminimumpadding * 4,
                                    bottom: Kminimumpadding * 8),
                                width: 250,
                                child: CustomButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              RecommendedProvidersMap(
                                                  edit: false,
                                                  appBar: true,
                                                  serviceId: serviceId,
                                                  markers: _markers)),
                                    );
                                  },
                                  textValue: "Request By Map",
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  : Center(
                      child: Text(
                        "No Provider",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    );
            } else {
              return Center(
                child: Text('no provider provide this service'),
              );
            }
          },
        ));
  }
}
