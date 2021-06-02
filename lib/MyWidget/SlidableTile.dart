import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:service_provider/MyTools/Constant.dart';

class SlidableTile extends StatefulWidget {
  final String profile;
  final String user;
  final String title;
  final String schedule;
  final String distance;
  final String action;
  final bool hasAction;

  SlidableTile(
      {@required this.profile,
      @required this.user,
      @required this.title,
      @required this.schedule,
      @required this.distance,
      this.action,
      @required this.hasAction});

  @override
  State<StatefulWidget> createState() {
    return _SlidableTile(
        profile: profile,
        user: user,
        title: title,
        schedule: schedule,
        distance: distance,
        action: action,
        hasAction: hasAction);
  }
}

class _SlidableTile extends State<SlidableTile> {
  final String profile;
  final String user;
  final String title;
  final String schedule;
  final String distance;
  final String action;
  final bool hasAction;

  _SlidableTile(
      {@required this.profile,
      @required this.user,
      @required this.title,
      @required this.schedule,
      @required this.distance,
      this.action,
      @required this.hasAction});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Slidable(
        //(action=="cancle")? Colors.orange[200]:(action=="cancle")? Colors.grey[200]:Colors.white
        actionPane: SlidableScrollActionPane(),

        actions: <Widget>[
          SlideAction(
            //  icon: Icons.info_outline_rounded,
            child: Text('View Details'),
            color: KprimaryColor,
            onTap: () {
              print('Details');
            },
          ),
        ],

        secondaryActions: (hasAction)
            ? <Widget>[
                SlideAction(
                  //icon: Icons.remove_circle_outline,
                  child: (action == "cancle")
                      ? Text(
                          'cancle',
                          style: TextStyle(color: Colors.white),
                        )
                      : (action == "activate")
                          ? Text(
                              'activate',
                              style: TextStyle(color: Colors.white),
                            )
                          : Text(
                              'empty',
                              style: TextStyle(color: Colors.white),
                            ),
                  color: (action == "cancle")
                      ? Colors.red
                      : (action == "activate")
                          ? Colors.blue
                          : Colors.red,
                  onTap: () {
                    print('Remove');
                  },
                )
              ]
            : null,

        actionExtentRatio: 0.25,

        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: KsecondaryColor.withOpacity(.755),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(profile),
              radius: 26,

              // minRadius: 20,
              // maxRadius: 25,
            ),
            radius: 30,
            // minRadius: 27,
            // maxRadius: 27,
          ),
          title: Container(
            margin: EdgeInsets.only(top: 1, bottom: 3),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: 17,
                      color: KprimaryColorDark,
                      fontWeight: FontWeight.w600),
                ),
                (action == "cancle")?Icon(Icons.iso_outlined, color: KsecondaryColor)
                :(action == "activate")?Icon(Icons.domain_verification, color: KsecondaryColor)
                :(action == "Inprogress")?Icon(Icons.domain_verification, color: KsecondaryColor)
                :(action == "Completed")?Icon(Icons.domain_verification, color: KsecondaryColor)
                :Icon(Icons.domain_verification, color: KsecondaryColor)


              ],
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "for: $user",
                style: TextStyle(
                    color: KprimaryColorDark,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
              ),
              Container(
                margin: EdgeInsets.only(top: 4),
                child: Text(
                  "\t\t${schedule.toString()}",
                  style: TextStyle(fontSize: 13, color: KprimaryColorDark),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: KsecondaryColor,
                      size: 16,
                    ),
                    Text(
                      "${distance.toString()} Km ",
                      style: TextStyle(
                          color: KprimaryColorDark,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Away from you",
                      style: TextStyle(
                          color: KprimaryColorDark,
                          fontWeight: FontWeight.w500),
                    ),
                    Divider(
                      thickness: 1,
                      // height: 1,
                    )
                  ],
                ),
              ),
            ],
          ),
          onTap: () {
            //Navigator.pushNamed(context, JobDetails.id);
          },
        ),
      ),
    );
  }
}
