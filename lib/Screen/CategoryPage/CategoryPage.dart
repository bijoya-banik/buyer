// import 'package:ecommerce_bokkor_dev/Screen/CategoryPage/CategoryCard.dart';
// import 'package:ecommerce_bokkor_dev/main.dart';
// import 'package:flutter/material.dart';

// class CategoryPage extends StatefulWidget {
//   @override
//   _CategoryPageState createState() => _CategoryPageState();
// }

// class _CategoryPageState extends State<CategoryPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//   appBar: new AppBar(
//         backgroundColor: appTealColor,
//         title: const Text('Category'),
//       ),

//       body: SafeArea(
//         child: Container(
//                       margin: EdgeInsets.only(
//                         left: 0,
//                         right: 0,
//                       ),
                
//                       width: MediaQuery.of(context).size.width,
//                       padding: EdgeInsets.only(left: 5, right: 5,top: 4, bottom: 5),
//                       child: OrientationBuilder(
//                         builder: (context, orientation) {
//                           return orientation == Orientation.portrait
//                               ////// <<<<< Portrait Card start >>>>> //////
//                               ? GridView.builder(
//                                   gridDelegate:
//                                       SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 2,
//                                     childAspectRatio: (MediaQuery.of(context)
//                                                 .size
//                                                 .width /
//                                             3) /
//                                         (MediaQuery.of(context).size.height /
//                                             5),
//                                   ),
//                                   itemBuilder:
//                                       (BuildContext context, int index) =>
//                                             new Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: CategoryCard(index),
//                                   ),
//                                   itemCount: 20,
//                                 )
//                               ////// <<<<< Portrait Card end >>>>> //////
//                               :
//                               ////// <<<<< Landscape Card start >>>>> //////
//                               GridView.builder(
//                                   gridDelegate:
//                                       SliverGridDelegateWithFixedCrossAxisCount(
//                                     crossAxisCount: 4,
//                                     childAspectRatio: (MediaQuery.of(context)
//                                                 .size
//                                                 .width /
//                                             2) /
//                                         (MediaQuery.of(context).size.height /
//                                             2.5),
//                                   ),
//                                   itemBuilder:
//                                       (BuildContext context, int index) =>
//                                           new Padding(
//                                     padding: const EdgeInsets.all(5.0),
//                                     child: CategoryCard(index),
//                                   ),
//                                   itemCount: 20,
//                                 );
//                           ////// <<<<< Landscape Card end >>>>> //////
//                         },
//                       )),
//       ),
      
//     );
//   }
// }