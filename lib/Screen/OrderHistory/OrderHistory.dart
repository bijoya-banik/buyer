import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/OrderHistory/OrderHistoryCard.dart';
import 'package:ecommerce_bokkor_dev/Screen/SubCategory/SubCategoryCard.dart';
import 'package:ecommerce_bokkor_dev/model/OrderModel/orderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';

class OrderHistory extends StatefulWidget {
  @override
  _OrderHistoryState createState() => new _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  int _current = 0;
  int _isBack = 0;
  String result = '';
  var userData, token, body, orderData;
  bool _isLoggedIn = false, _isLoading = false;

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    if (userJson != null) {
      //Navigator.push(context, SlideLeftRoute(page: LogInPage("3")));
      var user = json.decode(userJson);
      setState(() {
        userData = user;
        _isLoggedIn = true;
      });
      token = localStorage.getString('token');
      _getOrders();
    } else {
      setState(() {
        _isLoggedIn = false;
      });
    }
  }

  Future<void> _getOrders() async {
    var res = await CallApi().getData('/app/showOrder?token=$token');
      print(res);
    body = json.decode(res.body);
    print("body");
    print(body);

    if (res.statusCode == 200) {
      _orderState();
    }
  }

  void _orderState() {
    
    var newProducts = OrderModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      orderData = newProducts.order;
      _isLoading = false;
    });
  }

  Future<bool> _onWillPop() async {
    Navigator.push(context, SlideLeftRoute(page: Navigation(3)));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        //backgroundColor: Colors.black,
        appBar: new AppBar(
          backgroundColor: appTealColor,
          leading: GestureDetector(
              onTap: () {
                Navigator.push(context, SlideLeftRoute(page: Navigation(3)));
              },
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: Icon(Icons.arrow_back, color: Colors.white)),
            ),
          title:  Text(FlutterI18n.translate(context, "My_Orders")),
        ),
        //body: new Text("It's a Dialog!"),
        body: orderData == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : orderData.length == 0
                ? Center(
                    child: Container(
                    child: Text(FlutterI18n.translate(context, "No_Orders_yet")),
                  ))
                : SafeArea(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: new Container(
                          margin: EdgeInsets.only(top: 15, bottom: 15),
                          //color: Colors.white,
                          child: Column(
                            // children: <Widget>[
                            //   OrderHistoryCard(),
                            // ],
                            children: List.generate(orderData.length, (index) {
                              return OrderHistoryCard(orderData[index]);
                            }),
                          )),
                    ),
                  ),
      ),
    );
  }
}
