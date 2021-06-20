import 'package:flutter/material.dart';
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
  final List<String> userFavorateProviderList;
  ProviderCard({this.providerModel, this.uId, this.address,this.userFavorateProviderList});

  @override
  State<StatefulWidget> createState() {
    return _ProviderCard(
        providerModel: providerModel,
        uId: uId, 
        address: address,
        userFavorateProviderList: userFavorateProviderList);
  }
}

class _ProviderCard extends State<ProviderCard> {
  final ProviderModel providerModel;
  Store store = new Store();
  final String uId;
  UserStore userStore = new UserStore();
  final AddressModel address;
  final List<String> userFavorateProviderList;

  _ProviderCard({this.providerModel, this.uId, this.address,this.userFavorateProviderList});
   
  @override
  void initState() {
     
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
                    fontSize: 17,
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
                color: KsecondaryColor,
              ),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
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
                      showDialog(
                          context: context,
                          builder: (context) {
                            return MapDialog();
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
            ),
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
                    "${providerModel.rate}",
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
                    )
                ),
          );
        },
      ),
    );
  }
}
