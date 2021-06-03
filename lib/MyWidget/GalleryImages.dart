import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Services/auth.dart';

import 'ImageDialog.dart';

class GalleryImages extends StatefulWidget{

  final Map<bool,List> gallery;

  GalleryImages({@required this.gallery});

  static List<File> finalGallery;

  @override
  State<StatefulWidget> createState(){
    return _GalleryImages(gallery: gallery);
  }

}

class _GalleryImages extends State<GalleryImages>{

  final Map<bool,List> gallery;
  //List<File> _files = [File("/data/user/0/com.example.service_provider/cache/image_picker4307476145657976484.jpg")];
  bool _asUser = false;

  Auth _auth = new Auth();

  _GalleryImages({@required this.gallery});

  @override
  void initState() {
    
    // gallery[false] = _files;

    // print("index-1-gallerytruelength${index - 1 - gallery[true].length}");
    super.initState();
    _auth.getCurrentUserId().then((uid) {

      _auth.checkUserExist(uid).then((asUser) => setState((){
          _asUser = asUser;
        })
      );

    });
  }

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.height / 55, left: 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.width / 3.4,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: (!_asUser) ? gallery[true].length + gallery[false].length + 1 : gallery[true].length + gallery[false].length,
          itemBuilder: (context, index) {
            print(index);
            
            // setState(() => finalGallery.length != 0 ? indexNB = index+1 : null);
            return GestureDetector(
              //if(!_asUser)
              onTap: (){ 
                if( !_asUser && index == 0)
                  pickGalleryImage();
                else
                  if(!_asUser)
                    if(index < gallery[true].length+1){
                      if(gallery[true].length > 0)
                        DialogHelper.exit(context, gallery[true][index - 1], true);
                      else
                        if (gallery[false].length > 0)
                          DialogHelper.exitFile(context, gallery[false][index - 1]);
                    }else{
                      if(gallery[true].length > 0){
                        if (gallery[false].length > 0)
                          DialogHelper.exitFile(context, gallery[false][index - gallery[true].length - 1]);
                      }else{
                        if (gallery[false].length > 0)
                          DialogHelper.exitFile(context, gallery[false][index-1]);
                      }
                    }

                  // DialogHelper.exitFile(context, gallery[index - 1])
                  // :DialogHelper.exitFile(context, gallery[index]);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1.5
                    ),
                  ],
                ),
                width: MediaQuery.of(context).size.width / 2.6,
                margin: EdgeInsets.only( left: 2, top: 2, right: 13, bottom: 2),
                child: (index == 0)
                ? Icon(Icons.add, size: 60, color: KprimaryColor)
                : Stack(
                  alignment: Alignment.center,
                    children: [


                      // if(gallery[true].length == 0)
                      //   Container(child: Image.file(File("/data/user/0/com.example.service_provider/cache/image_picker4307476145657976484.jpg")),),



                      if(index <= gallery[true].length && gallery[true].length > 0)
                        Image.network(gallery[true][index-1]),

                      if (index < gallery[true].length && gallery[true].length < 0 && gallery[false].length > 0)
                        Image.file(gallery[false].reversed.elementAt(index)),

                      if (index > gallery[true].length && gallery[true].length > 0 && gallery[false].length > 0)    
                        Image.file(gallery[false].reversed.elementAt(index - gallery[true].length - 1)),
                      
                      if (index > gallery[true].length && gallery[true].length <= 0 && gallery[false].length > 0)    
                        Image.file(gallery[false].reversed.elementAt(index-1)),
                        
                      if(!_asUser)
                        _createOverlayEntry(index),
                          //color: Colors.white,
                    ],
                  ),
              ),
            );
          },
        ),
      ),
    );
  }

  void pickGalleryImage() async {
    await Permission.photos.request();
    var _permessionStatus = await Permission.photos.status;
    if (_permessionStatus.isGranted) {
      // ignore: deprecated_member_use
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
      setState(() {

        print(image.path);
        gallery[false].add(image);

        print("HERE ------------------------------" +
            image.path +
            " + " +
            gallery.length.toString());
      });
    }
  }

  Widget _createOverlayEntry(int index) {
    
    return Container(
      margin: EdgeInsets.only(bottom: (MediaQuery.of(context).size.height/10), left: (MediaQuery.of(context).size.width/3.2)),
      width: 20,
      height: 20,

      // ignore: deprecated_member_use
      child: RaisedButton(
        color: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
        child: Text(
            "❌",
          style: TextStyle(
            fontSize: 12,
          ),
        ),
        onPressed: (){
          setState(() {
            print("index:$index, gallerylength: ${gallery.length}, _fileslength: ${gallery[false].length}");
            (index > gallery[true].length)? 
              gallery[false].removeAt(gallery[false].length - (index-gallery[true].length))
              : gallery[true].removeAt(index-1);
          });
        },
      ),
    );

  }

}