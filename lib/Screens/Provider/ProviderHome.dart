import 'package:flutter/material.dart';
import 'package:service_provider/Screens/Provider/RecommendedJobs.dart';

class ProviderHome extends StatefulWidget {
  static String id = 'ProviderHome';
  @override
  _ProviderHomeState createState() => _ProviderHomeState();
}

class _ProviderHomeState extends State<ProviderHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              child: GridView.count(
            crossAxisCount: 2,
<<<<<<< Updated upstream
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            primary: false,
            children: [
              elements("Settings", "Assets/images/settings.jpg",context,""),
              elements("Profile", "Assets/images/prof.png",context,""),
              elements("Jobs", "Assets/images/jobs.png",context,RecommendedJobs.id),
              elements("Done Jobs", "Assets/images/donejobs.jpg",context,""),
            ],
=======
         mainAxisSpacing: 10,
         crossAxisSpacing: 10,
         primary: false,
         children: [
           elements("Settings", "Assets/images/settings.jpg"),
           elements("Profile", "Assets/images/prof.png"),
           elements("Jobs", "Assets/images/jobs2.png"),
           elements("Done Jobs", "Assets/images/donejobs.jpg"),
           
         ],
>>>>>>> Stashed changes
          ))
        ],
      ),
    );
  }
}

Widget elements(String title, String imagepath,context,String routeName) {
  return GestureDetector(
    onTap: (){
      Navigator.of(context).pushNamed(routeName);
    },
      child: Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagepath,
            height: 130,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ),
    ),
  );
}
