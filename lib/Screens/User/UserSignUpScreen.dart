import 'package:country_list_pick/country_list_pick.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:service_provider/Models/user.dart';
import 'package:service_provider/MyWidget/MyCustomTextField.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/User/UserLoginScreen.dart';
import 'package:service_provider/Screens/User/VerificationUser.dart';

class UserSignUpScreen extends StatefulWidget {
  static String id = 'UserSignUpScreen';

  @override
  State<StatefulWidget> createState() {
    return _UserSignUpScreen();
  }
}

class _UserSignUpScreen extends State<UserSignUpScreen> {
  String _email, _password, _name, _confirmPassWord,country;
  final _auth = FirebaseAuth.instance;
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
        child: ProgressHUD(
          child: Form(
            key: _globalKey,
            child: ListView(
              children: <Widget>[
                getImage(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.0055),
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
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.0055),
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
                  padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.0055),
                  child: Focus(
                    child: CustomTextField(
                      obscureText: true,
                      labelText: "Password",
                      hintText: "complex password",
                      prefixIcon: Icons.vpn_key,
                      onClicked: (value) {
                        _password = value;
                      },
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0055),
                  child: Focus(
                    child: CustomTextField(
                      obscureText: true,
                      labelText: "Confirm Password",
                      hintText: "confirm",
                      prefixIcon: Icons.vpn_key,
                      onClicked: (value) {
                        _confirmPassWord = value;
                      },
                    ),
                  ),
                ),
                Center(
                  child: CountryListPick(
                    appBar: AppBar(
                      backgroundColor: KprimaryColor,
                      title: Text('Pick your country'),
                    ),
                    // if you need custome picker use this
                    pickerBuilder: (context, CountryCode countryCode) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("Country :",style: TextStyle(fontSize: 20,color: Colors.black),),
                           SizedBox(
                            width: 12,
                          ),
                          Image.asset(
                            countryCode.flagUri,
                            package: 'country_list_pick',
                            height: 30,
                            width: 30,
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Text(countryCode.name,style: TextStyle(fontSize: 15,color: Colors.black),),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.arrow_drop_down,size:20,color: Colors.black,),
                        ],
                      );
                    },
                    theme: CountryTheme(
                      isShowFlag: true,
                      isShowTitle: true,
                      isShowCode: true,
                      isDownIcon: true,
                      showEnglishName: true,
                    ),
                    // or
                    // initialSelection: 'US'
                    onChanged: (CountryCode code) {
                      print(code.name);
                      country=code.name;
                    },
                    useSafeArea: false,
                    useUiOverlay: true,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 4),
                  // ignore: deprecated_member_use
                  child: Builder(
                    builder: (context) => CustomButton(
                      textValue: "Sign Up",
                      onPressed: () async {
                        final progress = ProgressHUD.of(context);
                        toggleProgressHUD(true, progress);
                        if (_globalKey.currentState.validate()) {
                          _globalKey.currentState.save();
                          try {
                            if (_password == _confirmPassWord) {
                              await _auth.createUserWithEmailAndPassword(
                                  email: _email.trim(),
                                  password: _password.trim()).then((value){
                                  Navigator.pushReplacementNamed(context, UserVerifyScreen.id,arguments: UserModel(uName: _name,uEmail: _email.trim(),uPassword: _password.trim(),ucountry:country));
                                  });
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("the password doesn't match"),
                                      actions: [
                                        // ignore: deprecated_member_use
                                        RaisedButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          color: Colors.red,
                                          child: Text("ok"),
                                        ),
                                      ],
                                    );
                                  });
                            }
                            toggleProgressHUD(false, progress);
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
                  padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.0345),
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
                              context, UserLoginScreen.id,
                              arguments: _usertype);
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
