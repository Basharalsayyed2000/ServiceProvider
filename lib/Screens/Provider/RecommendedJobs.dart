import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/NeededData.dart';
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
  List<RequestModel> requests=[];
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
  // ignore: missing_return
  Widget build(BuildContext context) {
    String pageType = ModalRoute.of(context).settings.arguments;
    if(pageType=="Available"){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        title: Text("Avaliable Jobs"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:  Firestore.instance.collection(KRequestCollection).snapshots(),//store.loadRequest(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
             requests= [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              if (data[KRequestProviderId] == pId && data[KRequestIsActive] && !data[KRequestIsCompleted] && !data[KRequestIsAccepted ] && !data[KRequestIsProviderSeen]) {
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
                      "${requests[index].rDescription}", NeededData(requestModel:requests[index],pageType:"Available")),
                ],
              ),
              itemCount: requests.length,
            );
          }else {
            return Center(
              child: Text('no provider provide this service'),
            );
          }
          // ignore: dead_code
          if (snapshot.hasData && requests.isEmpty){
            return Center(
              child: Text('There is no recommended job'),
            );
          } 
         
        },
      ),
    );
    }else if(pageType=="Done"){
      return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        title: Text("Done Jobs"),
        centerTitle: true,
      ),
       body: StreamBuilder<QuerySnapshot>(
        stream:  Firestore.instance.collection(KRequestCollection).snapshots(),//store.loadRequest(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
             requests= [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              if (data[KRequestProviderId] == pId && data[KRequestIsActive] && data[KRequestIsCompleted] && data[KRequestIsAccepted ] && data[KRequestIsProviderSeen]) {
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
                      "${requests[index].rDescription}", NeededData(requestModel:requests[index],pageType:"Done")),
                ],
              ),
              itemCount: requests.length,
            );
          }else {
            return Center(
              child: Text('no provider provide this service'),
            );
          }
          // ignore: dead_code
          if (snapshot.hasData && requests.isEmpty){
            return Center(
              child: Text('There is no recommended job'),
            );
          } 
         
        },
      ),
      );
    }
    else if(pageType=="Inprogress"){
        return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        title: Text("InProgress Jobs"),
        centerTitle: true,
      ),
       body: StreamBuilder<QuerySnapshot>(
        stream:  Firestore.instance.collection(KRequestCollection).snapshots(),//store.loadRequest(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
             requests= [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              if (data[KRequestProviderId] == pId && data[KRequestIsActive] && !data[KRequestIsCompleted] && data[KRequestIsAccepted ] && data[KRequestIsProviderSeen]) {
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
                      "${requests[index].rDescription}", NeededData(requestModel:requests[index],pageType:"Inprogress")),
                ],
              ),
              itemCount: requests.length,
            );
          }else {
            return Center(
              child: Text('no provider provide this service'),
            );
          }
          // ignore: dead_code
          if (snapshot.hasData && requests.isEmpty){
            return Center(
              child: Text('There is no recommended job'),
            );
          } 
         
        },
      ),
      );
    }
  }

  Card buildCard(String title, String subtitle, NeededData neededData) {
    return Card(
      child: GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, JobDetails.id, arguments: neededData),
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
