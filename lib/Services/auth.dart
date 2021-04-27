import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  Future<String> getCurrentUserId() async {
    return  (await _auth.currentUser()).uid;
  }

   Future<void> checkEmailVerified(context)async{
    FirebaseUser user = await _auth.currentUser();
    await user.sendEmailVerification();
    Fluttertoast.showToast(msg: 'An Email has been sent to ${user.email} please verify');
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
