import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget{
  static String id='loginScreen';
  @override
  State<StatefulWidget> createState(){
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen>{

  var currencies = {'Lebanese Pounds', 'Ghana Cedis', 'Dollars', 'Pounds'};
  var _selectedcurrency = 'Lebanese Pounds';

  final _minimumPadding = 5.0;

  @override
  Widget build(BuildContext context){
    TextStyle textStyle = Theme.of(context).textTheme.headline6;
    return Scaffold(

      appBar: AppBar(
        title: Text("Simple Interest Calculator"),
        centerTitle: true,
      ),

      body: Container(
        margin: EdgeInsets.all(_minimumPadding*2),
        child: ListView(
          children: <Widget>[

            Container(
                margin: EdgeInsets.all(_minimumPadding * 10),
                child: getLogo()
            ),

            Padding(
              padding: EdgeInsets.all(_minimumPadding),
              child: TextField(
                style: textStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0)
                    ),
                    labelText: "Principal",
                    hintText: "Enter Principal e.g. 12000"
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(_minimumPadding),
              child: TextField(
                style: textStyle,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    labelText: "Rate Of Interest",
                    hintText: "In percent"
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
              child: Row(
                children: <Widget>[

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(_minimumPadding),
                      child: TextField(
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          labelText: "Term",
                          hintText: "Time in years",
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(_minimumPadding),
                      child: DropdownButton<String>(
                        style: textStyle,
                        value: _selectedcurrency,
                        items: currencies.map((String currency){
                          return DropdownMenuItem<String>(
                            child: Text(currency),
                            value: currency,
                          );
                        }).toList(),
                        onChanged: (String item){
                          setState(() {
                            _selectedcurrency = item;
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(_minimumPadding),
              child: Row(
                children: <Widget>[

                  Expanded(
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                        child: Text("Calculate", textScaleFactor: 1.5,),
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        onPressed: (){}
                    ),
                  ),

                  Expanded(
                    // ignore: deprecated_member_use
                    child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,

                        child: Text("Reset", textScaleFactor: 1.5,),
                        onPressed: (){}
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
              child: Text("Todo Text", style: textStyle),
            )
          ],
        ),
      ),
    );
  }

  Widget getLogo(){
    AssetImage assetImage = new AssetImage('assets/bank app logo 2.0.png');
    Image image = new Image(image: assetImage, width: 125.0, height: 125.0,);

    return image;
  }
}