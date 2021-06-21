import 'package:flutter/material.dart';

class Review extends StatelessWidget{

  final int rate;
  final String comment;
  Review({this.rate,this.comment});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/2,
          child: Stack(
            children: [
              Column(
                children: [
                  
                ],
              ),
            ],
          ),
        )
    );
  }

}