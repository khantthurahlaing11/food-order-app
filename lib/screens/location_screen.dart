

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';

class LocationScreen extends StatefulWidget {
  String customerId;
  LocationScreen(this.customerId);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool loading = false;
  Completer<GoogleMapController> _controller = Completer();
  late CameraPosition initialCameraPosition;
  late Location location;
  late LocationData currentLocation ;

  @override
  void initState() {
    super.initState();
    setInitialLocation();
  }
  @override
  Widget build(BuildContext context) {
    return 
    this.loading?
    Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
          FirebaseFirestore.instance.collection("customers").doc(widget.customerId).update({
            "lat" : currentLocation.latitude,
            "log" : currentLocation.longitude
          });
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyApp(),));
      },child: Text("OK"),),
      body: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
        initialCameraPosition: initialCameraPosition),
    ) : Scaffold(body: CircularProgressIndicator(),);
  }

  void setInitialLocation() async{
    location = Location();
    currentLocation = await location.getLocation();
    initialCameraPosition = CameraPosition(
      zoom: 15,
      target: LatLng(currentLocation.latitude!, currentLocation.longitude!));

      setState(() {
        this.loading = true;
      });
  }
}