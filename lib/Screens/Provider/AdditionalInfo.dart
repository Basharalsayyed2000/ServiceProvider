import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:service_provider/Models/Service.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyTools/Function.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/Screens/Provider/ProviderLoginScreen.dart';
import 'package:service_provider/Services/store.dart';
import 'package:service_provider/Services/UserStore.dart';

class AdditionalInfo extends StatefulWidget {
  static String id = "additionalInfo";
  @override
  State<StatefulWidget> createState() {
    return _AdditionalInfo();
  }
}

class _AdditionalInfo extends State<AdditionalInfo> {
  File _image;
  String _imageUrl;
  List<String> _servicesName = [""];
  // ignore: unused_field
  List<ServiceModel> _services = [];
  String _currentItemSelected = "";
  String _description;
  final _store = Store();
  UserStore _userStore = UserStore();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  ProviderModel _provider;
  String _sId = "";
  @override
  void initState() {
    _currentItemSelected = _servicesName[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable

    _provider = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadService(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ServiceModel> _services = [];
            List<String> _servicesName = [""];
            String sid;
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              sid = doc.documentID.toString();
              if (data[KServicesStatus]) {
                _servicesName.add(data[KServiceName]);
                _services.add(ServiceModel(
                  sName: data[KServiceName],
                  sDesc: data[KServiceDesc],
                  sImageUrl: data[KServicesImageUrl],
                  sAddDate: data[KServiceAddDate],
                  sId: sid,
                ));
              }
            }
            return ProgressHUD(
              child: Form(
                key: _globalKey,
                child: Container(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: ListView(
                    children: <Widget>[
                      Center(
                        child: GestureDetector(
                          onTap: pickImage,
                          child: Container(
                            //margin: EdgeInsets.only(top: 40),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(120.0),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey, spreadRadius: 1.5),
                              ],
                            ),
                            //padding: const EdgeInsets.all(18),
                            child: CircleAvatar(
                              backgroundImage: _image == null
                                  ? AssetImage('Assets/images/provider.jpg')
                                  : FileImage(_image),
                              radius: MediaQuery.of(context).size.height * 0.16,
                            ),
                            // Image(
                            //         image: _image == null
                            //         ? AssetImage('Assets/images/provider.jpg')
                            //         : FileImage(_image),
                            // //      AssetImage("Assets/images/noprofile.png"),
                            //         width: 120.0,
                            //         height: 120.0,
                            //       ),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width / 4 * 2,
                            top: MediaQuery.of(context).size.height / 20),
                        padding: EdgeInsets.only(left: 15),
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(color: KprimaryColor, spreadRadius: 1.5)
                            ]),
                        child: DropdownButtonFormField(
                            isExpanded: false,
                            dropdownColor: KprimaryColor,
                            style: TextStyle(
                                color: KprimaryColorDark, fontSize: 18),
                            value: _currentItemSelected,
                            items: _servicesName
                                .map((dropDownItem) => DropdownMenuItem(
                                      value: dropDownItem,
                                      child: Text(dropDownItem),
                                    ))
                                .toList(),
                            onChanged: (dropDownItem) {
                              setState(() {
                                _currentItemSelected = dropDownItem;
                              });
                            }),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height / 20),
                        child: CustomTextField(
                          minLines: 5,
                          maxLength: 200,
                          labelText: '',
                          onClicked: (value) {
                            _description = value;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 4),
                        // ignore: deprecated_member_use
                        child: Builder(
                          builder: (context) => CustomButton(
                            textValue: "Finish",
                            onPressed: () async {
                              if (_currentItemSelected == "") {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("You must choose SERVICE"),
                                        actions: [
                                          // ignore: deprecated_member_use
                                          RaisedButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            color: Colors.red,
                                            child: Text("ok"),
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                for (int j = 0;
                                    j < _services.length.toInt();
                                    j++) {
                                  if (_currentItemSelected ==
                                      _services[j].sName.toString()) {
                                    setState(() {
                                      _sId = _services[j].sId.toString();
                                    });
                                    break;
                                  }
                                }
                                uploadImage(context, _provider, _sId);
                              }
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(
              child: Text('Loading'),
            );
          }
        },
      ),
    );
  }

  void uploadImage(context, ProviderModel _provider, _serviceId) async {
    if (_image == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("You must choose picture"),
              actions: [
                // ignore: deprecated_member_use
                RaisedButton(
                  onPressed: () => Navigator.pop(context),
                  color: Colors.red,
                  child: Text("ok"),
                ),
              ],
            );
          });
    } else {
      try {
        final progress = ProgressHUD.of(context);
        toggleProgressHUD(true, progress);
        FirebaseStorage storage = FirebaseStorage(
            storageBucket: 'gs://service-provider-ef677.appspot.com');
        String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();
        StorageReference ref =
            storage.ref().child('ServicesImage/$imageFileName');
        StorageUploadTask storageUploadTask = ref.putFile(_image);
        StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

        String url = await taskSnapshot.ref.getDownloadURL();
        setState(() {
          _imageUrl = url;
        });
        if (_globalKey.currentState.validate()) {
          _globalKey.currentState.save();

          _provider.pImageUrl = _imageUrl;
          _provider.pProviderDescription = _description;

          _provider.pProvideService = _serviceId;
          _provider.pAddDate=getDateNow();
          toggleProgressHUD(false, progress);
          _userStore.addProvider(_provider, _provider.pId);
          Navigator.pushReplacementNamed(context, ProviderLoginScreen.id);
        }
      } catch (ex) {
        // ignore: deprecated_member_use
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(ex.message),
                actions: [
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: () => Navigator.pop(context),
                    color: Colors.red,
                    child: Text("ok"),
                  ),
                ],
              );
            });
      }
    }
  }

  void getServiceId() async {}

  void pickImage() async {
    await Permission.photos.request();
    var _permessionStatus = await Permission.photos.status;
    if (_permessionStatus.isGranted) {
      // ignore: deprecated_member_use
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
      });
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
