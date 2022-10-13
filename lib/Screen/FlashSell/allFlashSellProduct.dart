// import 'package:ecommerce_bokkor_dev/Screen/FlashSell/allFlashSellCard.dart';
// import 'package:ecommerce_bokkor_dev/Screen/NewArrival/allNewArrivalCard.dart';
// import 'package:flutter/material.dart';

// import '../../main.dart';

// class AllFlashSellProduct extends StatefulWidget {
//   @override
//   _AllFlashSellProductState createState() => _AllFlashSellProductState();
// }

// class _AllFlashSellProductState extends State<AllFlashSellProduct> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         backgroundColor: appTealColor,
//         title: const Text('Flash Sell Products'),
//         titleSpacing: 1,
//       ),
//       body: SafeArea(
//         child: Container(
//           //color: Colors.red,
//             margin: EdgeInsets.only(
//               left: 0,
//               right: 0,
//             ),
//             width: MediaQuery.of(context).size.width,
//             padding: EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 5),
//             child: OrientationBuilder(
//               builder: (context, orientation) {
//                 return orientation == Orientation.portrait
//                     ////// <<<<< Portrait Card start >>>>> //////
//                     ?  ListView.builder(
//                               physics: BouncingScrollPhysics(),
//                               scrollDirection: Axis.vertical,
//                               itemBuilder: (BuildContext context, int index) =>
//                                   Container(
//                                 margin:
//                                     EdgeInsets.only(bottom: 0, top: 0, left: 3),
//                                 decoration: BoxDecoration(
//                                   color: Colors.white,
//                                   borderRadius: BorderRadius.only(
//                                       bottomLeft: Radius.circular(10),
//                                       bottomRight: Radius.circular(10)),
//                                 ),
//                                 child: AllFlashSellProductCard(index),
//                               ),
//                               itemCount: 7,
//                             )
//                     ////// <<<<< Portrait Card end >>>>> //////
//                     :
//                     ////// <<<<< Landscape Card start >>>>> //////
//                     GridView.builder(
//                         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                           crossAxisCount: 2,
//                           childAspectRatio:
//                               (MediaQuery.of(context).size.width / 2) /
//                                   (MediaQuery.of(context).size.height / 1.9),
//                         ),
//                         itemBuilder: (BuildContext context, int index) =>
//                             AllFlashSellProductCard(index),
//                         itemCount: 20,
//                       );
//                 ////// <<<<< Landscape Card end >>>>> //////
//               },
//             )),
//       ),
//     );
//   }
// }