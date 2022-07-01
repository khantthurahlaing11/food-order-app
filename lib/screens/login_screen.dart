
import 'package:flutter/material.dart';
import 'package:food/auth/login_status.dart';
import 'package:food/main.dart';
import 'package:provider/provider.dart';

import '../auth/auth.dart';
import 'home.dart';
import 'register_screen.dart';


class LoginScreen extends StatefulWidget {

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final key = GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.pink),
        child: Column(
          children: [
            SizedBox(height:50),
            Padding(padding: EdgeInsets.all(20),
            child: Column(children: [
              SizedBox(height: 25,),
              Center(child: Text("Login",style: TextStyle(
                color: Colors.white,
                fontSize: 40
              ),),),
              SizedBox(height: 10,),
              Center(child: Text("Please! Login",style: TextStyle(
                color: Colors.white,
                fontSize: 15
              ),),),
              SizedBox(height: 10,),
            ],),),
            SizedBox(height: 20,),
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
                      SizedBox(height: 10,),
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
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                        return RegisterScreen();
                      }));
                    }, child: Text("Create New Account",style: TextStyle(color: Colors.deepPurpleAccent),)),
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
                           Map<String,dynamic> result = await Auth().login(emailController.text, passwordController.text);
                          if(result['status']){
                            Provider.of<LoginStatus>(context,listen: false).setStatus(true);
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp(),));
                          }
                        }
                    },child: Text("Login",style: TextStyle(color: Colors.white),))
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