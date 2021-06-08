import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service_provider/Models/Address.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/Screens/Provider/Navbar.dart';
import 'package:service_provider/Services/UserStore.dart';
import 'package:service_provider/Services/store.dart';

///
///
/// Only Use _currentPosition.latitude and _currentPosition.longitude
/// to get the latitude and longitude of the user
///
///
// ignore: must_be_immutable
class ProviderLocation extends StatefulWidget {
  static String id = "ProviderLocation";

  final bool appBar;

  String address;

  ProviderLocation({this.appBar, this.address});

  @override
  State<StatefulWidget> createState() {
    return _ProviderLocation(
        appBar: (this.appBar == null) ? true : false);
  }
}

class _ProviderLocation extends State<ProviderLocation> {
  static Position _currentPosition =
      Position(latitude: 37.42796133580664, longitude: -122.085749655962);
  // static String _currentAddress = "";
  static String _city = "";
  static String _country = "";
  static String _postalcode = "";
  static String _detailsAddress = "";
  static bool mapToggle = false;
  Store store = new Store();
  final bool appBar;
  double _latitude, _longitude;
  UserStore user =new UserStore();
  _ProviderLocation({this.appBar});

  static Placemark address;
  // ignore: unused_field
  ProviderModel _provider;
  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
    zoom: 5,
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
        _country = address.country;
        _city = address.locality;
        _postalcode = address.postalCode;
        _detailsAddress = address.street;
        _latitude = latitude;
        _longitude = longitude;
      });
    } catch (e) {
      print(e);
    }
  }

  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _markers = Set.from([]);
      _markers.add(Marker(
        markerId: MarkerId("id-1"),
        position: LatLng(_currentPosition.latitude, _currentPosition.longitude),
        infoWindow: InfoWindow(title: "Your Location"),
      ));
    });
  }

  GoogleMapController mapController;

  BitmapDescriptor customIcon1;

  createMarker(context) {
    if (customIcon1 == null) {
      ImageConfiguration configuration = createLocalImageConfiguration(context);

      BitmapDescriptor.fromAssetImage(
              configuration, "Assets/images/mapIcon.png")
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
    _provider = ModalRoute.of(context).settings.arguments;

    // createMarker(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Select Location"),
        centerTitle: true,
        backgroundColor: KprimaryColor,
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          child: mapToggle
              ? Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1.7,
                      child: GoogleMap(
                          mapType: MapType.hybrid,
                          initialCameraPosition: _initialCameraPosition,
                          mapToolbarEnabled: false,
                          zoomControlsEnabled: false,
                          onMapCreated: _onMapCreated,
                          markers: _markers,
                          onTap: (pos) {
                            Marker f = new Marker(
                              markerId: MarkerId('$pos'),
                              position: pos,
                              infoWindow: InfoWindow(
                                title: "You Are Here",
                              ),
                            );

                            setState(() {
                              if (_markers.isNotEmpty) {
                                _markers = Set.from([]);
                              }
                              _markers.add(f);
                              _getAddressFromLatLng(
                                  pos.latitude, pos.longitude);
                              print(pos.toString());
                            });
                          }),
                    ),

                    // CustomTextField(
                    //   labelText: _country, onClicked: null,
                    // ),
                    // CustomTextField(
                    //   labelText: _city, onClicked: null,
                    // ),
                    // CustomTextField(
                    //   labelText: _postalcode, onClicked: null,
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    Text('Country :$_country'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('City :$_city'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('PostalCode :$_postalcode'),
                    SizedBox(
                      height: 10,
                    ),
                    Text('details :$_detailsAddress'),
                    SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                        onPressed: () async {
                          // final progress = ProgressHUD.of(context);
                          // toggleProgressHUD(true, progress);
                          try {
                            String locId = await store.addLocation(AddressModel(
                              country: _country,
                              city: _city,
                              street: _detailsAddress,
                              latitude: _latitude,
                              longgitude: _longitude,
                            ));
                            _provider.locationId= locId;    
                            _provider.myFavorateList=[];
                            user.addProvider(_provider, _provider.pId);
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                Navbar.id,
                                (Route<dynamic> route) => false,
                                arguments: _provider);

                            // toggleProgressHUD(false, progress);
                            Fluttertoast.showToast(
                              msg: 'Record Succesfully',
                            );
                          } catch (e) {
                            // toggleProgressHUD(false, progress);

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(e.message),
                                    actions: [
                                      // ignore: deprecated_member_use
                                      RaisedButton(
                                        onPressed: () => Navigator.pop(context),
                                        color: Colors.red,
                                        child: Text("ok"),
                                      ),
                                    ],
                                  );
                                });
                            print('$e');
                          }
                          //toggleProgressHUD(false, progress);
                        },
                        textValue: "Submit"),
                  ],
                )
              : Center(
                  child: Text(
                    "Please Wait",
                    style: TextStyle(fontSize: 40),
                  ),
                )),
    );
  }

  void toggleProgressHUD(_loading, _progressHUD) {
    setState(() {
      if (!_loading) {
        _progressHUD.dismiss();
      } else {
        _progressHUD.show();
      }
    });
  }
}