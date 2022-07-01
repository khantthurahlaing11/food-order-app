
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food/main.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';

class UserLocation extends StatefulWidget {

  double lat;
  double log;
  UserLocation(this.lat,this.log);

  @override
  State<UserLocation> createState() => _UserLocationState();
}

class _UserLocationState extends State<UserLocation> {
  bool loading = false;
  Completer<GoogleMapController> _controller = Completer();
  late CameraPosition initialCameraPosition;
  late Location location;
  late LocationData currentLocation ;
  Set<Marker> _marker = {};
  late BitmapDescriptor locationIcon;

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
      appBar: AppBar(title: Text("Customer Location"),),
      body: GoogleMap(
        markers: _marker,
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) async{
          _controller.complete(controller);
          LatLng pinPosition = LatLng(widget.lat, widget.log);
          setState(() {
            _marker.add(
              Marker(markerId: MarkerId("Icons"),
            position: pinPosition,
            icon: locationIcon
            )
            );
          });
        },
        initialCameraPosition: initialCameraPosition),
    ) : Scaffold(body: CircularProgressIndicator(),);
  }

  void setInitialLocation() async{
    setMapIcon();
    initialCameraPosition = CameraPosition(
      zoom: 16,
      target: LatLng(widget.lat,widget.log));

      setState(() {
        this.loading = true;
      });
  }

  void setMapIcon()async{
  locationIcon =  await BitmapDescriptor.fromAssetImage(ImageConfiguration(), "assets/icons/i1.png");
  }
}