
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {


  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(items: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/pexels-ella-olsson-1640777.jpg",)
        )),),
        Container(
        width: MediaQuery.of(context).size.width,
        height: 300,
        decoration: BoxDecoration(image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage("assets/images/pexels-ella-olsson-1640777.jpg")
        )),)
    ], options:CarouselOptions(autoPlay: true,viewportFraction: 1));
  }
}