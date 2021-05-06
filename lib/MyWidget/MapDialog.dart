import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:service_provider/Screens/User/ServiceRequestLocation.dart';

class MapDialog extends StatelessWidget{

  final List<Placemark> placemarks;
  final int nbPlacemarks;
  final bool readOnly;

  MapDialog({this.placemarks, this.nbPlacemarks, this.readOnly});

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
          height: MediaQuery.of(context).size.height,
          child: ServiceRequestLocation(

          ),
        )
    );
  }

}

class MapDialogHelper{
  static exit(context, nbPlacemarks, placemarks, readonly) => showDialog(context: context, builder: (context) => MapDialog(placemarks: placemarks, readOnly: (readonly == null)? false : readonly));

}