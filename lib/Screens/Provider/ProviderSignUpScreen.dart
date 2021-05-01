import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:intl/intl.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/Provider/AdditionalInfo.dart';
import 'package:service_provider/Screens/Provider/ProviderLoginScreen.dart';
import 'package:service_provider/Services/auth.dart';
import 'package:intl/date_symbol_data_local.dart';

class ProviderSignUpScreen extends StatefulWidget {
  static String id = 'ProviderSignUpScreen';

  @override
  State<StatefulWidget> createState() {
    return _ProviderSignUpScreen();
  }
}

class _ProviderSignUpScreen extends State<ProviderSignUpScreen> {
  // ignore: unused_field
  String _email,
      _password,
      _name,
      _birthDate,
      
      _phone,
      // ignore: unused_field
      _errorMessage;
      
  final _auth = Auth();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  Color _colorDt;
  FontWeight _weightDt;
  DateTime _date;

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
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
                        _phone = value;
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  // ignore: deprecated_member_use
                  child: Builder(
                    builder: (context) => CustomButton(
                      textValue: "Continue",
                      onPressed: () async {
                        final progress = ProgressHUD.of(context);
                        toggleProgressHUD(true, progress);
                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();

                          try {
                            final authResult = await _auth.signUp(
                                _email.trim(), _password.trim());
                              Providers _provider= Providers(
                                    pName: _name,
                                    pbirthDate: _birthDate,
                                    isAdmin:false,
                                    pphoneNumber: _phone,
                                    pEmail: _email.trim(),
                                    pId: authResult.user.uid,
                                    pPassword: _password.trim(),
                                    );
                            toggleProgressHUD(false, progress);
                            Navigator.pushNamed(context, AdditionalInfo.id,arguments: _provider);
                          } catch (e) {
                            toggleProgressHUD(false, progress);

                            // ignore: deprecated_member_use
                            Scaffold.of(context).showSnackBar(SnackBar(
                              content: Text(e.toString()),
                            ));
                          }
                        }
                        toggleProgressHUD(false, progress);
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: Kminimumpadding * 2.5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(
                          color: KprimaryColorDark,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, ProviderLoginScreen.id);
                        },
                        child: Text(
                          "Sign in",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: KprimaryColorDark,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
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
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.0085),
      child: Container(
        width: MediaQuery.of(context).size.height * 0.40,
        height: MediaQuery.of(context).size.width * 0.55,
        child: image,
      ),
    );
  }

  Widget getDateFormPicker() {
    return SizedBox(
      height: 73.0,
      child: DateTimePickerFormField(
        autofocus: false,
        decoration: InputDecoration(
          labelText: "Date Of Birth",
          isDense: true,
          labelStyle: TextStyle(color: _colorDt, fontWeight: _weightDt),
          prefixIcon: Icon(
            Icons.date_range,
            color: KprimaryColorDark,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: KdisabledColor, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: KfocusColor, width: 2.5),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(color: KdisabledColor, width: 1.5),
          ),
        ),

        //validator: (value) => "Date Of Birth is Empty !",
        format: DateFormat("MMMM d yyyy"),
        inputType: InputType.date,
        initialDate: DateTime(1970, 1, 1),
        onChanged: (selectedDate) {
          setState(() {
            _birthDate = selectedDate.toString();
            if (selectedDate != null) {
              _date = selectedDate;
              _colorDt = KprimaryColorDark;
              _weightDt = FontWeight.bold;
              _errorMessage = "Date Of Birth is Empty !";
            } else {
              _colorDt = null;
              _weightDt = null;
              _errorMessage = null;
            }
          });
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
    final String configFileName = dateString;
    return configFileName;
  }

  void toggleProgressHUD(_loading, _progressHUD) {
    setState(() {
      if (!_loading) {
        _progressHUD.dismiss();
      } else {
        _progressHUD.show();
      }
    });
  }
}
