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
<<<<<<< Updated upstream
        child: Form(
          key: _globalKey,
          child: ListView(
            children: <Widget>[
              getImage(),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.005),
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
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.005),
                child: Focus(
                  child: CustomTextField(
                    labelText: "Email / Phone Number",
                    hintText: "example@yourmail.com / +XXX 123456789",
                    prefixIcon: Icons.mail,
                    onClicked: (value) {
                      _email = value;
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.005),
                child: Focus(
                  child: CustomTextField(
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
                padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.005),
                child: Focus(
                  child: CustomTextField(
                    labelText: "Confirm Password",
                    hintText: "Confirm Password",
                    prefixIcon: Icons.vpn_key,
                    onClicked: (value) {
                      _password = value;
                    },
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: Kminimumpadding * 3),
                // ignore: deprecated_member_use
                child: CustomButton(
                  textValue: "Sign Up",
                  onPressed: () async {
                    if (_globalKey.currentState.validate()) {
                      _globalKey.currentState.save();
                      print(_email);
                      print(_password);
                      try{
                        await _auth.signUp(_email.trim(), _password.trim());
                        Navigator.pushNamed(context, LoginScreen.id);
                      }catch(e){
                        print(e);
                      }
                    }
                  },
                ),
              ),
              SizedBox(height: 15,),
              Container(
                padding: EdgeInsets.only(top: Kminimumpadding * 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text("Already have an account? "),
                    InkWell(
                      onTap: (){
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: KprimaryColorDark,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline
                        ),
                      ),
                    ),
                  ]
                )
              )
            ],
=======
        child: ProgressHUD(
          child: Form(
            key: _globalKey,
            child: ListView(
              children: <Widget>[
                getImage(),
                Container(
                  padding: EdgeInsets.only(
                      top: Kminimumpadding * 1.5,
                      bottom: Kminimumpadding * 1.5),
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
                  padding: EdgeInsets.only(
                      top: Kminimumpadding * 1.5,
                      bottom: Kminimumpadding * 1.5),
                  child: Focus(
                    child: CustomTextField(
                      labelText: "Email / Phone Number",
                      hintText: "example@yourmail.com / +XXX 123456789",
                      prefixIcon: Icons.mail,
                      onClicked: (value) {
                        _email = value;
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: Kminimumpadding * 1.5,
                      bottom: Kminimumpadding * 1.5),
                  child: Focus(
                    child: CustomTextField(
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
                  padding: EdgeInsets.only(
                      top: Kminimumpadding * 1.5,
                      bottom: Kminimumpadding * 1.5),
                  child: Focus(
                    child: CustomTextField(
                      labelText: "Confirm Password",
                      hintText: "Confirm Password",
                      prefixIcon: Icons.vpn_key,
                      onClicked: (value) {
                        _password = value;
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: Kminimumpadding * 3),
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
                    padding: EdgeInsets.only(top: Kminimumpadding * 6),
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
>>>>>>> Stashed changes
          ),
        ),
      ),
    );
  }

  Widget getImage() {
    AssetImage assetImage = new AssetImage("Assets/images/Logo.png");
    Image image = new Image(image: assetImage);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*0.02),
      child: Container(
        width: MediaQuery.of(context).size.height * 0.40,
        height: MediaQuery.of(context).size.width * 0.55,
        child: image,
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
