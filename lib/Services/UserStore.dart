import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/Models/user.dart';
import 'package:service_provider/MyTools/Constant.dart';

class UserStore {
  final Firestore _firestore = Firestore.instance;

  addUser(UserModel user, String uid) async {
    await _firestore.collection(KUserCollection).document(uid).setData({
      KUserName: user.uName,
      KUserAddDate: user.uAddDate,
      KUserImageUrl: user.uImageUrl,
      KUserIsAdmin: user.isAdmin,
      KUserEmail: user.uEmail,
      KUserPassword: user.uPassword,
      KUserId: user.uId,
      KUserShowOnlyMyCountryProvider: user.showOnlyProviderInMyCountry,
      KUserCountry:user.ucountry,
      KFavorateProviderList: user.favorateProvider
    });
  }

  userUpdateShowOnlyMyCountryProviders(bool value, String id) async {
    await _firestore
        .collection(KUserCollection)
        .document(id)
        .updateData({KUserShowOnlyMyCountryProvider: value});
  }

  updateFvorateUser(uid, List<String> list) async {
    await _firestore
        .collection(KUserCollection)
        .document(uid)
        .updateData({KFavorateProviderList: list});
  }

  addFavorateProvider(String pid, String uid) async {
    await _firestore
        .collection(KUserCollection)
        .document(uid)
        .collection(KFavorateProviderListCollection)
        .document(pid)
        .setData({KFavorateProviderId: pid});
  }

  deleteFavorateProvider(String pid, String uid) async {
    await _firestore
        .collection(KUserCollection)
        .document(uid)
        .collection(KFavorateProviderListCollection)
        .document(pid)
        .delete();
  }

  deleteUser(String uid) async {
    await _firestore.collection(KUserCollection).document(uid).delete();
  }

  updatePasswordUser(String uid, String password) async {
    await _firestore
        .collection(KUserCollection)
        .document(uid)
        .updateData({KUserPassword: password});
  }

  addProvider(ProviderModel provider, String pid) async {
    await _firestore.collection(KProviderCollection).document(pid).setData({
      KProviderName: provider.pName,
      KProviderAddDate: provider.pAddDate,
      KProviderImageUrl: provider.pImageUrl,
      KProviderPhoneNumber: provider.pphoneNumber,
      KProviderIsAdmin: provider.isAdmin,
      KProviderLocationId: provider.locationId,
      KProviderDescription: provider.pProviderDescription,
      KServiceId: provider.pProvideService,
      KProviderEmail: provider.pEmail,
      KProviderId: provider.pId,
      KProviderPassword: provider.pPassword,
      KProviderTotalRate: 1.0,
      KProviderNumberOfRatedRequest: 1,
      KProviderIsVerified: false,
      KProviderIsMale: provider.isMale,
      KImageCartificateUrlList: provider.certificateImages,
      KProviderPrice: provider.price,
      KproviderCountry: provider.country
    });
  }

  Stream<QuerySnapshot> loadProvider(String field, bool isdescending,String onlyMyCountry) {
    if(onlyMyCountry==""){
      if (field == "") {
        return _firestore.collection(KProviderCollection).snapshots();
      } else if (field == KProviderIsVerified) {
        return _firestore
            .collection(KProviderCollection)
            .where(KProviderIsVerified, isEqualTo: true )
            .snapshots();
      } else if (field == KProviderIsMale) {
        return _firestore
            .collection(KProviderCollection)
            .where(KProviderIsMale, isEqualTo: !isdescending)
            .snapshots();
      }
      else{
         return _firestore.collection(KProviderCollection).orderBy(field,descending: !isdescending).snapshots();
      } 
    }else{
      if (field == "") {
        return _firestore.collection(KProviderCollection).where(KproviderCountry,isEqualTo :onlyMyCountry ).snapshots();
      } else if (field == KProviderIsVerified) {
        return _firestore
            .collection(KProviderCollection)
            .where(KProviderIsVerified, isEqualTo: true )
            .where(KproviderCountry,isEqualTo :onlyMyCountry )
            .snapshots();
      } else if (field == KProviderIsMale) {
        return _firestore
            .collection(KProviderCollection)
            .where(KProviderIsMale, isEqualTo: !isdescending)
            .where(KproviderCountry,isEqualTo :onlyMyCountry )
            .snapshots();
      } 
      else{
         return _firestore.collection(KProviderCollection).orderBy(field,descending: !isdescending).where(KproviderCountry,isEqualTo :onlyMyCountry).snapshots();

      }

    }
  }

  updatefavorateList(List<String> myFavorateList, String pId) async {
    await _firestore
        .collection(KProviderCollection)
        .document(pId)
        .updateData({KMyFavorateList: myFavorateList});
  }

  updateProviderPassword(String userId, String trim) async {
    await _firestore
        .collection(KProviderCollection)
        .document(userId)
        .updateData({KProviderPassword: trim});
  }

  void updateUserProfile(String imageUrl, String userId) async {
    await _firestore
        .collection(KUserCollection)
        .document(userId)
        .updateData({KUserImageUrl: imageUrl});
  }

  updateUserName(String username, String userId) {
    _firestore
        .collection(KUserCollection)
        .document(userId)
        .updateData({KUserName: username});
  }

  updateProviderName(String username, String providerId) {
    _firestore
        .collection(KProviderCollection)
        .document(providerId)
        .updateData({KProviderName: username});
  }

  updateUserEmail(String email, String userId) {
    _firestore
        .collection(KUserCollection)
        .document(userId)
        .updateData({KUserEmail: email});
  }

  updateProviderEmail(String email, String providerId) {
    _firestore
        .collection(KProviderCollection)
        .document(providerId)
        .updateData({KProviderEmail: email});
  }

  updateProviderRating(
      String providerId, double lastrate, int current, int total) async {
    var newrate;

    total = total + 1;
    lastrate = lastrate + current;
    newrate = lastrate / total;
    print("last no of rating $total");
    print("provider rating $lastrate");
    print("request rating $current");
    await _firestore
        .collection(KProviderCollection)
        .document(providerId)
        .updateData({
      KProviderTotalRate: newrate,
      KProviderNumberOfRatedRequest: total,
    });
  }

    searchByName(String searchField)  {
    return  _firestore
        .collection(KProviderCollection)
        .where(KProviderSearchKey,
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }

}
