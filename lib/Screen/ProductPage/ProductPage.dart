import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/Screen/CategoryPage/CategoryCard.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductPage/ProductsCard.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:ecommerce_bokkor_dev/model/BestSellerModel/bestSellerModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductPage extends StatefulWidget {
  final data;
  ProductPage(this.data);
  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<ProductPage> {
  var body, filterList, user;
  bool _isLoading = true;

  @override
  void initState() {
    _getUserInfo();
    print("widget.data['searchtext']");
    print(widget.data['searchtext']);
    getFilterData();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    if (userJson != null) {
      var users = json.decode(userJson);
      setState(() {
        user = users;
      });
    }
    print("user");       
    print(user);     
  }              
            
  Future<void> getFilterData() async {
    var res = await CallApi().getData(
        '/app/showProduct?max=${widget.data['maxPrice']}&min=${widget.data['minPrice']}&cat=${widget.data['category']}&sub=${widget.data['subCategory']}&ordercoloum=${widget.data['orderName']}&ordersort=${widget.data['orderType']}&searchtext=${widget.data['searchtext']}');
  
    body = json.decode(res.body);

    print(body);

    if (res.statusCode == 200) {
      _getFilterlist();
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _getFilterlist() {
    var newFilter = BestSellerModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      filterList = newFilter.product;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: appTealColor,
        title: Text(FlutterI18n.translate(context, "All_Products")),
      ),
      body: filterList == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : filterList.length == 0
              ? Center(
                  child: Container(
                  child: Text(FlutterI18n.translate(context, "No_products_found")+"!"),
                ))
              : SafeArea(
                  child: Container(
                      margin: EdgeInsets.only(
                        left: 0,
                        right: 0,
                      ),
                      width: MediaQuery.of(context).size.width,
                      padding:
                          EdgeInsets.only(left: 5, right: 5, top: 4, bottom: 5),
                      child: OrientationBuilder(
                        builder: (context, orientation) {
                          return orientation == Orientation.portrait
                              ////// <<<<< Portrait Card start >>>>> //////
                              ? GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: (MediaQuery.of(context)
                                                .size
                                                .width /
                                            3) /
                                        (MediaQuery.of(context).size.height /
                                            4),
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          new Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child:
                                        ProductsCard(user, filterList[index]),
                                  ),
                                  itemCount: filterList.length,
                                )
                              ////// <<<<< Portrait Card end >>>>> //////
                              :
                              ////// <<<<< Landscape Card start >>>>> //////
                              GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: (MediaQuery.of(context)
                                                .size
                                                .width /
                                            2) /
                                        (MediaQuery.of(context).size.height /
                                            2.5),
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          new Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child:
                                        ProductsCard(user, filterList[index]),
                                  ),
                                  itemCount: filterList.length,
                                );
                          ////// <<<<< Landscape Card end >>>>> //////
                        },
                      )),
                ),
    );
  }
}
