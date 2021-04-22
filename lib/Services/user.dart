import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_provider/Models/userData.dart';
import 'package:service_provider/MyTools/Constant.dart';

class User {
  final Firestore _firestore = Firestore.instance;

  addUser(UserData user, String uid) async {
    await _firestore.collection(KUserCollection).document(uid).setData({
      KUserName: user.uName,
      KUserAddDate: user.uAddDate,
      KUserImageLocation: user.uImageLoc,
      KUserRank: user.urank,
      KUserBirthDate: user.ubirthDate,
      KUserPhoneNumber: user.uphoneNumber,
    });
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
}
