import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/Screens/Provider/AdditionalInfo.dart';

class ProviderVerifyScreen extends StatefulWidget {
  static String id = 'ProviderVerifyScreen';
  @override
  _ProviderVerifyScreenState createState() => _ProviderVerifyScreenState();
}

class _ProviderVerifyScreenState extends State<ProviderVerifyScreen> {
  final _auth = FirebaseAuth.instance;
  Timer timer;
  FirebaseUser user;
  var providerModel=ProviderModel();
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
    providerModel = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        child: 
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('An email has been sent'),
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
      providerModel.pId=user.uid;
      providerModel.isAdmin=false;
      Navigator.pushNamedAndRemoveUntil(context, AdditionalInfo.id, (Route<dynamic> route) => false,arguments: providerModel);
    }
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
