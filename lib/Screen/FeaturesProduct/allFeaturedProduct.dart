// import 'dart:convert';

// import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
// import 'package:ecommerce_bokkor_dev/Screen/FeaturesProduct/allFeaturedProductCard.dart';
// import 'package:ecommerce_bokkor_dev/Screen/NewArrival/allNewArrivalCard.dart';
// import 'package:ecommerce_bokkor_dev/model/BestSellerModel/bestSellerModel.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../main.dart';
// import 'PortraitFeaturedProduct.dart';

// class AllFeaturedProduct extends StatefulWidget {
//   @override
//   _AllFeaturedProductState createState() => _AllFeaturedProductState();
// }

// class _AllFeaturedProductState extends State<AllFeaturedProduct> {
//   var featuredProductsData;
//   bool _isLoading = true;
//   var body, user;
//   @override
//   void initState() {
//     _getUserInfo();
//     _showFeaturedProducts();
//     super.initState();
//   }

//   void _getUserInfo() async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     var userJson = localStorage.getString('user');
//     if (userJson != null) {
//       var users = json.decode(userJson);
//       setState(() {
//         user = users;
//       });
//     }
//     print("user");
//     print(user);
//   }

//   /////// <<<<< Featured Products start >>>>> ///////
//   Future _getLocalFeaturedProductsData(key) async {
//     SharedPreferences localStorage = await SharedPreferences.getInstance();
//     var localfeaturedProductsData = localStorage.getString(key);
//     if (localfeaturedProductsData != null) {
//       body = json.decode(localfeaturedProductsData);
//       //_featuredProductsState();
//       //_isLoading = false;
//     }
//   }

//   Future<void> _showFeaturedProducts() async {
//     var key = 'best-products-list';
//     await _getLocalFeaturedProductsData(key);

//     var res = await CallApi().getData('/app/showFeaturedProduct');
//     body = json.decode(res.body);

//     if (res.statusCode == 200) {
//       _featuredProductsState();

//       SharedPreferences localStorage = await SharedPreferences.getInstance();
//       localStorage.setString(key, json.encode(body));
//     }
//   }

//   void _featuredProductsState() {
//     var featuredProducts = BestSellerModel.fromJson(body);
//     if (!mounted) return;
//     setState(() {
//       featuredProductsData = featuredProducts.product;
//       _isLoading = false;
//     });
//   }

//   ////// <<<<< Featured Products end >>>>> //////
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: new AppBar(
//         backgroundColor: appTealColor,
//         title: const Text('Featured Products'),
//         titleSpacing: 1,
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
//                               child: PortraitFeaturedProductsCard(
//                                   user, featuredProductsData[index]),
//                             ),
//                             itemCount: featuredProductsData.length,
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
//                               child: PortraitFeaturedProductsCard(
//                                   user, featuredProductsData[index]),
//                             ),
//                             itemCount: featuredProductsData.length,
//                           );
//                     ////// <<<<< Landscape Card end >>>>> //////
//                   },
//                 )),
//       ),
//     );
//   }
// }
