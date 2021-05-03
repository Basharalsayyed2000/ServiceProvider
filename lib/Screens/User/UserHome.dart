import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/User/MyBooks.dart';
import 'package:service_provider/Screens/User/ProfilePage.dart';
import 'package:service_provider/Screens/User/ProvidersList.dart';
import 'package:service_provider/Services/auth.dart';

class UserHome extends StatefulWidget {
  static String id = 'Providerscreen';
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final auth =  Auth();
  // ignore: unused_field
  static String _useId;


  Color _colorH = KprimaryColor, _colorS, _colorP;

  int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }
  
   Future<String> getcurrentid()async{
   _useId = (await FirebaseAuth.instance.currentUser()).uid;
   return '';
   }
  @override
  Widget build(BuildContext context) {
    setState(() {
      getcurrentid();
    });
    PageController _pageController = PageController();
    List<Widget> _screen = [
      ServicesList(),
      MyBooks(),
      UserProfilescreen(),
    ];

    void _onPageChanged(int index) {
      setState(() {
        _selectedIndex = index;
        _colorH = _selectedIndex == 0 ? KprimaryColor : null;
        _colorS = _selectedIndex == 1 ? KprimaryColor : null;
        _colorP = _selectedIndex == 2 ? KprimaryColor : null;
      });
    }

    void _onItemTapped(int selectedIndex) {
      _pageController.jumpToPage(selectedIndex);
      _onPageChanged(selectedIndex);
    }

    return Scaffold(
       drawer: NavDrawer(),
      body: PageView(
        controller: _pageController,
        children: _screen,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _colorH,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.build,
              color: _colorS,
            ),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _colorP,
            ),
            label: 'My Profile',
          ),
        ],
      ),
    );
  }
}
class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      
      child: ListView(
        
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            
            child: Text(
              'Side menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(
                  
                    fit: BoxFit.fill,
                    image: AssetImage('Assets/images/noprofile.png',))),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Welcome'),
            onTap: () => {},
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('Profile'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}
