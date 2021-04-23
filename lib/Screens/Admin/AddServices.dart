import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:service_provider/Models/Service.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/Services/store.dart';
import 'package:intl/date_symbol_data_local.dart';

class AddService extends StatefulWidget {
  static String id = 'addService';
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  File _image;
  String _imageUrl;
  String _name, _desc, _addedDate;
  bool status;
  // ignore: unused_field
  final Store _store = Store();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ListView(
         // mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height:MediaQuery.of(context).size.height * 0.1305 ,),
            Row(
              children: <Widget>[
                CircleAvatar(
                  backgroundImage: _image == null ?null : FileImage(_image),
                  radius: 80,
                ),
                GestureDetector(
                    onTap: pickImage,
                    child: Icon(
                      Icons.folder,
                      color: KprimaryColor,
                      size: 30,
                    ))
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),

            SizedBox(
              height: 30,
            ),
            CustomTextField(
              onClicked: (value) {
                _name = value;
              },
              hintText: 'Name',
              prefixIcon: Icons.insert_emoticon,
              labelText: 'Service Name',
            ),
            SizedBox(
              height: 10,
            ),

            CustomTextField(
              onClicked: (value) {
                _desc = value;
              },
              hintText: 'Description',
              prefixIcon: Icons.text_fields,
              labelText: 'Description',
            ),
            SizedBox(
              height: 100,
            ),

            // ignore: deprecated_member_use
            Builder(
              builder: (context) => CustomButton(
                onPressed: () {
                  if (_globalKey.currentState.validate()) {
                    uploadImage(context);
                    // loadImage();
                     _addedDate=getDateNow();
                    _globalKey.currentState.save();

                    _store.addservice(Service(
                        sName: _name,
                        sDesc: _desc,
                        sAddDate: _addedDate,
                        sImageUrl: _imageUrl));
                    // ignore: deprecated_member_use
                    Scaffold.of(context).showSnackBar(SnackBar(
                      content: Text('success'),
                    ));
                    reset();
                  }
                },
                textValue: 'Add Service',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void reset() {
    _globalKey.currentState.reset();
    setState(() {
      _image = null;
    });
  }

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

  void uploadImage(context) async {
    try {
      FirebaseStorage storage = FirebaseStorage(
          storageBucket: 'gs://service-provider-ef677.appspot.com');
      StorageReference ref = storage.ref().child(_image.path);
      StorageUploadTask storageUploadTask = ref.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

      String url = await taskSnapshot.ref.getDownloadURL();
      setState(() {
        _imageUrl = url;
      });
    } catch (ex) {
      // ignore: deprecated_member_use
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(ex.message),
      ));
    }
  }

  String getDateNow() {
    initializeDateFormatting();
    DateTime now = DateTime.now();
// ignore: unused_local_variable
    var dateString = DateFormat('dd-MM-yyyy').format(now);
    final String configFileName = dateString;
    return configFileName;
  }

  void loadImage() async {
    var imageId = await ImageDownloader.downloadImage(_imageUrl);
    var path = await ImageDownloader.findPath(imageId);
    File image = File(path);
    setState(() {
      _image = image;
    });
  }
}
