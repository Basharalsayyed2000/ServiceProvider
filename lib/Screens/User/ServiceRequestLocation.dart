import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:service_provider/Screens/User/ServiceRequest.dart';

///
///
/// Only Use _currentPosition.latitude and _currentPosition.longitude
/// to get the latitude and longitude of the user
///
///
class ServiceRequestLocation extends StatefulWidget {
  static String id = "serviceRequestLocation";

  final bool appBar;

  String address;

  ServiceRequestLocation({this.appBar, this.address});

  @override
  State<StatefulWidget> createState() {
    return _ServiceRequestLocation(
      appBar: (this.appBar == null)? true : false
    );
  }
}

class _ServiceRequestLocation extends State<ServiceRequestLocation> {

  static Position _currentPosition = Position(latitude:37.42796133580664, longitude:-122.085749655962);
  static String _currentAddress = "";
  static bool mapToggle = false;

  final bool appBar;

  _ServiceRequestLocation({this.appBar});

  static Placemark address;

  static final CameraPosition _initialCameraPosition  = CameraPosition(
    target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
    zoom: 15,
  );


  _getCurrentLocation() async {

    Geolocator.requestPermission();

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;

        mapToggle = true;
        //Pass the lat and long to the function
        _getAddressFromLatLng(position.latitude, position.longitude);

      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> p = await placemarkFromCoordinates(latitude, longitude);

      address = p[0];

      setState(() {
        _currentAddress = "${address.locality}";
        print(_currentAddress);

      });
    } catch (e) {
      print(e);
    }
  }


  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers = Set.from([]);
      _markers.add(
        Marker(
          markerId: MarkerId("id-1"),
          position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
          infoWindow: InfoWindow(
              title: "Your Location"
          ),
        )
      );
    });
  }

  GoogleMapController mapController;

  BitmapDescriptor customIcon1;

  createMarker(context) {
    if (customIcon1 == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);

      BitmapDescriptor.fromAssetImage(configuration, "Assets/images/mapIcon.png")

          .then((icon) {
        setState(() {
          customIcon1 = icon;
        });
      });
    }
  }

  @override
  void initState() {
    _getCurrentLocation();
    _onMapCreated(mapController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    createMarker(context);
    return (this.appBar == true)
        ?
    Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
        centerTitle: true,
        backgroundColor: KprimaryColor,
      ),

      body: Container(
        child: mapToggle ? GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: _initialCameraPosition,
          mapToolbarEnabled: false,
          zoomControlsEnabled: false,
          onMapCreated: _onMapCreated,
          markers: _markers,

          onLongPress: (pos) {



              setState(() {
                _currentPosition = Position(latitude: pos.latitude, longitude: pos.longitude);
              });

              Marker f = new Marker(markerId: MarkerId('$pos'), position: pos,

                onTap: (){});

                setState(() {

                  if(_markers.isNotEmpty){
                    _markers = Set.from([]);

                  }
                  _markers.add(f);
                });

                Navigator.pushNamed(context, ServiceRequest.id);
              

            },

          onTap:  (pos) {

            Marker f = new Marker(markerId: MarkerId('$pos'), position: pos,

              onTap: (){});

              setState(() {

              if(_markers.isNotEmpty){
                _markers = Set.from([]);

              }
              _markers.add(f);
            });
          }


        ) : Center(
          child:Text(
            "Please Wait",
            style: TextStyle(
              fontSize: 40
            ),
          ),
        )
      ),
    )
        :
    Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            mapToggle = false;
            _getCurrentLocation();
          });
        },
        child: Icon(
          Icons.add_location_outlined,
          color: KprimaryColorDark,
        ),
        backgroundColor: KprimaryColor,
      ),
      body: Container(
          child: mapToggle ? GoogleMap(
              mapType: MapType.hybrid,
              initialCameraPosition: _initialCameraPosition,
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              onMapCreated: _onMapCreated,
              markers: _markers,

              onLongPress: (pos) {



                setState(() {
                  _currentPosition = Position(latitude: pos.latitude, longitude: pos.longitude);
                });

                Marker f = new Marker(markerId: MarkerId('$pos'), position: pos,

                    onTap: (){});

                setState(() {

                  if(_markers.isNotEmpty){
                    _markers = Set.from([]);

                  }
                  _markers.add(f);
                });

                Navigator.pushNamed(context, ServiceRequest.id);


              },

              onTap:  (pos) {

                Marker f = new Marker(markerId: MarkerId('$pos'), position: pos,

                    onTap: (){});

                setState(() {

                  if(_markers.isNotEmpty){
                    _markers = Set.from([]);

                  }
                  _markers.add(f);
                });
              }


          ) : Center(
            child:Text(
              "Please Wait",
              style: TextStyle(
                  fontSize: 40
              ),
            ),
          )
      ),
    );
  }
}