import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/User/ProfilePage.dart';
import 'package:service_provider/Screens/User/RecommendedProviders.dart';
import 'package:service_provider/Screens/User/ProvidersList.dart';


class UserHome extends StatefulWidget {
   static String id = 'Providerscreen';
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
    
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String _useId = ModalRoute.of(context).settings.arguments;
    PageController _pageController=PageController();
    List<Widget> _screen=[
    ProvidersList(),Recommended(),Profilescreen(),
    ];
    // ignore: unused_local_variable
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
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
             color: _selectedIndex==0 ? KprimaryColor : Colors.grey ,),
            
            label: 'Home',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build,
            color: _selectedIndex==1 ? KprimaryColor : Colors.grey ,),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
             color: _selectedIndex==2 ? KprimaryColor : Colors.grey ,),
            label: 'My Profile',
          ),
        ],
       
        
      ),
    );
  }
}