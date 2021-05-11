import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/Provider/JobDetails.dart';

class RecommendedJobs extends StatefulWidget {
  static String id = "RecommendedJobs";
  @override
  _RecommendedJobsState createState() => _RecommendedJobsState();
}

class _RecommendedJobsState extends State<RecommendedJobs> {
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
        backgroundColor: KprimaryColor,
        title: Text("Hello"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:  Firestore.instance.collection(KRequestCollection).snapshots(),//store.loadRequest(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<RequestModel> requests = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              if (data[KRequestProviderId] == pId) {
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
            return ListView.builder(
              primary: false,
              itemBuilder: (context, index) => Stack(
                children: <Widget>[
                  buildCard("${requests[index].rProblem}",
                      "${requests[index].rDescription}", requests[index]),
                ],
              ),
              itemCount: requests.length,
            );
          } else {
            return Center(
              child: Text('no provider provide this service'),
            );
          }
        },
      ),
    );
  }

  Card buildCard(String title, String subtitle, RequestModel _request) {
    return Card(
      child: GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, JobDetails.id, arguments: _request),
        child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            // leading: CircleAvatar(
            //   backgroundImage: imageurl == ''
            //       ? AssetImage('Assets/images/provider.jpg')
            //       : NetworkImage(imageurl),
            //   radius: MediaQuery.of(context).size.height * 0.037,
            // ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
            )),
      ),
    );
  }
}
