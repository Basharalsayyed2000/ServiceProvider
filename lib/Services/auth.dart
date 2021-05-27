import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:service_provider/MyTools/Constant.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  Future<AuthResult> signUp(String email, String password) async {
    final authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  Future<AuthResult> signIn(String email, String password) async {
    final authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    return authResult;
  }

  sendRequestToResetPassword(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<bool> isUserLoggedIn() async {
    return ((await _auth.currentUser()) != null);
  }

  Future<bool> checkUserExist(String docID) async {
    bool exists = false;
    try {
      await Firestore.instance
          .document("$KUserCollection/$docID")
          .get()
          .then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  Future<bool> checkProviderExist(String docID) async {
    bool exists = false;
    try {
      await Firestore.instance
          .document("$KProviderCollection/$docID")
          .get()
          .then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } catch (e) {
      return false;
    }
  }

  Future<String> getCurrentUserId() async {
    return (await _auth.currentUser()).uid;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

}
