

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchBox extends StatefulWidget {


  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
      border: Border.all(color: Colors.grey)
      ),
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 0),
      child: TextField(
        onChanged: (val){

        },
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: SvgPicture.asset("assets/icons/search-svgrepo-com (1).svg",width: 20,color: Colors.pink,),
          hintText: "Search Here"
        ),
      ),
    );
  }
}