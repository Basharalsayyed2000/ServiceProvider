import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:service_provider/Models/Service.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyTools/Function.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/Services/store.dart';

class AddService extends StatefulWidget {
  static String id = 'addService';
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  File _image;
  String _imageUrl;
  String _name, _desc, _addedDate;
  int activeState=1;
  bool status;
  // ignore: unused_field
  final TextEditingController _nameEditingController = TextEditingController();
  // ignore: unused_field
  final TextEditingController _descriptionEditingController =
      TextEditingController();
  // ignore: unused_field
  final Store _store = Store();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _globalKey,
        child: ProgressHUD(
          child: ListView(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1305,
              ),
              Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: pickImage,
                    child: CircleAvatar(
                      backgroundImage: _image == null
                          ? AssetImage('Assets/images/provider.jpg')
                          : FileImage(_image),
                      radius: MediaQuery.of(context).size.height * 0.13,
                    ),
                  ),
                  GestureDetector(
                    onTap: pickImage,
                    child: Icon(
                      Icons.picture_in_picture_outlined,
                      size: 30,
                    ),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),

              SizedBox(
                height: 30,
              ),
              CustomTextField(
                controller: _nameEditingController,
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
                controller: _descriptionEditingController,
                onClicked: (value) {
                  _desc = value;
                },
                hintText: 'Description',
                prefixIcon: Icons.text_fields,
                labelText: 'Description',
              ),
             
              ListTile(
                title: const Text('active'),
                leading: Radio(
                  value: 1,
                  groupValue: activeState,
                  onChanged: (value) {
                    setState(() {
                      activeState = value;
                    });
                  },
                ),
              ),
              ListTile(
                title: const Text('disactive'),
                leading: Radio(
                  value: 2,
                  groupValue: activeState,
                  onChanged: (value) {
                    setState(() {
                      activeState = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // ignore: deprecated_member_use
              Builder(
                builder: (context) => CustomButton(
                  onPressed: () async {
                   
                    uploadImage(context);
                  
                  },
                  textValue: 'Add Service',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void reset() {
    _globalKey.currentState.reset();
    setState(() {
      _image = null;
      activeState=1;
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
          // loadImage();
          _addedDate = getDateNow();
          _globalKey.currentState.save();
           
          _store.addservice(Service(
              sName: _name,
              sDesc: _desc,
              sAddDate: _addedDate,
              sImageUrl: _imageUrl,
              status: (activeState==1)? true: false,
              ));
                toggleProgressHUD(false, progress);
                
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("successfully uplaoded"),
                  actions: [
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () => Navigator.pop(context),
                      color: KprimaryColor,
                      child: Text("ok"),
                    ),
                  ],
                );
              });
          reset();
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

  

  void loadImage() async {
    var imageId = await ImageDownloader.downloadImage(_imageUrl);
    var path = await ImageDownloader.findPath(imageId);
    File image = File(path);
    setState(() {
      _image = image;
    });
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
