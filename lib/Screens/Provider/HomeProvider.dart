import 'package:flutter/material.dart';

class HomeProvider extends StatefulWidget {
  static String id = 'HomeProvider';
  @override
  _HomeProviderState createState() => _HomeProviderState();
}

class _HomeProviderState extends State<HomeProvider> {
  bool isCompleted = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Requests"),
        centerTitle: true,
      ),
           
      body:
      Column(children:[
      Container(
        
        padding: EdgeInsets.all(20),
        child:
       Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    isCompleted=false;
                  });
                },
                              child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isCompleted = false;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            "Available",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    !isCompleted ? Colors.black : Colors.grey),
                          ),
                          if (!isCompleted)
                            Container(
                              margin: EdgeInsets.only(top: 3),
                              height: 2,
                              width: 55,
                              color: Colors.orange,
                            )
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isCompleted = true;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            "InProgress",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color:
                                    isCompleted ? Colors.black : Colors.grey),
                          ),
                          if (isCompleted)
                            Container(
                              margin: EdgeInsets.only(top: 3),
                              height: 2,
                              width: 55,
                              color: Colors.orange,
                            )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          if (!isCompleted) buildRequests(),
          if (isCompleted) buildComplited()
        ]));
  }

  Container buildComplited() {
    return Container(
      child: Column(
        children: [
          buildCard("Said Asfour", "81 748 400"),
          buildCard("Bashar Sayed", "81 350 091"),
        ],
      ),
    );
  }

  Container buildRequests() {
    return Container(
        child: Column(
      children: [buildCard("Bassam Odaymat", "81 655 888")],
    ));
  }

  Card buildCard(String title, String subtitle) {
    return Card(
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Image.asset("Assets/images/noprofile.png"),
        trailing: Icon(Icons.phone),
      ),
    );
  }
}
