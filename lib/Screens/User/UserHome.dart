import 'package:flutter/material.dart';


class UserHome extends StatefulWidget {
   static String id = 'Providerscreen';
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Providers"),
      ),
      body: Column(
        children: [
            Expanded(child: 
       GridView.count(
        crossAxisCount: 2,
         mainAxisSpacing: 10,
         crossAxisSpacing: 10,
         primary: false,
         children: [
           Card(
             
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8)
               
             ),
             elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             Image.asset("Assets/images/plumber.webp",height: 130,),
             Text("Plumber",
             style: TextStyle(fontWeight: FontWeight.bold),)
            ],),
           ),
           Card(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8)
             ),
             elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             Image.asset("Assets/images/electrician.png",height: 130,),
             Text("Electrician",
             style: TextStyle(fontWeight: FontWeight.bold),)
            ],),
           ),
           Card(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8)
             ),
             elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             Image.asset("Assets/images/carpenter.webp",height: 130,),
             Text("Carpenter",
             style: TextStyle(fontWeight: FontWeight.bold),)
            ],),
           ),
            Card(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8)
             ),
             elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             Image.asset("Assets/images/painter.png",height: 130,),
             Text("Painter",
             style: TextStyle(fontWeight: FontWeight.bold),)
            ],),
           ),
           Card(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8)
             ),
             elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             Image.asset("Assets/images/blacksmith.png",height: 130,),
             Text("Smith",
             style: TextStyle(fontWeight: FontWeight.bold),)
            ],),
           ),
           Card(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8)
             ),
             elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             Image.asset("Assets/images/conditioning.webp",height: 130,),
             Text("Conditioning",
             style: TextStyle(fontWeight: FontWeight.bold),)
            ],),
           ),
           Card(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8)
             ),
             elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             Image.asset("Assets/images/parquet.png",height: 130,),
             Text("Parquet",
             style: TextStyle(fontWeight: FontWeight.bold),)
            ],),
           ),
            Card(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8)
             ),
             elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             Image.asset("Assets/images/marble.webp",height: 130,),
             Text("Marble",
             style: TextStyle(fontWeight: FontWeight.bold),)
            ],),
           ),
           Card(
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8)
             ),
             elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             Image.asset("Assets/images/ceramictiles.png",height: 130,),
             Text("Ceramic tiles",
             style: TextStyle(fontWeight: FontWeight.bold),)
            ],),
           )
         ],

         )),
         
        ],
      ),
     bottomNavigationBar: BottomNavigationBar(
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
        // currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        // onTap: _onItemTapped,
      ),
    );
  }
}