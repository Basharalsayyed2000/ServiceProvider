import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_provider/Services/auth.dart';

class UserProfilescreen extends StatefulWidget {
  static String id = 'UserProfilescreen';
  @override
  _UserProfilescreenState createState() => _UserProfilescreenState();
}

class _UserProfilescreenState extends State<UserProfilescreen> {
  PickedFile _imageFile;
  final _auth = Auth();
  // ignore: unused_field
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  String _userId;
  @override
  void initState() {
    super.initState();
    _getUserId();
  }
    _getUserId()async{
      String value=await _auth.getCurrentUserId();
      setState(() {
        _userId=value;
      });
    }
  // Future<void> _getUserName() async {
  //   Firestore.instance
  //       .collection(KUserCollection)
  //       .document(await _auth.getCurrentUserId())
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       _userModel.uName = value.data[KUserName];
  //       _userModel.uEmail = value.data[KUserEmail];
  //       _userModel.uPassword = value.data[KUserPassword];
  //       _userModel.ubirthDate = value.data[KUserBirthDate];
  //       _userModel.uAddDate = value.data[KUserAddDate];
  //       _userModel.uId = value.data[KUserId];
  //       _userModel.uphoneNumber = value.data[KUserPhoneNumber];
  //       _userModel.isAdmin = value.data[KUserIsAdmin];
  //     });
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
        backgroundColor: KprimaryColor,
        actions: <Widget>[],
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection(KUserCollection)
              .document(_userId)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading");
            }else{
          var userDocument = snapshot.data;
          return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0185,
              ),
              Center(
                  child: Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: _imageFile == null
                        ? AssetImage("Assets/images/noprofile.png")
                            as ImageProvider
                        : FileImage(File(_imageFile.path)),
                  ),
                  Positioned(
                    bottom: 20.0,
                    right: 20.0,
                    child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: ((builder) => bottomsheet()),
                          );
                        },
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.teal,
                          size: 28.0,
                        )),
                  )
                ],
              )),
              Center(
                child: Text(
                  '${userDocument[KUserName]}',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0385,
              ),
              TextField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: KfocusColor, width: 2.5),
                    ),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "E-mail",
                    labelStyle: TextStyle(
                        color: KprimaryColor, fontWeight: FontWeight.bold),
                    hintText: "${userDocument[KUserEmail]}",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0485,
              ),
              TextField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: KfocusColor, width: 2.5),
                    ),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Phone Number",
                    labelStyle: TextStyle(
                        color: KprimaryColor, fontWeight: FontWeight.bold),
                    hintText: "${userDocument[KUserPhoneNumber]}",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0485,
              ),
              TextField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: KfocusColor, width: 2.5),
                    ),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Age",
                    labelStyle: TextStyle(
                        color: KprimaryColor, fontWeight: FontWeight.bold),
                    hintText: "${userDocument[KUserBirthDate]}",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0485,
              ),
              TextField(
                decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: KfocusColor, width: 2.5),
                    ),
                    contentPadding: EdgeInsets.only(bottom: 3),
                    labelText: "Accout Type",
                    labelStyle: TextStyle(
                        color: KprimaryColor, fontWeight: FontWeight.bold),
                    hintText: "User",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintStyle: TextStyle(
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ),
            ],
          ));
            }
          }),
    );
  }

  Widget bottomsheet() {
    return Container(
      height: 100,
      width: 200,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          Text(
            "Choose a profile",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: deprecated_member_use
              FlatButton.icon(
                icon: Icon(Icons.camera),
                onPressed: () {
                  takePhoto(ImageSource.camera);
                },
                label: Text("Camera"),
              ),
              // ignore: deprecated_member_use
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(ImageSource.gallery);
                },
                label: Text("Gallery"),
              )
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
      );
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }
}


