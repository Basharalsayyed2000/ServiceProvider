import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:geolocator/geolocator.dart';
import 'package:service_provider/Services/UserStore.dart';
import 'package:service_provider/Services/store.dart';

// ignore: must_be_immutable
class RecommendedProvidersMap extends StatefulWidget {
  static String id = "RecommendedProvidersMap";
  final bool appBar;
  final bool edit;
  final String serviceId;
  String address;
  final Set<Marker> markers;
  RecommendedProvidersMap(
      {this.appBar, this.address, this.edit, this.serviceId, this.markers});

  @override
  State<StatefulWidget> createState() {
    return _RecommendedProvidersMap(
        appBar: (this.appBar == null) ? true : appBar,
        edit: (edit != null) ? edit : false,
        serviceId: serviceId,
        markers: markers ?? {});
  }
}

class _RecommendedProvidersMap extends State<RecommendedProvidersMap> {
  static Position _currentPosition =
      Position(latitude: 37.42796133580664, longitude: -122.085749655962);
  final String serviceId;
  static String _city = "";
  static String _country = "";
  static String _detailsAddress = "";
  static bool mapToggle = false;
  final bool edit;
  List<ProviderModel> _providers = [];
  Store store = new Store();
  final bool appBar;
  double _latitude, _longitude;
  UserStore user = new UserStore();
  final Set<Marker> markers;
  _RecommendedProvidersMap(
      {this.appBar, this.edit, this.serviceId, this.markers});

  static Placemark address;
  // ignore: unused_field
  RequestModel _requestModel;
  static final CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(_currentPosition.latitude, _currentPosition.longitude),
    zoom: 8,
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
        _detailsAddress = address.street;
        _latitude = latitude;
        _longitude = longitude;
      });
    } catch (e) {
      print(e);
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      //  markers = Set.from([]);
      markers.add(Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(140),
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
    // fillMarker();
    _getCurrentLocation();
    _onMapCreated(mapController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // createMarker(context);
    return Scaffold(
      appBar:(this.appBar)? AppBar(
        title: Text("Select Location"),
        centerTitle: true,
        backgroundColor: KprimaryColor,
      ):null,
      body: Container(
        child: mapToggle
            ? Stack(children: [
                Container(
                  child: GoogleMap(
                      mapType: MapType.hybrid,
                      initialCameraPosition: _initialCameraPosition,
                      mapToolbarEnabled: false,
                      zoomControlsEnabled: true,
                      onMapCreated: _onMapCreated,
                      markers: markers,
                      onTap: (!edit)
                          ? (pos) {}
                          : (pos) {
                              Marker f = new Marker(
                                markerId: MarkerId('$pos'),
                                position: pos,
                                infoWindow: InfoWindow(
                                  title: "You Are Here",
                                ),
                              );

                              setState(() {
                                markers.add(f);
                                _getAddressFromLatLng(
                                    pos.latitude, pos.longitude);
                                print(pos.toString());
                              });
                            }),
                ),
              ])
            : Center(
                child: Text(
                  "Please Wait",
                  style: TextStyle(fontSize: 40),
                ),
              ),
      ),
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
