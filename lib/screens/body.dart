
import 'package:flutter/widgets.dart';
import 'package:food/components/discount_card.dart';
import 'package:food/components/product_list.dart';
import 'package:food/screens/category_list.dart';
import 'package:food/screens/image_slider.dart';
import 'package:food/screens/search_box.dart';

class Body extends StatefulWidget {

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        SearchBox(),
   
        ImageSlider(),
        SizedBox(height: 40,),
        CategoryList(),
        SizedBox(height: 20,),
        DiscountCard(),
        SizedBox(height: 40,),
        ProductList()
      ]),
    );
  }
}