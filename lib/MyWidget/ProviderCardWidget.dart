import 'package:flutter/material.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/User/ServiceDetails.dart';
import 'package:service_provider/Services/UserStore.dart';
import 'package:service_provider/Services/store.dart';

class ProviderCard extends StatefulWidget {
  final ProviderModel providerModel;
  final String uId;
  ProviderCard({this.providerModel, this.uId});

  @override
  State<StatefulWidget> createState() {
    return _ProviderCard(providerModel: providerModel, uId: uId);
  }
}

class _ProviderCard extends State<ProviderCard> {
  final ProviderModel providerModel;
  Store store = new Store();
  final String uId;
  UserStore userStore = new UserStore();
  _ProviderCard({this.providerModel, this.uId});

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
              (providerModel.isvarified)?Icon(
                Icons.verified_outlined,
                color: Colors.blue,
              ):Container(),
              Text(
                " " + providerModel.pName,
                style: TextStyle(
                    fontSize: 17,
                    color: KprimaryColorDark,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${providerModel.pEmail}",
              style: TextStyle(
                  color: KprimaryColorDark,
                  fontWeight: FontWeight.w500,
                  fontSize: 14),
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
                  //userFavorateProvider.remove(_provider.pId);
                  userStore.deleteFavorateProvider(providerModel.pId, uId);
                });
              } else {
                setState(() {
                  providerModel.myFavorateList.add(uId);
                  //userFavorateProvider.add(_provider.pId);
                  userStore.addFavorateProvider(providerModel.pId, uId);
                });
              }
              await userStore.updatefavorateList(
                  providerModel.myFavorateList, providerModel.pId);
              // await _user.updateFvorateUser(uId, userFavorateProvider);
            }),
        onTap: () {
          Navigator.pushNamed(context, ServiceDetails.id,
              arguments: providerModel);
        },
      ),
    );
  }
}
