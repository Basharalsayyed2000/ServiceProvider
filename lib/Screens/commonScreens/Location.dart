import 'package:geocoder/geocoder.dart' as geoCo;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service_provider/Models/Address.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/Services/store.dart';
class SetLocation extends StatefulWidget {
static String id="SetLocation";
  @override
  _SetLocationState createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  GoogleMapController googleMapController;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  Position position;
  Store store;
  String postalCode,addressLocation,country;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }
  @override
  Widget build(BuildContext context) {
    Providers  _provider = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Location'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 500,
              child: GoogleMap(
              onTap: (tapped) async{
              final coordinates= new geoCo.Coordinates(tapped.latitude, tapped.longitude);
              var address =await geoCo.Geocoder.local.findAddressesFromCoordinates(coordinates);
              var firstAddress=address.first;
              getMarkers(tapped.latitude, tapped.longitude);
              store.addLocation(Address(
               address: firstAddress.addressLine,
               country: firstAddress.countryName,
               postalCode: firstAddress.postalCode,
               latitude: tapped.latitude,
               longgitude: tapped.longitude,
               adId:_provider.pId,
              ));
              setState(() {
                country=firstAddress.countryName;
                postalCode=firstAddress.postalCode;
                addressLocation=firstAddress.addressLine;
              });
              },
                mapType: MapType.hybrid,
                compassEnabled: true,
                trafficEnabled: true,
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    googleMapController = controller;
                  });
                },
                initialCameraPosition:
                    CameraPosition(target: LatLng(position.latitude.toDouble(), position.longitude.toDouble()), zoom: 15.0),
                markers: Set<Marker>.of(markers.values),
              ),
            ),
            Text('Address : $addressLocation'),
            Text('country : $country'),
            Text('postalCode : $postalCode'),
          ],
        ),
      ),
    );
  }

  void getMarkers(double lat, double long) {
    MarkerId markerId = MarkerId(lat.toString() + long.toString());
    Marker _marker = Marker(
      markerId: markerId,
      position: LatLng(lat, long),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
      infoWindow: InfoWindow(snippet: 'Address'),
    );
    setState(() {
      markers[markerId] = _marker;
    });
  }
  void getCurrentLocation() async{
    Position currentPosiotion= await Geolocator.getCurrentPosition();
    setState(() {
       position=currentPosiotion;
    }); 
  }
  @override
  void dispose() {
    super.dispose();
  }
}
