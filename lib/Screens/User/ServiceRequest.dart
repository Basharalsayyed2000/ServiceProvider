import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';

class ServiceRequest extends StatefulWidget{
  static String id = "serviceRequestScreen";
  @override
  State<StatefulWidget> createState(){
    return _ServiceRequest();
  }
}

class _ServiceRequest extends State<ServiceRequest>{

  Color _colorD;
  FontWeight _weightD;

  Color _colorDt;
  FontWeight _weightDt;
  Color _colorT;
  FontWeight _weightT;

  DateTime _date;
  DateTime _time;

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
                  width: 160.0,
                  height: 160.0,
                ),
              ),
            ),

            Container(

              child: MyCustomTextField(
                labelText: "Problem",
                hintText: "Describe your current situation.",
              ),
            ),

            Container(
              child: Container(
                padding: EdgeInsets.only(top: minimumpadding * 1.35, bottom: minimumpadding * 1.35),
                height: 70,
                child: getDateFormPicker(),
              ),
            ),

            Container(
              child: Container(
                  height: height,
                  padding: EdgeInsets.only(top: minimumpadding * 1.35, bottom: minimumpadding * 1.35),
                  margin: EdgeInsets.symmetric(vertical: minimumpadding*1.35),
                  child: getTimeFormPicker()
              ),
            ),



            Container(
              padding: EdgeInsets.only(top: minimumpadding * 1.8),
              //height: 70,
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
                  minLines: 2,
                  maxLines: 5,
                  maxLength: 152,
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(

                        color: _colorD,
                        fontWeight: _weightD
                    ),
                    hintText: "Describe your current situation.",
                     prefixIcon: Icon(Icons.description, color: _colorD,),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: disabledColor, width: 1.5),
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: focusColor, width: 2.5),
                    ),

                  ),

                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: minimumpadding * 2),
              child: MyCustomButton(
                textValue: "Continue",
                onPressed: (){},
              ),
            )

          ],
        ),
      ),
    );
  }

  Widget getDateFormPicker(){
    return DateTimePickerFormField(
      autofocus: false,
      decoration: InputDecoration(
          labelText: "Date",

          labelStyle: TextStyle(
              color: _colorDt,
              fontWeight: _weightDt
          ),

          prefixIcon: Icon(Icons.date_range, color: _colorDt,),

          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide(color: disabledColor, width: 1.5)
          ),

          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: focusColor, width: 2.5)
          )

      ),
      format: DateFormat("EEEE, MMMM d, yyyy"),
      inputType: InputType.date,
      initialDate: DateTime.now(),
      onChanged: (selectedDate) {
        setState(() {
          if(selectedDate != null){
            _date = selectedDate;
            _colorDt =  primaryColorDark;
            _weightDt = FontWeight.bold;
          }else{
            _colorDt =  null;
            _weightDt = null;
          }
        }
        );
        print('Selected date: $_date');
      },

    );
  }

  Widget getTimeFormPicker(){
    return DateTimePickerFormField(
      inputType: InputType.time,
      format: DateFormat("HH:mm"),
      initialTime: (_date == DateTime.now()) ? TimeOfDay.now() : null,
      editable: false,

      decoration: InputDecoration(
        labelText: "Time",
        labelStyle: TextStyle(
            fontWeight: _weightT,
            color: _colorT
        ),
        prefixIcon: Icon(Icons.access_time_sharp, color: _colorT,),

        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: accentColor, width: 1.5)
        ),

        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: accentColor, width: 2.5)
        ),

      ),

      onChanged: (selectedTime) {
        setState(() {
          if(selectedTime != null){
            _time = selectedTime;
            _colorT =  primaryColorDark;
            _weightT = FontWeight.bold;
          }else{
            _colorT =  null;
            _weightT = null;
          }
        }
        );
        print('Selected date: $_time');
      },
    );
  }

}


/*
DatePickerWidget(
                firstDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
                lastDate: DateTime(2030, 12, 31),
                pickerTheme: DateTimePickerTheme(
                  itemTextStyle: TextStyle(color: Colors.black, fontSize: 19),
                  dividerColor: primaryColor,
                  backgroundColor: null
                ),
              ),
 */