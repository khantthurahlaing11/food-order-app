

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/admin/show_order.dart';
import 'package:food/auth/order.dart';
import 'package:food/screens/user_location.dart';

class Admin extends StatefulWidget {


  @override
  State<Admin> createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Panel")),
      body: SingleChildScrollView(child: 
      StreamBuilder<QuerySnapshot>(
        stream: Order().getCustomers(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
        return ListView.builder(
          
          shrinkWrap: true,
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.only(top: 20),
            child: 
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Container(
                width: MediaQuery.of(context).size.width*0.5,
                padding: EdgeInsets.symmetric(horizontal: 30,vertical: 20),
                child: Text("${snapshot.data!.docs[index]['email']}",style: TextStyle(fontWeight: FontWeight.bold),),),
             SizedBox(width: 20,),
              IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShowOrder(snapshot.data!.docs[index].id,snapshot.data!.docs[index]['total']),));
              }, icon: Icon(Icons.remove_red_eye,color: Colors.pink,)),
               IconButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => UserLocation(
                    snapshot.data!.docs[index]['lat'],snapshot.data!.docs[index]['log']),));
              }, icon: Icon(Icons.location_on,color: Colors.pink,)),
              IconButton(onPressed: (){
                Order().deleteOrder(snapshot.data!.docs[index].id);
              }, icon: Icon(Icons.delete,color: Colors.pink,)),
            ],)
          ,);
        },);
      },)
      ),
    );
  }
}