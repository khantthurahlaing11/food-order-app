

import 'package:flutter/material.dart';
import 'package:food/auth/auth.dart';
import 'package:food/auth/login_status.dart';
import 'package:food/main.dart';
import 'package:food/screens/home.dart';
import 'package:provider/provider.dart';

import 'login_screen.dart';


class RegisterScreen extends StatefulWidget {


  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final key = GlobalKey<FormState>();
   TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
   
    return Scaffold(

      body: Container(
        decoration: BoxDecoration(color: Colors.pink),
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height:20),
            Padding(padding: EdgeInsets.all(20),
            child: Column(children: [
              SizedBox(height: 25,),
              Center(child: Text("Register",style: TextStyle(
                color: Colors.white,
                fontSize: 40
              ),),),
              SizedBox(height: 15,),
              Center(child: Text("Please! Register New Account",style: TextStyle(
                color: Colors.white,
                fontSize: 15
              ),),),
               SizedBox(height: 15,),
            
            ],),),
            SizedBox(height: 10,),
            Expanded(child: Container(
              decoration: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15))
              ),
              child: Padding(padding: EdgeInsets.all(30),
              child: SingleChildScrollView(child:Column(children: [
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(children: [
                    Form(
                      key: key,
                      child: Column(children: [
                      // SizedBox(height: 10,),
                       Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1,color: Colors.pink))
                        ),
                        child: TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: "Enter Your Name",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none
                          ),
                           validator: (val){
                            if(val == null || val.isEmpty){
                              return "Name Must Not Be Empty";
                            }
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1,color: Colors.pink))
                        ),
                        child: TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: "Enter Your Email",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none
                          ),
                           validator: (val){
                            if(val == null || val.isEmpty){
                              return "Email Must Not Be Empty";
                            }
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(width: 1,color: Colors.pink))
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            hintText: "Enter Your Password",
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none
                          ),
                          validator: (val){
                            if(val == null || val.isEmpty){
                              return "Password Must Not Be Empty";
                            }
                          },
                        ),
                      )
                    ],)),
                    SizedBox(height: 40,),
                    TextButton(onPressed: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context){
                        return LoginScreen();
                      }));
                    }, child: Text("Please! Login",style: TextStyle(color: Colors.deepPurpleAccent),)),
                    Container(
                      decoration: BoxDecoration(color: Colors.pink,borderRadius: BorderRadius.circular(10)),
                      height: 50,
                      width: MediaQuery.of(context).size.width*0.5,
                      child:  OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10)))
                        ),
                        onPressed: () async{
                        if(key.currentState!.validate()){
                          Map<String,dynamic> status = await Auth().register(emailController.text, passwordController.text);
                          if(status['status']){
                            Provider.of<LoginStatus>(context,listen: false).setStatus(true);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp(),));
                          }
                        }
                    },child: Text("Register",style: TextStyle(color: Colors.white),))
                    ,)

                  ],),
                )
              ],)),
              )))
            
          ],
        ),
      ),);
  }
}