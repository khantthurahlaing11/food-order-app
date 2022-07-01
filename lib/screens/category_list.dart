
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryList extends StatefulWidget {


  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  String defaultId = "GFOLXnvnUSTDvOX3y3yd";
   Future<QuerySnapshot<Map<String,dynamic>>> categoryProducts = FirebaseFirestore.instance.collection("products").where("category",isEqualTo: "GFOLXnvnUSTDvOX3y3yd").get();

  
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> categories = FirebaseFirestore.instance.collection("categories").snapshots();
    return Column(
      children: [
      StreamBuilder<QuerySnapshot>(
        stream: categories,
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshots){
          return Container(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshots.data!.docs.length,
              itemBuilder: (context,index){
                return InkWell(
                  onTap: (){
                    setState(() {
                       categoryProducts = FirebaseFirestore.instance.collection("products").where("category",isEqualTo: snapshots.data!.docs[index].id).get();
                    });
                  },
                  child: Container(
                  decoration: BoxDecoration(border: Border.all(width: 0.5)),
                  padding: EdgeInsets.all(15),
                  child: Text("${snapshots.data!.docs[index]['name']}",style: TextStyle(
                    color: Colors.deepPurpleAccent,
                    fontWeight: FontWeight.bold,fontSize: 15
                  ),)
                ),);
            }),
          );
      }),
      SingleChildScrollView(

        child: 
      FutureBuilder(
        future: categoryProducts,
        builder: (context,AsyncSnapshot<QuerySnapshot<Map<String,dynamic>>> snapshot){
          return Container(
            // width: MediaQuery.of(context).size.width*0.8,
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                return Container(
                  width: MediaQuery.of(context).size.width*0.34,
                  margin: EdgeInsets.only(left: 20,right: 10,top: 20,bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(offset: Offset(1,4),blurRadius: 10),       
                    ]
                  ),
                  child: Column(
                    children: [
                    SizedBox(height: 10,),
                    Container(child: Text("${snapshot.data!.docs[index]['name']}",style: 
                    TextStyle(color: Colors.pink,fontWeight: FontWeight.bold)
                    ,),),
                    SizedBox(height: 10,),
                    Container(  
                    height: 116,      
                    child: Image.network("${snapshot.data!.docs[index]['img']}",
                    
                  ),
                    )
                  ],));
            }),
          );
        } )
      ,)
    ],);
  }
}