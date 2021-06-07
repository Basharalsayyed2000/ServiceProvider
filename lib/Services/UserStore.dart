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
      KUserEnableAcceptPublicRequest:user.enableAcceptPublicRequest,
      KFavorateProviderList: user.favorateProvider
    });
  }
  
  userUpdateEnableDirectAccept(bool value,String id) async {
   await _firestore
        .collection(KUserCollection)
        .document(id)
        .updateData({KUserEnableAcceptPublicRequest :value});
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

  updatePasswordUser(String uid,String password) async {
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
      KProviderBirthDate: provider.pbirthDate,
      KProviderPhoneNumber: provider.pphoneNumber,
      KProviderIsAdmin: provider.isAdmin,
      KProviderLocationId: provider.locationId,
      KProviderDescription: provider.pProviderDescription,
      KServiceId: provider.pProvideService,
      KProviderEmail: provider.pEmail,
      KProviderId: provider.pId,
      KProviderPassword: provider.pPassword
    });
  }

  Stream<QuerySnapshot> loadProvider() {
    return _firestore.collection(KProviderCollection).snapshots();
  }

  updatefavorateList(List<String> myFavorateList, String pId) async {
    await _firestore
        .collection(KProviderCollection)
        .document(pId)
        .updateData({KMyFavorateList: myFavorateList});
  }

  updateProviderPassword(String userId,String trim)async {
    await _firestore
        .collection(KProviderCollection)
        .document(userId)
        .updateData({KProviderPassword: trim}); 
  }

  void updateUserProfile(String imageUrl, String userId) async{
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

}
