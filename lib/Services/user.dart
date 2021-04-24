import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/Models/user.dart';
import 'package:service_provider/MyTools/Constant.dart';

class UserStore{
  final Firestore _firestore = Firestore.instance;

  addUser(User user, String uid) async {
    await _firestore.collection(KUserCollection).document(uid).setData({
      KUserName: user.uName,
      KUserAddDate: user.uAddDate,
      KUserImageUrl: user.uImageUrl,
      KUserBirthDate: user.ubirthDate,
      KUserPhoneNumber: user.uphoneNumber,
      KUserIsAdmin:user.isAdmin,
    });
  }

  Future<bool> isExistInUserCollection(uid)async{
  // ignore: await_only_futures
   Stream  snapshot = await _firestore.collection(KUserCollection).snapshots();
   if(await snapshot.contains(uid))
    return true;
   else
    return false;
  }

  getDataUserById(uid) async {
    try {
      final DocumentSnapshot doc =
      await _firestore.collection(KUserCollection).document(uid).get();
      print(doc.data[KUserName]);
    } catch (e) {
      print(e);
    }
  }
  addProvider(Provider provider, String pid) async {
    await _firestore.collection(KProviderCollection).document(pid).setData({
      KProviderName: provider.pName,
      KProviderAddDate: provider.pAddDate,
      KProviderImageUrl: provider.pImageUrl,
      KProviderBirthDate: provider.pbirthDate,
      KProviderPhoneNumber: provider.pphoneNumber,
      KProviderIsAdmin:provider.isAdmin,
      KProviderAddress:provider.pAddress,
      KProviderDescription:provider.pProviderDescription,
      KServiceId:provider.pProvideService

    });
  }
}
