import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/Models/NeededData.dart';
import 'package:service_provider/Models/provider.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/GalleryDialogImages.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';
import 'package:service_provider/Screens/User/ServiceRequest.dart';

class ServiceDetails extends StatefulWidget{
  static String id = "serviceDetails";
  @override
  State<StatefulWidget> createState() {
    return _ServiceDetails();
  }
}

class _ServiceDetails extends State<ServiceDetails> {
  ProviderModel _provider;
  @override
  Widget build(BuildContext context) {
    _provider = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Details"),
        centerTitle: true,
        backgroundColor: KprimaryColor,
      ),

      body: StreamBuilder(
          stream: Firestore.instance
              .collection(KServicesCollection)
              .document(_provider.pProvideService)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading");
            } else {
              var userDocument = snapshot.data;
              List<String> urlList = _provider.certificateImages;
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
                                  NetworkImage('${_provider.pImageUrl}'),
                              radius:
                                  MediaQuery.of(context).size.height * 0.067,
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
                                    "${_provider.pEmail}",
                                    style: TextStyle(
                                      color: Colors.blueGrey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                Text(
                                  "By: ${_provider.pName}",
                                  style: TextStyle(
                                    height: 1.3,
                                    fontSize: 12,
                                  ),
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
                      padding: EdgeInsets.only(bottom: Kminimumpadding * 5),
                      child: Text(
                      "Certificate",
                        style: TextStyle(
                            fontSize: 19, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          top: Kminimumpadding * 1,
                          bottom: Kminimumpadding * 1),
                      child: Text(
                        '${_provider.pProviderDescription}',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  
             
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: Kminimumpadding * 5, bottom: Kminimumpadding * 4),
 
               child: Text(
                '${_provider.pProviderDescription}',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(bottom: Kminimumpadding * 5),
              child: Text(
                "Service Gallery",
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),

            Container(

              child: SizedBox(
                height: MediaQuery.of(context).size.width/3.4,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GalleryImages(
                          assetImage: "Assets/images/Logo.png",
                        ),
                        GalleryImages(
                          assetImage: "Assets/images/painter.png",
                        ),
                        GalleryImages(
                          assetImage: "Assets/images/parquet.png",
                        ),
                        GalleryImages(
                          assetImage: "https://www.netclipart.com/pp/m/326-3265302_handyman-cartoon-mechanic.png",
                          isOnline: true,
                        ),

                      ],
                    ),
                  ]
                ),
              ),
            ),

            Container(
              padding: EdgeInsets.only(top: Kminimumpadding * 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(Kminimumpadding*1.5),

                      
                      child: CustomButton(
                        onPressed: (){
                          Navigator.pushNamed(context, ServiceRequest.id,arguments:NeededData(provider:_provider,isActive:true) );
                        },
                        textValue: "Book Now",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(Kminimumpadding*1.5),
                      child: CustomButton(
                        onPressed: (){
                          Navigator.pushNamed(context, ServiceRequest.id,arguments:NeededData(provider:_provider,isActive:false) );
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
      margin: EdgeInsets.only(
          bottom: 10,
          left: 10,
          right: 10,
          top: 10),
      child: getImage(),
    );
  }

  Widget getImage(){
    AssetImage assetImage = new AssetImage("Assets/images/Logo.png");
    Image image = new Image(image: assetImage, width: MediaQuery.of(context).size.width/2.6, height: MediaQuery.of(context).size.width/3.4);

    return image;
  }

}