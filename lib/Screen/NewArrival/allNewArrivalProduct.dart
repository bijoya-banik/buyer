// import 'dart:convert';

// import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
// import 'package:ecommerce_bokkor_dev/Screen/NewArrival/LandscapeNewArrival.dart';
// import 'package:ecommerce_bokkor_dev/Screen/NewArrival/allNewArrivalCard.dart';
// import 'package:ecommerce_bokkor_dev/model/BestSellerModel/bestSellerModel.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../main.dart';
// import 'PortraitNewArrival.dart';

// class AllNewArrivalProduct extends StatefulWidget {
//   @override
//   _AllNewArrivalProductState createState() => _AllNewArrivalProductState();
// }

// class _AllNewArrivalProductState extends State<AllNewArrivalProduct> {
//   var newProductsData;
//   bool _isLoading = true;
//   var body, user;

//   @override
//   void initState() {
//     _getUserInfo();
//     _showNewProducts();
//     super.initState();
//   }

//   void _getUserInfo() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     var userJson = localStorage.getString('user');
//     if(userJson != null){
//       var users = json.decode(userJson);
//       setState(() {
//         user = users;
//       });
//     }
//     print("user");
//     print(user);
//   }

//   /////// <<<<< New Products start >>>>> ///////
//   Future _getLocalFeaturedProductsData(key) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     var localfeaturedProductsData = localStorage.getString(key);
//     if (localfeaturedProductsData != null) {
//       body = json.decode(localfeaturedProductsData);
//       //_featuredProductsState();
//       //_isLoading = false;
//     }
//   }

//   Future<void> _showNewProducts() async {
//     var key = 'best-products-list';
//     await _getLocalFeaturedProductsData(key);

//     var res = await CallApi().getData('/app/showNewProduct');
//     body = json.decode(res.body);

//     if (res.statusCode == 200) {
//       _newProductsState();

//       SharedPreferences localStorage = await SharedPreferences.getInstance();
//       localStorage.setString(key, json.encode(body));
//     }
//   }

//   void _newProductsState() {
//     var newProducts = BestSellerModel.fromJson(body);
//     if (!mounted) return;
//     setState(() {
//       newProductsData = newProducts.product;
//       _isLoading = false;
//     });
//     print(newProductsData.length);
//   }

//   ////// <<<<< New Products end >>>>> //////
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         backgroundColor: appTealColor,
//         title: const Text('New Arrival'),
//       ),
//       body: SafeArea(
//         child: _isLoading == true
//             ? Center(
//                 child: CircularProgressIndicator(),
//               )
//             : Container(
//                 margin: EdgeInsets.only(
//                   left: 0,
//                   right: 0,
//                 ),
//                 width: MediaQuery.of(context).size.width,
//                 padding: EdgeInsets.only(left: 5, right: 5, top: 4, bottom: 5),
//                 child: OrientationBuilder(
//                   builder: (context, orientation) {
//                     return orientation == Orientation.portrait
//                         ////// <<<<< Portrait Card start >>>>> //////
//                         ? GridView.builder(
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2,
//                               childAspectRatio:
//                                   (MediaQuery.of(context).size.width / 3) /
//                                       (MediaQuery.of(context).size.height / 5),
//                             ),
//                             itemBuilder: (BuildContext context, int index) =>
//                                 new Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: ProtraitNewArrivalCard(
//                                   user, newProductsData[index]),
//                             ),
//                             itemCount: newProductsData.length,
//                           )
//                         ////// <<<<< Portrait Card end >>>>> //////
//                         :
//                         ////// <<<<< Landscape Card start >>>>> //////
//                         GridView.builder(
//                             gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 2,
//                               childAspectRatio:
//                                   (MediaQuery.of(context).size.width / 2) /
//                                       (MediaQuery.of(context).size.height /
//                                           2.1),
//                             ),
//                             itemBuilder: (BuildContext context, int index) =>
//                                 new Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: ProtraitNewArrivalCard(
//                                   user, newProductsData[index]),
//                             ),
//                             itemCount: newProductsData.length,
//                           );
//                     ////// <<<<< Landscape Card end >>>>> //////
//                   },
//                 )),
//       ),
//     );
//   }
// }
