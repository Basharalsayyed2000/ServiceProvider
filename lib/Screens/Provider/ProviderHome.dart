import 'package:flutter/material.dart';

class ProviderHome extends StatefulWidget {
   static String id = 'ProviderHome';
  @override
  _ProviderHomeState createState() => _ProviderHomeState();
}

class _ProviderHomeState extends State<ProviderHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        children: [
          Expanded(child: GridView.count(
            crossAxisCount: 2,
         mainAxisSpacing: 10,
         crossAxisSpacing: 10,
         primary: false,
         children: [
           elements("Settings", "assets/settings.jpg"),
           elements("Profile", "assets/prof.png"),
           elements("Jobs", "assets/jobs2.png"),
           elements("Done Jobs", "assets/donejobs.jpg"),
           
         ],
          ))
        ],
      ),
    );
  }
}
Widget elements(String title,String imagepath){
  return
Card(
             
             shape: RoundedRectangleBorder(
               borderRadius: BorderRadius.circular(8)
               
             ),
             elevation: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
             Image.asset(imagepath,height: 130,),
             Text(title,
             style: TextStyle(fontWeight: FontWeight.bold),)
            ],),
           );
}