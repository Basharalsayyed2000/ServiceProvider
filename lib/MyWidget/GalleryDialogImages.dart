import 'package:flutter/material.dart';
import 'ImageDialog.dart';

// ignore: must_be_immutable
class GalleryImages extends StatelessWidget{
  final String assetImage;
  bool isOnline;

  GalleryImages({@required this.assetImage, this.isOnline});

  @override
  Widget build(BuildContext context) {
    if(this.isOnline == null)
      this.isOnline = false;

    return this.isOnline ?
    GestureDetector(
      onTap: () => DialogHelper.exit(context, this.assetImage, true),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 1.5),
          ],
        ),
        height: MediaQuery.of(context).size.width/3.4,
        width: MediaQuery.of(context).size.width/2.6,
        margin: EdgeInsets.only(left: 2, top: 2, right: 13, bottom: 2),
        child: Image(
          image: NetworkImage(this.assetImage),
        ),
      ),
    )
        :
    GestureDetector(
      onTap: () => DialogHelper.exit(context, this.assetImage, false),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey, spreadRadius: 1.5),
          ],
        ),
        height: MediaQuery.of(context).size.width/3.4,
        width: MediaQuery.of(context).size.width/2.6,
        margin: EdgeInsets.only(left: 2, top: 2, right: 13, bottom: 2),
        child: Image(
          image: AssetImage(this.assetImage),
        ),
      ),
    );
  }
}