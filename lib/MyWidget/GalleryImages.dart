import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Services/store.dart';

import 'ImageDialog.dart';

class GalleryImage extends StatefulWidget{

  final bool edit;
  final bool autoUpdate;
  final Map<bool,List> gallery;
  final String userid;

  GalleryImage({@required this.gallery, this.userid, this.autoUpdate, this.edit});

  static List<File> finalGallery;

  @override
  State<StatefulWidget> createState(){
    return _GalleryImage(gallery: gallery, userid: userid, autoUpdate: (autoUpdate != null)? autoUpdate : false, edit: (edit != null)? edit : false);
  }

}

class _GalleryImage extends State<GalleryImage>{

  final Map<bool,List> gallery;
  final bool edit;
  final bool autoUpdate;
  final String userid;
  
  bool _edit = false;

  ScrollController _scrollController = new ScrollController();

  final _store = Store();

  _GalleryImage({@required this.gallery, this.userid, this.autoUpdate, this.edit});

  @override
  void initState() {
    
    // gallery[false] = _files;

    // print("index-1-gallerytruelength${index - 1 - gallery[true].length}");
    _edit = edit;
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.only( bottom: MediaQuery.of(context).size.height / 55, left: 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.width / 3.4,
        child: Scrollbar(
          controller: _scrollController,
          isAlwaysShown: false,
          radius: Radius.circular(5),
          thickness: 7,
          interactive: true,
          child: Container(
            margin: EdgeInsets.only(bottom: 10),
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: (_edit) ? gallery[true].length + gallery[false].length + 1 : gallery[true].length,
              itemBuilder: (context, index) {
                print(index);
                
                return GestureDetector(
                  //if(_edit)
                  onTap: (){ 
                    if( _edit && index == 0)
                      pickGalleryImage();
                    else
                      if(_edit)
                        if(index < gallery[false].length+1){
                          if(gallery[false].length > 0)
                            DialogHelper.exitFile(context, gallery[false].reversed.elementAt(index - 1));
                          else
                            if (gallery[true].length > 0)
                              DialogHelper.exit(context, gallery[true].reversed.elementAt(index - 1), true);
                        }else{
                          if(gallery[false].length > 0){
                            if (gallery[true].length > 0)
                              DialogHelper.exit(context, gallery[true].reversed.elementAt(index - gallery[false].length - 1), true);
                          }else{
                            if (gallery[true].length > 0)
                              DialogHelper.exit(context, gallery[true].reversed.elementAt(index-1), true);
                          }
                        }
                      else{
                        if(index < gallery[true].length+1)
                          if(gallery[true].length > 0)
                            DialogHelper.exit(context, gallery[true].reversed.elementAt(index), true);
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
                    child: (_edit && index == 0)
                    ? Icon(Icons.add, size: 60, color: KprimaryColor)
                    : Stack(
                      alignment: Alignment.center,
                        children: [


                          // if(gallery[true].length == 0)
                          //   Container(child: Image.file(File("/data/user/0/com.example.service_provider/cache/image_picker4307476145657976484.jpg")),),

                          if (!_edit && index < gallery[true].length && gallery[true].length > 0)
                            Image.network(gallery[true].reversed.elementAt(index)),

                          // if (!_edit && index < gallery[true].length && gallery[true].length < 0 && gallery[false].length > 0)
                          //   Image.file(gallery[false].reversed.elementAt(index)),

                          // if (!_edit && index > gallery[true].length && gallery[true].length > 0 && gallery[false].length > 0)    
                          //   Image.file(gallery[false].reversed.elementAt(index - gallery[true].length)),
                          
                          // if (!_edit && index > gallery[true].length && gallery[true].length <= 0 && gallery[false].length > 0)    
                          //   Image.file(gallery[false].reversed.elementAt(index)),


                          if (_edit && index <= gallery[false].length && gallery[false].length > 0)
                            Image.file(gallery[false].reversed.elementAt(index-1)),

                          if (_edit && index < gallery[false].length && gallery[false].length < 0 && gallery[true].length > 0)
                            Image.network(gallery[true].reversed.elementAt(index)),

                          if (_edit && index > gallery[false].length && gallery[false].length > 0 && gallery[true].length > 0)    
                            Image.network(gallery[true].reversed.elementAt(index - gallery[false].length - 1)),
                          
                          if (_edit && index > gallery[false].length && gallery[false].length <= 0 && gallery[true].length > 0)    
                            Image.network(gallery[true].reversed.elementAt(index-1)),
                            
                          if(_edit)
                            _createOverlayEntry(index),
                              //color: Colors.white,
                        ],
                      ),
                  ),
                );
              },
            ),
          ),
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
        
        if(gallery[false].isNotEmpty && autoUpdate == true){
          _store.uploadGalleryImage(gallery, gallery[true]).then((value) {
            gallery[false].clear();
            _store.updateListGallery(gallery[true], userid);
          });
        }else{
          print("error updating offline gallery");
        }

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
            print("index:$index, gallerylength: ${gallery[true].length}, _fileslength: ${gallery[false].length}");
            if(index > gallery[false].length){
              gallery[true].removeAt(gallery[true].length - (index-gallery[false].length));

              if(autoUpdate){
                _store.updateListGallery(gallery[true], userid);

              }else{
                print("error updating online gallery");
              }

            } else{
              gallery[false].removeAt(gallery[false].length - index);
            }
          });
        },
      ),
    );

  }

}