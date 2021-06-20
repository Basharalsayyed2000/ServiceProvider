import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';

class Testing extends StatefulWidget {
  static String id="Testing";
  @override
  _Testing createState() => _Testing();
}

class _Testing extends State<Testing> {
  @override
  void initState() {
    DateTime currentPhoneDate = DateTime.now(); //DateTime

    Timestamp myTimeStamp = Timestamp.fromDate(currentPhoneDate); //To TimeStamp

    DateTime myDateTime = myTimeStamp.toDate(); // TimeStamp to DateTime

    print("current phone data is: $currentPhoneDate");
    print("current phone data is: $myDateTime");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Country Code Pick'),
          backgroundColor: KprimaryColor,
        ),
        body: Center(
         
        ),
      ),
    );
  }
}