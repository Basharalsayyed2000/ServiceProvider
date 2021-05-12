import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:service_provider/MyTools/Constant.dart';

class MyActivity extends StatefulWidget{
  static String id = "myActivity";

  @override
  State<StatefulWidget> createState(){
    return _MyActivity();
  }
}

class _MyActivity extends State<MyActivity>{

  @override
  void initState() {
    super.initState();
    _seriesPieData = new List<charts.Series<Task, String>>();
    _generateData();
  }

  List<charts.Series<Task, String>> _seriesPieData;
  
  _generateData(){
    var pieData = [
      Task("Private Requests", 30, Colors.redAccent),
      Task("Idle Requests", 10, Colors.orange),
      Task("Completed Requests", 10, Colors.deepPurpleAccent),
    ];
    
    _seriesPieData.add(
      charts.Series(
        data: pieData,
        domainFn: (Task task,_) => task.name,
        measureFn: (Task task,_) => task.value,
        colorFn: (Task task,_) => charts.ColorUtil.fromDartColor(task.color),
        id: "My Activity",
        labelAccessorFn: (Task row,_)=> row.value.toString(),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KprimaryColor,
        title: Text("My Activity"),
        centerTitle: true,
      ),
      body: Padding(
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

              SizedBox(height: 50.0,),

              Expanded(
                child: charts.PieChart(
                  _seriesPieData,
                  animate: true,
                  animationDuration: Duration(seconds: 4),
                  behaviors: [
                    charts.DatumLegend(
                      outsideJustification: charts.OutsideJustification.endDrawArea,
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
                        labelPosition: charts.ArcLabelPosition.inside
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

class Task{
  String name;
  double value;
  Color color;

  Task(this.name, this.value, this.color);
}