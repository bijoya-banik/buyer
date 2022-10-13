// import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
// import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
// import 'package:ecommerce_bokkor_dev/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_i18n/flutter_i18n.dart';

// class EmptyCart extends StatefulWidget {
//   @override
//   _EmptyCartState createState() => _EmptyCartState();
// }

// class _EmptyCartState extends State<EmptyCart> {
//   @override
//   void initState() {
//     bottomNavIndex = 0;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: appTealColor,
//         automaticallyImplyLeading: false,
//         title: Center(
//           child: Container(
//             child: Container(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Text(FlutterI18n.translate(context, "Cart"),
//                       style: TextStyle(fontSize: 20, color: Colors.white)),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           color: Colors.white,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Container(
//                   child: Image.asset(
//                     'assets/images/empty_cart.png',
//                     height: 170,
//                     width: 150,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 Text("Your Cart Is Empty",
//                     style: TextStyle(
//                         fontSize: 20,
//                         color: Colors.black,
//                         fontWeight: FontWeight.bold)),
//                 SizedBox(
//                   height: 7,
//                 ),
//                 Text("You haven't added anything to your cart",
//                     style: TextStyle(fontSize: 17, color: Colors.black38)),

//                 ///////////////// Check out Button Start///////////////

//                 Container(
//                     decoration: BoxDecoration(
//                       color: appTealColor.withOpacity(0.9),
//                       //widget.totalItem.length < 1
//                       //     ? Colors.grey
//                       // :

//                       borderRadius: BorderRadius.all(Radius.circular(5.0)),
//                     ),
//                     //width: 200,
//                     padding: EdgeInsets.only(left: 15, right: 15),
//                     margin: EdgeInsets.only(top: 30),
//                     height: 42,
//                     child: FlatButton(
//                       onPressed: () {
//                         Navigator.push(
//                             context, SlideLeftRoute(page: Navigation(0)));
//                       },
//                       //  widget.totalItem.length < 1 ||
//                       //         _isCheckingOut
//                       //     ? null
//                       //     :  _pay,  //_pay, //_checkOut,
//                       child: Text(
//                         'Start Shopping',
//                         textDirection: TextDirection.ltr,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 18.0,
//                           decoration: TextDecoration.none,
//                           fontFamily: 'MyriadPro',
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                       color: Colors.transparent,
//                       //elevation: 4.0,
//                       //splashColor: Colors.blueGrey,
//                       shape: new RoundedRectangleBorder(
//                           borderRadius: new BorderRadius.circular(20.0)),
//                     )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
