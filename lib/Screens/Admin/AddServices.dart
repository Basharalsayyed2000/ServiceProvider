import 'package:flutter/material.dart';
import 'package:service_provider/Models/Services.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/Services/store.dart';

// ignore: must_be_immutable
class AddService extends StatelessWidget {
  static String id = 'addService';
  // ignore: unused_field
  String _name, _desc, _imageLocation, _addedDate;
  // ignore: unused_field
  final Store _store = Store();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CustomTextField(
                onClicked: (value) {
                  _name = value;
                },
<<<<<<< Updated upstream
                hintText: 'Name',
                prefixIcon: Icons.insert_emoticon),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                onClicked: (value) {
                  _price = value;
                },
                hintText: 'Price',
                prefixIcon: Icons.money),
=======
                hint: 'Service Name',
                icon: Icons.insert_emoticon),

>>>>>>> Stashed changes
            SizedBox(
              height: 10,
            ),
            CustomTextField(
                onClicked: (value) {
                  _desc = value;
                },
<<<<<<< Updated upstream
                hintText: 'Description',
                prefixIcon: Icons.text_fields),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
=======
                hint: 'Service Description',
                icon: Icons.text_fields),
            SizedBox(
              height: 10,
            ),

            CustomTextFied(
>>>>>>> Stashed changes
                onClicked: (value) {
                  _imageLocation = value;
                },
<<<<<<< Updated upstream
                hintText: 'Catagory',
                prefixIcon: Icons.card_travel),
=======
                hint: 'Added Date',
                icon: Icons.schedule),
>>>>>>> Stashed changes
            SizedBox(
              height: 20,
            ),
            CustomTextField(
                onClicked: (value) {
                  _imageLocation = value;
                },
                hintText: 'image Location',
                prefixIcon: Icons.image),
            SizedBox(
              height: 20,
            ),
            // ignore: deprecated_member_use
            RaisedButton(
              onPressed: () {
                if (_globalKey.currentState.validate()) {
                  _store.addservice(Services(
                    sName: _name,
                    sDesc: _desc,
                    sAddDate: _addedDate,
                    sImageLoc: _imageLocation,
                  ));
                }
              },
              child: Text(
                'Add Service',
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
