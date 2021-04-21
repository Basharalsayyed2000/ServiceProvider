// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
class AddService extends StatefulWidget {
    static String id = 'addService';

  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  String _imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Image'),
      ),
      body: Column(
        children: <Widget>[
          (_imageUrl!=null)
          ?Image.network(_imageUrl):
          Placeholder(
            fallbackHeight:200 ,
            fallbackWidth: 200,
          ),
          SizedBox(
            height: 20,
          ),
          // ignore: deprecated_member_use
          RaisedButton(
            child: Text('Upload Image'),
            color: KprimaryColor,
            onPressed: (){
              uploadImage('imageServices','Electrictian');
            }
          ),
        ],
      ),
    );
  }
  


uploadImage(folderName,imageName)async{
  final _storage=FirebaseStorage.instance;
  final _picker = ImagePicker();
  PickedFile _image;
 //check permission 
await Permission.photos.request();
var _permessionStatus=await Permission.photos.status;
if(_permessionStatus.isGranted){
  //select image
  _image =await _picker.getImage(source: ImageSource.gallery);
  final bytes = await _image.readAsBytes();
  var _file= File(bytes,_image.path);
     
  
  if(_image!=null){
  
  var _snapshot =await _storage.ref().child('$folderName/$imageName').putFile(_image);

  var downloadurl= await _snapshot.reference.getDownloadURL();

  setState(() {
    _imageUrl=downloadurl;
  });
  }else{
    print('no Path Recieved');
  }
}else{
  print('Grent permession and try again');
}
}

}