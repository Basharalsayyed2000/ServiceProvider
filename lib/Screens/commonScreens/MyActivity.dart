import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:service_provider/MyTools/Constant.dart';

class MyActivity extends StatefulWidget {
  static String id = "myActivity";

  @override
  State<StatefulWidget> createState() {
    return _MyActivity();
  }
}

class _MyActivity extends State<MyActivity> {
  String userId;
  double rejectedCount=0, disactiveCount=0, inprogressCount=0, completeCount=0, idleCount=0;
  bool loading=false;
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
      Task("disActive ", disactiveCount, Colors.redAccent),
      Task("Idle ", idleCount, Colors.orange),
      Task("Completed ", completeCount, Colors.deepPurpleAccent),
      Task("Inprogress ", inprogressCount, Colors.cyanAccent),
      Task("Rejected ", rejectedCount, Colors.lightGreenAccent),
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
            ],
          ),
        ),
      ):
      CircularProgressIndicator(),
    );
  }

  _fetchData() async {
    await Firestore.instance
        .collection(KRequestCollection)
        .getDocuments()
        .then((QuerySnapshot querySnapshot) async {
      querySnapshot.documents.forEach((doc) {
        if (userId == doc[KRequestUserId]) {
          if(!doc[KRequestIsActive]){
            setState(() {
               disactiveCount++;
               print("disactive $disactiveCount");
            });
          }
          else if(doc[KRequestIsActive]&& !doc[KRequestIsProviderSeen]){
             setState(() {
              idleCount++;
               print("idleCount $idleCount");
            });
          }
           else if(doc[KRequestIsActive]&& doc[KRequestIsProviderSeen] && doc[KRequestIsCompleted]){
             setState(() {
              completeCount++;
               print("completeCount $completeCount");
            });
          }
           else if(doc[KRequestIsActive]&& doc[KRequestIsProviderSeen] && !doc[KRequestIsCompleted]&& doc[KRequestIsAccepted]){
              setState(() {
              inprogressCount++;
               print("inprogressCount $inprogressCount");
            });
          }
           else if(doc[KRequestIsActive]&& doc[KRequestIsProviderSeen] && !doc[KRequestIsCompleted]&& !doc[KRequestIsAccepted]){
              setState(() {
              rejectedCount++;
              print("rejectedCount $rejectedCount");
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
