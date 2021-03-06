import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:service_provider/MyWidget/GalleryImages.dart';
import 'package:service_provider/MyWidget/ProfileTextFields.dart';
import 'package:service_provider/Screens/commonScreens/MyActivity.dart';
import 'package:service_provider/Screens/commonScreens/WelcomeScreen.dart';
import 'package:service_provider/Services/UserStore.dart';
import 'package:service_provider/Services/auth.dart';

class ProviderProfilescreen extends StatefulWidget {
  static String id = 'ProviderProfilescreen';
  @override
  _ProviderProfilescreenState createState() => _ProviderProfilescreenState();
}

class _ProviderProfilescreenState extends State<ProviderProfilescreen> {
  PickedFile imageFile;
  final _auth = Auth();
  UserStore user;
  // ignore: unused_field
  dynamic _pickImageError;
  final ImagePicker _picker = ImagePicker();
  String _userId;
  String imageUrl;
  var providerDocument;
  String serviceProviderId = "";
  // ignore: unused_field
  String _providerType = "Electrician";
  // ignore: unused_field
  var _address = ["Lebanon", "Tripoli", "Maarad"];
  var _description;
  //String _description = "I am a Electrician graduate at the Beirut Arabic University in Beirut.";
  //String _gallery = "Electrician";

  TextEditingController _username;
  var _gallery = <bool, List>{};
  TextEditingController _accountType;

  // TextEditingController _email;

  // TextEditingController _phoneNb;

