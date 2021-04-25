import 'dart:io';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilescreen extends StatefulWidget {
  static String id = 'UserProfilescreen';
  @override
  _UserProfilescreenState createState() => _UserProfilescreenState();
}

class _UserProfilescreenState extends State<UserProfilescreen> {
  PickedFile _imageFile;
  // ignore: unused_field
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Profile"),
        backgroundColor: KprimaryColor,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: GestureDetector(
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
                  "Said Asfour",
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
                    hintText: "saidasfour@gmail.com",
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
                    hintText: "81/748400",
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
                    hintText: "21",
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
          )),
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
