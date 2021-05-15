import 'package:flutter/material.dart';

class Providerhom extends StatefulWidget {
  static String id = 'Userhom';
  @override
  _ProviderhomState createState() => _ProviderhomState();
}

class _ProviderhomState extends State<Providerhom> {
  bool isCompleted=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("Requests"),
        centerTitle: true,
      ),
           bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.build),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'My Profile',
          ),
        ],
        // currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        // onTap: _onItemTapped,
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
                    Text("REQUESTS",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: !isCompleted? Colors.black : Colors.grey
                    ),),
                    if(!isCompleted)
                    Container(
                      margin: EdgeInsets.only(top:3),
                      height: 2,
                      width: 55,
                      color: Colors.orange,

                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: (){
                  setState(() {
                    isCompleted=true;
                  });
                },
                              child: Column(
                  children: [
                    Text("COMPLETED",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isCompleted? Colors.black : Colors.grey
                    ),),
                    if(isCompleted)
                    Container(
                      margin: EdgeInsets.only(top:3),
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
      ),),
      SizedBox(height: 10,),
      if(!isCompleted)
      buildRequests(),
      if(isCompleted)
      buildComplited()
      
      ]
      
      
      )
      
    );
  }

  Container buildComplited() {
    return Container(child: 
 Column
      (
      children: [
        buildCard("Said Asfour", "81 748 400"),
        buildCard("Bashar Sayed", "81 350 091"),
        
        
      ],
      ),
      
  );
  }

  Container buildRequests() {
    return Container(child: 
 Column
        (
        children: [
         buildCard("Bassam Odaymat", "81 655 888")
          
          
        ],
        )
    );
    
  }
   Card buildCard(String title,String subtitle) {
    return Card(
         child: ListTile(
           title: Text(title),
           subtitle: Text(subtitle),
           leading: Image.asset("assets/noprofile.png"),
           trailing: Icon(Icons.phone),
         ),
       );
  }
}

