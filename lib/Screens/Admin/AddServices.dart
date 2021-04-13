import 'package:flutter/material.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';


// ignore: must_be_immutable
class AddService extends StatelessWidget {
  static String id = 'addService';
  // ignore: unused_field
  String _name, _price, _desc, _imageLoc, _catagory;
  // ignore: unused_field
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextFied(
                onClicked: (value) {
                  _name = value;
                },
                hint: 'Name',
                icon: Icons.insert_emoticon),
            SizedBox(
              height: 10,
            ),
            CustomTextFied(
                onClicked: (value) {
                  _price = value;
                },
                hint: 'Price',
                icon: Icons.money),
            SizedBox(
              height: 10,
            ),
            CustomTextFied(
                onClicked: (value) {
                  _desc = value;
                },
                hint: 'Description',
                icon: Icons.text_fields),
            SizedBox(
              height: 10,
            ),
            CustomTextFied(
                onClicked: (value) {
                  _catagory = value;
                },
                hint: 'Catagory',
                icon: Icons.card_travel),
            SizedBox(
              height: 10,
            ),
            CustomTextFied(
                onClicked: (value) {
                  _imageLoc = value;
                },
                hint: 'image Location',
                icon: Icons.image),
            SizedBox(
              height: 20,
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  
                }
              },
              child: Text(
                'Add Product',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
