

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/auth/order.dart';

class ShowOrder extends StatefulWidget {
  String id;
  String amt;
  ShowOrder(this.id,this.amt);

  @override
  State<ShowOrder> createState() => _ShowOrderState();
}

class _ShowOrderState extends State<ShowOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Lists")),
      body: SingleChildScrollView(child: 
        Column(children: [
           FutureBuilder(
      future: Order().getOrder(widget.id),
      builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot) {
      return ListView.builder(
        
        shrinkWrap: true,
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context,index){
          return Card(
          
            child: 
          Row(children: [
            Image.network(snapshot.data!.docs[index]['img'],width: 100,height: 100,),
            SizedBox(width: 20,),
            Column(children: [
              Container(child: Text(snapshot.data!.docs[index]['name'],style: TextStyle(color: Colors.pink),),),
              Container(child: Text("${snapshot.data!.docs[index]['price']} MMK",style: TextStyle(color: Colors.black),),)
            ],),
            SizedBox(width: 20,),
            Column(children: [
              Text("Qty",style: TextStyle(color: Colors.pink),),
              Text("${snapshot.data!.docs[index]['qty']}")
            ],),
             SizedBox(width: 20,),
            Column(children: [
              Text("Amount",style: TextStyle(color: Colors.pink),),
              Text("${snapshot.data!.docs[index]['qty'] *snapshot.data!.docs[index]['price']}")
            ],)
          ],)
          ,);
        });
    },),
    SizedBox(height: 20,),
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
      
      Text("Total Amount",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold)),
      Text("${widget.amt} MMK",style: TextStyle(fontSize: 16,color: Colors.black,fontWeight: FontWeight.bold))
    ],)
        ],)
    ,),
    );
  }
}