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
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            primary: false,
            children: [
              elements("Settings", "Assets/images/settings.jpg",context,"",""),
              elements("Profile", "Assets/images/prof.png",context,"",""),
              elements("Available Jobs", "Assets/images/jobs.png",context,RecommendedJobs.id,"Available"),
              elements("Done Jobs", "Assets/images/donejobs.jpg",context,RecommendedJobs.id,"Done"),
              elements("InProgress", "Assets/images/donejobs.jpg",context,RecommendedJobs.id,"Inprogress"),
            ],
          ))
        ],
      ),
    );
  }
}

Widget elements(String title, String imagepath,context,String routeName,String pageType) {
  return GestureDetector(
    onTap: (){
      Navigator.of(context).pushNamed(routeName,arguments: pageType);
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
