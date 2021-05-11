import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/Request.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/GalleryDialogImages.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';

class JobDetails extends StatefulWidget {
  static String id = "jobDetails";

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  double _padding;
  RequestModel requestModel;
  @override
  Widget build(BuildContext context) {
    requestModel = ModalRoute.of(context).settings.arguments;
    _padding = MediaQuery.of(context).size.height / 400;
    return Scaffold(
      appBar: AppBar(
        title: Text("Job Details"),
        centerTitle: true,
        backgroundColor: KprimaryColor,
        elevation: 0,
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              flex: 11,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    color: KprimaryColor),
                padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Job Title",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: KprimaryColorDark),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Electrician",
                              style: TextStyle(
                                  fontSize: 16, color: KprimaryColorDark),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 35,
                      thickness: 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: _padding, bottom: _padding),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Problem",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: KprimaryColorDark),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${requestModel.rProblem}",
                              style: TextStyle(
                                  fontSize: 16, color: KprimaryColorDark),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 35,
                      thickness: 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: _padding, bottom: _padding),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: KprimaryColorDark),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${requestModel.rDescription}",
                              style: TextStyle(
                                  fontSize: 16, color: KprimaryColorDark),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 35,
                      thickness: 2,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 5, right: 5, top: _padding, bottom: _padding),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Date & Time",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: KprimaryColorDark),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "${requestModel.requestDate.substring(0, 10)} , ${requestModel.requestTime.substring(10, 16)}",
                              style: TextStyle(
                                  fontSize: 16, color: KprimaryColorDark),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.black,
                      height: 35,
                      thickness: 2,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Address",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: KprimaryColorDark),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Lebanon",
                                  style: TextStyle(
                                      fontSize: 16, color: KprimaryColorDark),
                                ),
                                Text(
                                  "Tripoli",
                                  style: TextStyle(
                                      fontSize: 16, color: KprimaryColorDark),
                                ),
                                Text(
                                  "Sehet Al Nour",
                                  style: TextStyle(
                                      fontSize: 16, color: KprimaryColorDark),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: KprimaryColorDark,
                      height: 35,
                      thickness: 2,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Gallery",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: KprimaryColorDark),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: _padding * 8),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width / 3.4,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  for (String imageurl
                                      in requestModel.rImageUrl)
                                    GalleryImages(
                                      assetImage: imageurl,
                                      isOnline: true,
                                    ),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: _padding * 7),
                        child:
                            CustomButton(onPressed: () {}, textValue: "Accept"),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: _padding * 7),
                        child:
                            CustomButton(onPressed: () {}, textValue: "Reject"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        
        ),
      ),
    );
  }
}
