// import 'package:countdown_flutter/countdown_flutter.dart';
// import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
// import 'package:ecommerce_bokkor_dev/Screen/ProductDetails/ProductDetails.dart';
// import 'package:flutter/material.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';

// import '../../main.dart';

// class AllFlashSellProductCard extends StatefulWidget {
//   final index;
//   AllFlashSellProductCard(this.index);
//   @override
//   _AllFlashSellProductCardState createState() =>
//       _AllFlashSellProductCardState();
// }

// class _AllFlashSellProductCardState extends State<AllFlashSellProductCard> {
// var rating = 0.0;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       alignment: Alignment.center,
//       width: MediaQuery.of(context).size.width / 1.2,
//       child: GestureDetector(
//         onLongPress: () {
//           print("object");
//           // _showpop();
//         },
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => ProductsDetailsPage(widget.index.id, 1)),
//           );
//         },
//         child: ListTile(
//           contentPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
//           title: Stack(
//             children: <Widget>[
//               Card(
//                 elevation: 1.0,
//                 color: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 ),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     boxShadow: [
//                       BoxShadow(
//                         blurRadius: 0.5,
//                         color: Color(0XFF377FA8).withOpacity(0.5),
//                         //offset: Offset(6.0, 7.0),
//                       ),
//                     ],
//                   ),
//                   height: 150,
//                   width: MediaQuery.of(context).size.width / 1,
//                   padding: EdgeInsets.only(bottom: 0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: <Widget>[
//                       Container(
//                         // height: 80,
//                         margin: EdgeInsets.only(right: 12),
//                         padding: EdgeInsets.only(left: 8),
//                         // width: 80,
//                         //color: Colors.red,
//                         alignment: Alignment.center,
//                         //width: MediaQuery.of(context).size.width / 1.2,
//                         child: Image.asset(
//                           'assets/images/fsproduct1.png',
//                           height: 80,
//                           width: 80,
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       Expanded(
//                         child: Container(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: <Widget>[
//                               Container(
//                                 padding: EdgeInsets.only(top: 8),
//                                 child: Text(
//                                   "XTREME E226BU 2:1",
//                                   maxLines: 1,
//                                   overflow: TextOverflow.ellipsis,
//                                   style: TextStyle(
//                                       fontSize: 15,
//                                       fontFamily: 'Roboto',
//                                       color: Color(0XFF09324B),
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(top: 8, left: 0),
//                                 child: Row(
//                                   children: <Widget>[
//                                     Expanded(
//                                       child: Container(
//                                         margin: EdgeInsets.only(
//                                             right: 0, top: 0, bottom: 10),
//                                         child: Text("USD 300.00",
//                                             maxLines: 1,
//                                             overflow: TextOverflow.ellipsis,
//                                             style: TextStyle(
//                                                 fontSize: 13,
//                                                 fontFamily: 'Roboto',
//                                                 color: appTealColor,
//                                                 fontWeight: FontWeight.bold)),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 //color: Colors.red,
//                                 margin: EdgeInsets.only(bottom: 5),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: <Widget>[
//                                     Stack(
//                                       children: <Widget>[
//                                         Container(
//                                           width: 100,
//                                           height: 6,
//                                           decoration: BoxDecoration(
//                                               color: Color(0XFFB1E0FB),
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(10.0))),
//                                         ),
//                                         Container(
//                                           width: 80,
//                                           height: 6,
//                                           decoration: BoxDecoration(
//                                               color: Color(0XFFFD68AE),
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(10.0))),
//                                         )
//                                       ],
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.only(left: 8.0),
//                                       child: Text("80% Sold",
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                           style: TextStyle(
//                                               fontSize: 8,
//                                               fontFamily: 'Roboto',
//                                               color: Color(0XFF09324B),
//                                               fontWeight: FontWeight.bold)),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(bottom: 5),
//                                 child: CountdownFormatted(
//                                   duration: Duration(hours: 1),
//                                   builder:
//                                       (BuildContext ctx, String remaining) {
//                                     return Text(remaining); // 01:00:00
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 //color: Colors.red,
//                 margin: EdgeInsets.only(top: 8, right: 8),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     Container(
//                         padding: EdgeInsets.only(
//                             left: 10, right: 10, top: 8, bottom: 8),
//                         // padding: EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: widget.index % 2 == 0
//                               ? Color(0XFFFD68AE)
//                               : Colors.transparent,
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         ),
//                         child: Text(
//                           widget.index % 2 == 0 ? "-80%" : "",
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 10,
//                               fontFamily: 'Roboto'),
//                         )),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
