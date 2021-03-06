import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service_provider/Models/Address.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/MapDialog.dart';
import 'package:service_provider/Screens/User/ServiceDetails.dart';
import 'package:service_provider/Services/UserStore.dart';
import 'package:service_provider/Services/store.dart';

class ProviderCard extends StatefulWidget {
  final ProviderModel providerModel;
  final String uId;
  final AddressModel address;
  final bool fromSearch;
  final String rid;
  final bool fromForword;
  final List<String> userFavorateProviderList;
  ProviderCard({this.fromForword,this.rid,this.providerModel, this.uId, this.address,this.userFavorateProviderList,this.fromSearch});

  @override
  State<StatefulWidget> createState() {
    return _ProviderCard(
        providerModel: providerModel,
        uId: uId, 
        address: address,
        userFavorateProviderList: userFavorateProviderList,
        fromSearch:fromSearch,
        rid: rid,
        fromForword: fromForword
        );
  }
}

class _ProviderCard extends State<ProviderCard> {
  final ProviderModel providerModel;
  Store store = new Store();
  final String uId;
  final bool fromForword;
  UserStore userStore = new UserStore();
  final AddressModel address;
  final List<String> userFavorateProviderList;
  final bool fromSearch;
  final String rid;
  double ratecalc;
  _ProviderCard({this.fromForword,this.rid,this.providerModel, this.uId, this.address,this.userFavorateProviderList,this.fromSearch});
   
  @override
  void initState() {
   
    ratecalc=this.providerModel.rate/this.providerModel.numberOfRequestRated;
    super.initState();
  } 

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: KsecondaryColor.withOpacity(.755),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: (providerModel.pImageUrl != null)
                ? NetworkImage(providerModel.pImageUrl)
                : AssetImage("Assets/images/noprofile.png"),
            radius: 26,
          ),
          radius: 28,
        ),
        title: Container(
          margin: EdgeInsets.only(top: 10, bottom: 3),
          child: Row(
            children: [
              (providerModel.isvarified)
                  ? Icon(
                      Icons.verified_outlined,
                      color: Colors.blue,
                    )
                  : Container(),
              Text(
                (providerModel.isvarified)
                    ? " " + providerModel.pName
                    : providerModel.pName,
                style: TextStyle(
                    fontSize:(fromSearch)? 14:17,
                    color: KprimaryColorDark,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                width: 2,
              ),
              Icon(
                (providerModel.isMale)
                    ? Icons.male_rounded
                    : Icons.female_rounded,
                color: (providerModel.isMale)? Colors.blueAccent : Colors.purpleAccent,
              ),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (!fromSearch)?Container(
              margin: EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.location_on,
                      color: KsecondaryColor,
                      size: 16,
                    ),
                    onTap: () {
                      Set<Marker> _markers = {};
                        _markers.add(Marker(
                          markerId: MarkerId(
                              providerModel.pId),
                          position: LatLng(address.latitude,
                              address.longgitude),
                          icon: BitmapDescriptor
                              .defaultMarkerWithHue(200),
                          infoWindow: InfoWindow(
                              title: 
                                  providerModel.pName,
                              snippet: "???" +
                                  "${(ratecalc.toString().length > 3)? ratecalc.toString().substring(0, 4) : ratecalc}",   
                              onTap: () {
                              },        
                            ), 
                        ));
                      showDialog(
                          context: context,
                          builder: (context) {
                            return MapDialog(hasAppBar: false,edit: false,markers: _markers,);
                          });
                    },
                  ),
                  Text(
                    "\t ${address.country} , ${address.city}",
                    style: TextStyle(
                        color: KprimaryColorDark, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ):Container(),
            Container(
              margin: EdgeInsets.only(top: 4),
              child: Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20,
                  ),
                  Text(
                    "${(ratecalc.toString().length > 3)? ratecalc.toString().substring(0, 4) : ratecalc}",
                    style: TextStyle(fontSize: 13, color: KprimaryColorDark),
                  ),
                  SizedBox(
                    width: 9,
                  ),
                  Icon(
                    Icons.money_rounded,
                    color: Colors.green,
                    size: 20,
                  ),
                  SizedBox(
                    width: 2,
                  ),
                  Text(
                    "${providerModel.price}\$",
                    style: TextStyle(fontSize: 13, color: KprimaryColorDark),
                  ),
                ],
              ),
            ),
          ],
        ),
        hoverColor: Colors.grey[300],
        trailing: IconButton(
            icon: Icon(
              Icons.favorite,
              size: 32,
              color: (providerModel.myFavorateList.contains(uId))
                  ? Colors.red
                  : Colors.grey,
            ),
            onPressed: () async {
              if (providerModel.myFavorateList.contains(uId)) {
                setState(() {
                  providerModel.myFavorateList.remove(uId);
                  userFavorateProviderList.remove(providerModel.pId);
                  userStore.deleteFavorateProvider(providerModel.pId, uId);
                });
              } else {
                setState(() {
                  providerModel.myFavorateList.add(uId);
                  userFavorateProviderList.add(providerModel.pId);
                  userStore.addFavorateProvider(providerModel.pId, uId);
                });
              }
              await userStore.updatefavorateList(
                  providerModel.myFavorateList, providerModel.pId);
              await userStore.updateFvorateUser(uId, userFavorateProviderList);
            }),

        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ServiceDetails(
                      providerModel:providerModel,  
                       rid: rid,
                      fromForword: fromForword,
                      fromSearch: fromSearch,
                      address: address,
                    )
                ),
          );
        },
      ),
    );
  }
}
