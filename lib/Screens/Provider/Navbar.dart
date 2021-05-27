import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/Screens/Provider/HomeProvider.dart';
import 'package:service_provider/Screens/Provider/RecommendedJobs.dart';


class Navbar extends StatefulWidget {
   static String id = 'Navbar';
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {

  Color _colorH = KprimaryColor, _colorS, _colorP;

  int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    String _useId = ModalRoute.of(context).settings.arguments;
    PageController _pageController=PageController();
    List<Widget> _screen=[
    HomeProvider(),RecommendedJobs(),HomeProvider(),
    ];

    void _onPageChanged(int index){
    setState(() {
      _selectedIndex=index;
      _colorH = _selectedIndex==0 ? KprimaryColor : null;
      _colorS = _selectedIndex==1 ? KprimaryColor : null;
      _colorP = _selectedIndex==2 ? KprimaryColor : null;
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
        selectedItemColor: Colors.grey,
        
       onTap:_onItemTapped,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
             color: _colorH,
            ),
            
            label: 'Home',
            
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build,
            color: _colorS,
            ),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,
             color: _colorP,
            ),
            label: 'My Profile',
          ),
        ],
       
        
      ),
    );
  }
}