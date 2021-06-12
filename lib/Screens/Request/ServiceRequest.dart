import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:intl/intl.dart';
import 'package:service_provider/Models/NeededData.dart';
import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/GalleryImages.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/Screens/Request/ServiceRequestLocation.dart';
import 'package:service_provider/Services/auth.dart';

class ServiceRequest extends StatefulWidget {
  static String id = "serviceRequestScreen";
  @override
  State<StatefulWidget> createState() {
    return _ServiceRequest();
  }
}

class _ServiceRequest extends State<ServiceRequest> {
  final _auth = Auth();
  // ignore: deprecated_member_use
  //List<File> _gallery = new List<File>();
  List<String> _galleryUrl = [];

  FontWeight _weightT;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  Color _colorDt;
  FontWeight _weightDt;
  Color _colorT;
  DateTime _date;
  DateTime _time;
  RequestModel request;
  String rProblem, rDescription, rDate, rTime, _userId;
  var gallery = <bool,List>{};
  
  @override
  void initState() {
    super.initState();
    gallery[true]=[];
    gallery[false]=[];
    _getUserId();
  }

  _getUserId() async {
    String value = await _auth.getCurrentUserId();
    setState(() {
      _userId = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    NeededData neededData = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Provider"),
        backgroundColor: KprimaryColor,
        centerTitle: true,
      ),
      body: ProgressHUD(
        child: Form(
          key: _globalKey,
          child: Container(
            margin: EdgeInsets.only(
                left: Kminimumpadding * 2, right: Kminimumpadding * 2),
            child: ListView(
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Image(
                      image: AssetImage("Assets/images/serviceRequestLogo.png"),
                      width: 160.0,
                      height: 160.0,
                    ),
                  ),
                ),
                Container(
                  child: CustomTextField(
                    onClicked: (value) {
                      rProblem = value;
                    },
                    hintText: 'Describe your current situation.',
                    prefixIcon: Icons.insert_emoticon,
                    labelText: 'Problem',
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: Kminimumpadding * 1.35,
                      bottom: Kminimumpadding * 1.35),
                  height: 70,
                  child: getDateFormPicker(),
                ),
                Container(
                    height: Kheight,
                    padding: EdgeInsets.only(
                        top: Kminimumpadding * 1.35,
                        bottom: Kminimumpadding * 1.35),
                    margin:
                        EdgeInsets.symmetric(vertical: Kminimumpadding * 1.35),
                    child: getTimeFormPicker()),
                Container(
                  child: CustomTextField(
                    labelText: "Description",
                    hintText: "Describe your current situation.",
                    onClicked: (value) {
                      rDescription = value;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Problem Image',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
                SizedBox(
                  height: 15,
                ),
                GalleryImage(
                  gallery: gallery,
                  edit: true, 
                  ),
                // Container(
                //   margin: EdgeInsets.only(
                //       bottom: MediaQuery.of(context).size.height / 55),
                //   child: SizedBox(
                //     height: MediaQuery.of(context).size.width / 3.4,
                //     child: ListView.builder(
                //       scrollDirection: Axis.horizontal,
                //       itemCount: _gallery.length + 1,
                //       itemBuilder: (context, index) {
                //         return GestureDetector(
                //           onTap: () => (index == 0) ? pickGalleryImage() : null,
                //           child: Container(
                //             decoration: BoxDecoration(
                //               borderRadius: BorderRadius.circular(5.0),
                //               color: Colors.white,
                //               boxShadow: [
                //                 BoxShadow(
                //                     color: Colors.grey, spreadRadius: 1.5),
                //               ],
                //             ),
                //             width: MediaQuery.of(context).size.width / 2.6,
                //             margin: EdgeInsets.only(
                //                 left: 2, top: 2, right: 13, bottom: 2),
                //             child: (index == 0)
                //                 ? Icon(Icons.add,
                //                     size: 60, color: KprimaryColor)
                //                 : Image.file(_gallery[index - 1]),
                //           ),
                //         );
                //       },
                //     ),
                //   ),
                // ),
                Container(
                  padding: EdgeInsets.only(top: Kminimumpadding * 2),
                  child: Builder(
                    builder: (context) => CustomButton(
                      onPressed: () async {
                        capsolateData(context, neededData);
                      },
                      textValue: 'Continue',
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget getDateFormPicker() {
    return DateTimePickerFormField(
      autofocus: false,
      decoration: InputDecoration(
          labelText: "Date",
          labelStyle: TextStyle(color: _colorDt, fontWeight: _weightDt),
          prefixIcon: Icon(
            Icons.date_range,
            color: _colorDt,
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: KdisabledColor, width: 1.5)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: KfocusColor, width: 2.5))),
      format: DateFormat("EEEE, MMMM d, yyyy"),
      inputType: InputType.date,
      initialDate: DateTime.now(),
      onChanged: (selectedDate) {
        setState(() {
          if (selectedDate != null) {
            _date = selectedDate;
            rDate = selectedDate.toString();
            _colorDt = KprimaryColorDark;
            _weightDt = FontWeight.bold;
          } else {
            _colorDt = null;
            _weightDt = null;
          }
        });
        print('Selected date: $_date');
      },
    );
  }

  Widget getTimeFormPicker() {
    return DateTimePickerFormField(
      inputType: InputType.time,
      format: DateFormat("HH:mm"),
      initialTime: (_date == DateTime.now()) ? TimeOfDay.now() : null,
      editable: false,
      decoration: InputDecoration(
        labelText: "Time",
        labelStyle: TextStyle(fontWeight: _weightT, color: _colorT),
        prefixIcon: Icon(
          Icons.access_time_sharp,
          color: _colorT,
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: KaccentColor, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: KaccentColor, width: 2.5)),
      ),
      onChanged: (selectedTime) {
        setState(() {
          if (selectedTime != null) {
            _time = selectedTime;
            rTime = selectedTime.toString();
            _colorT = KprimaryColorDark;
            _weightT = FontWeight.bold;
          } else {
            _colorT = null;
            _weightT = null;
          }
        });
        print('Selected date: $_time');
      },
    );
  }

  // void addRequest(context, bool isactive, ProviderModel provider) async {
  //   if (_date == null) {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: Text("You must choose date"),
  //             actions: [
  //               // ignore: deprecated_member_use
  //               RaisedButton(
  //                 onPressed: () => Navigator.pop(context),
  //                 color: Colors.red,
  //                 child: Text("ok"),
  //               ),
  //             ],
  //           );
  //         });
  //   } else if (_time == null) {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             title: Text("You must choose time"),
  //             actions: [
  //               // ignore: deprecated_member_use
  //               RaisedButton(
  //                 onPressed: () => Navigator.pop(context),
  //                 color: Colors.red,
  //                 child: Text("ok"),
  //               ),
  //             ],
  //           );
  //         });
  //   } else {
  //     try {
  //       final progress = ProgressHUD.of(context);
  //       toggleProgressHUD(true, progress);
  //       if (_globalKey.currentState.validate()) {
  //         // loadImage();
  //         _addedDate = getDateNow();
  //         _globalKey.currentState.save();

  //         _store.addRequest(RequestModel(
  //           rProblem: rProblem,
  //           rDescription: rDescription,
  //           rAddDate: _addedDate,
  //           requestDate: rDate,
  //           requestTime: rTime,
  //           isActive: (isactive == true) ? true : false,
  //           isAccepted: false,
  //           isComplete: false,
  //           providerId: provider.pId,
  //           userId: _userId,
  //         ));
  //         toggleProgressHUD(false, progress);

  //         showDialog(
  //             context: context,
  //             builder: (context) {
  //               return AlertDialog(
  //                 title: Text("successfully uplaoded"),
  //                 actions: [
  //                   // ignore: deprecated_member_use
  //                   RaisedButton(
  //                     onPressed: () => Navigator.pop(context),
  //                     color: KprimaryColor,
  //                     child: Text("ok"),
  //                   ),
  //                 ],
  //               );
  //             });
  //         Navigator.pushNamed(context, UserHome.id);
  //         Fluttertoast.showToast(
  //           msg: 'Send Succesfully',
  //         );
  //       }
  //     } catch (ex) {
  //       // ignore: deprecated_member_use
  //       showDialog(
  //           context: context,
  //           builder: (context) {
  //             return AlertDialog(
  //               title: Text(ex.message),
  //               actions: [
  //                 // ignore: deprecated_member_use
  //                 RaisedButton(
  //                   onPressed: () => Navigator.pop(context),
  //                   color: Colors.red,
  //                   child: Text("ok"),
  //                 ),
  //               ],
  //             );
  //           });
  //     }
  //   }
  // }

  Future uploadGalleryImage() async {
    for (var img in gallery[false]) {
      FirebaseStorage storage = FirebaseStorage(
          storageBucket: 'gs://service-provider-ef677.appspot.com');
      String imageFileName = DateTime.now().microsecondsSinceEpoch.toString();
      StorageReference ref =
          storage.ref().child('RequestImages/$imageFileName');
      StorageUploadTask storageUploadTask = ref.putFile(img);
      StorageTaskSnapshot taskSnapshot = await storageUploadTask.onComplete;

      String url = await taskSnapshot.ref.getDownloadURL();

      //_userStore.addGallaryCollection(url, docId);

      gallery[true].add(url);
      print("size is ${gallery[true].length}");

    }
  }

  // void pickGalleryImage() async {
  //   await Permission.photos.request();
  //   var _permessionStatus = await Permission.photos.status;
  //   if (_permessionStatus.isGranted) {
  //     // ignore: deprecated_member_use
  //     var image = await ImagePicker.pickImage(source: ImageSource.gallery);

  //     setState(() {
  //       gallery[false].add(image);

  //       print("HERE ------------------------------" +
  //           image.path +
  //           " " +
  //           _gallery.length.toString());
  //     });
  //   }
  // }

  void capsolateData(context, NeededData neededData) async {
    if (_date == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("You must choose date"),
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
    } else if (_time == null) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("You must choose time"),
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
    } else {
      final progress = ProgressHUD.of(context);
      toggleProgressHUD(true, progress);
      try {
        if (gallery[false].isNotEmpty) {
          await uploadGalleryImage();
        }
        
        if (_globalKey.currentState.validate()) {
          _globalKey.currentState.save();
           
          for(var i in gallery[true]){
            _galleryUrl.add(i);
          } 
          RequestModel _request = RequestModel(
            rDescription: rDescription,
            requestDate: rDate,
            requestTime: rTime,
            rProblem: rProblem,
            userId: _userId,
            providerId:(neededData.isRequestPublic)? "":neededData.provider.pId,
            isAccepted: false,
            isComplete: false,
            isActive: neededData.isRequestActive ,
            rImageUrl: _galleryUrl,
            isPublic: neededData.isRequestPublic,
            serviceId: neededData.serviceRequestId,
          );

          toggleProgressHUD(false, progress);
          Navigator.pushReplacementNamed(context, ServiceRequestLocation.id,
              arguments: _request);
        }
      } catch (ex) {
        toggleProgressHUD(true, progress);
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(ex.message),
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
      }
      toggleProgressHUD(true, progress);
    }
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
