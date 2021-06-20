import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/GalleryDialogImages.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/Screens/Request/ServiceRequest.dart';

class ServiceDetails extends StatefulWidget {
  static String id = "serviceDetails";
  final ProviderModel providerModel;
  ServiceDetails({
    this.providerModel
  });
  @override
  State<StatefulWidget> createState() {
    return _ServiceDetails(
        providerModel:providerModel
    );
  }
}

class _ServiceDetails extends State<ServiceDetails> {
  final ProviderModel providerModel;
  _ServiceDetails({
    this.providerModel
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Details"),
        centerTitle: true,
        backgroundColor: KprimaryColor,
      ),
      body: StreamBuilder(
          stream: Firestore.instance
              .collection(KServicesCollection)
              .document(providerModel.pProvideService)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading");
            } else {
              var userDocument = snapshot.data;
              List<String> urlList = providerModel.certificateImages;
              print(urlList.length);
              return Container(
                margin: EdgeInsets.only(
                    left: Kminimumpadding * 5, right: Kminimumpadding * 4.5),
                child: ListView(
                  children: [
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                top: Kminimumpadding * 5,
                                right: Kminimumpadding * 4),
                            child: CircleAvatar(
                              backgroundImage:
                                  NetworkImage('${providerModel.pImageUrl}'),
                              radius: MediaQuery.of(context).size.height * 0.06,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Text(
                                    "${userDocument[KServiceName]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      height: 1.3,
                                      fontSize: 19,
                                    ),
                                  ),
                                  padding:
                                      EdgeInsets.only(top: Kminimumpadding * 4),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 3, bottom: 3),
                                  child: Text(
                                    "${providerModel.pEmail}",
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "By: ${providerModel.pName}",
                                      style: TextStyle(
                                        height: 1.3,
                                        fontSize: 12,
                                      ),
                                    ),
                                    (providerModel.isvarified)
                                        ? Icon(
                                            Icons.verified,
                                            color: Colors.blue,
                                          )
                                        : Container(),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20,
                                    ),
                                    Text(
                                      "${providerModel.rate}",
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: KprimaryColorDark),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 35,
                      thickness: 2,
                      indent: 5,
                      endIndent: 5,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: Kminimumpadding * 2),
                      child: Text(
                        "Description",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w500),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width,
                      child: ListView(children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: Kminimumpadding * 1,
                              bottom: Kminimumpadding * 1),
                          child: Text(
                            '${providerModel.pProviderDescription}',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ]),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: Kminimumpadding * 7, bottom: 30),
                      child: Text(
                        "Service Gallery",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.width / 3.4,
                        child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              (providerModel.certificateImages.isNotEmpty)
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        for (String imageurl
                                            in providerModel.certificateImages)
                                          GalleryImages(
                                            assetImage: imageurl,
                                            isOnline: true,
                                          ),
                                      ],
                                    )
                                  : Text('No image')
                            ]),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: Kminimumpadding * 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(Kminimumpadding * 1.5),
                              child: CustomButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ServiceRequest(
                                          isActive: true,
                                          providerModel: providerModel,
                                          )
                                        ),
                                  );
                                },
                                textValue: "Book Now",
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.all(Kminimumpadding * 1.5),
                              child: CustomButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ServiceRequest(
                                          isActive: false,
                                          providerModel: providerModel,
                                          )
                                        ),
                                  );
                                },
                                textValue: "Book Later",
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

  // ignore: unused_element
  Widget _buildOverlayContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
      child: getImage(),
    );
  }

  Widget getImage() {
    AssetImage assetImage = new AssetImage("Assets/images/Logo.png");
    Image image = new Image(
        image: assetImage,
        width: MediaQuery.of(context).size.width / 2.6,
        height: MediaQuery.of(context).size.width / 3.4);

    return image;
  }
}
