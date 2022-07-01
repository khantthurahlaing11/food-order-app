


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food/auth/order.dart';
import 'package:food/carts/cart.dart';
import 'package:food/main.dart';
import 'package:food/screens/location_screen.dart';

import 'package:provider/provider.dart';

class CartView extends StatefulWidget {


  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {

  
  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Cart List")),
      body: Column(
        children: [
        ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 20),
          physics: ScrollPhysics(),
          shrinkWrap: true,
          itemCount: cart.getLength(),
          itemBuilder: (context,index){
            return Card(
              
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Image.network(cart.getList()[index].product.img,width:65,height:65),
              SizedBox(width: 15,),
             Column(children: [
                Container( 
                child: Text(cart.getList()[index].product.name,style:TextStyle(color: Colors.pink))),
                Container( 
                child: Text("${cart.getList()[index].product.price} MMK",)),
             ],),
             SizedBox(width: 15,),
             Column(children: [
               Text("Qty",style:TextStyle(color: Colors.pink)),
               Text("${cart.getList()[index].counter}"),
             ],),
             SizedBox(width: 15,),
              Column(
                children: [
               Text("Amount",style:TextStyle(color: Colors.pink)),
               Text("${cart.getList()[index].counter * cart.getList()[index].product.price} ")
             ],),

             TextButton(onPressed: (){
              setState(() {
                 cart.deleteProduct(cart.getList()[index]);
              });
             }, child: Icon(Icons.remove_circle) )
             
            ],),);
          }),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

            Text("Total Amount",style: TextStyle(fontWeight: FontWeight.bold),),
            Text("${cart.total} MMK",style: TextStyle(fontWeight: FontWeight.bold))
          ],),
         
          SizedBox(height: 20,),
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            decoration: BoxDecoration(color: Colors.pink,
            borderRadius: BorderRadius.circular(10)
            ),
            child: TextButton(onPressed: () async{
              var user = FirebaseAuth.instance.currentUser;
              if(user != null){
               DocumentReference doc = await Order().createCustomer(user.email!,cart.total.toString());
               cart.getList().forEach((element) {
                 Order().createOrder(element.counter, element.product, doc.id);
               });
               cart.delete();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LocationScreen(doc.id),));
              }
          }, child: Text("Checkout",style: TextStyle(color: Colors.white),)),)
      ],),
    );
  }
}

