import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:service_provider/MyTools/Constant.dart';

class MyActivity extends StatefulWidget {
  static String id = "myActivity";
  final bool isUser;
  final String serviceid;
  MyActivity({this.isUser,this.serviceid});
  @override
  State<StatefulWidget> createState() {
    return _MyActivity(isUser:isUser,serviceid:serviceid);
  }
}

class _MyActivity extends State<MyActivity> {
  String userId;
  double rejectedCount=0, disactiveCount=0, inprogressCount=0, completeCount=0, idleCount=0,total=0,idleCountPublic=0;
  bool loading=false;
  final bool isUser;
  final String serviceid;
  _MyActivity({this.isUser,this.serviceid});
  List<charts.Series<Task, String>> _seriesPieData;


  void getcurrentid() async {
    String _userId = (await FirebaseAuth.instance.currentUser()).uid;
    setState(() {
      userId = _userId;
    });
  }

  @override
  void initState() {
    super.initState();
    getcurrentid();
    _fetchData();
    // ignore: deprecated_member_use
    _seriesPieData = new List<charts.Series<Task, String>>(); 
  }


  _generateData() {
    var pieData;
    setState(() {
      pieData = [
      Task("Completed ", completeCount, Colors.green), 
      (isUser)?Task("disActive ", disactiveCount, Colors.grey):Task("public Idle",idleCountPublic,Colors.purple),
      (isUser)?Task("Rejected ", rejectedCount, Colors.red):Task("",0,Colors.white),
      Task((isUser)?"Idle ":"private Idle ", idleCount, Colors.yellow),
      Task("Inprogress ", inprogressCount, Colors.orange),
    ];
    });
  

    _seriesPieData.add(charts.Series(
      data: pieData,
      domainFn: (Task task, _) => task.name,
      measureFn: (Task task, _) => task.value,
      colorFn: (Task task, _) => charts.ColorUtil.fromDartColor(task.color),
      id: "My Activity",
      labelAccessorFn: (Task row, _) => row.value.toString(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        title: Text("My Activity"),
        centerTitle: true,
      ),
      body:(loading==true)?
       Padding(
        padding: EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                "Number of Requests",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Expanded(
                child: charts.PieChart(
                  _seriesPieData,
                  animate: true,
                  animationDuration: Duration(seconds: 4),
                  behaviors: [
                    charts.DatumLegend(
                      outsideJustification:
                          charts.OutsideJustification.endDrawArea,
                      horizontalFirst: false,
                      desiredMaxRows: 2,
                      cellPadding: EdgeInsets.only(top: 5, right: 4, bottom: 4),
                      entryTextStyle: charts.TextStyleSpec(
                        color: charts.MaterialPalette.purple.shadeDefault,
                        fontFamily: 'Georgia',
                        fontSize: 15,
                      ),
                    ),
                  ],
                  defaultRenderer: charts.ArcRendererConfig(
                    arcWidth: 100,
                    arcRendererDecorators: [
                      charts.ArcLabelDecorator(
                          labelPosition: charts.ArcLabelPosition.inside)
                    ],
                  ),
                ),
              ),
              Container(
                child: Text("Total Requests :$total"),
              ),
            ],
          ),
        ),
      ):
      Center(child: CircularProgressIndicator()),
    );
  }

  _fetchData() async {
    await Firestore.instance
        .collection(KRequestCollection)
        .getDocuments()
        .then((QuerySnapshot querySnapshot) async {
      querySnapshot.documents.forEach((doc) {
        if (userId == ((isUser)?doc[KRequestUserId]:doc[KRequestProviderId]) || ((!isUser)?doc[KRequestServiceId]==serviceid:false)) {
          if(!doc[KRequestIsActive]){
            setState(() {
              (isUser)? disactiveCount++:disactiveCount=0;
              (isUser)? total++:total=total;
            });
          }
          else if(doc[KRequestIsActive]&& !doc[KRequestIsProviderSeen] ){
             setState(() {
              (isUser)?idleCount++
              :(doc[KRequestIsPublic])?
               idleCountPublic++
              : idleCount++;

              total++;
            });
          }
           else if(doc[KRequestIsActive]&& doc[KRequestIsProviderSeen] && doc[KRequestIsCompleted]){
             setState(() {
              completeCount++;
               total++;
            });
          }
           else if(doc[KRequestIsActive]&& doc[KRequestIsProviderSeen] && !doc[KRequestIsCompleted]&& doc[KRequestIsAccepted]){
              setState(() {
              inprogressCount++;
               total++;
            });
          }
           else if(doc[KRequestIsActive]&& doc[KRequestIsProviderSeen] && !doc[KRequestIsCompleted]&& !doc[KRequestIsAccepted]){
              setState(() {
              (isUser)?rejectedCount++:rejectedCount=0;
              (isUser)? total++:total=total;
            });
          }
        }
      });
    });
    _generateData();
    setState(() {
      loading=true;
    });
  }
}

class Task {
  String name;
  double value;
  Color color;

  Task(this.name, this.value, this.color);
}
