import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/PasswordVerificationDialog.dart';


// ignore: must_be_immutable
class Settings extends StatefulWidget {
  static String id = 'Settings';
  bool isUser;
  @override
  _SettingsState createState() => _SettingsState(isUser:isUser);
}

class _SettingsState extends State<Settings> {
  bool valNotify1=true;
  bool valNotify2=false;
  bool valNotify3=false;
  bool isUser;
  _SettingsState({this.isUser});
  onChangeFunction1(bool newValue1){
    setState(() {
      valNotify1=newValue1;
    });
  }

  onChangeFunction2(bool newValue2){
    setState(() {
      valNotify2=newValue2;
    });
  }

  onChangeFunction3(bool newValue3){
    setState(() {
      valNotify3=newValue3;
    });
  }
  @override
  Widget build(BuildContext context) {
    isUser=ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: KprimaryColor,
        title: Text("Settings",style: TextStyle(fontSize: 22),),
      // leading: IconButton(onPressed: (){},
      // icon: Icon(Icons.arrow_back
      // ,color: Colors.white ,),
      // ),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 40,),
           Row(
             children: [
                Icon(Icons.person,color: Colors.blue,),
            SizedBox(height: 10,),
            Text("Account",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
             ],
           ),
           Divider(height: 20,thickness: 1,),
           SizedBox(height: 10,),
            buildAccountOption(context,"Change Password",),
            buildAccountOption(context,"Content settings"),
            buildAccountOption(context,"Privacy and Security"),
            SizedBox(height: 40,),
            Row(
              children: [
                Icon(Icons.volume_up_outlined,color: Colors.blue,),
                SizedBox(height: 10,),
                Text("Notifications",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),

              ],
            ),
             Divider(height: 20,thickness: 1,),
             SizedBox(height: 10,),
             buildNotificationOption("Default",valNotify1,onChangeFunction1),
             buildNotificationOption("Default",valNotify2,onChangeFunction2),
             buildNotificationOption("Default",valNotify3,onChangeFunction3)

          ],
        ),
        
      ),

    );
  }
  Padding  buildNotificationOption(String title,bool value,Function onChangedMethod){
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.grey),),
            Transform.scale(
              scale: 0.7,
              child: CupertinoSwitch(
                activeColor: Colors.blue,
                trackColor: Colors.grey,
                value: value,
                onChanged: (bool newValue){
                  onChangedMethod(newValue);
                },
              ),
            )
          ],

        ),
      );
  }
  GestureDetector buildAccountOption(BuildContext context,String title){
    return GestureDetector(
      onTap: (){
        DialogHelper.exit(context, false,isUser) ;
        },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.grey),),
            Icon(Icons.arrow_forward_ios,color: Colors.grey,)
          ],
        ),
      ),
    );
  }
}