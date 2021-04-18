import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:intl/intl.dart';
import 'package:service_provider/Models/userData.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/commonScreens/LoginScreen.dart';
import 'package:service_provider/Services/auth.dart';
import 'package:service_provider/Services/user.dart';
import 'package:intl/date_symbol_data_local.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'signUpScreen';

  @override
  State<StatefulWidget> createState() {
    return _SignUpScreen();
  }
}

class _SignUpScreen extends State<SignUpScreen> {
  // ignore: unused_field
  String _email, _password, _name, _id;
  // ignore: unused_field
  final _auth = Auth();
  final _user = User();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  Color _colorDt;
  FontWeight _weightDt;

  DateTime _date;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    bool _usertype = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.only(
            top: Kminimumpadding * 2,
            bottom: Kminimumpadding * 2,
            left: Kminimumpadding * 4.5,
            right: Kminimumpadding * 4.5),

        child: ProgressHUD(
          child: Form(
            key: _globalKey,
            child: ListView(
              children: <Widget>[
                getImage(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0.325),
                  child: Focus(
                    child: CustomTextField(
                      labelText: "Full Name",
                      hintText: "e.g Sam Wilson",
                      prefixIcon: Icons.person,
                      onClicked: (value) {
                        _name = value;
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0.325),
                  child: CustomTextField(
                    labelText: "Email",
                    hintText: "example@yourmail.com",
                    keyboardType: TextInputType.emailAddress,
                    validator: null,
                    prefixIcon: Icons.mail,
                    onClicked: (value) {
                      _email = value;
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0.325),
                  child: Focus(
                    child: CustomTextField(
                      obscureText: true,
                      labelText: "Password",
                      hintText: "e.g Password",
                      prefixIcon: Icons.vpn_key,
                      onClicked: (value) {
                        _password = value;
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0.325),
                  child: getDateFormPicker(),
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 0.325),
                  child: Focus(
                    child: CustomTextField(
                      labelText: "Phone Number",
                      hintText: "+XXX 123456789",
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.phone_iphone,
                      onClicked: (value) {
                        _email = value;
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  // ignore: deprecated_member_use
                  child: Builder(
                    builder: (context) => CustomButton(
                      textValue: "Sign Up",
                      onPressed: () async {
                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();

                          try {
                            _id = _user.getUserId().toString();
                            print(_id);
                            print(getDateNow());
                            await _auth.signUp(_email.trim(), _password.trim());
                            _user.addUser(UserData(
                              uName: _name,
                              uId:'good' ,//_id,
                              uAddDate: 'good',//getDateNow(),
                              uImageLoc: null,
                              urank: _usertype == false ? 2 : 1,
                            ));
                            Navigator.pushNamed(context, LoginScreen.id);
                          } catch (e) {
                            final progress = ProgressHUD.of(context);
                            progress.showWithText('Loading...');
                            Future.delayed(Duration(seconds: 1), () {
                              progress.dismiss();
                            });
                            // ignore: deprecated_member_use
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(e.toString()),
                            ));
                            
                            print(e.message);
                          }
                        }
                      },
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    padding: EdgeInsets.only(top: Kminimumpadding * 2.5),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text(
                        "Already have an account? Sign in",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: KprimaryColorDark,
                            decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                )
              ],
            ),

          ),
        ),
      ),
    );
  }

  Widget getImage() {
    AssetImage assetImage = new AssetImage("Assets/images/Logo.png");
    Image image = new Image(image: assetImage);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.0085),
      child: Container(
        width: MediaQuery.of(context).size.height * 0.40,
        height: MediaQuery.of(context).size.width * 0.55,
        child: image,
      ),
    );
  }

  Widget getDateFormPicker(){
    return SizedBox(
      height: 73.0,
      child: DateTimePickerFormField(
        autofocus: false,
        decoration: InputDecoration(
            labelText: "Date",
            isDense: true,
            labelStyle: TextStyle(
              color: _colorDt,
              fontWeight: _weightDt
            ),

            prefixIcon: Icon(Icons.date_range, color: KprimaryColorDark,),

            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
                borderSide: BorderSide(color: KdisabledColor, width: 1.5)
            ),

            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: KfocusColor, width: 2.5)
            )

        ),
        validator: null,
        format: DateFormat("MMMM d yyyy"),
        inputType: InputType.date,
        initialDate: DateTime(1970, 1, 1),
        onChanged: (selectedDate) {
          setState(() {
            if(selectedDate != null){
              _date = selectedDate;
              _colorDt =  KprimaryColorDark;
              _weightDt = FontWeight.bold;
            }else{
              _colorDt =  null;
              _weightDt = null;
            }
          }
          );
          print('Selected date: $_date');
        },

      ),
    );
  }

  // ignore: missing_return
  String getDateNow() {
    initializeDateFormatting();
    DateTime now = DateTime.now();
// ignore: unused_local_variable
    var dateString = DateFormat('dd-MM-yyyy').format(now);
    final String configFileName = 'lastConfig.$dateString.json';
    return configFileName;
  }
}
