import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service_provider/Screens/User/RecommendedProviderMap.dart';

class MapDialog extends StatelessWidget{

  final bool edit;
  final bool hasAppBar;
  final Set<Marker> markers; 
  MapDialog({this.edit,this.markers,this.hasAppBar});

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
          child: RecommendedProvidersMap(
             edit: edit,
             appBar: hasAppBar,
             markers: markers,
          ),
        )
    );
  }

}