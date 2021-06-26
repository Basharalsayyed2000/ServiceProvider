import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:service_provider/Models/NeededData.dart';
import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/GalleryDialogImages.dart';
import 'package:service_provider/MyWidget/MapDialog.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/Services/UserStore.dart';
import 'package:service_provider/Services/store.dart';

class JobDetails extends StatefulWidget {
  static String id = "jobDetails";

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  double _padding;
  NeededData neededData;
  Store store = new Store();
  UserStore user = new UserStore();
  RequestModel requestModel;
  @override
  Widget build(BuildContext context) {
    neededData = ModalRoute.of(context).settings.arguments;
    _padding = MediaQuery.of(context).size.height / 400;
    requestModel = neededData.requestModel;
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Details"),
        centerTitle: true,
        backgroundColor: KprimaryColor,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 11,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: KprimaryColor),
                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: ListView(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Job Title",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: KprimaryColorDark),
                            ),
                          ),
                          Expanded(
                            child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection(KServicesCollection)
                                    .document(requestModel.serviceId)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return new CircularProgressIndicator();
                                  }
                                  var document2 = snapshot.data;
                                  return Text(
                                    "${document2[KServiceName]}",
                                    style: TextStyle(
                                        fontSize: 16, color: KprimaryColorDark),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 35,
                      thickness: 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: _padding, bottom: _padding),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Problem",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: KprimaryColorDark),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${requestModel.rProblem}",
                              style: TextStyle(
                                  fontSize: 16, color: KprimaryColorDark),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 35,
                      thickness: 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: _padding, bottom: _padding),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: KprimaryColorDark),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${requestModel.rDescription}",
                              style: TextStyle(
                                  fontSize: 16, color: KprimaryColorDark),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 35,
                      thickness: 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: _padding, bottom: _padding),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Date & Time",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: KprimaryColorDark),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${requestModel.requestDate.substring(0, 10)} , ${requestModel.requestTime.substring(10, 16)}",
                              style: TextStyle(
                                  fontSize: 16, color: KprimaryColorDark),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 35,
                      thickness: 2,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Address",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: KprimaryColorDark),
                            ),
                          ),
                          Expanded(
                            child: StreamBuilder(
                                stream: Firestore.instance
                                    .collection(KLocationCollection)
                                    .document(requestModel
                                        .locationId) //ID OF DOCUMENT
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return new CircularProgressIndicator();
                                  }
                                  var document = snapshot.data;
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${document[KLocationCountry]}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: KprimaryColorDark),
                                      ),
                                      Text(
                                        "${document[KLocationCity]}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: KprimaryColorDark),
                                      ),
                                      Text(
                                        "${document[KLocationStreet]}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: KprimaryColorDark),
                                      ),
                                   SizedBox(height: 6,),
  
                                    // ignore: deprecated_member_use
                                    GestureDetector(
                                      child:Row(
                                        children: [
                                          Icon(Icons.location_pin,color: Colors.white,size: 17,),
                                          SizedBox(width: 3,),
                                          Text("view location",style: TextStyle(color: Colors.white),),
                                        ],
                                      ),
                                      //color: Colors.white,
                                      onTap: () {
                                        showDialog(context: context, builder: (context){
                                           Set<Marker> _markers = {};
                                          _markers.add(Marker(
                                            markerId: MarkerId(
                                                requestModel.requestId),
                                            position: LatLng(document[KLocationLatitude],
                                                document[KLocationlonggitude]),
                                            icon: BitmapDescriptor
                                                .defaultMarkerWithHue(200),
                                            infoWindow: InfoWindow(
                                                title: 
                                                  document[KLocationCity],
                                                snippet: "⭐" +
                                                    "${document[KLocationStreet]}",   
                                                onTap: () {
                                                },        
                                              ), 
                                          ));
                                         return MapDialog(hasAppBar: false,edit: false,markers: _markers );
                                        });
                                      },
                                    ),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: KprimaryColorDark,
                      height: 35,
                      thickness: 2,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Gallery",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: KprimaryColorDark),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: _padding * 8),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width / 3.4,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              (requestModel.rImageUrl.isNotEmpty)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        for (String imageurl
                                            in requestModel.rImageUrl)
                                          GalleryImages(
                                            assetImage: imageurl,
                                            isOnline: true,
                                          ),
                                      ],
                                    )
                                  : Text("no image"),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
             
             (!neededData.forUser)
                ? Expanded(
                    flex: 2,
                    child: Container(
                      child: (!requestModel.isProviderSeen)? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [ 
                          Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: _padding * 7),
                                    child: CustomButton(
                                        color: Colors.red,
                                        onPressed: () async {
                                          if (!requestModel.isProviderSeen) {
                                            await store.rejectJob(
                                                requestModel.requestId);
                                            Navigator.of(context).pop();
                                          }

                                          Fluttertoast.showToast(
                                            msg: (!requestModel.isProviderSeen)
                                                ? 'The job was rejected'
                                                : '',
                                          );
                                        },
                                        textValue:
                                            (!requestModel.isProviderSeen)
                                                ? "reject"
                                                : ""),
                                        
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: _padding * 7),
                                    child: CustomButton(
                                        color: Colors.green,
                                        onPressed: () async {
                                          if (!requestModel.isProviderSeen) {
                                            await store.acceptJob(
                                                requestModel.requestId);
                                            Navigator.of(context).pop();
                                          }

                                          Fluttertoast.showToast(
                                            msg: (!requestModel.isProviderSeen)
                                                ? 'The job was Accepted'
                                                : '',
                                          );
                                        },
                                        textValue:
                                            (!requestModel.isProviderSeen)
                                                ? "Accept"
                                                : ""),
                                        
                                  ),
                                ) 
                          ],
                      ):(requestModel.isAccepted && !requestModel.isComplete)?
                           Center(
                            child: Container(
                            child: Text(
                           "         This request inprogress",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
                          :(requestModel.isComplete && requestModel.rating==0)?
                             Center(
                            child: Container(
                            child: Text(
                           "      This request are not rated",
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          )):Center(),
                    ),
                  )
                : Expanded(child: Center()),








            // (!neededData.forUser)
            //     ? Expanded(
            //         flex: 2,
            //         child: Container(
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               (!requestModel.isComplete &&
            //                       !(requestModel.isProviderSeen))
            //                   ? Expanded(
            //                       child: Container(
            //                         padding: EdgeInsets.symmetric(
            //                             horizontal: _padding * 7),
            //                         child: CustomButton(
            //                             color: Colors.green,
            //                             onPressed: () async {
            //                               if (!requestModel.isProviderSeen) {
            //                                 await store.acceptJob(
            //                                     requestModel.requestId);
            //                                 Navigator.of(context).pop();
            //                               } 
            //                               Fluttertoast.showToast(
            //                                 msg: ((!requestModel
            //                                             .isProviderSeen) ||
            //                                         (!requestModel
            //                                                 .isProviderSeen &&
            //                                             neededData.enable))
            //                                     ? 'The job was Accepted'
            //                                     : (!requestModel
            //                                                 .isProviderSeen &&
            //                                             !neededData.enable)
            //                                         ? 'you must wait ${neededData.username} to accept'
            //                                         : (requestModel
            //                                                     .isProviderSeen &&
            //                                                 requestModel
            //                                                     .isAccepted)
            //                                             ? 'The job was Completed'
            //                                             : '',
            //                               );
            //                             },
            //                             textValue: (!requestModel
            //                                     .isProviderSeen)
            //                                 ? "Accept"
            //                                 : (requestModel.isProviderSeen &&
            //                                         requestModel.isAccepted)
            //                                     ? "Complete"
            //                                     : ""),
            //                       ),
            //                     )
            //                   : Center(
            //                       child: Container(
            //                       child: Text(
            //                         (requestModel.isComplete)
            //                             ? "   this request are not rated yet"
            //                             : "      Wait ${neededData.username} to accept",
            //                         style: TextStyle(
            //                             fontSize: 24,
            //                             color: Colors.red,
            //                             fontWeight: FontWeight.bold),
            //                       ),
            //                     )),
            //               (!requestModel.isProviderSeen)
            //                   ? Expanded(
            //                       child: Container(
            //                         padding: EdgeInsets.symmetric(
            //                             horizontal: _padding * 7),
            //                         child: CustomButton(
            //                             color: Colors.red,
            //                             onPressed: () async {
            //                               if (!requestModel.isProviderSeen) {
            //                                 await store.rejectJob(
            //                                     requestModel.requestId);
            //                                 Navigator.of(context).pop();
            //                               }

            //                               Fluttertoast.showToast(
            //                                 msg: (!requestModel.isProviderSeen)
            //                                     ? 'The job was rejected'
            //                                     : '',
            //                               );
            //                             },
            //                             textValue:
            //                                 (!requestModel.isProviderSeen)
            //                                     ? "reject"
            //                                     : ""),
                                        
            //                       ),
            //                     )
            //                   : Expanded(child: Center())
            //             ],
            //           ),
            //         ),
            //       )
            //     : Expanded(child: Center())
          ],
        ),
      ),
    );
  }

  void showRatingDialog(String requestId) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return RatingDialog(
            ratingColor: KsecondaryColor,
            title: 'Rating us',
            message:
                'We are glad to serve you!,Rating this service and tell others what you think.',
            image: Image(
              image: AssetImage("Assets/images/Logo.png"),
              height: 100,
            ),
            initialRating: 2,
            submitButton: 'Submit',
            onSubmitted: (response) {
              print('rating: ${response.rating}, comment: ${response.comment}');
              store.addRating(requestId, response.comment, response.rating);
              user.updateProviderRating(
                  neededData.requestModel.providerId,
                  neededData.providerTotalRate,
                  response.rating,
                  neededData.providerNumberRate);
            },
          );
        });
  }
}
