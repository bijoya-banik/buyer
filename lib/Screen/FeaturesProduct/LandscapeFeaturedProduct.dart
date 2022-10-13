// import 'package:ecommerce_bokkor_dev/main.dart';
// import 'package:flutter/material.dart';

// class LandscapeFeaturedProductCard extends StatefulWidget {
//   final index;
//   LandscapeFeaturedProductCard(this.index);
//   @override
//   _LandscapeFeaturedProductCardState createState() =>
//       _LandscapeFeaturedProductCardState();
// }

// class _LandscapeFeaturedProductCardState
//     extends State<LandscapeFeaturedProductCard> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: GestureDetector(
//         onTap: () {
//           // Navigator.push(
//           //   context,
//           //   MaterialPageRoute(builder: (context) => DetailsPage()),
//           // );
//         },
//         child: ListTile(
//           title: Stack(
//             children: <Widget>[
//               Container(
//                 //width: 100,
//                 padding: EdgeInsets.only(bottom: 0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     Center(
//                       child: Container(
//                         //color: Colors.red,

//                         padding: const EdgeInsets.all(0.0),
//                         margin: EdgeInsets.only(top: 0),
//                         child: Image.asset(
//                           'assets/images/product_5.jpg',
//                           height: 100,
//                           width: 120,
//                         ),
//                       ),
//                     ),
//                     Container(
//                       height: 100,
//                       child: VerticalDivider(
//                         //indent: 2.0,
//                         color: Colors.grey[300],
//                       ),
//                     ),
//                     Expanded(
//                       child: Container(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Container(
//                               child: Text(
//                                 widget.index.name == null
//                                     ? ""
//                                     : widget.index.name,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                     fontSize: 16,
//                                     color: Colors.black87,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(left: 0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: <Widget>[
//                                   //Icon(Icons.label_important, size: 15, color: header,),
//                                   Container(
//                                     margin: EdgeInsets.only(left: 0),
//                                     child: Text("Category",
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: TextStyle(
//                                             fontSize: 13,
//                                             color: Colors.black87)),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               margin: EdgeInsets.only(top: 8, left: 0),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: <Widget>[
//                                   Expanded(
//                                     child: Container(
//                                       margin: EdgeInsets.only(
//                                           right: 8, top: 0, bottom: 10),
//                                       child: Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: <Widget>[
//                                           Icon(
//                                             Icons.attach_money,
//                                             size: 13,
//                                             color: appTealColor,
//                                           ),
//                                           Expanded(
//                                             child: Container(
//                                               margin: EdgeInsets.only(left: 3),
//                                               child: Text("50",
//                                                   maxLines: 1,
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   style: TextStyle(
//                                                       fontSize: 15,
//                                                       color: appTealColor,
//                                                       fontWeight:
//                                                           FontWeight.bold)),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   Container(
//                                     margin: EdgeInsets.only(bottom: 5),
//                                     child: Row(
//                                       children: <Widget>[
//                                         Icon(
//                                           Icons.star,
//                                           color: appTealColor,
//                                           size: 12,
//                                         ),
//                                         Container(
//                                             margin: EdgeInsets.only(left: 3),
//                                             child: Text("5.0",
//                                                 style: TextStyle(
//                                                     color: Colors.black54,
//                                                     fontSize: 12))),
//                                         Container(
//                                             margin: EdgeInsets.only(left: 2),
//                                             child: Text("(30)",
//                                                 style: TextStyle(
//                                                     color: Colors.black54,
//                                                     fontSize: 12)))
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Container(
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: <Widget>[
//                                   Container(
//                                     //color: Colors.red,
//                                     margin: EdgeInsets.only(
//                                         right: 8, top: 0, bottom: 0, left: 0),
//                                     child: Row(
//                                       children: <Widget>[
//                                         // Icon(
//                                         //   Icons.timer,
//                                         //   size: 13,
//                                         //   color: header,
//                                         // ),
//                                         // Container(
//                                         //   margin: EdgeInsets.only(left: 4),
//                                         //   child: Text(
//                                         //       "1 HR",
//                                         //       style: TextStyle(
//                                         //           color: Colors.grey[500],
//                                         //           fontSize: 11)),
//                                         // ),
//                                       ],
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                         padding: EdgeInsets.all(5),
//                         color: widget.index % 2 == 0
//                             ? appTealColor.withOpacity(0.7)
//                             : Colors.transparent,
//                         child: Text(
//                           widget.index % 2 == 0 ? "20% OFF" : "",
//                           style: TextStyle(color: Colors.white, fontSize: 14),
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
