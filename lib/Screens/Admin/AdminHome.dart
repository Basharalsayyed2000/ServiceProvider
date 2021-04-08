import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/Admin/AddServices.dart';
import 'package:service_provider/Screens/Admin/ManageServices.dart';



class AdminHome extends StatelessWidget {
  static String id = 'AdminHomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          // ignore: deprecated_member_use
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, AddService.id);
            },
            child: Text("Add Product"),
          ),
          // ignore: deprecated_member_use
          RaisedButton(
            onPressed: () {
              Navigator.pushNamed(context, ManageService.id);
            },
            child: Text("Manage Product"),
          ),
          // ignore: deprecated_member_use
          RaisedButton(
            onPressed: () {
            },
            child: Text("Veiw orders"),
          ),
        ],
      ),
    );
  }
}
