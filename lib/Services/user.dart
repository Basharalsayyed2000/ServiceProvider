import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_provider/Models/userData.dart';
import 'package:service_provider/MyTools/Constant.dart';

class User {
  final Firestore _firestore = Firestore.instance;

  final FirebaseAuth auth = FirebaseAuth.instance;

 

  addUser(UserData user) async{
    await _firestore.collection(KUserCollection).add({
      KUserName: user.uName,
      // ignore: equal_keys_in_map
      KUserName: user.urank,
      KUserAddDate: user.uAddDate,
      KUserImageLocation: user.uImageLoc,
      KUserId:getUserId,
    });
  }

   Future<String> getUserId() async {
    final FirebaseUser user = await auth.currentUser();
    String uid = user.uid.toString();
    return uid;
  }
}
