

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DiscountCard extends StatefulWidget {
  

  @override
  State<DiscountCard> createState() => _DiscountCardState();
}

class _DiscountCardState extends State<DiscountCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        SizedBox(height: 5,),
        Text("Offers & Discount",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.deepPurpleAccent),),
       SizedBox(height: 20,),
        Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(image: AssetImage("assets/images/pexels-pixabay-326281.jpg"),
            fit: BoxFit.fill
            ),
            
          ),
          child: Padding(padding: EdgeInsets.all(20),
        child: Row(children: [
          SizedBox(width: 130,),
          Expanded(child: RichText(text: TextSpan(children: [ 
            TextSpan(text: "40% Discount",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold)),
          ]),))
        ],),
        ),)
      ],),
    );
  }
}