import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:service_provider/MyTools/Constant.dart';

class AvailableRequests extends StatefulWidget{

  static String id = "availableRequests";
  
  @override
  State<StatefulWidget> createState(){
    return _AvailableRequests();
  }

}

class _AvailableRequests extends State<AvailableRequests>{
  
  var _users = ["Said", "Bashar"];
  var _schedules = ["Thursday 25 June 5:30PM", "Monday 5 Jully 9:30AM"];
  var _profiles = ["https://am3pap003files.storage.live.com/y4mRVsIxyqYiVDJJrxHKsMHSMNIDeyFsdEOrdoF1L2739_TR0gcRvgLzRvqR172-vwM3NeL_Z9UeK4P3t8lDUvkq8e40NaJL39nknp2hfEr5g_R4Km5-0ErbZLT68Q_8u5d0d3B4kDEB0Yp2vVjEcR7LsQ2shNvL_lTl-kAlVy2cWo-uCxZPJrNZ5Ei_uvpDwXPvXp3ue9Ip-Jze28CM90YNQ/said.jpeg?psid=1&width=768&height=836", "https://am3pap003files.storage.live.com/y4mo7WDu-vFo78fggCLw9NZxp02tlFBN9obvHx5qpT7f7PHWLo-x2Yz5lTI1550vW53xyuYyHEOEfctpjPI5IbYkGvfJKd1KhYHF8shP98AC_NdfOHLtYKlmQo37oXMgW-8CTskyEnYuU-3EjkY2peQ_FvkE_wkloeXkhTp1xynY4tDJqvl9ZeijER1B01oCtw31Mk8ggKyPL0Y5TZXSCH0pw/bashar.jpeg?psid=1&width=720&height=718"];
  var _titles = ["Help Please", "Electrician Assistance"];
  var _distance = [0.02, 1.0];

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.only(top: 8),
      color: Colors.white,
      child: ListView.separated(
        itemCount: _users.length,
        itemBuilder: (context, index){
          return Slidable(

            actionPane: SlidableScrollActionPane(),
            
            actions: <Widget>[
              SlideAction(
              //  icon: Icons.info_outline_rounded,
              child: Text('View Details'),
                color: KprimaryColor,
                onTap: (){
                  print('Details');
                },
              ),

            ],
            
            secondaryActions: <Widget>[
              SlideAction(
                
                //icon: Icons.remove_circle_outline,
                child: Text('Remove'),
                color: Colors.red,
                onTap: (){
                  print('Remove');
                },
              ),
            ],

            actionExtentRatio: 0.25,
            
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: KsecondaryColor.withOpacity(.755),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage("${_profiles[index]}"),
                  radius: 26,
                  
                  // minRadius: 20,
                  // maxRadius: 25,
                ),
                radius: 30,
                // minRadius: 27,
                // maxRadius: 27,
              ),

              title: Text(_users[index]),

              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                
                children: [

                  Container(
                    margin: EdgeInsets.only(top: 1),
                    child: Text(
                      _titles[index],
                      style: TextStyle(
                        fontSize: 16,
                        color: KprimaryColorDark,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 3),
                    child: Text(
                      "Time: ${_schedules[index]}",
                      style: TextStyle(
                        fontSize: 13,
                        color: KprimaryColorDark
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 3),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: KsecondaryColor,
                          size: 16,
                        ),
                        Text(
                          "${_distance[index]} Km ",
                          style: TextStyle(
                            color: KprimaryColorDark,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          "Away from you",
                          style: TextStyle(
                            color: KprimaryColorDark
                          ),
                        )
                      ],
                    ),
                  ),
                  
                ],
              ),
              
              onTap: (){
                //Navigator.pushNamed(context, JobDetails.id);
              },

            ), 

          );
        }, 
        separatorBuilder: (context, index){
          return Divider(
            thickness: 1,
          );
        }, 
      )
              /*
              Row(
              children: [
                Icon(
                  Icons.location_on,
                  size: 17,
                  color: KsecondaryColor,
                ),
                Text("${_distance[index]} Km Away from you"),
              ],
            ),
            onLongPress: (){},
            leading: Icon(Icons.ac_unit),
            title: Container(
              child: Text("Title $index"),
            )
              */
            
                
    );
  }

}