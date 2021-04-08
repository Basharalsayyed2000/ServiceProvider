// ignore: unused_import
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:intl/intl.dart';
import 'package:service_provider/MyTools/Constant.dart';

class ServiceRequest extends StatefulWidget{
  static String id = "serviceRequestScreen";
  @override
  State<StatefulWidget> createState(){
    return _ServiceRequest();
  }
}

class _ServiceRequest extends State<ServiceRequest>{
  Color color1 = Color.fromRGBO(212, 241, 244, 1);
  Color color2 = Color.fromRGBO(117, 230, 218, 1);
  Color color3 = Color.fromRGBO(24, 154, 180, 1);
  Color color4 = Color.fromRGBO(4, 68, 95, 1);

  // ignore: avoid_init_to_null
  Color _colorP = null;
  // ignore: avoid_init_to_null
  FontWeight _weightP = null;
  // ignore: avoid_init_to_null
  Color _colorD = null;
  // ignore: avoid_init_to_null
  FontWeight _weightD = null;

  DateTime date1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Provider"),
        backgroundColor: primaryColor,
        centerTitle: true,
      ),

      body: Container(
        margin: EdgeInsets.only(left: minimumpadding * 2, right: minimumpadding * 2),
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                padding: EdgeInsets.all(minimumpadding * 5),
                child: Image(
                  image: AssetImage("Assets/images/serviceRequestLogo.png"),
                  width: minimumpadding*40,
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(bottom: minimumpadding * 3),
              child: Focus(

                onFocusChange: (hasFocus){
                  setState(() {
                    _colorP = hasFocus ? primaryColorDark : null;
                    _weightP = hasFocus ? FontWeight.bold : null;
                  });
                },

                child: TextField(

                  autofocus: false,

                  decoration: InputDecoration(
                    labelText: "Problem",
                    labelStyle: TextStyle(
                      color: _colorP,
                      fontWeight: _weightP
                    ),
                    hintText: "Describe your current situation.",
                    // prefixIcon: Icon(Icons.title),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: disabledColor, width: 2),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: focusColor, width: 3),
                    ),

                  ),

                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(bottom: minimumpadding * 5),
              child: Focus(

                onFocusChange: (hasFocus){
                  setState(() {
                    _colorD = hasFocus ? primaryColorDark : null;
                    _weightD = hasFocus ? FontWeight.bold : null;
                  });
                },

                child: TextField(
                  autofocus:  false,

                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,

                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(
                      color: _colorD,
                      fontWeight: _weightD
                    ),
                    hintText: "Describe your current situation.",
                    // prefixIcon: Icon(Icons.title),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: disabledColor, width: 2),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: focusColor, width: 3),
                    ),

                  ),

                ),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: DatePickerWidget(
                firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                lastDate: DateTime(2030, 12, DateTime.now().day),
                pickerTheme: DateTimePickerTheme(
                  itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
                  dividerColor: primaryColor,
                  backgroundColor: null
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}