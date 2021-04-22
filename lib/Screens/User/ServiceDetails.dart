import 'package:flutter/material.dart';
import 'package:service_provider/MyTools/Constant.dart';
import 'package:service_provider/MyWidget/GalleryDialogImages.dart';
import 'package:service_provider/MyWidget/MyCustomButton.dart';

class ServiceDetails extends StatefulWidget{
  static String id = "serviceDetails";
  @override
  State<StatefulWidget> createState() {
    return _ServiceDetails();
  }
}

class _ServiceDetails extends State<ServiceDetails>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Service Details"),
        centerTitle: true,
        backgroundColor: KprimaryColor,
      ),

      body: Container(
        margin: EdgeInsets.only(left: Kminimumpadding * 5, right: Kminimumpadding * 4.5),
        child: ListView(
          children: [
            Container(

              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GalleryImages(
                    assetImage: "Assets/images/electrician.png",
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width/2.4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "Car Repair and Servicing",
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              height: 1.3,
                              fontSize: 19,
                            ),
                          ),
                          padding: EdgeInsets.only(top: Kminimumpadding * 5),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 3, bottom: 3),
                          child: Text(
                            "\$19.49",
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          "By: Bassam Odaymat",
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

            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.only(top: Kminimumpadding * 5, bottom: Kminimumpadding * 4),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
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
                        onPressed: (){},
                        textValue: "Book Now",
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(Kminimumpadding*1.5),
                      child: CustomButton(
                        onPressed: (){},
                        textValue: "Book Later",
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

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