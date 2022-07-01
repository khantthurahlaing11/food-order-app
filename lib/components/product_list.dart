
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food/components/detail_screen.dart';
import 'package:food/models/product.dart';

class ProductList extends StatefulWidget {


  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
    Stream<QuerySnapshot> products = FirebaseFirestore.instance.collection("products").snapshots();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot>(
        stream: products,
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshots){
          return GridView.builder(
          physics: ScrollPhysics(),  
          shrinkWrap: true,
          itemCount: snapshots.data!.docs.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.8), 
          itemBuilder: (BuildContext context,index){
            return InkWell(
              onTap: (){
                Product product = Product(
                snapshots.data!.docs[index].id,
                snapshots.data!.docs[index]['name'], 
                snapshots.data!.docs[index]['description'], 
                snapshots.data!.docs[index]['img'], 
                snapshots.data!.docs[index]['price'], 
                snapshots.data!.docs[index]['shop']);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                  snapshots.data!.docs[index].id,product
                )));
              },
              child: SingleChildScrollView(
              child: Column(children: [
              Container(
                padding:EdgeInsets.symmetric(horizontal: 5),
                child: Image.network("${snapshots.data!.docs[index]['img']}"),),
              Container(child: Column(children: [
                Text("${snapshots.data!.docs[index]['name']}",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: 15),),
                Text("${snapshots.data!.docs[index]['price']} MMK",style: TextStyle(color: Colors.pink,fontWeight: FontWeight.bold,fontSize: 15),),
              ],),)
            ],),),);
          });
      }),);
  }
}