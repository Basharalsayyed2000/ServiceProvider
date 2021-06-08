import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:service_provider/Models/Service.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyTools/Function.dart';
import 'package:service_provider/MyWidget/GalleryImages.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/Screens/Provider/ProviderLocation.dart';
import 'package:service_provider/Services/UserStore.dart';
import 'package:service_provider/Services/store.dart';
//import 'package:service_provider/Services/UserStore.dart';

class AdditionalInfo extends StatefulWidget {
  static String id = "additionalInfo";
  @override
  State<StatefulWidget> createState() {
    return _AdditionalInfo();
  }
}

class _AdditionalInfo extends State<AdditionalInfo> {
  File _image;
  // ignore: deprecated_member_use
  Map<bool, List> _gallery = <bool, List>{};
  List<String> _galleryUrl = [];
  String _imageUrl;
  List<String> _servicesName = [""];
  // ignore: unused_field
  List<ServiceModel> _services = [];
  String _currentItemSelected = "";
  // ignore: unused_field
  String _description, _birthDate, _errorMessage, _phoneNumber;
  final _userStore = Store();
  UserStore user;
  // UserStore _userStore = UserStore();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  ProviderModel _provider;
  String _sId = "";
  Color _colorDt;
  FontWeight _weightDt;

  // ignore: unused_field
  Color _colorT;
  DateTime _date;
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
        stream: _userStore.loadService(),
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
                            margin: EdgeInsets.only(top: 20),
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
                              radius: MediaQuery.of(context).size.height * 0.12,
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
                        padding: EdgeInsets.only(
                            top: Kminimumpadding * 1.35,
                            bottom: Kminimumpadding * 1.35),
                        height: 70,
                        child: getDateFormPicker(),
                      ),
                      Container(
                        child: CustomTextField(
                          onClicked: (value) {
                            _phoneNumber = value;
                          },
                          hintText: '+XXX XXXXX.....',
                          prefixIcon: Icons.phone,
                          labelText: 'Phone Number',
                        ),
                      ),
                      
                    //  GalleryImages(gallery: _gallery),

                      Container(
                        padding: EdgeInsets.only(top: 4),
                        // ignore: deprecated_member_use
                        child: Builder(
                          builder: (context) => CustomButton(
                            textValue: "Continue",
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

        await uploadGalleryImage(_provider.pId);

        if (_globalKey.currentState.validate()) {
          _globalKey.currentState.save();

          _provider.pImageUrl = _imageUrl;
          _provider.pProviderDescription = _description;

          _provider.pProvideService = _serviceId;
          _provider.pAddDate = getDateNow();
          _provider.pbirthDate = _birthDate;
          _provider.pphoneNumber = _phoneNumber;
          _provider.certificateImages = _galleryUrl;
          toggleProgressHUD(false, progress);
          Navigator.pushReplacementNamed(context, ProviderLocation.id,
              arguments: _provider);
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

  Future uploadGalleryImage(docId) async {
    if(_gallery.isNotEmpty)
    for (var img in _gallery[false]) {

      print(img.path);

      FirebaseStorage storage = FirebaseStorage(
          storageBucket: 'gs://service-provider-ef677.appspot.com');
      String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();
      StorageReference ref =
          storage.ref().child('CertificateImage/$imageFileName');
      StorageUploadTask storageUploadTask = ref.putFile(img);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

      String url = await taskSnapshot.ref.getDownloadURL();

      //_userStore.addGallaryCollection(url, docId);

      _galleryUrl.add(url);
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

  Widget getDateFormPicker() {
    return SizedBox(
      height: 73.0,
      child: DateTimePickerFormField(
        autofocus: false,
        decoration: InputDecoration(
          labelText: "Date Of Birth",
          isDense: true,
          labelStyle: TextStyle(color: _colorDt, fontWeight: _weightDt),
          prefixIcon: Icon(
            Icons.date_range,
            color: KprimaryColorDark,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: KdisabledColor, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: KfocusColor, width: 2.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: KdisabledColor, width: 1.5),
          ),
        ),
        validator: (value) =>
            (value == null) ? "Date Of Birth is Empty !" : null,
        format: DateFormat("MMMM d yyyy"),
        inputType: InputType.date,
        initialDate: DateTime(1970, 1, 1),
        onChanged: (selectedDate) {
          setState(() {
            _birthDate = selectedDate.toString();
            if (selectedDate != null) {
              _date = selectedDate;
              _colorDt = KprimaryColorDark;
              _weightDt = FontWeight.bold;
              _errorMessage = "Date Of Birth is Empty !";
            } else {
              _colorDt = null;
              _weightDt = null;
              _errorMessage = null;
            }
          });
          print('Selected date: $_date');
        },
      ),
    );
  }

}