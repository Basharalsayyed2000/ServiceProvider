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
  bool fore = true;
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
        padding: EdgeInsets.only(top: 20, bottom: 20),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Row(
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
                      pageType = "complete";
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        "Completed",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: (pageType == "complete")
                                ? Colors.black
                                : Colors.grey),
                      ),
                      if (pageType == "complete")
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
          ),
          SizedBox(
            height: 25,
          ),
          StreamBuilder(
              stream: Firestore.instance
                  .collection(KProviderCollection)
                  .document(pId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return new Center(child: new CircularProgressIndicator());
                if (!snapshot.hasData) {
                  return Center(child: Text("Loading"));
                }
                var providerDocument = snapshot.data;
                return (pageType == "Available")
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
                                    rating: data[KRequestRating],
                                    commentRating: data[KRequestRatingComment],
                                    isAccepted: data[KRequestIsAccepted],
                                    isActive: data[KRequestIsActive],
                                    locationId: data[KRequestLocationId],
                                    isComplete: data[KRequestIsCompleted],
                                    isProviderSeen:
                                        data[KRequestIsProviderSeen],
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
                                                  builder: (context, snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState.waiting)
                                                      return new Center(
                                                          child:
                                                              new CircularProgressIndicator());
                                                    if (snapshot.hasData) {
                                                      var document2 =
                                                          snapshot.data;
                                                      return SlidableTile(
                                                        profile: document2[
                                                            KUserImageUrl],
                                                        userName: document2[
                                                            KUserName],
                                                        request: _requests
                                                            .elementAt(index),
                                                        status: "Idle",
                                                        hasAction: true,
                                                        forUser: false,
                                                        providerId: pId,
                                                        enable: document2[
                                                            KUserShowOnlyMyCountryProvider],
                                                        providerLocationId:
                                                            providerDocument[
                                                                KProviderLocationId],
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
                                : Expanded(
                                    child: Center(
                                      child: Text(
                                        'There is no Available Job',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.orange,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  );
                          } else {
                            Expanded(
                              child: Center(
                                child: Text(
                                  'There is no Available Job',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.orange,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            );
                          }
                        })
                    : (pageType == "Inprogress")
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
                                        !data[KRequestIsCompleted] &&
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
                                      rating: data[KRequestRating],
                                             commentRating: data[KRequestRatingComment],                              
                                        isComplete: data[KRequestIsCompleted],
                                        isProviderSeen:
                                            data[KRequestIsProviderSeen],
                                        serviceId: data[KRequestServiceId],
                                        publicId: data[KRequestPublicId],
                                        actionDate: data[KRequestActionDate],
                                        rImageUrl: data[KRequestImageUrl] ==
                                                null
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
                                                      top:
                                                          (index == 0) ? 4 : 0),
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
                                                            userName: document2[
                                                                KUserName],
                                                            request: _requests
                                                                .elementAt(
                                                                    index),
                                                            status:
                                                                "Inprogress",
                                                            hasAction: true,
                                                            forUser: false,
                                                            providerLocationId:
                                                                providerDocument[
                                                                    KProviderLocationId],
                                                          );
                                                        } else {
                                                          return new CircularProgressIndicator();
                                                        }
                                                      })),
                                          itemCount: _requests.length,
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return Divider(
                                              thickness: 1,
                                              // height: 1,
                                            );
                                          },
                                        ),
                                      )
                                    : Expanded(
                                      child: Center(
                                          child: Text(
                                            'There is no job Inprogress',
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.orange,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                    );
                              } else {
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      'There is no job Inprogress',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                );
                              }
                            })
                        : (pageType == "complete")
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
                                            rDescription:
                                                data[KRequestDescription],
                                            rAddDate: data[KRequestAddDate],
                                            requestDate: data[KRequestDate],
                                            requestTime: data[KRequestTime],
                                            requestId: requestId,
                                            providerId:
                                                data[KRequestProviderId],
                                            userId: data[KRequestUserId],
                                            isAccepted:
                                                data[KRequestIsAccepted],
                                            isActive: data[KRequestIsActive],
                                            locationId:
                                                data[KRequestLocationId],
                                            isComplete:
                                                data[KRequestIsCompleted],
                                            isProviderSeen:
                                                data[KRequestIsProviderSeen],
                                             rating: data[KRequestRating],
                                             commentRating: data[KRequestRatingComment],   
                                            serviceId: data[KRequestServiceId],
                                            publicId: data[KRequestPublicId],
                                            actionDate:
                                                data[KRequestActionDate],
                                            rImageUrl:
                                                data[KRequestImageUrl] == null
                                                    ? []
                                                    : data[KRequestImageUrl]
                                                        .map<String>(
                                                            (i) => i as String)
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
                                                          top: (index == 0)
                                                              ? 4
                                                              : 0),
                                                      child: StreamBuilder(
                                                          stream: Firestore
                                                              .instance
                                                              .collection(
                                                                  KUserCollection)
                                                              .document(_requests
                                                                  .elementAt(
                                                                      index)
                                                                  .userId) //ID OF DOCUMENT
                                                              .snapshots(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting)
                                                              return new Center(
                                                                  child:
                                                                      new CircularProgressIndicator());
                                                            if (snapshot
                                                                .hasData) {
                                                              var document2 =
                                                                  snapshot.data;
                                                              return SlidableTile(
                                                                profile: document2[
                                                                    KUserImageUrl],
                                                                userName:
                                                                    document2[
                                                                        KUserName],
                                                                request: _requests
                                                                    .elementAt(
                                                                        index),
                                                                status:
                                                                    "complete",
                                                                hasAction: (_requests
                                                                    .elementAt(
                                                                        index).rating==0)?false:true,
                                                                forUser: false,
                                                                providerLocationId:
                                                                    providerDocument[
                                                                        KProviderLocationId],
                                                              );
                                                            } else {
                                                              return new CircularProgressIndicator();
                                                            }
                                                          })),
                                              itemCount: _requests.length,
                                              separatorBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Divider(
                                                  thickness: 1,
                                                  // height: 1,
                                                );
                                              },
                                            ),
                                          )
                                        : Center(
                                            child: Text(
                                              'No Requests completed request',
                                              style: TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          );
                                  } else {
                                    Center(
                                      child: Text(
                                        'No Requests completed request',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                                  }
                                })
                            : Text("Loading");
              }),
          SizedBox(
            height: 10,
          ),
        ]),
      ),
    );
  }
}
