import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/Models/UserAction.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/SlidableTile.dart';
import 'package:service_provider/Screens/Request/RequestComponent.dart';
import 'package:service_provider/Services/auth.dart';
import 'package:service_provider/Services/store.dart';

class MyBooks extends StatefulWidget {
  static String id = 'MyBooks';

  @override
  _MyBooksState createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  final _store = Store();
  final _auth = Auth();
  String _userId;
  UserActionModel userAction;
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
    userAction = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        title: (userAction.userAction == "Sent")
            ? Text("My Sent Request")
            : (userAction.userAction == "Book Later")
                ? Text("Disactive Request")
                : (userAction.userAction == "Inprogress")
                    ? Text("Inprogress requests")
                    : Text("Completed requests"),
        centerTitle: true,
        elevation: 0,
      ),
      body: (userAction.userAction == "Sent")
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
                          userId: _userId,
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
                      ? ListView.separated(
                          primary: false,
                          itemBuilder: (context, index) => Container(
                              color: Colors.blue[200],
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
                                        user: document2[KProviderName],
                                        title:
                                            _requests.elementAt(index).rProblem,
                                        schedule:
                                            "${_requests.elementAt(index).requestDate.substring(0, 10)} ${_requests.elementAt(index).requestTime.substring(10, 16)}",
                                        distance: "${0.5 + index}",
                                        action: "cancle",
                                        hasAction: true,
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
          : (userAction.userAction == "Book Later")
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
                          //List<dynamic> requestUrl=[];
                          //  if(!(data[KRequestImageUrl]==null)){
                          //  requestUrl= List.of(data[KRequestImageUrl]);
                          // }
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
                          ? ListView.separated(
                              primary: false,
                              itemBuilder: (context, index) => Container(
                                  color: Colors.grey[300],
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
                                            user: document2[KProviderName],
                                            title: _requests
                                                .elementAt(index)
                                                .rProblem,
                                            schedule:
                                                "${_requests.elementAt(index).requestDate.substring(0, 10)} ${_requests.elementAt(index).requestTime.substring(10, 16)}",
                                            distance: "${0.5 + index}",
                                            action: "activate",
                                            hasAction: true,
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
              : (userAction.userAction == "Completed")
                  ?  StreamBuilder<QuerySnapshot>(
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
                              userId: _userId,
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
                          ? ListView.separated(
                              primary: false,
                              itemBuilder: (context, index) => Container(
                                  color: Colors.green[300],
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
                                            profile:
                                                document2[KProviderImageUrl],
                                            user: document2[KProviderName],
                                            title: _requests
                                                .elementAt(index)
                                                .rProblem,
                                            schedule:
                                                "${_requests.elementAt(index).requestDate.substring(0, 10)} ${_requests.elementAt(index).requestTime.substring(10, 16)}",
                                            distance: "${0.5 + index}",
                                            action: "Completed",
                                            hasAction: false,
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
                  : (userAction.userAction == "Inprogress")
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
                              userId: _userId,
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
                          ? ListView.separated(
                              primary: false,
                              itemBuilder: (context, index) => Container(
                                  color: Colors.orange[200],
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
                                            user: document2[KProviderName],
                                            title: _requests
                                                .elementAt(index)
                                                .rProblem,
                                            schedule:
                                                "${_requests.elementAt(index).requestDate.substring(0, 10)} ${_requests.elementAt(index).requestTime.substring(10, 16)}",
                                            distance: "${0.5 + index}",
                                            action: "Inprogress",
                                            hasAction: false,
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
                      : Center(
                          child: Text('Loading'),
                        ),
    );
  }

  Card buildCard(String title, String subtitle, RequestModel _request) {
    return Card(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, RequestComponent.id,
            arguments: _request),
        child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            leading: CircleAvatar(
              backgroundImage: AssetImage('Assets/images/provider.jpg'),
              radius: MediaQuery.of(context).size.height * 0.037,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.phone),
                PopupMenuButton<String>(
                  onSelected: handleClick2,
                  itemBuilder: (BuildContext context) {
                    return {'Edit', 'Settings'}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ],
            )),
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
