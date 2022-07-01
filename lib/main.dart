

import 'package:flutter/material.dart';
import 'package:food/auth/login_status.dart';
import 'package:food/screens/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:food/screens/login_screen.dart';
import 'package:provider/provider.dart';

import 'carts/cart.dart';


void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=> Cart()),
      ChangeNotifierProvider(create: (context)=> LoginStatus()),
    ],
    child: MyApp()
    )
  );
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    bool status = Provider.of<LoginStatus>(context).getStatus();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: (status)? Home() : LoginScreen()
      
    );
  }
}