  // TextEditingController _password;

  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    super.initState();
    _getUserId();
    // ignore: deprecated_member_use
    _gallery[true] = new List();
    // ignore: deprecated_member_use
    _gallery[false] = new List();
  }

  _getUserId() async {
    String value = await _auth.getCurrentUserId();
    setState(() {
      _userId = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("My Profile"),
        elevation: 1.5,
        backgroundColor: KprimaryColor,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (choice) {
              // ignore: unnecessary_statements
              (choice == "My Activity")
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MyActivity(
                                isUser: false,
                                serviceid: serviceProviderId,
                              )),
                    )
                  // ignore: unnecessary_statements
                  : null;
              if (choice == "Logout") {
                Navigator.pushReplacementNamed(context, WelcomeScreen.id);
                _auth.signOut();
              }
            },
            itemBuilder: (BuildContext context) {
              return {"My Activity", "Logout"}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection(KProviderCollection)
              .document(_userId)
              .snapshots(),
          // ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(child: CircularProgressIndicator());
            if (!snapshot.hasData) {
              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    CircularProgressIndicator(backgroundColor: KsecondaryColor),
                    Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 25),
                        child: Text("Please Wait"))
                  ]));
            } else {
              var providerDocument = snapshot.data;
              double calcrate=providerDocument[KProviderTotalRate]/providerDocument[KProviderNumberOfRatedRequest];

              if (providerDocument[KServiceId] != null)
                serviceProviderId = providerDocument[KServiceId];

              if (providerDocument[KProviderImageUrl] != null)
                imageUrl = providerDocument[KProviderImageUrl];
              //if(providerDocument[KProviderType] != null)
              //  _accountType = TextEditingController(text: "${providerDocument[KProviderType]}");
              _accountType = TextEditingController(text: "Provider");
              if (providerDocument[KProviderName] != null)
                _username = TextEditingController(
                    text: "${providerDocument[KProviderName]}");

              if (providerDocument[KImageCartificateUrlList] != null) {
                _gallery[true].clear();
                providerDocument[KImageCartificateUrlList].forEach((value) {
                  _gallery[true].add(value);
                  print(
                      "total:${_gallery.length}\t true:${_gallery[true].length} \t false:${_gallery[false].length}");
                });
              }

              // if (providerDocument[KProviderEmail] != null)
              //   _email =TextEditingController(text: "${providerDocument[KProviderEmail]}");

              // if (providerDocument[KProviderPhoneNumber] != null)
              //   _phoneNb =TextEditingController(text: "${providerDocument[KProviderPhoneNumber]}");

              // if (providerDocument[KProviderPassword] != null)
              //   _password = TextEditingController(text: "${providerDocument[KProviderPassword]}");

              if (providerDocument[KProviderDescription] != null) {
                _description = providerDocument[KProviderDescription];
              }
              if (providerDocument[KProviderLocationId] != null)
              return StreamBuilder(
                  stream: Firestore.instance
                      .collection(KLocationCollection)
                      .document(providerDocument[KProviderLocationId])
                      .snapshots(),
                  builder: (context, snapshotL) {
                    if (snapshotL.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    if (!snapshotL.hasData){
                      return Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                            CircularProgressIndicator(
                                backgroundColor: KsecondaryColor),
                            Container(
                                margin: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height / 25),
                                child: Text("Please Wait"))
                          ]));
                    }else {
                      var locationDocument = snapshotL.data;
                      _address.clear();

                      if (locationDocument[KLocationCountry] != null)
                        _address.add(locationDocument[KLocationCountry]);

                      if (locationDocument[KLocationCity] != null)
                        _address.add(locationDocument[KLocationCity]);

                      if (locationDocument[KLocationStreet] != null)
                        _address.add(locationDocument[KLocationStreet]);

                      return ProgressHUD(
                        child: GestureDetector(
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
                                          colors: [
                                        KprimaryColor.withOpacity(0.87),
                                        KprimaryColor,
                                        KsecondaryColor.withOpacity(.82)
                                        // Color.fromRGBO(6, 87, 91, 1).withOpacity(.7),
                                        // Color.fromRGBO(102, 165, 173, 1),
                                      ])),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height * 0.0435,
                                      ),
                                      Center(
                                          child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(80.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                      spreadRadius: 3,
                                                      color: Colors.black
                                                          .withOpacity(.3),
                                                      blurRadius: 3)
                                                ]),
                                            child: CircleAvatar(
                                                radius: 70,
                                                backgroundColor: KprimaryColor,
                                                backgroundImage: imageUrl == ""
                                                    ? AssetImage(
                                                            "Assets/images/noprofile.png")
                                                        as ImageProvider
                                                    : NetworkImage(imageUrl)
                                                //: FileImage(File(_imageFile.path)),
                                                ),
                                          ),
                                          Positioned(
                                            bottom: 20.0,
                                            right: 20.0,
                                            child: InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder: ((builder) =>
                                                        bottomsheet(context)),
                                                  );
                                                },
                                                child: Icon(
                                                  Icons.camera_alt,
                                                  color: KprimaryColorDark
                                                      .withOpacity(.89),
                                                  size: 28.0,
                                                )),
                                          )
                                        ],
                                      )),

                                      Container(
                                          padding: EdgeInsets.only(top: 5),
                                          margin: EdgeInsets.only(left: 35),
                                          child: ProfileTextField(
                                            isUser: false,
                                            isusername: true,
                                            edit: true,
                                            controller: _username,
                                            id: _userId,
                                            isverified:providerDocument[KProviderIsVerified] ,
                                          )
                                          // Text(
                                          //   '${providerDocument[KUserName]}',
                                          //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                          // ),
                                          ),

                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          "${_address[0]}, ${_address[1]}",
                                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500, color: KprimaryColorDark)
                                        ),
                                      ),

                                      Container(
                                        margin: EdgeInsets.only(bottom: 5),
                                        child: Text(
                                          "???${calcrate.toString().substring(0,3)}",
                                          style: TextStyle(fontSize: 14, color: KprimaryColorDark)
                                        ),
                                      ),

                                      // Container(
                                      //   child: Text(
                                      //     "${_address[2]}",
                                      //     style: TextStyle(fontSize: 14, color: KprimaryColorDark)
                                      //   )
                                      // )

                                      // SizedBox(
                                      //   height: MediaQuery.of(context).size.height * 0.0185,
                                      // ),
                                    ],
                                  ),
                                ),

                                Container(
                                    margin: EdgeInsets.only(top: 15, bottom: 5),
                                    child: ProfileTextField(
                                      controller: _accountType,
                                      prefix: "Account Type",
                                    )),

                                Divider(
                                  color: KprimaryColorDark,
                                  height: 1,
                                  thickness: 1.5,
                                  indent: 10,
                                  endIndent: 10,
                                ),

                                /*Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        child: ProfileTextField(
                          controller: _email,
                          prefix: "E-mail",
                          id: _userId,
                        ),
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
                        child: ProfileTextField(
                          controller: _phoneNb,
                          prefix: "Phone-number",
                        ),
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
                        child: ProfileTextField(
                          controller: _password,
                          prefix: "Password",
                          isPassword: true,
                        ),
                      ),*/
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 5.5,
                                  child: Container(
                                      padding: EdgeInsets.all(18),
                                      child: Scrollbar(
                                        controller: _scrollController,
                                        isAlwaysShown: true,
                                        radius: Radius.circular(30),
                                        interactive: true,
                                        child: ListView(
                                          controller: _scrollController,
                                          children: [
                                            Text(_description,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .subtitle1),
                                          ],
                                        ),
                                      )),
                                ),

                                GalleryImage(
                                    gallery: _gallery,
                                    edit: true,
                                    userid: _userId,
                                    autoUpdate: true),
                                // Divider(
                                //   color: KprimaryColorDark,
                                //   height: 1,
                                //   thickness: 1.5,
                                //   indent: 10,
                                //   endIndent: 10,
                                // ),
                              ],
                            )),
                      );
                    }
                  });
            }
          }),
    );
  }

  Widget bottomsheet(BuildContext context) {
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
                  takePhoto(context, ImageSource.camera);
                  Navigator.pop(context);
                },
                label: Text("Camera"),
              ),
              // ignore: deprecated_member_use
              FlatButton.icon(
                icon: Icon(Icons.image),
                onPressed: () {
                  takePhoto(context, ImageSource.gallery);
                  Navigator.pop(context);
                },
                label: Text("Gallery"),
              )
            ],
          )
        ],
      ),
    );
  }

  void takePhoto(context, ImageSource source) async {
    try {
      final pickedFile = await _picker.getImage(
        source: source,
      );
      final File file = File(pickedFile.path);

      setState(() {
        imageFile = pickedFile;
      });

      print(pickedFile.path);

      // final progress = ProgressHUD.of(context);
      // toggleProgressHUD(true, progress);

      FirebaseStorage storage = FirebaseStorage(
          storageBucket: 'gs://service-provider-ef677.appspot.com');
      String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();
      StorageReference ref = storage.ref().child('UserProfile/$imageFileName');
      StorageUploadTask storageUploadTask = ref.putFile(file);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

      String url = await taskSnapshot.ref.getDownloadURL();
      // print(url);
      setState(() async {
        imageUrl = url;
        await Firestore.instance
            .collection(KUserCollection)
            .document(_userId)
            .updateData({KUserImageUrl: imageUrl});
      });

      // toggleProgressHUD(false, progress);
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        _auth.signOut();
        break;
      case 'Settings':
        break;
    }
  }

  void toggleProgressHUD(_loading, _progressHUD) {
    setState(() {
      if (!_loading) {
        _progressHUD.dismiss();
      } else {
        _progressHUD.show();
      }
    });
  }
}
