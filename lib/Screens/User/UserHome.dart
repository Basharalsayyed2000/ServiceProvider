import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/User/ProfilePage.dart';
import 'package:service_provider/Screens/User/ServiceRequest.dart';
import 'package:service_provider/Screens/commonScreens/LoginScreen.dart';
import 'package:service_provider/Screens/User/ProvidersList.dart';

class UserHome extends StatefulWidget {
   static String id = 'Providerscreen';
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
    
  @override
  Widget build(BuildContext context) {
    PageController _pageController=PageController();
    List<Widget> _screen=[
    ProvidersList(),ServiceRequest(),Profilescreen(),
    ];
    int _selectedIndex=0;
    void _onPageChanged(int index){
    setState(() {
      _selectedIndex=index;
    });
    }
    void _onItemTapped(int selectedIndex){
      _pageController.jumpToPage(selectedIndex);
      _onPageChanged(selectedIndex);
    }
    
    return Scaffold(
     body: PageView(
       controller: _pageController,
       children:_screen,
       onPageChanged: _onPageChanged,
       physics: NeverScrollableScrollPhysics(),
     ),
     bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: KprimaryColor,
        
       onTap:_onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            
            label: 'Home',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Profile',
          ),
        ],
       
        
      ),
    );
  }
}