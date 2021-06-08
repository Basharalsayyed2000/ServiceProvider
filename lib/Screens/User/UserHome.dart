import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/Service.dart';
import 'package:service_provider/Models/user.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/Admin/AdminHome.dart';
import 'package:service_provider/Screens/User/MyBooks.dart';
import 'package:service_provider/Screens/User/MyFavorateProviders.dart';
import 'package:service_provider/Screens/User/ProfilePage.dart';
import 'package:service_provider/Screens/User/RecommendedProviders.dart';
import 'package:service_provider/Screens/commonScreens/Settings.dart';
import 'package:service_provider/Screens/commonScreens/WelcomeScreen.dart';
import 'package:service_provider/Services/auth.dart';
import 'package:service_provider/Services/store.dart';

class UserHome extends StatefulWidget {
  static String id = 'Providerscreen';
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final auth = Auth();
  String userId;
  final _store = Store();
  final _userModel = UserModel();

  @override
  void initState() {
    getcurrentid();
    super.initState();
  }


  void getcurrentid() async {
    String _userId = (await FirebaseAuth.instance.currentUser()).uid;
    setState(() {
      userId = _userId;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      drawer: Drawer(
        child: StreamBuilder(
            stream: Firestore.instance
                .collection(KUserCollection)
                .document(userId)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return new Center(child: new CircularProgressIndicator());
              if (!snapshot.hasData) {
                return Text("Loading");
              } else {
                var userDocument = snapshot.data;

                _userModel.uName = userDocument[KUserName];
                _userModel.uEmail = userDocument[KUserEmail];
                _userModel.uPassword = userDocument[KUserPassword];
                _userModel.uAddDate = userDocument[KUserAddDate];
                _userModel.uId = userDocument[KUserId];
                _userModel.isAdmin = userDocument[KUserIsAdmin];
                _userModel.uImageUrl = userDocument[KUserImageUrl];
                _userModel.enableAcceptPublicRequest=userDocument[KUserEnableAcceptPublicRequest];
                return ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    DrawerHeader(
                      child: Column(children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.pushNamed(context, UserProfilescreen.id);
                          },
                          child: CircleAvatar(
                            backgroundColor: KprimaryColor,
                            backgroundImage: (_userModel.uImageUrl == null)
                                ? AssetImage("Assets/images/noprofile.png")
                                : NetworkImage(_userModel.uImageUrl),
                            radius: 35,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${_userModel.uName}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          '${_userModel.uEmail}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                          ),
                        ),
                      ]),
                    ),
                    ListTile(
                      leading: Icon(Icons.input),
                      title: Text('Welcome'),
                      onTap: () => {},
                    ),
                    ListTile(
                      leading: Icon(Icons.verified_user),
                      title: Text('Profile'),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, UserProfilescreen.id);
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.favorite_rounded),
                      title: Text('MyFavorate Providers'),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, MyFavorateProviders.id);
                      },
                    ),
                    const Divider(
                      height: 35,
                      thickness: 2,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 18, bottom: 12),
                      child: Text("My Book"),
                    ),
                    ListTile(
                      leading: Icon(Icons.send),
                      title: Text('Sent request'),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyBooks(userAction:"Sent",)),
                          );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.watch_later),
                      title: Text('Book later requests'),
                      onTap: () {
                        Navigator.of(context).pop();
                         Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyBooks(userAction:"Book Later",)),
                          );
                        
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.work_outline_rounded),
                      title: Text('Inprogress requests'),
                      onTap: () {
                        Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyBooks(userAction:"Inprogress",)),
                          );
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.check_sharp),
                      title: Text('Completed requests'),
                      onTap: () {
                        Navigator.of(context).pop();
                         Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyBooks(userAction:"Completed",)),
                          );
      
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.cancel_outlined),
                      title: Text('Rejected requests'),
                      onTap: () {
                        Navigator.of(context).pop();
                           Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyBooks(userAction:"Rejected",)),
                          );
                       
                      },
                    ),

                     (!_userModel.enableAcceptPublicRequest)?ListTile(
                      leading: Icon(Icons.add_reaction_rounded),
                      title: Text('public requests reaction'),
                      onTap: () {
                        Navigator.of(context).pop();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => MyBooks(userAction:"publicReaction",)),
                          );
                      },
                    ):Center(),
                    const Divider(
                      height: 35,
                      thickness: 2,
                      indent: 5,
                      endIndent: 5,
                    ),
                    ListTile(
                      leading: Icon(Icons.notifications_on),
                      title: Text('Notification'),
                      onTap: () => {Navigator.of(context).pop()},
                    ),
                    ListTile(
                      leading: Icon(Icons.settings),
                      title: Text('Setting'),
                      onTap: () {
                        Navigator.of(context).pop();
                         Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Settings(isUser:true,enableDirectAcceptRequest: _userModel.enableAcceptPublicRequest,uId: userId,)),
                          );
                      },
                    ),
                    const Divider(
                      height: 35,
                      thickness: 2,
                      indent: 5,
                      endIndent: 5,
                    ),
                    ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text('Logout'),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.pushReplacementNamed(
                            context, WelcomeScreen.id);
                        auth.signOut();
                      },
                    ),
                    (userDocument[KUserIsAdmin] == true)
                        ? ListTile(
                            leading: Icon(Icons.arrow_left),
                            title: Text('Control panel'),
                            onTap: () {
                              Navigator.pushNamed(context, AdminHome.id);
                            })
                        : ListTile()
                  ],
                );
              }
            }),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text("Services"),
        backgroundColor: KprimaryColor,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _store.loadService(),
        // ignore: missing_return
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<ServiceModel> _services = [];
            for (var doc in snapshot.data.documents) {
              var data = doc.data;
              String serviceId = doc.documentID;
              if (data[KServicesStatus]) {
                _services.add(ServiceModel(
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
                    onTap: () => Navigator.pushNamed(
                        context, RecommendedProviders.id,
                        arguments: _services[index]),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                              _services[index].sImageUrl,
                              fit: BoxFit.fill,
                              height: 140,
                              width: 160,
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
}
