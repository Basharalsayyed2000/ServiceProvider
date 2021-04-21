import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_provider/Models/userData.dart';
import 'package:service_provider/MyTools/Constant.dart';

class User {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addUser(UserData user, String uid) async {
    await _firestore.collection(KUserCollection).doc(uid).set({
      KUserName: user.uName,
      KUserAddDate: user.uAddDate,
      KUserImageLocation: user.uImageLoc,
      KUserRank: user.urank,
      KUserBirthDate: user.ubirthDate,
      KUserPhoneNumber: user.uphoneNumber,
    });
  }
  getUserById(docId)async{
      return  _firestore.collection(KUserCollection).doc(docId).snapshots();
  }
}
