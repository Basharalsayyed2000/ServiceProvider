import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:service_provider/Models/NeededData.dart';
import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/Models/UserAction.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/GalleryDialogImages.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/Screens/Provider/HomeProvider.dart';
import 'package:service_provider/Screens/User/MyBooks.dart';
import 'package:service_provider/Screens/User/UserHome.dart';
import 'package:service_provider/Services/store.dart';

class JobDetails extends StatefulWidget {
  static String id = "jobDetails";

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  double _padding;
  NeededData neededData;
  Store store = Store();
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
                child: Column(
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

            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    (!neededData.forUser)
                        ? Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: _padding * 7),
                              child: CustomButton(
                                  color: Colors.green,
                                  onPressed: () async {
                                    if(!requestModel.isAccepted){
                                    await store
                                        .acceptJob(requestModel.requestId);
                                    Navigator.of(context).pop();
                                    }
                                    else if(requestModel.isAccepted){
                                      await store.endJob(requestModel.requestId);
                                    Navigator.of(context).pop();
                                    }
                                    Fluttertoast.showToast(
                                      msg:(requestModel.isAccepted)?'The job was Completed':(!requestModel.isAccepted)? 'The job was Accepted':'',
                                    );
                                  },
                                  textValue:(requestModel.isAccepted)?"Complete":(!requestModel.isAccepted)? "Accept":""),
                            ),
                          )
                        : Expanded(
                            child: Text(""),
                          ),
                    (!requestModel.isProviderSeen && !requestModel.isPublic || neededData.forUser)
                        ? Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: _padding * 7),
                              child: CustomButton(
                                  color: (requestModel.isActive)
                                      ? Colors.red
                                      : (!requestModel.isActive)
                                          ? Colors.blue
                                          : Colors.blueAccent,
                                  onPressed: () async {
                                    if (requestModel.isActive &&
                                        neededData.forUser) {
                                      await store
                                          .cancleJob(requestModel.requestId);
                                      Navigator.of(context).pop();
                                    } else if (!requestModel.isActive &&
                                        neededData.forUser) {
                                      await store
                                          .activateJob(requestModel.requestId);
                                      Navigator.of(context).pop();
                                    } else if (requestModel.isActive &&
                                        !neededData.forUser) {
                                      await store
                                          .rejectJob(requestModel.requestId);
                                      Navigator.of(context).pop();
                                    }

                                    Fluttertoast.showToast(
                                      msg: (requestModel.isActive &&
                                              neededData.forUser)
                                          ? 'The job was cancled'
                                          : (!requestModel.isActive &&
                                                  neededData.forUser)
                                              ? 'The job was Activated'
                                              : (requestModel.isActive &&
                                                      !neededData.forUser)
                                                  ? 'The job was rejected'
                                                  : 'The job was cancled',
                                    );
                                  },
                                  textValue: (requestModel.isActive &&
                                          neededData.forUser)
                                      ? 'cancle'
                                      : (!requestModel.isActive &&
                                              neededData.forUser)
                                          ? 'Activate'
                                          : (requestModel.isActive &&
                                                  !neededData.forUser)
                                              ? 'reject'
                                              : 'The job was cancled'),
                            ),
                          )
                        : Expanded(child: Text(""))
                  ],
                ),
              ),
            )

            // (neededData.pageType == "Available")
            //     ? Expanded(
            //         flex: 2,
            //         child: Container(
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //             children: [
            //               Expanded(
            //                 child: Container(
            //                   padding: EdgeInsets.symmetric(
            //                       horizontal: _padding * 7),
            //                   child: CustomButton(
            //                       onPressed: () async {
            //                         await store.acceptJob(
            //                             neededData.requestModel.requestId);
            //                         Navigator.of(context)
            //                             .pushReplacementNamed(HomeProvider.id);
            //                         Fluttertoast.showToast(
            //                           msg: 'The job was Accepted',
            //                         );
            //                       },
            //                       textValue: "Accept"),
            //                 ),
            //               ),
            //               Expanded(
            //                 child: Container(
            //                   padding: EdgeInsets.symmetric(
            //                       horizontal: _padding * 7),
            //                   child: CustomButton(
            //                       onPressed: () async {
            //                         neededData.requestModel.isAccepted = false;
            //                         neededData.requestModel.isProviderSeen =
            //                             true;
            //                         await store.rejectJob(
            //                             neededData.requestModel.requestId);
            //                         Navigator.of(context)
            //                             .pushReplacementNamed(HomeProvider.id);
            //                         Fluttertoast.showToast(
            //                           msg: 'The job was Rejected',
            //                         );
            //                       },
            //                       textValue: "Reject"),
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       )
            //     : (neededData.pageType == "Inprogress")
            //         ? Expanded(
            //             child: Container(
            //               padding:
            //                   EdgeInsets.symmetric(horizontal: _padding * 7),
            //               child: CustomButton(
            //                   onPressed: () async {
            //                     neededData.requestModel.isComplete = true;
            //                     await store
            //                         .endJob(neededData.requestModel.requestId);
            //                     Navigator.of(context)
            //                         .pushReplacementNamed(HomeProvider.id);
            //                     Fluttertoast.showToast(
            //                       msg: 'The job was completed',
            //                     );
            //                   },
            //                   textValue: "Complete"),
            //             ),
            //           )
            //         : Expanded(
            //             child: Container(
            //               child: Text("This job was complete"),
            //             ),
            //           ),
          ],
        ),
      ),
    );
  }
}
