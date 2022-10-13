// import 'package:flutter/material.dart';

// import '../../main.dart';
// import '../ProductDetails/ProductDetails.dart';

// class UpsaleNewArrival extends StatefulWidget {
//   final index;
//   UpsaleNewArrival(this.index);
//   @override
//   _UpsaleNewArrivalState createState() => _UpsaleNewArrivalState();
// }

// class _UpsaleNewArrivalState extends State<UpsaleNewArrival> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       width: MediaQuery.of(context).size.width / 2 + 20,
//       child: GestureDetector(
//         onTap: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => ProductsDetailsPage(widget.index.id, 1)),
//           );
//         },
//         child: ListTile(
//           contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
//           title: Stack(
//             children: <Widget>[
//               Container(
//                 width: MediaQuery.of(context).size.width / 2 + 20,
//                 padding: EdgeInsets.only(bottom: 0),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                       height: 140,
//                       alignment: Alignment.topLeft,
//                       width: MediaQuery.of(context).size.width / 2 + 20,
//                       //  decoration: BoxDecoration(

//                       //    image: DecorationImage(image: AssetImage( 'assets/images/product_1.jpg',))
//                       //  ),
//                       child: Image.asset(
//                         'assets/images/product_2.jpg',
//                         height: 140,
//                         width: MediaQuery.of(context).size.width / 2 + 20,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                             bottomLeft: Radius.circular(10),
//                             bottomRight: Radius.circular(10)),
//                         //border: Border.all(width: 0.5, color: Colors.grey),
//                         boxShadow: [
//                           BoxShadow(
//                             blurRadius: 1.0,
//                             color: Colors.grey.withOpacity(.5),
//                             //offset: Offset(6.0, 7.0),
//                           ),
//                         ],
//                       ),
//                       padding: EdgeInsets.only(left: 15, right: 15),
//                       width: MediaQuery.of(context).size.width / 2 + 20,
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           Container(
//                             margin: EdgeInsets.only(left: 0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: <Widget>[
//                                 //Icon(Icons.label_important, size: 15, color: Colors.red,),
//                                 Container(
//                                   padding: EdgeInsets.only(top: 10),
//                                   child: Text("Category",
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                       style: TextStyle(
//                                           fontSize: 13, color: Colors.black87)),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.only(top: 8),
//                             child: Text(
//                               "Product Name",
//                               maxLines: 1,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.black87,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(top: 8, left: 0),
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Expanded(
//                                   child: Container(
//                                     margin: EdgeInsets.only(
//                                         right: 8, top: 0, bottom: 10),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                       children: <Widget>[
//                                         Expanded(
//                                           child: Container(
//                                             child: Text("\$ 50 ",
//                                                 maxLines: 1,
//                                                 overflow: TextOverflow.ellipsis,
//                                                 style: TextStyle(
//                                                     fontSize: 15,
//                                                     color: appTealColor,
//                                                     fontWeight:
//                                                         FontWeight.bold)),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 Container(
//                                   margin: EdgeInsets.only(left: 3, bottom: 4),
//                                   child: Row(
//                                     children: <Widget>[
//                                       Icon(
//                                         Icons.star,
//                                         color: Color(0xFFffa900),
//                                         size: 12,
//                                       ),
//                                       Container(
//                                           margin: EdgeInsets.only(
//                                             left: 3,
//                                           ),
//                                           child: Text("5.0",
//                                               style: TextStyle(
//                                                   color: Colors.black54,
//                                                   fontSize: 12))),
//                                       Container(
//                                           margin: EdgeInsets.only(left: 2),
//                                           child: Text("(30)",
//                                               style: TextStyle(
//                                                   color: Colors.black54,
//                                                   fontSize: 12)))
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Container(
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 //  Container(
//                                 //    //color: Colors.red,
//                                 //    margin: EdgeInsets.only(
//                                 //        right: 8, top: 0, bottom: 0, left: 0),
//                                 //    child: Row(
//                                 //      children: <Widget>[
//                                 //        Icon(
//                                 //          Icons.timer,
//                                 //          size: 13,
//                                 //          color: Colors.red,
//                                 //        ),
//                                 //        Container(
//                                 //          margin: EdgeInsets.only(left: 4),
//                                 //          child: Text(
//                                 //              "1 HR",
//                                 //              style: TextStyle(
//                                 //                  color: Colors.grey[500],
//                                 //                  fontSize: 11)),
//                                 //        ),
//                                 //      ],
//                                 //    ),
//                                 //  ),
//                               ],
//                             ),
//                           ),
//                         ],
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
//                         color: Colors.red,
//                         child: Text(
//                           "20% OFF",
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
