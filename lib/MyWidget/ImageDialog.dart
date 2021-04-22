import 'package:flutter/material.dart';

class ImageDialog extends StatelessWidget{

  final String image;
  final bool isOnline;

  ImageDialog({@required this.image, this.isOnline});

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
        child: isOnline ? Image.network(this.image): Image(image: AssetImage(this.image),),
      )
    );
  }

}

class DialogHelper{
  static exit(context, assetImage, isOnline) => showDialog(context: context, builder: (context) => ImageDialog(image: assetImage,isOnline: (isOnline == null)? false : isOnline));

}