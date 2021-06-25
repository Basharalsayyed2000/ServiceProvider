import 'package:flutter/material.dart';
import 'dart:math' as math;
 
class ExpandableParent extends StatefulWidget{
 
  final String title;
 
  final List<Widget> children;
 
  ExpandableParent({this.title, this.children});
 
  @override
  State<StatefulWidget> createState(){
    return _ExpandableParent(title: title, children: children);
  }
 
}
 
class _ExpandableParent extends State<ExpandableParent>{
 
  bool open = false;
 
  final String title;
 
  final List<Widget> children;
 
  var length;
 
  _ExpandableParent({this.title, this.children});
 
  @override
  Widget build(BuildContext context){
    length = (children.length < 1)? 1 : children.length+1;
    return Container(
      margin: EdgeInsets.symmetric(vertical: (open)? 10 : 1),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: (open)?[
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 0.0), //(x,y)
              blurRadius: 0.2,
            ),
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 0.2,
            ),
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1.0, 0.0), //(x,y)
              blurRadius: 0.2,
            ),
            BoxShadow(
              color: Colors.grey,
              offset: Offset(1.0, 1.0), //(x,y)
              blurRadius: 0.2,
            ),
          ]:
          [],
          
          // border: Border(bottom: BorderSide(color: Colors.blueGrey)),
          color: Colors.white
        ),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: (!open)?1 : length,
          separatorBuilder: (context, index){
            print(index);
            if(index > 0 && index < length)
              return Divider(
                height: 0,
                indent: 15,
                endIndent: 15,
                thickness: 1.5,
              );

            return Divider(
              height: 8,

              thickness: 1,
            );
          },
          itemBuilder: (context, index){
            if(index == 0){
              return ListTile(
                onTap: (){
                  toggleOpen();
                },
                leading: Text(
                  "$title",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                trailing: Transform.rotate(
                  angle: (open == true)? 270 * math.pi / 180 : 180 * math.pi / 180,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios, size: 20,),
                    onPressed: () {
                      toggleOpen();
                    }
                  ),
                )
              );
            }else{
              return Container(
                child: children[index - 1]
              );
            }
          }
        ),
      ) 
      
    );
  }
 
  void toggleOpen(){
    setState(() {
      open = !open;
    });
  }
 
}
 
class ExpandableTile extends StatefulWidget{
 
  final Widget leading;
  final Widget subtitle;
 
  final Function onTap;
 
  ExpandableTile({this.leading, this.subtitle, @required this.onTap});
 
  @override
  State<StatefulWidget> createState() {
    return _ExpansionTile(leading: leading, subtitle: subtitle, onTap: onTap);
  }
 
}
 
class _ExpansionTile extends State<ExpandableTile>{
 
  final Widget leading;
  final Widget subtitle;
 
  final Function onTap;
 
  _ExpansionTile({this.leading, this.subtitle, @required this.onTap});
 
  @override
  Widget build(BuildContext context) {
    if(subtitle != null)
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 7.5),
        child: ListTile(
          leading: leading,
          subtitle: subtitle,
          onTap: ()=>onTap(),
        ),
      );
 
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 7.5),
      child: ListTile(
        leading: leading,
        onTap: ()=>onTap(),
      ),
    );
 
  }
 
}