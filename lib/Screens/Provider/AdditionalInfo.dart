import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/MapDialog.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';

class AdditionalInfo extends StatefulWidget{
  static String id = "additionalInfo";
  @override
  State<StatefulWidget> createState() {
    return _AdditionalInfo();
  }
}

class _AdditionalInfo extends State<AdditionalInfo>{

  List<String> _services = ["Mechanic","Electrician", "Parker"];
  String _currentItemSelected = "";

  @override
  void initState() {
    _currentItemSelected = _services[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: ListView(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 40),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(120.0),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey, spreadRadius: 1.5),
                  ],
                ),
                padding: const EdgeInsets.all(18),
                child: Image(
                  image: AssetImage("Assets/images/noprofile.png"),
                  width: 120.0,
                  height: 120.0,

                ),
              ),
            ),

            Container(
              margin: EdgeInsets.only(right: MediaQuery.of(context).size.width/4 * 2, top: MediaQuery.of(context).size.height/20),
              padding: EdgeInsets.only(left: 15),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(color: KprimaryColor, spreadRadius: 1.5)
                ]
              ),
              child: DropdownButton<String>(
                isExpanded: false,
                dropdownColor: KprimaryColor,
                style: TextStyle(
                  color: KprimaryColorDark,
                  fontSize: 18
                ),
                value: _currentItemSelected,
                items: _services.map(
                  (String dropDownItems) => DropdownMenuItem<String>(
                    value: dropDownItems,
                    child: Text(dropDownItems),
                  )
                ).toList(),
                onChanged: (String dropDownItem) {
                  setState((){
                      _currentItemSelected = dropDownItem;
                    }
                  );
                }
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/20),
              child: CustomTextField(
                minLines: 5,
                maxLength: 200, labelText: '', onClicked: null,
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/60),
              child: CustomTextField(
                enabled: false,
                labelText: "Address", onClicked: null,
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/40),
              margin: EdgeInsets.only(left: MediaQuery.of(context).size.width/4, right: MediaQuery.of(context).size.width/4),
              child: CustomButton(
                onPressed: (){
                  MapDialogHelper.exit(context,null,null,false);
                },
                textValue: "Set Location"
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),
              child: CustomButton(
                onPressed: (){

                },
                textValue: "Sign Up"
              ),
            ),

          ],
        ),
      ),
    );
  }
}