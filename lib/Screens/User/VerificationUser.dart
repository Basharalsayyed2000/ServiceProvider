import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:service_provider/Models/user.dart';
import 'package:service_provider/MyTools/Function.dart';
import 'package:service_provider/Screens/User/UserHome.dart';
import 'package:service_provider/Services/UserStore.dart';

class UserVerifyScreen extends StatefulWidget {
  static String id = 'UserVerifyScreen';
  @override
  _UserVerifyScreenState createState() => _UserVerifyScreenState();
}

class _UserVerifyScreenState extends State<UserVerifyScreen> {
  final _auth = FirebaseAuth.instance;
  Timer timer;
  FirebaseUser user;
  final _user =UserStore();
  String _addedDate;
  var userModel=UserModel();
  @override
  void initState() {
    getCurrentUser();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    super.initState();
  }

  getCurrentUser() async {
    user = await _auth.currentUser();
    user.sendEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    userModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('An email has been sent to'),
            Text('please verify'),
          ],
        ),
      ),
    );
  }

  Future<void> checkEmailVerified() async {
    user = await _auth.currentUser();
    await user.reload();
    if (user.isEmailVerified) {
      timer.cancel();
      _addedDate = getDateNow();
      _user.addUser(
        
      UserModel(
       uName: userModel.uName,
       uAddDate: _addedDate,
       uImageUrl: null,
       ubirthDate: null,
       uphoneNumber: null,
       isAdmin: false,
       uEmail: userModel.uEmail,
       uId: user.uid,
       uPassword: userModel.uPassword,
       favorateProvider: []
      ),
      user.uid);
                           
      Navigator.pushNamedAndRemoveUntil(context, UserHome.id, (Route<dynamic> route) => false);
      Fluttertoast.showToast(msg: 'Record Succesfully',);

    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
