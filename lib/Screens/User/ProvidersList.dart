import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/Service.dart';
import 'package:service_provider/Models/user.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/Admin/AdminHome.dart';
import 'package:service_provider/Screens/User/RecommendedProviders.dart';
import 'package:service_provider/Screens/commonScreens/WelcomeScreen.dart';
import 'package:service_provider/Services/auth.dart';
import 'package:service_provider/Services/store.dart';

class ServicesList extends StatefulWidget {
  @override
  _ServicesListState createState() => _ServicesListState();
}

class _ServicesListState extends State<ServicesList> {
  final _store = Store();
  final _auth =Auth();
  final _userModel=Users();

   @override
  void initState() {
    super.initState();
    _getUserName();
  }
    Future<void> _getUserName() async {
    Firestore.instance
        .collection(KUserCollection)
        .document(await _auth.getCurrentUserId())
        .get()
        .then((value) {
      setState(() {
      _userModel.uName=value.data[KUserName];
      _userModel.uEmail=value.data[KUserEmail];
      _userModel.uPassword=value.data[KUserPassword];
      _userModel.ubirthDate=value.data[KUserBirthDate];
      _userModel.uAddDate=value.data[KUserAddDate];
      _userModel.uId=value.data[KUserId];
      _userModel.uphoneNumber=value.data[KUserPhoneNumber];
      _userModel.isAdmin=value.data[KUserIsAdmin];
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Providers"),
        backgroundColor: KprimaryColor,
        actions: <Widget>[
          // ignore: deprecated_member_use
          RaisedButton(onPressed: (){
            _auth.signOut();
            Navigator.pushReplacementNamed(context,WelcomeScreen.id);
          },
          child: Text(
          'logout',
          style:TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
          ),
          color: KprimaryColor,

          ),
          
          (_userModel.isAdmin==true)?
          // ignore: deprecated_member_use
          RaisedButton(
            onPressed: (){
            _auth.signOut();
            Navigator.pushNamed(context,AdminHome.id);
          },
          child: Text(
          'Control panel',
          style:TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.bold),
          ),
          color: KprimaryColor,
          
          )
          :Text(''),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadService(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Service> _services = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              String serviceId=doc.documentID;
               if(data[KServicesStatus]){
              _services.add(Service(
                sName: data[KServiceName],
                sDesc: data[KServiceDesc],
                sImageUrl: data[KServicesImageUrl],
                sAddDate: data[KServiceAddDate],
                sId: serviceId,
              ));
              }
            }
            return GridView.builder(
              primary: false,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, Recommended.id,arguments: _services[index]),
                    child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        elevation: 4,
                        child:  Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.network(
                                  _services[index].sImageUrl,
                                  fit: BoxFit.fill,
                                  height: 135,
                                  width: 200,
                                ),
                                Text(
                                  _services[index].sName,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                        ),
                          
                        ),
                    ),
                ],
              ),
              itemCount: _services.length,
            );
          } else {
            return Center(
              child: Text('Loading'),
            );
          }
        },
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
        break;
    }
  }
}
