import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/SlidableTile.dart';

class History extends StatefulWidget {
  static String id = "history";
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  String pId;
  @override
  void initState() {
    getcurrentid();
    super.initState();
  }

  void getcurrentid() async {
    String _userId = (await FirebaseAuth.instance.currentUser()).uid;
    setState(() {
      pId = _userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed Task"),
        centerTitle: true,
        backgroundColor: KprimaryColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection(KRequestCollection).snapshots(),
          // ignore: missing_return
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return new Center(child: new CircularProgressIndicator());
            if (snapshot.hasData) {
              List<RequestModel> _requests = [];
              for (var doc in snapshot.data.documents) {
                var data = doc.data;
                String requestId = doc.documentID;
                if (data[KRequestProviderId] == pId) {
                  //List<dynamic> requestUrl=[];
                  //  if(!(data[KRequestImageUrl]==null)){
                  //  requestUrl= List.of(data[KRequestImageUrl]);
                  // }
                  if (data[KRequestIsActive] &&
                      data[KRequestIsAccepted] &&
                      data[KRequestIsCompleted] &&
                      data[KRequestIsProviderSeen])
                    _requests.add(RequestModel(
                      rProblem: data[KRequestProblem],
                      rDescription: data[KRequestDescription],
                      rAddDate: data[KRequestAddDate],
                      requestDate: data[KRequestDate],
                      requestTime: data[KRequestTime],
                      requestId: requestId,
                      providerId: data[KRequestProviderId],
                      userId: data[KRequestUserId],
                      isAccepted: data[KRequestIsAccepted],
                      isActive: data[KRequestIsActive],
                      locationId: data[KRequestLocationId],
                      isComplete: data[KRequestIsCompleted],
                      isProviderSeen: data[KRequestIsProviderSeen],
                      isPublic: data[KRequestIsPublic],
                      serviceId: data[KRequestServiceId],
                      publicId: data[KRequestPublicId],
                      actionDate: data[KRequestActionDate],
                      rImageUrl: data[KRequestImageUrl] == null
                          ? []
                          : data[KRequestImageUrl]
                              .map<String>((i) => i as String)
                              .toList(),
                    ));
                }
              }

              return (_requests.isNotEmpty)
                  ? ListView.separated(
                      primary: false,
                      itemBuilder: (context, index) => Container(
                          // color: Colors.green[300],
                          margin: EdgeInsets.only(top: (index == 0) ? 4 : 0),
                          child: StreamBuilder(
                              stream: Firestore.instance
                                  .collection(KUserCollection)
                                  .document(_requests
                                      .elementAt(index)
                                      .userId) //ID OF DOCUMENT
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                  return new Center(
                                      child: new CircularProgressIndicator());
                                if (snapshot.hasData) {
                                  var document2 = snapshot.data;
                                  return SlidableTile(
                                    profile: document2[KUserImageUrl],
                                    userName: document2[KUserName],
                                    request: _requests.elementAt(index),
                                    status: "complete",
                                    hasAction: false,
                                    forUser: false,
                                  );
                                } else {
                                  return new CircularProgressIndicator();
                                }
                              })),
                      itemCount: _requests.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          thickness: 1,
                          // height: 1,
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        'There is no Completed Request',
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                    );
            } else {
              Center(
                child: Text(
                  'There is no Completed Request',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              );
            }
          }),
    );
  }
}
