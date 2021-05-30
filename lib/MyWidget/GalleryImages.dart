import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Services/auth.dart';

import 'ImageDialog.dart';

class GalleryImages extends StatefulWidget{

  final List<File> gallery;

  GalleryImages({@required this.gallery});

  static List<File> finalGallery;

  @override
  State<StatefulWidget> createState(){
    return _GalleryImages(gallery: gallery);
  }

}

class _GalleryImages extends State<GalleryImages>{

  final List<File> gallery;
  bool _asUser = false;

  Auth _auth = new Auth();

  _GalleryImages({@required this.gallery});

  @override
  void initState() {
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
          itemCount: (!_asUser) ? gallery.length + 1 : gallery.length,
          itemBuilder: (context, index) {
            print(index);
            // setState(() => finalGallery.length != 0 ? indexNB = index+1 : null);
            return GestureDetector(
              //if(!_asUser)
              onTap: (){ 
                ( !_asUser && index == 0) ? 
                pickGalleryImage() 
                
                :(
                  (!_asUser) ? 
                  DialogHelper.exitFile(context, gallery[index - 1])
                  :DialogHelper.exitFile(context, gallery[index])
                );
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
                width:
                    MediaQuery.of(context).size.width / 2.6,
                margin: EdgeInsets.only(
                    left: 2, top: 2, right: 13, bottom: 2),
                child: (index == 0)
                ? Icon(Icons.add,
                  size: 60, color: KprimaryColor)
                : Stack(
                  alignment: Alignment.center,
                    children: [
                      Container(
                        child: Image.file(gallery[index - 1]),
                      ),
                      
                      if(!_asUser)
                        Container(
                          child: _createOverlayEntry(index),
                          //color: Colors.white,
                        ),
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
        gallery.add(image);

        print("HERE ------------------------------" +
            image.path +
            " " +
            gallery.length.toString());
      });
    }
  }

  Widget _createOverlayEntry(int index) {
    RenderBox renderBox = context.findRenderObject();
    return Container(
      margin: EdgeInsets.only(bottom: (renderBox.size.height/1.5), left: (renderBox.size.width/3.2)),
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
            gallery.removeAt(index-1);
          });
        },
      ),
    );

  }

}