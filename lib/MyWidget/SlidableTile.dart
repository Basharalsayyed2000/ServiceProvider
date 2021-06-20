import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:service_provider/Models/NeededData.dart';
import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/Provider/JobDetails.dart';
import 'package:service_provider/Services/store.dart';
import 'dart:math' show cos, sqrt, asin;

class SlidableTile extends StatefulWidget {
  final String profile;
  final String userName;
  final String status;
  final bool hasAction;
  final bool forUser;
  final RequestModel request;
  final String providerId;
  final bool enable;
  final String providerLocationId;
  final double providerTotalRate;
  final int providerNumberOfRating;

  SlidableTile(
      {@required this.profile,
      @required this.userName,
      @required this.status,
      @required this.hasAction,
      @required this.forUser,
      @required this.request,
      this.providerId,
      this.enable,
      this.providerLocationId,
      this.providerNumberOfRating,
      this.providerTotalRate});

  @override
  State<StatefulWidget> createState() {
    return _SlidableTile(
        profile: profile,
        userName: userName,
        status: status,
        hasAction: hasAction,
        forUser: forUser,
        request: request,
        providerId: providerId,
        enable: enable,
        providerLocationId: providerLocationId,
        providerNumberOfRating: providerNumberOfRating,
        providerTotalRate: providerTotalRate);
  }
}

class _SlidableTile extends State<SlidableTile> {
  final String profile;
  final String userName;
  final String status;
  final bool hasAction;
  final bool forUser;
  final RequestModel request;
  final String providerId;
  final bool enable;
  bool load = false;
  final String providerLocationId;
  double distance;
  final double providerTotalRate;
  final int providerNumberOfRating;
  Store store = new Store();
  _SlidableTile(
      {@required this.profile,
      @required this.userName,
      @required this.status,
      @required this.hasAction,
      @required this.forUser,
      @required this.request,
      this.providerId,
      this.enable,
      this.providerLocationId,
      this.providerNumberOfRating,
      this.providerTotalRate});

