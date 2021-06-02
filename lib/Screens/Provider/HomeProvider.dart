import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/SlidableTile.dart';

class HomeProvider extends StatefulWidget {
  static String id = 'HomeProvider';
  @override
  _HomeProviderState createState() => _HomeProviderState();
}

class _HomeProviderState extends State<HomeProvider> {
  String pageName = "available";
  List<RequestModel> requests;
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
          elevation: 0,
          title: Text("My Jobs"),
          centerTitle: true,
          backgroundColor: KprimaryColor,
        ),
        body: Column(children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          pageName = "available";
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            "Available",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: (pageName == "Available")
                                    ? Colors.black
                                    : Colors.grey),
                          ),
                          if (pageName == "Available")
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
                          pageName = "Inprogress";
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            "InProgress",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: (pageName == "Inprogress")
                                    ? Colors.black
                                    : Colors.grey),
                          ),
                          if (pageName == "Inprogress")
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
                          pageName = "completed";
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            "Completed",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: (pageName == "completed")
                                    ? Colors.black
                                    : Colors.grey),
                          ),
                          if (pageName == "completed")
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
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          (pageName == "Available")
              ? StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection(KRequestCollection)
                      .snapshots(), //store.loadRequest(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    if (snapshot.hasData) {
                      requests = [];
                      for (var doc in snapshot.data.documents) {
                        var data = doc.data;
                        if (data[KRequestProviderId] == pId &&
                            data[KRequestIsActive] &&
                            !data[KRequestIsCompleted] &&
                            !data[KRequestIsAccepted] &&
                            !data[KRequestIsProviderSeen]) {
                          requests.add(RequestModel(
                              rAddDate: data[KRequestAddDate],
                              rProblem: data[KRequestProblem],
                              requestTime: data[KRequestTime],
                              requestDate: data[KRequestDate],
                              rDescription: data[KRequestDescription],
                              requestId: doc.documentID,
                              isAccepted: data[KRequestIsAccepted],
                              isActive: data[KRequestIsActive],
                              isComplete: data[KRequestIsCompleted],
                              locationId: data[KRequestLocationId],
                              userId: data[KRequestUserId],
                              rImageUrl: (data[KRequestImageUrl] == null)
                                  ? []
                                  : List.from(data[KRequestImageUrl]),
                              providerId: data[KRequestProviderId]));
                        }
                      }
                      var profile =
                          "https://am3pap003files.storage.live.com/y4mo7WDu-vFo78fggCLw9NZxp02tlFBN9obvHx5qpT7f7PHWLo-x2Yz5lTI1550vW53xyuYyHEOEfctpjPI5IbYkGvfJKd1KhYHF8shP98AC_NdfOHLtYKlmQo37oXMgW-8CTskyEnYuU-3EjkY2peQ_FvkE_wkloeXkhTp1xynY4tDJqvl9ZeijER1B01oCtw31Mk8ggKyPL0Y5TZXSCH0pw/bashar.jpeg?psid=1&width=720&height=718";
                      return ListView.separated(
                        primary: false,
                        itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.only(top: (index == 0) ? 8 : 0),
                            child: SlidableTile(
                              profile: profile,
                              user: "Bashar alsayyed Adnan",
                              title: requests.elementAt(index).rProblem,
                              schedule:
                                  "${requests.elementAt(index).requestDate.substring(0, 10)} ${requests.elementAt(index).requestTime.substring(10, 16)}",
                              distance: "${0.5 + index}",
                              action: "cancle",
                              hasAction: true,
                            )),
                        itemCount: requests.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            thickness: 1,
                            // height: 1,
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text('no provider provide this service'),
                      );
                    }
                    // ignore: dead_code
                    if (snapshot.hasData && requests.isEmpty) {
                      return Center(
                        child: Text('There is no recommended job'),
                      );
                    }
                  },
                )
              : StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance
                      .collection(KRequestCollection)
                      .snapshots(), //store.loadRequest(),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting)
                      return Center(child: CircularProgressIndicator());
                    if (snapshot.hasData) {
                      requests = [];
                      for (var doc in snapshot.data.documents) {
                        var data = doc.data;
                        if (data[KRequestProviderId] == pId &&
                            data[KRequestIsActive] &&
                            !data[KRequestIsCompleted] &&
                            !data[KRequestIsAccepted] &&
                            !data[KRequestIsProviderSeen]) {
                          requests.add(RequestModel(
                              rAddDate: data[KRequestAddDate],
                              rProblem: data[KRequestProblem],
                              requestTime: data[KRequestTime],
                              requestDate: data[KRequestDate],
                              rDescription: data[KRequestDescription],
                              requestId: doc.documentID,
                              isAccepted: data[KRequestIsAccepted],
                              isActive: data[KRequestIsActive],
                              isComplete: data[KRequestIsCompleted],
                              locationId: data[KRequestLocationId],
                              userId: data[KRequestUserId],
                              rImageUrl: (data[KRequestImageUrl] == null)
                                  ? []
                                  : List.from(data[KRequestImageUrl]),
                              providerId: data[KRequestProviderId]));
                        }
                      }
                      var profile =
                          "https://am3pap003files.storage.live.com/y4mo7WDu-vFo78fggCLw9NZxp02tlFBN9obvHx5qpT7f7PHWLo-x2Yz5lTI1550vW53xyuYyHEOEfctpjPI5IbYkGvfJKd1KhYHF8shP98AC_NdfOHLtYKlmQo37oXMgW-8CTskyEnYuU-3EjkY2peQ_FvkE_wkloeXkhTp1xynY4tDJqvl9ZeijER1B01oCtw31Mk8ggKyPL0Y5TZXSCH0pw/bashar.jpeg?psid=1&width=720&height=718";
                      return ListView.separated(
                        primary: false,
                        itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.only(top: (index == 0) ? 8 : 0),
                            child: SlidableTile(
                              profile: profile,
                              user: "Bashar alsayyed Adnan",
                              title: requests.elementAt(index).rProblem,
                              schedule:
                                  "${requests.elementAt(index).requestDate.substring(0, 10)} ${requests.elementAt(index).requestTime.substring(10, 16)}",
                              distance: "${0.5 + index}",
                              action: "cancle",
                              hasAction: true,
                            )),
                        itemCount: requests.length,
                        separatorBuilder: (BuildContext context, int index) {
                          return Divider(
                            thickness: 1,
                            // height: 1,
                          );
                        },
                      );
                    } else {
                      return Center(
                        child: Text('no provider provide this service'),
                      );
                    }
                    // ignore: dead_code
                    if (snapshot.hasData && requests.isEmpty) {
                      return Center(
                        child: Text('There is no recommended job'),
                      );
                    }
                  },
                )
        ]));
  }
}
