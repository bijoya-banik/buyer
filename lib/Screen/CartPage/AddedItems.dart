// import 'package:ecommerce_bokkor_dev/main.dart';
// import 'package:flutter/material.dart';

// class AddedItems extends StatefulWidget {
//   final cart;
//   AddedItems(this.cart);
//   @override
//   _AddedItemsState createState() => _AddedItemsState();
// }

// class _AddedItemsState extends State<AddedItems> {
//   String price = "", quantity = "";

//   @override
//   void initState() {
//     // setState(() {
//     //   price = widget.cart.price;
//     //   quantity = widget.cart.quantity;
//     // });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.fromLTRB(10, 7, 10, 0),
//       child: Column(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.only(bottom: 7),
//             decoration: BoxDecoration(
//                 border: Border(
//               top: BorderSide(
//                 color: Colors.grey,
//                 width: 0.5,
//               ),
//             )),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Container(
//                   child: Row(
//                     children: <Widget>[
//                       // Container(
//                       //   alignment: Alignment.center,
//                       //   margin: EdgeInsets.only(right: 10.0,),
//                       //   child: ClipOval(
//                       //       child: Image.asset(
//                       //     'assets/images/product_5.jpg',
//                       //     height: 50,
//                       //     width: 50,
//                       //     fit: BoxFit.cover,
//                       //   )),
//                       // ),
//                       Container(
//                         margin: EdgeInsets.only(
//                           right: 10.0,
//                         ),
//                         decoration: BoxDecoration(
//                             //  color: Colors.red
//                             border: Border.all(
//                               color: Colors.grey,
//                             ),
//                             borderRadius: BorderRadius.circular(5)),
//                         child: Container(
//                           padding: EdgeInsets.all(3),
//                           child: Column(
//                             children: <Widget>[
//                               GestureDetector(
//                                 onTap: () {
//                                   setState(() {
//                                     int pr =
//                                         int.parse("${widget.cart['price']}");

//                                     int quant =
//                                         int.parse("${widget.cart['quantity']}");
//                                     widget.cart['quantity'] =
//                                         widget.cart['quantity'] + 1;
//                                     int stk =
//                                         int.parse("${widget.cart['stock']}");
//                                     //quant++;
//                                     print(pr);
//                                     print(quant);
//                                     print(stk);

//                                     if (quant < stk) {
//                                       pr *= widget.cart['quantity'];
//                                       widget.cart['totalPrice'] = pr;
//                                       print(pr);
//                                     }

//                                     // pr *= quant;
//                                     // price = "$pr";
//                                     // DBProvider.db.newClient(Client(
//                                     //     id: widget.cart.id,
//                                     //     name: "${widget.cart.name}",
//                                     //     productId: "${widget.cart.productId}",
//                                     //     combinationId:
//                                     //         "${widget.cart.combinationId}",
//                                     //     price: "$price",
//                                     //     quantity: "$quantity"));
//                                   });
//                                 },
//                                 child: Container(
//                                   child: Icon(
//                                     Icons.add,
//                                     color: appTealColor,
//                                     //size: 14,
//                                   ),
//                                 ),
//                               ),
//                               Container(
//                                 margin: EdgeInsets.only(top: 3),
//                                 child: Text(
//                                   "${widget.cart['quantity']}",
//                                   style: TextStyle(
//                                       color: Colors.black,
//                                       fontFamily: "sourcesanspro",
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {},
//                                 child: Container(
//                                   child: Icon(
//                                     Icons.remove,
//                                     color: appTealColor,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Container(
//                             width: MediaQuery.of(context).size.width / 3,
//                             padding: EdgeInsets.only(top: 8),
//                             child: Text(
//                               "${widget.cart['name']}",
//                               textAlign: TextAlign.left,
//                               overflow: TextOverflow.ellipsis,
//                               style: TextStyle(
//                                   color: Colors.black,
//                                   fontFamily: "sourcesanspro",
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.normal),
//                             ),
//                           ),
//                           Container(
//                             alignment: Alignment.centerLeft,
//                             padding: EdgeInsets.only(top: 2),
//                             child: Text(
//                               "\$ ${widget.cart['totalPrice']}",
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                   color: appTealColor,
//                                   fontFamily: "sourcesanspro",
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.normal),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   child: Row(
//                     children: <Widget>[
//                       Container(
//                         child: IconButton(
//                           icon: Icon(
//                             Icons.cancel,
//                             color: appTealColor,
//                           ),
//                           onPressed: () {
//                             //DBProvider.db.deleteClient(widget.cart.id);
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