  @override
  void initState() {
    if ((providerLocationId != null)) {
      getDistance(request.locationId, providerLocationId).then((value) {
        distance = value;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return (load || providerLocationId == null)
        ? Container(
            child: Slidable(
              actionPane: SlidableScrollActionPane(),
              actions: <Widget>[
                SlideAction(
                  //  icon: Icons.info_outline_rounded,
                  child: Text(
                    'View Details',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: KprimaryColor,
                  onTap: () {
                    Navigator.pushNamed(context, JobDetails.id,
                        arguments: NeededData(
                          requestModel: request,
                          pageType: status,
                          forUser: this.forUser,
                          providerId: providerId,
                          username: userName,
                          enable: enable,
                          providerTotalRate: providerTotalRate,
                          providerNumberRate: providerNumberOfRating,
                        ));
                  },
                ),
              ],
              secondaryActions: (hasAction)
                  ? <Widget>[
                      SlideAction(
                        //icon: Icons.remove_circle_outline,
                        child: (status == "Idle" && forUser)
                            ? Text(
                                'cancle',
                                style: TextStyle(color: Colors.white),
                              )
                            : (status == "Disactive" && forUser)
                                ? Text(
                                    'activate',
                                    style: TextStyle(color: Colors.white),
                                  )
                                : (status == "Idle" && !forUser)
                                    ? Text(
                                        'reject',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : (status == "Inprogress" && !forUser)
                                        ? Text(
                                            'complete',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        : (status == "Rejected" && forUser)
                                            ? Text(
                                                'forword',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              )
                                            : Text(
                                                'empty',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                        color: (status == "Disactive")
                            ? Colors.blue
                            : (status == "Inprogress" && !forUser)
                                ? Colors.green
                                : (status == "Rejected" && forUser)
                                    ? Colors.deepPurpleAccent
                                    : (status == "Idle")
                                        ? Colors.red
                                        : Colors.grey,
                        onTap: () {
                          if (status == "Idle" && forUser) {
                            store.cancleJob(request.requestId);
                            Fluttertoast.showToast(
                              msg: 'The job was Cancled',
                            );
                          } else if (status == "Disactive") {
                            store.activateJob(request.requestId);
                            Fluttertoast.showToast(
                              msg: 'The job was activated',
                            );
                          } else if (status == "Idle" && !forUser) {
                            store.rejectJob(request.requestId);
                            Fluttertoast.showToast(
                              msg: 'The job was Rejected',
                            );
                          } else if (status == "Inprogress" && !forUser) {
                            store.endJob(request.requestId);
                            Fluttertoast.showToast(
                              msg: 'The job was Completed',
                            );
                          }
                        },
                      )
                    ]
                  : null,
              actionExtentRatio: 0.25,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: KsecondaryColor.withOpacity(.755),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    backgroundImage: (profile != null)
                        ? NetworkImage(profile)
                        : AssetImage("Assets/images/noprofile.png"),
                    radius: 26,

                    // minRadius: 20,
                    // maxRadius: 25,
                  ),
                  radius: 30,
                  // minRadius: 27,
                  // maxRadius: 27,
                ),
                title: Container(
                  margin: EdgeInsets.only(top: 1, bottom: 3),
                  child: Row(
                    children: [
                      Text(
                        "ID: " + request.publicId,
                        style: TextStyle(
                            fontSize: 17,
                            color: KprimaryColorDark,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Text(
                              (status == "Idle")
                                  ? "  Idle "
                                  : (status == "Inprogress")
                                      ? " Inprogress"
                                      : (status == "complete")
                                          ? " completed "
                                          : (status == "Disactive")
                                              ? " Inactive "
                                              : (status == "Rejected")
                                                  ? " Rejected"
                                                  : "activate",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        height: 25,
                        width: (status == "Inprogress" || status == "complete")
                            ? 85
                            : (status == "Rejected")
                                ? 75
                                : (status == "Disactive")
                                    ? 65
                                    : 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: (status == "Idle")
                                ? Colors.lime
                                : (status == "Inprogress")
                                    ? Colors.orange
                                    : (status == "Disactive")
                                        ? Colors.grey
                                        : (status == "complete")
                                            ? Colors.green
                                            : (status == "Rejected")
                                                ? Colors.red
                                                : Colors.deepPurpleAccent),
                      ),
                      SizedBox(
                        width: 2,
                      ),
                    ],
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (forUser) ? "to: $userName" : "from: $userName",
                      style: TextStyle(
                          color: KprimaryColorDark,
                          fontWeight: FontWeight.w500,
                          fontSize: 14),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer,
                            color: KsecondaryColor,
                            size: 16,
                          ),
                          Text(
                            "  ${request.requestDate.substring(0, 10)} ${request.requestTime.substring(10, 16)}",
                            style: TextStyle(
                                fontSize: 13, color: KprimaryColorDark),
                          ),
                        ],
                      ),
                    ),
                    (providerLocationId != null)
                        ? Container(
                            margin: EdgeInsets.only(top: 4),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: KsecondaryColor,
                                  size: 16,
                                ),
                                Text(
                                  "\t ${distance.toString().substring(0, 8)} Km ",
                                  style: TextStyle(
                                      color: KprimaryColorDark,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Away from you",
                                  style: TextStyle(
                                      color: KprimaryColorDark,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
                onTap: () {
                  //Navigator.pushNamed(context, JobDetails.id);
                },
              ),
            ),
          )
        : Center();
  }

  Future<double> getDistance(
      String providerLocationId, String userLocationId) async {
    var lat2, lat1, lon2, lon1;
    var a;
    await Firestore.instance
        .collection(KLocationCollection)
        .getDocuments()
        .then((QuerySnapshot querySnapshot) async {
      querySnapshot.documents.forEach((doc) {
        if (providerLocationId == doc.documentID) {
          lat1 = double.parse(doc[KLocationLatitude].toString());
          lon1 = double.parse(doc[KLocationlonggitude].toString());
        }
        if (userLocationId == doc.documentID) {
          lat2 = double.parse(doc[KLocationLatitude].toString());
          lon2 = double.parse(doc[KLocationlonggitude].toString());
        }
      });
    });
    var p = 0.017453292519943295;
    var c = cos;
    a = 0.5 -
        c((lat2 - lat1) * p) / 2 +
        c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

    setState(() {
      load = true;
    });

    return 12742 * asin(sqrt(a));
    //return 1.3;
  }
}
