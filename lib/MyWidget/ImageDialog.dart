import 'dart:io';

import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget{

  final String image;
  final File imageFile;
  final bool isOnline;
  final bool isFile;

  ImageDialog({this.imageFile, this.isFile, this.image, this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height/2,
        child: isOnline ? Image.network(this.image): ( !isFile ? Image(image: AssetImage(this.image)) : Image.file(imageFile)),
      )
    );
  }

}

class DialogHelper{
  static exit(context, assetImage, isOnline) => showDialog(context: context, builder: (context) => ImageDialog(image: assetImage,isOnline: (isOnline == null)? false : isOnline));
  static exitFile(context, imageFile) => showDialog(context: context, builder: (context) => ImageDialog(imageFile: imageFile, isFile: true, isOnline: false));

}