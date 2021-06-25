import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/Models/user.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/SlidableTile.dart';
import 'package:service_provider/Services/auth.dart';
import 'package:service_provider/Services/store.dart';

class MyBooks extends StatefulWidget {
  static String id = 'MyBooks';
  final String userAction;
  final UserModel userModel;
  MyBooks({this.userAction,this.userModel});
  @override
  _MyBooksState createState() => _MyBooksState(userAction: userAction,userModel: userModel);
}

class _MyBooksState extends State<MyBooks> {
  final _store = Store();
  final _auth = Auth();
  String _userId;
  final UserModel userModel;
  final String userAction;
  _MyBooksState({this.userAction,this.userModel});
  @override
  void initState() {
    super.initState();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        title: (userAction == "Sent")
            ? Text("My Sent Request")
            : (userAction == "Book Later")
                ? Text("Inactive Request")
                : (userAction == "Inprogress")
                    ? Text("Inprogress requests")
                    : (userAction == "Rejected")
                        ? Text("Rejected requests")
                        : (userAction == "Completed")
                            ? Text("Compeleted Request")
                            : (userAction == "suggestion")
                                ? Text("requests time suggestion")
                            : Text("Inprogress requests"),
        centerTitle: true,
        elevation: 0,
      ),
      body: (userAction == "Sent")
          ? StreamBuilder<QuerySnapshot>(
              stream: _store.loadRequest(),
              // ignore: missing_return
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return new Center(child: new CircularProgressIndicator());
                if (snapshot.hasData) {
                  List<RequestModel> _requests = [];
                  for (var doc in snapshot.data.documents) {
                    var data = doc.data;
                    String requestId = doc.documentID;
                    if (data[KRequestUserId] == _userId) {
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
                          userId: _userId,
                          isAccepted: data[KRequestIsAccepted],
                          isActive: data[KRequestIsActive],
                          locationId: data[KRequestLocationId],
                          isComplete: data[KRequestIsCompleted],
                          isProviderSeen: data[KRequestIsProviderSeen],
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
                              margin:
                                  EdgeInsets.only(top: (index == 0) ? 8 : 0),
                              child: StreamBuilder(
                                  stream: Firestore.instance
                                      .collection(KProviderCollection)
                                      .document(_requests
                                          .elementAt(index)
                                          .providerId) //ID OF DOCUMENT
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
                                        profile: document2[KProviderImageUrl],
                                        userName: document2[KProviderName],
                                        request: _requests.elementAt(index),
                                        status: "Idle",
                                        hasAction: true,
                                        forUser: true,
                                        providerLocationId:
                                            document2[KProviderLocationId],
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
          : (userAction == "Book Later")
              ? StreamBuilder<QuerySnapshot>(
                  stream: _store.loadRequest(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return new Center(child: new CircularProgressIndicator());
                    if (snapshot.hasData) {
                      List<RequestModel> _requests = [];
                      for (var doc in snapshot.data.documents) {
                        var data = doc.data;
                        String requestId = doc.documentID;
                        if (data[KRequestUserId] == _userId) {
                          if (!data[KRequestIsActive] &&
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
                              userId: _userId,
                              isAccepted: data[KRequestIsAccepted],
                              isActive: data[KRequestIsActive],
                              locationId: data[KRequestLocationId],
                              isComplete: data[KRequestIsCompleted],
                              isProviderSeen: data[KRequestIsProviderSeen],
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
                                  //  color: Colors.grey[300],
                                  margin: EdgeInsets.only(
                                      top: (index == 0) ? 8 : 0),
                                  child: StreamBuilder(
                                      stream: Firestore.instance
                                          .collection(KProviderCollection)
                                          .document(_requests
                                              .elementAt(index)
                                              .providerId) //ID OF DOCUMENT
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
                                                document2[KProviderImageUrl],
                                            userName: document2[KProviderName],
                                            request: _requests.elementAt(index),
                                            status: "Disactive",
                                            hasAction: true,
                                            forUser: true,
                                            providerLocationId:
                                                document2[KProviderLocationId],
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
                            )
                          : Center(
                              child: Text(
                                'There is no InActive Request',
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            );
                    } else {
                      Center(
                        child: Text(
                          'There is no InActive Request',
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.red,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                  })
              : (userAction == "Completed")
                  ? StreamBuilder<QuerySnapshot>(
                      stream: _store.loadRequest(),
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
                            if (data[KRequestUserId] == _userId) {
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
                                  userId: _userId,
                                  isAccepted: data[KRequestIsAccepted],
                                  isActive: data[KRequestIsActive],
                                  locationId: data[KRequestLocationId],
                                  isComplete: data[KRequestIsCompleted],
                                  isProviderSeen: data[KRequestIsProviderSeen],
                                  serviceId: data[KRequestServiceId],
                                  publicId: data[KRequestPublicId],
                                  rating: data[KRequestRating],
                                  commentRating: data[KRequestRatingComment],
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
                                      //  color: Colors.green[300],
                                      margin: EdgeInsets.only(
                                          top: (index == 0) ? 4 : 0),
                                      child: StreamBuilder(
                                          stream: Firestore.instance
                                              .collection(KProviderCollection)
                                              .document(_requests
                                                  .elementAt(index)
                                                  .providerId) //ID OF DOCUMENT
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
                                                  profile: document2[
                                                      KProviderImageUrl],
                                                  userName:
                                                      document2[KProviderName],
                                                  status: "complete",
                                                  hasAction: true,
                                                  forUser: true,
                                                  providerLocationId: document2[
                                                      KProviderLocationId],
                                                  request: _requests
                                                      .elementAt(index),
                                                  providerTotalRate: document2[
                                                      KProviderTotalRate],
                                                  providerPFP: document2[KProviderImageUrl],
                                                  providerNumberOfRating: document2[
                                                      KProviderNumberOfRatedRequest]);
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
                      })
                  : (userAction == "Inprogress")
                      ? StreamBuilder<QuerySnapshot>(
                          stream: _store.loadRequest(),
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
                                if (data[KRequestUserId] == _userId) {
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
                                      userId: _userId,
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
                                  ? ListView.separated(
                                      primary: false,
                                      itemBuilder: (context, index) =>
                                          Container(
                                              // color: Colors.orange[200],
                                              margin: EdgeInsets.only(
                                                  top: (index == 0) ? 8 : 0),
                                              child: StreamBuilder(
                                                  stream: Firestore.instance
                                                      .collection(
                                                          KProviderCollection)
                                                      .document(_requests
                                                          .elementAt(index)
                                                          .providerId) //ID OF DOCUMENT
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
                                                            KProviderImageUrl],
                                                        userName: document2[
                                                            KProviderName],
                                                        request: _requests
                                                            .elementAt(index),
                                                        status: "Inprogress",
                                                        hasAction: false,
                                                        forUser: true,
                                                        providerLocationId:
                                                            document2[
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
                                    )
                                  : Center(
                                      child: Text(
                                        'There is no Inprogress Request',
                                        style: TextStyle(
                                            fontSize: 24,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    );
                            } else {
                              Center(
                                child: Text(
                                  'There is no Inprogress Request',
                                  style: TextStyle(
                                      fontSize: 24,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }
                          })
                      // : (userAction == "publicReaction")
                      //     ? StreamBuilder<QuerySnapshot>(
                      //         stream: _store.loadRequest(),
                      //         // ignore: missing_return
                      //         builder: (context, snapshot) {
                      //           if (snapshot.connectionState ==
                      //               ConnectionState.waiting)
                      //             return new Center(
                      //                 child: new CircularProgressIndicator());
                      //           if (snapshot.hasData) {
                      //             List<RequestModel> _requests = [];
                      //             for (var doc in snapshot.data.documents) {
                      //               var data = doc.data;
                      //               String requestId = doc.documentID;
                      //               if (data[KRequestUserId] == _userId) {
                      //                 //List<dynamic> requestUrl=[];
                      //                 //  if(!(data[KRequestImageUrl]==null)){
                      //                 //  requestUrl= List.of(data[KRequestImageUrl]);
                      //                 // }
                      //                 if (data[KRequestIsActive] &&
                      //                     !data[KRequestIsAccepted] &&
                      //                     !data[KRequestIsCompleted] &&
                      //                     data[KRequestIsProviderSeen])
                      //                   _requests.add(RequestModel(
                      //                     rProblem: data[KRequestProblem],
                      //                     rDescription:
                      //                         data[KRequestDescription],
                      //                     rAddDate: data[KRequestAddDate],
                      //                     requestDate: data[KRequestDate],
                      //                     requestTime: data[KRequestTime],
                      //                     requestId: requestId,
                      //                     providerId: data[KRequestProviderId],
                      //                     userId: _userId,
                      //                     isAccepted: data[KRequestIsAccepted],
                      //                     isActive: data[KRequestIsActive],
                      //                     locationId: data[KRequestLocationId],
                      //                     isComplete: data[KRequestIsCompleted],
                      //                     isProviderSeen:
                      //                         data[KRequestIsProviderSeen],

                      //                     serviceId: data[KRequestServiceId],
                      //                     publicId: data[KRequestPublicId],
                      //                     actionDate: data[KRequestActionDate],
                      //                     rImageUrl:
                      //                         data[KRequestImageUrl] == null
                      //                             ? []
                      //                             : data[KRequestImageUrl]
                      //                                 .map<String>(
                      //                                     (i) => i as String)
                      //                                 .toList(),
                      //                   ));
                      //               }
                      //             }

                      //             return (_requests.isNotEmpty)
                      //                 ? ListView.separated(
                      //                     primary: false,
                      //                     itemBuilder: (context, index) =>
                      //                         Container(
                      //                             //  color: Colors.grey[300],
                      //                             margin: EdgeInsets.only(
                      //                                 top:
                      //                                     (index == 0) ? 8 : 0),
                      //                             child: StreamBuilder(
                      //                                 stream: Firestore.instance
                      //                                     .collection(
                      //                                         KProviderCollection)
                      //                                     .document(_requests
                      //                                         .elementAt(index)
                      //                                         .providerId) //ID OF DOCUMENT
                      //                                     .snapshots(),
                      //                                 builder:
                      //                                     (context, snapshot) {
                      //                                   if (snapshot
                      //                                           .connectionState ==
                      //                                       ConnectionState
                      //                                           .waiting)
                      //                                     return new Center(
                      //                                         child:
                      //                                             new CircularProgressIndicator());
                      //                                   if (snapshot.hasData) {
                      //                                     var document2 =
                      //                                         snapshot.data;
                      //                                     return SlidableTile(
                      //                                       profile: document2[
                      //                                           KProviderImageUrl],
                      //                                       userName: document2[
                      //                                           KProviderName],
                      //                                       request: _requests
                      //                                           .elementAt(
                      //                                               index),
                      //                                       status:
                      //                                           "publicReaction",
                      //                                       hasAction: false,
                      //                                       forUser: true,
                      //                                       providerLocationId:
                      //                                           document2[
                      //                                               KProviderLocationId],
                      //                                     );
                      //                                   } else {
                      //                                     return new CircularProgressIndicator();
                      //                                   }
                      //                                 })),
                      //                     itemCount: _requests.length,
                      //                     separatorBuilder:
                      //                         (BuildContext context,
                      //                             int index) {
                      //                       return Divider(
                      //                         thickness: 1,
                      //                         // height: 1,
                      //                       );
                      //                     },
                      //                   )
                      //                 : Center(
                      //                     child: Text(
                      //                       'There is no sent Request',
                      //                       style: TextStyle(
                      //                           fontSize: 24,
                      //                           color: Colors.red,
                      //                           fontWeight: FontWeight.bold),
                      //                     ),
                      //                   );
                      //           } else {
                      //             Center(
                      //               child: Text(
                      //                 'There is no sent Request',
                      //                 style: TextStyle(
                      //                     fontSize: 24,
                      //                     color: Colors.red,
                      //                     fontWeight: FontWeight.bold),
                      //               ),
                      //             );
                      //           }
                      //         })
                      : (userAction == "Rejected")
                          ? StreamBuilder<QuerySnapshot>(
                              stream: _store.loadRequest(),
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
                                    if (data[KRequestUserId] == _userId) {
                                      if (data[KRequestIsActive] &&
                                          !data[KRequestIsAccepted] &&
                                          !data[KRequestIsCompleted] &&
                                          data[KRequestIsProviderSeen])
                                        _requests.add(RequestModel(
                                          rProblem: data[KRequestProblem],
                                          rDescription:
                                              data[KRequestDescription],
                                          rAddDate: data[KRequestAddDate],
                                          requestDate: data[KRequestDate],
                                          requestTime: data[KRequestTime],
                                          requestId: requestId,
                                          providerId: data[KRequestProviderId],
                                          userId: _userId,
                                          isAccepted: data[KRequestIsAccepted],
                                          isActive: data[KRequestIsActive],
                                          locationId: data[KRequestLocationId],
                                          isComplete: data[KRequestIsCompleted],
                                          isProviderSeen:
                                              data[KRequestIsProviderSeen],
                                          serviceId: data[KRequestServiceId],
                                          publicId: data[KRequestPublicId],
                                          actionDate: data[KRequestActionDate],
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
                                      ? ListView.separated(
                                          primary: false,
                                          itemBuilder: (context, index) =>
                                              Container(
                                                  // color: Colors.orange[200],
                                                  margin: EdgeInsets.only(
                                                      top:
                                                          (index == 0) ? 8 : 0),
                                                  child: StreamBuilder(
                                                      stream: Firestore.instance
                                                          .collection(
                                                              KProviderCollection)
                                                          .document(_requests
                                                              .elementAt(index)
                                                              .providerId) //ID OF DOCUMENT
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
                                                                KProviderImageUrl],
                                                            userName: document2[
                                                                KProviderName],
                                                            request: _requests
                                                                .elementAt(
                                                                    index),
                                                            status: "Rejected",
                                                            hasAction: true,
                                                            forUser: true,
                                                            userModel: this.userModel,
                                                            providerLocationId:
                                                                document2[
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
                                        )
                                      : Center(
                                          child: Text(
                                            'There is no Rejected Request',
                                            style: TextStyle(
                                                fontSize: 24,
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        );
                                } else {
                                  Center(
                                    child: Text(
                                      'There is no Rejected Request',
                                      style: TextStyle(
                                          fontSize: 24,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  );
                                }
                              })
                          : Center(
                              child: Text('Loading'),
                            ),
    );
  }

  void handleClick2(String value) {
    switch (value) {
      case 'Edit':
        break;
      case 'Settings':
        break;
    }
  }
}
