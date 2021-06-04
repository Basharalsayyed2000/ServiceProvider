import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/SlidableTile.dart';
import 'package:service_provider/Services/store.dart';

class HomeProvider extends StatefulWidget {
  static String id = 'HomeProvider';
  @override
  _HomeProviderState createState() => _HomeProviderState();
}

class _HomeProviderState extends State<HomeProvider> {
  List<RequestModel> requests;
  String pId;
  String pageType;
  Store store;
  @override
  void initState() {
    getcurrentid();
    super.initState();
    pageType = "Available";
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
        elevation: 0,
        title: Text("My Jobs"),
        centerTitle: true,
        backgroundColor: KprimaryColor,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    pageType = "Available";
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "Available",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: (pageType == "Available")
                              ? Colors.black
                              : Colors.grey),
                    ),
                    if (pageType == "Available")
                      Container(
                        margin: EdgeInsets.only(top: 3),
                        height: 2,
                        width: 55,
                        color: Colors.orange,
                      )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    pageType = "Inprogress";
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "InProgress",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: (pageType == "Inprogress")
                              ? Colors.black
                              : Colors.grey),
                    ),
                    if (pageType == "Inprogress")
                      Container(
                        margin: EdgeInsets.only(top: 3),
                        height: 2,
                        width: 55,
                        color: Colors.orange,
                      )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    pageType = "Completed";
                  });
                },
                child: Column(
                  children: [
                    Text(
                      "Completed",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: (pageType == "Completed")
                              ? Colors.black
                              : Colors.grey),
                    ),
                    if (pageType == "Completed")
                      Container(
                        margin: EdgeInsets.only(top: 3),
                        height: 2,
                        width: 55,
                        color: Colors.orange,
                      )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          (pageType == "Available")
              ? 
              StreamBuilder(
                stream:  Firestore.instance
                        .collection(KProviderCollection).document(pId)
                        .snapshots(),
                 builder: (context, snapshot) { 
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return new Center(child: new CircularProgressIndicator());
                    if (!snapshot.hasData) {
                      return Text("Loading");
                    }
                    var providerDocument = snapshot.data;
                   return StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance
                        .collection(KRequestCollection)
                        .snapshots(),
                    // ignore: missing_return
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting)
                        return new Center(child: new CircularProgressIndicator());
                      if (snapshot.hasData) {
                        List<RequestModel> _requests = [];
                        for (var doc in snapshot.data.documents) {
                          var data = doc.data;
                          String requestId = doc.documentID;
                          if (data[KRequestProviderId] == pId || providerDocument[KServiceId]==data[KRequestServiceId]) {
                            //List<dynamic> requestUrl=[];
                            //  if(!(data[KRequestImageUrl]==null)){
                            //  requestUrl= List.of(data[KRequestImageUrl]);
                            // }
                            if (data[KRequestIsActive] &&
                                !data[KRequestIsAccepted] &&
                                !data[KRequestIsCompleted] &&
                                !data[KRequestIsProviderSeen])
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
                                isComplete: data[KRequestIsCompleted],
                                isProviderSeen: data[KRequestIsProviderSeen],
                                locationId: data[KRequestLocationId],
                                isPublic: data[KRequestIsPublic],
                                serviceId: data[KRequestServiceId],
                                rImageUrl: data[KRequestImageUrl] == null
                                    ? []
                                    : data[KRequestImageUrl]
                                        .map<String>((i) => i as String)
                                        .toList(),
                              ));
                          }
                        }

                        return (_requests.isNotEmpty)
                            ? Expanded(
                                child: ListView.separated(
                                  primary: false,
                                  itemBuilder: (context, index) => Container(
                                      // color: Colors.green[300],
                                      margin: EdgeInsets.only(
                                          top: (index == 0) ? 4 : 0),
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
                                                  child:
                                                      new CircularProgressIndicator());
                                            if (snapshot.hasData) {
                                              var document2 = snapshot.data;
                                              return SlidableTile(
                                                profile: document2[KUserImageUrl],
                                                user: document2[KUserName],
                                                request:
                                                    _requests.elementAt(index),
                                                status: "Idle",
                                                hasAction: true,
                                                forUser: false,
                                              );
                                            } else {
                                              return new CircularProgressIndicator();
                                            }
                                          })),
                                  itemCount: _requests.length,
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return Divider(
                                      thickness: 1,
                                      // height: 1,
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: Text(
                                  'There is no Available Job',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                      } else {
                        Center(
                          child: Text(
                            'There is no Available Job',
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.red,
                                fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                    });
                 })
              : (pageType == "Inprogress")
                  ? StreamBuilder<QuerySnapshot>(
                      stream: Firestore.instance
                          .collection(KRequestCollection)
                          .snapshots(),
                      // ignore: missing_return
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return new Center(
                              child: new CircularProgressIndicator());
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
                                  !data[KRequestIsCompleted] &&
                                  data[KRequestIsProviderSeen])
                                _requests.add(RequestModel(
                                  rProblem: data[KRequestProblem],
                                  rDescription: data[KRequestDescription],
                                  rAddDate: data[KRequestAddDate],
                                  requestDate: data[KRequestDate],
                                  requestTime: data[KRequestTime],
                                  requestId: requestId,
                                  locationId: data[KRequestLocationId],
                                  providerId: data[KRequestProviderId],
                                  userId: data[KRequestUserId],
                                  isAccepted: data[KRequestIsAccepted],
                                  isActive: data[KRequestIsActive],
                                  isComplete: data[KRequestIsCompleted],
                                  isProviderSeen: data[KRequestIsProviderSeen],
                                  rImageUrl: data[KRequestImageUrl] == null
                                      ? []
                                      : data[KRequestImageUrl]
                                          .map<String>((i) => i as String)
                                          .toList(),
                                ));
                            }
                          }

                          return (_requests.isNotEmpty)
                              ? Expanded(
                                  child: ListView.separated(
                                    primary: false,
                                    itemBuilder: (context, index) => Container(
                                        // color: Colors.green[300],
                                        margin: EdgeInsets.only(
                                            top: (index == 0) ? 4 : 0),
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
                                                    child:
                                                        new CircularProgressIndicator());
                                              if (snapshot.hasData) {
                                                var document2 = snapshot.data;
                                                return SlidableTile(
                                                  profile:
                                                      document2[KUserImageUrl],
                                                  user: document2[KUserName],
                                                  request: _requests
                                                      .elementAt(index),
                                                  status: "Inprogress",
                                                  hasAction: true,
                                                  forUser: false,
                                                );
                                              } else {
                                                return new CircularProgressIndicator();
                                              }
                                            })),
                                    itemCount: _requests.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return Divider(
                                        thickness: 1,
                                        // height: 1,
                                      );
                                    },
                                  ),
                                )
                              : Center(
                                  child: Text(
                                    'There is no job Inprogress',
                                    style: TextStyle(
                                        fontSize: 24,
                                        color: Colors.orange,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                        } else {
                          Center(
                            child: Text(
                              'There is no job Inprogress',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ),
                          );
                        }
                      })
                  : (pageType == "Completed")
                      ? StreamBuilder<QuerySnapshot>(
                          stream: Firestore.instance
                              .collection(KRequestCollection)
                              .snapshots(),
                          // ignore: missing_return
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting)
                              return new Center(
                                  child: new CircularProgressIndicator());
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
                                      isComplete: data[KRequestIsCompleted],
                                      isProviderSeen:
                                          data[KRequestIsProviderSeen],
                                      rImageUrl: data[KRequestImageUrl] == null
                                          ? []
                                          : data[KRequestImageUrl]
                                              .map<String>((i) => i as String)
                                              .toList(),
                                    ));
                                }
                              }

                              return (_requests.isNotEmpty)
                                  ? Expanded(
                                      child: ListView.separated(
                                        primary: false,
                                        itemBuilder: (context, index) =>
                                            Container(
                                                // color: Colors.green[300],
                                                margin: EdgeInsets.only(
                                                    top: (index == 0) ? 4 : 0),
                                                child: StreamBuilder(
                                                    stream: Firestore.instance
                                                        .collection(
                                                            KUserCollection)
                                                        .document(_requests
                                                            .elementAt(index)
                                                            .userId) //ID OF DOCUMENT
                                                        .snapshots(),
                                                    builder:
                                                        (context, snapshot) {
                                                      if (snapshot
                                                              .connectionState ==
                                                          ConnectionState
                                                              .waiting)
                                                        return new Center(
                                                            child:
                                                                new CircularProgressIndicator());
                                                      if (snapshot.hasData) {
                                                        var document2 =
                                                            snapshot.data;
                                                        return SlidableTile(
                                                          profile: document2[
                                                              KUserImageUrl],
                                                          user: document2[
                                                              KUserName],
                                                          request: _requests
                                                              .elementAt(index),
                                                          status: "complete",
                                                          hasAction: false,
                                                          forUser: false,
                                                        );
                                                      } else {
                                                        return new CircularProgressIndicator();
                                                      }
                                                    })),
                                        itemCount: _requests.length,
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return Divider(
                                            thickness: 1,
                                            // height: 1,
                                          );
                                        },
                                      ),
                                    )
                                  : Center(
                                      child: Text(
                                        'There is no sent Request',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                            } else {
                              Center(
                                child: Text(
                                  'There is no sent Request',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }
                          })
                      : Text("Loading"),
          SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }
}
