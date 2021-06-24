
import 'package:cloud_firestore/cloud_firestore.dart';

class ProviderModel{
String pName,pImageUrl, pphoneNumber,pProvideService,pProviderDescription,pEmail,pPassword,pId,locationId,country;
int price,numberOfRequestRated;
double rate;
Timestamp pAddDate;
bool isAdmin,isvarified,isMale;
List<String> certificateImages,myFavorateList;
ProviderModel(
      {
      this.pName,
      this.pAddDate,
      this.pImageUrl,
      this.pphoneNumber,
      this.isAdmin,
      this.pProvideService,
      this.pProviderDescription,
      this.pEmail,
      this.pPassword,
      this.pId,
      this.locationId,
      this.certificateImages,
      this.myFavorateList,
      this.rate,
      this.isvarified,
      this.numberOfRequestRated,
      this.isMale,
      this.price,
      this.country
      });
}