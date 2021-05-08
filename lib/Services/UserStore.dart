import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/Models/user.dart';
import 'package:service_provider/MyTools/Constant.dart';

class UserStore{
  final Firestore _firestore = Firestore.instance;

  addUser(UserModel user, String uid) async {
    await _firestore.collection(KUserCollection).document(uid).setData({
      KUserName: user.uName,
      KUserAddDate: user.uAddDate,
      KUserImageUrl: user.uImageUrl,
      KUserBirthDate: user.ubirthDate,
      KUserPhoneNumber: user.uphoneNumber,
      KUserIsAdmin:user.isAdmin,
      KUserEmail:user.uEmail,
      KUserPassword:user.uPassword,
      KUserId:user.uId
    });
  }


  Future<void> getDataUserById(uid) async {
   var document =  Firestore.instance.collection(KUserCollection).document(uid);
   await document.get().then((value) {
    });
  }
  addProvider(ProviderModel provider, String pid) async {
    await _firestore.collection(KProviderCollection).document(pid).setData({
      KProviderName: provider.pName,
      KProviderAddDate: provider.pAddDate,
      KProviderImageUrl: provider.pImageUrl,
      KProviderBirthDate: provider.pbirthDate,
      KProviderPhoneNumber: provider.pphoneNumber,
      KProviderIsAdmin:provider.isAdmin,
      KProviderLocationId:provider.locationId,
      KProviderDescription:provider.pProviderDescription,
      KServiceId:provider.pProvideService,
      KProviderEmail:provider.pEmail,
      KProviderId:provider.pId,
      KProviderPassword:provider.pPassword
    });
  }

  Stream<QuerySnapshot> loadProvider(){
     return _firestore.collection(KProviderCollection).snapshots();
  }
 
 
}
