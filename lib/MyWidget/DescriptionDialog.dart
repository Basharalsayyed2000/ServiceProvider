import 'package:flutter/material.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/Services/store.dart';

class DescriptionDialog extends StatelessWidget{

  final String pid;
  final Store _store = Store();
  String _description;
  
  DescriptionDialog({@required this.pid});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/1.5,
          // color: Colors.white,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20)
          ),
          padding: EdgeInsets.fromLTRB(15,MediaQuery.of(context).size.height/10,15,15),
          child: Form(
            onChanged: (){
              print(_description);
            },
            
            child: ListView(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 25, bottom: 10),
                  child: Text("Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 50),
                  child: CustomTextField(
                    minLines: 5,
                    maxLength: 200,
                    labelText: '',
                    onClicked: (value) {
                      print(value);
                      if(value != "")
                        _description = value;
                    }, 
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: CustomButton(
                    textValue: "Submit",
                    onPressed: (){
                      print(_description);
                      // _store.updateDescription(_description, pid);
                    }, 
                  ),
                )
              ],
            ),
          ),
        )
    );
  }

}