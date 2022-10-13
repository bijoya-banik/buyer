// import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
// import 'package:ecommerce_bokkor_dev/Screen/ProductDetails/ProductDetails.dart';
// import 'package:flutter/material.dart';
// import 'package:smooth_star_rating/smooth_star_rating.dart';

// import '../../main.dart';

// class AllNewArrivalProductCard extends StatefulWidget {
//   final index;
//   AllNewArrivalProductCard(this.index);
//   @override
//   _AllNewArrivalProductCardState createState() =>
//       _AllNewArrivalProductCardState();
// }

// class _AllNewArrivalProductCardState extends State<AllNewArrivalProductCard> {
//   var rating = 0.0;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: GestureDetector(
//         onTap: () {
//           print("object1");
//           Navigator.push(context, SlideLeftRoute(page: ProductsDetailsPage(widget.index.id, 1)));
//         },
//         child: Container(
//           margin: EdgeInsets.only(bottom: 0, top: 5, left: 2.5, right: 2.5),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.all(Radius.circular(10)),
//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 1.0,
//                 color: Colors.black.withOpacity(.5),
//               ),
//             ],
//           ),
//           child: GridTile(
//             child: Container(
//               padding: EdgeInsets.only(bottom: 0),
//               child: Column(
//                 children: <Widget>[
//                   Expanded(
//                     child: Container(
//                         child: Container(
//                       width: MediaQuery.of(context).size.width,
//                       child: Stack(children: <Widget>[
//                         ////// <<<<< Pic start >>>>> //////
//                         Center(
//                           child: Container(
//                             padding: const EdgeInsets.all(5.0),
//                             margin: EdgeInsets.only(top: 5),
//                             child: Image.asset(
//                               'assets/images/product4.png',
//                               height: 130,
//                               width: 120,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         ////// <<<<< Pic end >>>>> //////

//                         ////// <<<<< New tag start >>>>> //////
//                         Container(
//                           margin: EdgeInsets.only(top: 12),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: <Widget>[
//                               Container(
//                                   padding: EdgeInsets.all(5),
//                                   color: widget.index % 2 == 0
//                                       ? appTealColor
//                                       : Colors.transparent,
//                                   child: Text(
//                                     widget.index % 2 == 0 ? "New" : "",
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 12),
//                                   )),
//                             ],
//                           ),
//                         )
//                         ////// <<<<< New tag end >>>>> //////
//                       ]),
//                     )),
//                   ),
//                   Divider(
//                     color: Colors.grey[300],
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 8, right: 8),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         ////// <<<<< Name start >>>>> //////
//                         Expanded(
//                           child: Text(
//                               widget.index % 2 == 0
//                                   ? "Product Name DB"
//                                   : "Product Name from list",
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   fontSize: 15,
//                                   color: Colors.black87,
//                                   fontWeight: FontWeight.w500)),
//                         ),
//                         ////// <<<<< Name end >>>>> //////
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   ////// <<<<< Price start >>>>> //////
//                   Container(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: <Widget>[
//                         Container(
//                           margin: EdgeInsets.only(top: 0, left: 6),
//                           child: Row(
//                             children: <Widget>[
//                               Icon(
//                                 Icons.attach_money,
//                                 color: appTealColor,
//                                 size: 18,
//                               ),
//                               Text(
//                                 widget.index % 2 == 0 ? "20.25" : "100.25",
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     color: appTealColor,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   ////// <<<<< Price end >>>>> //////
//                   Container(
//                     margin: EdgeInsets.only(top: 8, left: 8),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         ////// <<<<< Place start >>>>> //////
//                         Expanded(
//                           child: Container(
//                             //color: Colors.red,
//                             margin:
//                                 EdgeInsets.only(right: 8, top: 0, bottom: 10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 SmoothStarRating(
//                                     //allowHalfRating: true,
//                                     rating: 4,
//                                     size: 12,
//                                     starCount: 5,
//                                     spacing: 2.0,
//                                     color: Color(0xFFFD68AE),
//                                     borderColor: Color(0xFFFD68AE),
//                                     onRatingChanged: (value) {
//                                       setState(() {
//                                         rating = value;
//                                       });
//                                     },
//                                   ),
//                                 // Expanded(
//                                 //   child: Container(
//                                 //     margin: EdgeInsets.only(left: 3),
//                                 //     child: Text("5 (19)",
//                                 //         maxLines: 1,
//                                 //         overflow: TextOverflow.ellipsis,
//                                 //         style: TextStyle(
//                                 //             fontSize: 12,
//                                 //             color: Colors.black87,
//                                 //             fontWeight: FontWeight.bold)),
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ),
//                         ////// <<<<< Place end >>>>> //////

//                         ////// <<<<< Time start >>>>> //////
//                         // Container(
//                         //   margin: EdgeInsets.only(right: 8, top: 0, bottom: 10),
//                         //   child: Row(
//                         //     children: <Widget>[
//                         //       Text(
//                         //           widget.index % 2 == 0
//                         //               ? "Just Now"
//                         //               : "2 days ago",
//                         //           style: TextStyle(
//                         //               color: Colors.grey, fontSize: 10)),
//                         //     ],
//                         //   ),
//                         // ),
//                         ////// <<<<< Time end >>>>> //////
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
