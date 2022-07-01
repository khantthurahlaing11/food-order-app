

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food/admin/admin.dart';
import 'package:food/auth/auth.dart';
import 'package:food/auth/login_status.dart';
import 'package:food/main.dart';
import 'package:food/screens/body.dart';
import 'package:provider/provider.dart';

import '../components/cart_view.dart';

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool status = false;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    checkRole();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: RichText(
          text: TextSpan(   
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 23,),
        children: [
          TextSpan(     
            text: "FoodOrder",
            
            style: TextStyle(color: Colors.amberAccent,)
          ),
          //   TextSpan(
          //   text: "Order",
          //   style: TextStyle(color: Colors.amberAccent)
          // ),
          //    TextSpan(
          //   text: "App",
          //   style: TextStyle(color: Colors.green)
          // ),
        ]
      )),
      actions: [IconButton(onPressed: (){

      }, icon: Icon(Icons.shopping_cart_checkout,color: Colors.amberAccent,size: 28,))],
      
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          if(index == 2){
            Auth().logout();
            Provider.of<LoginStatus>(context,listen: false).setStatus(false);
             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp(),));
          }else if(index == 3){
           if(this.status){
              Navigator.push(context, MaterialPageRoute(builder: (context) => Admin(),));
           }
          }else if(index == 1){
             Navigator.push(context, MaterialPageRoute(builder: (context) => CartView()));
          }
        },
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: [
        BottomNavigationBarItem(icon: Icon(Icons.home),label: "Home"),
        BottomNavigationBarItem(icon: Icon(Icons.shop),label: "Cart"),
        BottomNavigationBarItem(icon: Icon(Icons.logout),label: "Logout"),
        status?
        BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings),label: "Admin"):
        BottomNavigationBarItem(icon: Icon(Icons.verified_user),label: "User")
      ],),
      body: Body(),
    );
  }

  checkRole() async{
   QuerySnapshot<Map<String,dynamic>> roles = await FirebaseFirestore.instance.collection("role").where("user_id",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    if(roles.docs[0]['role'] == "admin"){
      setState(() {
        this.status = true;
      });
    }
  }
}