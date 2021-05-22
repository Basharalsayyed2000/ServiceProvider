import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_provider/MyWidget/ProfileTextFields.dart';
import 'package:service_provider/Screens/commonScreens/MyActivity.dart';
import 'package:service_provider/Services/auth.dart';

class UserProfilescreen extends StatefulWidget {
  static String id = 'UserProfilescreen';
  @override
  _UserProfilescreenState createState() => _UserProfilescreenState();
}

class _UserProfilescreenState extends State<UserProfilescreen> {

  FocusNode _emailNode;

  PickedFile _imageFile;
  final _auth = Auth();
  // ignore: unused_field
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  String _userId;

  var userDocument;

  TextEditingController _username;
  TextEditingController _accountType;
  TextEditingController _email;
  TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _getUserId();
  }
    _getUserId()async{
      String value=await _auth.getCurrentUserId();
      setState(() {
        _userId=value;
        _accountType = TextEditingController(text: "User");
        
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
        elevation: 2.5,
        backgroundColor: KprimaryColor,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (choice){
              // ignore: unnecessary_statements
              (choice == "My Activity") ? Navigator.pushNamed(context, MyActivity.id) : null;
            },
            itemBuilder: (BuildContext context){
              return {"My Activity", "Logout", "Settings"}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }
              ).toList();
            },
          )
        ],
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
          userDocument = snapshot.data;

          if(userDocument[KUserName] != null)
          _username = TextEditingController(text: "${userDocument[KUserName]}");

          if(userDocument[KUserEmail] != null)
          _email = TextEditingController(text: "${userDocument[KUserEmail]}");
          
          if(userDocument[KUserPassword] != null)
          _password = TextEditingController(text: "${userDocument[KUserPassword]}");

          return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter, 
                    end: Alignment.bottomCenter, 
                    colors: [KprimaryColor.withOpacity(0.87), KprimaryColor, KsecondaryColor.withOpacity(.82)])
                ),
                child: Column(
                  children: [
                    SizedBox(
                height: MediaQuery.of(context).size.height * 0.0485,
              ),
              Center(
                  child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(80.0),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 3,
                          color: Colors.black.withOpacity(.3),
                          blurRadius: 3
                        )
                      ]
                    ),

                    child: CircleAvatar(
                    radius: 80,
                    backgroundImage: _imageFile == null
                        ? AssetImage("Assets/images/noprofile.png")
                            as ImageProvider
                        : FileImage(File(_imageFile.path)),
                  ),
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
              
              Container(
                padding: EdgeInsets.symmetric(vertical: 18),
                margin: EdgeInsets.only(left: 50),
                
                child: ProfileTextField(
                  isusername: true,
                  edit: true,
                  controller: _username,
                )
                // Text(
                //   '${userDocument[KUserName]}',
                //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                // ),
              ),
              

              // SizedBox(
              //   height: MediaQuery.of(context).size.height * 0.0185,
              // ),
                  ],
                ),
              ),
              
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 5),
                child: ProfileTextField(controller: _accountType, prefix: "Account Type",)
              ),

              Divider(
                color: KprimaryColorDark,
                height: 1,
                thickness: 1.5,
                indent: 10,
                endIndent: 10,
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ProfileTextField(controller: _email, prefix: "E-mail", edit: true,),
              ),

              Divider(
                color: KprimaryColorDark,
                height: 1,
                thickness: 1.5,
                indent: 10,
                endIndent: 10,
              ),

              Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                child: ProfileTextField(controller: _password, prefix: "Password", edit: true, isPassword: true,),
              ),

              // Divider(
              //   color: KprimaryColorDark,
              //   height: 1,
              //   thickness: 1.5,
              //   indent: 10,
              //   endIndent: 10,
              // ),

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


