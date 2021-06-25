import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/ExpandableWidgets.dart';
import 'package:service_provider/MyWidget/PasswordVerificationDialog.dart';
import 'package:service_provider/Services/UserStore.dart';


// ignore: must_be_immutable
class Settings extends StatefulWidget {
  static String id = 'Settings';
   bool isUser;
   bool showProvidersOfMyCountry;
   String uId;
  Settings({this.isUser, this.showProvidersOfMyCountry , this.uId});
  @override
  _SettingsState createState() => _SettingsState(
    isUser:(isUser!=null)?isUser:false,
    showProvidersOfMyCountry:(showProvidersOfMyCountry!=null)?showProvidersOfMyCountry:false,
    uId:(uId!=null)?uId:"");
}

class _SettingsState extends State<Settings> {
  bool showProvidersOfMyCountry;
  bool valNotify2=false;
  bool valNotify3=false;
  UserStore userStore=new UserStore();
  bool isUser;
  String uId;
  _SettingsState({ this.isUser, this.showProvidersOfMyCountry, this.uId});
  
  

  onChangeFunction1(bool newValue1){
    setState(() {
      showProvidersOfMyCountry=newValue1;
    });
    if(isUser)
    {
      userStore.userUpdateShowOnlyMyCountryProviders(showProvidersOfMyCountry, uId);
    } 
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
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: KprimaryColor,
        title: Text("Settings",style: TextStyle(fontSize: 22),),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 40,),
           Row(
            children: [
            SizedBox(width: 5,),  
            Icon(Icons.person,color: Colors.blue,),
            SizedBox(width: 8,),
            Text("Account",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),)
             ],
           ),
           Divider(height: 20,thickness: 1,),
           SizedBox(height: 10,),
           ExpandableParent(
             title: "Security",
             children: [
              buildAccountOption(context,"Change Email"),
              buildAccountOption(context,"Change Password"),

              ExpandableTile(
                leading: Text("Change Email",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.grey),),
                onTap: (){
                  DialogHelper.exit(context,true,false);
                }
              ),
              ExpandableTile(
                leading: Text("Change Password",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.grey),),
                onTap: (){
                  DialogHelper.exit(context,false,false);
                }
              )
             ],
           ),

           SizedBox(height: 20,),

            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 0.0), //(x,y)
                    blurRadius: 0.2,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(0.0, 1.0), //(x,y)
                    blurRadius: 0.2,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(1.0, 0.0), //(x,y)
                    blurRadius: 0.2,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(1.0, 1.0), //(x,y)
                    blurRadius: 0.2,
                  ),
                ]
              ),
              child: ExpandableParent(
                title: "Details",
                children: [
                  ExpandableTile(
                    leading: Text("Change Description",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.grey),),
                    onTap: (){}
                  ),
                ],
              ),
            ),

           SizedBox(height: 20,),
            
            buildAccountOption(context,(isUser)?"Privacy and Security":""),
            SizedBox(height: 40,),
            Row(
              children: [
                 SizedBox(width: 5,),  
                Icon(Icons.privacy_tip_rounded,color: Colors.blue,),
                 SizedBox(width: 8,),  
                Text("Privacy",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),

              ],
            ),
             Divider(height: 20,thickness: 1,),
             SizedBox(height: 10,),
            //  buildAccountOption(context, title),
             buildNotificationOption("Show mycountry Only",showProvidersOfMyCountry,onChangeFunction1),
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
       DialogHelper.exit(context,(title=="Change Password")?false:true,isUser);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: Colors.grey),),
            if(title != "Change Password" && title != "Change Email")Icon(Icons.arrow_forward_ios,color: Colors.grey,)
          ],
        ),
      ),
    );
  }
}