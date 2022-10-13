import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/OrderHistory/OrderHistory.dart';
import 'package:ecommerce_bokkor_dev/Screen/OrderHistory/OrderItems.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductPage/ProductPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/SubCategory/SubCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class OrderHistoryCheckout extends StatefulWidget {
  final orderData;
  OrderHistoryCheckout(this.orderData);
  @override
  _OrderHistoryCheckoutState createState() => _OrderHistoryCheckoutState();
}

class _OrderHistoryCheckoutState extends State<OrderHistoryCheckout> {
  String isReviewd = "";

  @override
  void initState() {
    print(widget.orderData);
    setState(() {
      isReviewd = widget.orderData.status;
      //print(widget.orderData.firstName);
    });
    super.initState();
  }

  Future<bool> _onWillPop() async {
    Navigator.push(context, SlideRightRoute(page: Navigation(3)));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: new AppBar(
          backgroundColor: appTealColor,
          title: Text(FlutterI18n.translate(context,"Order_Details")),
          leading: GestureDetector(
              onTap: () {
                Navigator.push(context, SlideLeftRoute(page: OrderHistory()));
              },
              child: Container(child: Icon(Icons.arrow_back))),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            //color: Colors.red,
            child: Column(
              children: <Widget>[
                ////////// Address /////////
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 17,
                        //offset: Offset(0.0,3.0)
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ///////// Status start //////////

                      //////// Status  end/////////

                      //////// Oredr Number/////////

                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    child: Text(
                                      FlutterI18n.translate(context,"Order"),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: appTealColor,
                                          fontFamily: "DINPro",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "#${widget.orderData.id}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: appTealColor,
                                          fontFamily: "DINPro",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 30, right: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      FlutterI18n.translate(context,"Order_Date")+":",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontFamily: "DINPro",
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      "${widget.orderData.date}",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: "DINPro",
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin:
                                    EdgeInsets.only(left: 0, right: 10, top: 3),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      FlutterI18n.translate(context,"Order_Type")+":",
                                      style: TextStyle(
                                          color: Colors.black45,
                                          fontFamily: "DINPro",
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal),
                                    ),
                                    Text(
                                      "${widget.orderData.orderType}",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontFamily: "DINPro",
                                          fontSize: 13,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                margin:
                                    EdgeInsets.only(left: 0, right: 10, top: 3),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      FlutterI18n.translate(context,"Status")+":",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontFamily: "DINPro",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      "${widget.orderData.status}",
                                      style: TextStyle(
                                          color: appColor,
                                          fontFamily: "DINPro",
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //////// Oredr Number end /////////

                      //////// Delivery Address/////////

                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          FlutterI18n.translate(context,"Delivery_Address"),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontFamily: "DINPro",
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Divider(),
                      Container(
                        margin: EdgeInsets.only(top: 3),
                        child: Row(
                          children: <Widget>[
                            Text(
                               FlutterI18n.translate(context,"Area")+":",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: "DINPro",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "${widget.orderData.area}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: "DINPro",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3),
                        child: Row(
                          children: <Widget>[
                            Text(
                              FlutterI18n.translate(context,"House")+":",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: "DINPro",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "${widget.orderData.house}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: "DINPro",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3),
                        child: Row(
                          children: <Widget>[
                            Text(
                              FlutterI18n.translate(context,"Road")+":",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: "DINPro",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "${widget.orderData.road}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: "DINPro",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3),
                        child: Row(
                          children: <Widget>[
                            Text(
                              FlutterI18n.translate(context,"Block")+":",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: "DINPro",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "${widget.orderData.block}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: "DINPro",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3),
                        child: Row(
                          children: <Widget>[
                            Text(
                              FlutterI18n.translate(context,"City")+":",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: "DINPro",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "${widget.orderData.city}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: "DINPro",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3),
                        child: Row(
                          children: <Widget>[
                            Text(
                              FlutterI18n.translate(context,"State")+":",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: "DINPro",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "${widget.orderData.state}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: "DINPro",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 3),
                        child: Row(
                          children: <Widget>[
                            Text(
                              FlutterI18n.translate(context,"Country")+":",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[600],
                                  fontFamily: "DINPro",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                            Text(
                              "${widget.orderData.country}",
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.grey[900],
                                  fontFamily: "DINPro",
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                      ),
                      ////////Delivery Address end /////////
                    ],
                  ),
                ),

                ////////// Address end/////////

                ////////// Item Details /////////
                Container(
                  margin:
                      EdgeInsets.only(bottom: 15, left: 15, right: 15, top: 5),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[300],
                        blurRadius: 17,
                        //offset: Offset(0.0,3.0)
                      )
                    ],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ////// Fee start///////

                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            /////Subtotal////////
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      FlutterI18n.translate(context,"Subtotal"),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "DINPro",
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Container(
                                    //color: Colors.red,
                                    // width: 90,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      "${widget.orderData.subTotal} BHD",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "DINPro",
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //////Subtotal end//////

                            /////Shipping fee////////
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      FlutterI18n.translate(context,"Shipping_cost"),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "DINPro",
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Container(
                                    //color: Colors.red,
                                    //   width: 90,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      "${widget.orderData.shippingPrice} BHD",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "DINPro",
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //////Shipping end//////

                            /////Discount fee////////
                            Container(
                              margin: EdgeInsets.only(bottom: 5),
                              width: MediaQuery.of(context).size.width,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      FlutterI18n.translate(context,"Discount"),
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "DINPro",
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                  Container(
                                    //color: Colors.red,
                                    // width: 90,
                                    alignment: Alignment.centerRight,
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      "${widget.orderData.discount} %",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "DINPro",
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            //////Discount fee end//////
                          ],
                        ),
                      ),

                      ////// fee end//////

                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        height: 0.5,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey,
                      ),

                      //////// total start///////

                      Container(
                        margin: EdgeInsets.only(bottom: 5),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                               FlutterI18n.translate(context,"Total"),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "DINPro",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              //color: Colors.red,
                              // width: 90,
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(right: 10),
                              child: Text(
                                "${widget.orderData.grandTotal} BHD",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "DINPro",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),

                      //////// total end///////
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        height: 0.5,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.grey,
                      ),

                      //////// Title start///////

                      Container(
                        margin: EdgeInsets.only(bottom: 5, top: 10),
                        width: MediaQuery.of(context).size.width,
                        //color: Colors.red,
                        child: Text(
                          FlutterI18n.translate(context,"Items"),
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "DINPro",
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),

                      //////// Title end///////

                      //////// Items start///////

                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // children: <Widget>[
                          //   OrderItem(),
                          //   OrderItem(),
                          //   OrderItem(),
                          // ],
                          // children: _showItems(),
                          children: List.generate(
                              widget.orderData.orderdetails.length, (index) {
                            return OrderItem(
                                widget.orderData.orderdetails[index],
                                isReviewd);
                          }),
                        ),
                      ),

                      //////// Items end///////
                    ],
                  ),
                ),

                ////////// Item Details end/////////
              ],
            ),
          ),
        ),
        bottomNavigationBar: widget.orderData.status == "Delivered" ||
                widget.orderData.status == "Cancel"
            ? Container(
                height: 0,
              )
            : Container(
                color: Colors.white,
                height: 60,
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: Container(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            FlutterI18n.translate(context,"Click_to_pay_by_BenefitPay"),
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.black),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3),
                            child: Text(
                              FlutterI18n.translate(context,"Click_on_one_of_the_logos"),
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black45,
                                  fontSize: 11),
                            ),
                          ),
                        ],
                      )),
                    ),
                    GestureDetector(
                        onTap: () {
                          launch(
                              'https://wa.me/97339423596?text=Hello%20Order%20orderNo%20${widget.orderData.id}%20totalAmount%20${widget.orderData.grandTotal}%20BHD%20and%20would%20like%20to%20pay%20using%20BenefitPay');
                          // Navigator.push(
                          //     context, SlideLeftRoute(page: Navigation(0)));
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 15),
                          child: Image.asset(
                            'assets/images/benefit_pay.jpg',
                            width: 60,
                            height: 60,
                          ),
                        )),
                    GestureDetector(
                      onTap: () {
                        launch(
                            'https://wa.me/97339423596?text=Hello%20Order%20orderNo%20${widget.orderData.id}%20totalAmount%20${widget.orderData.grandTotal}%20BHD%20and%20would%20like%20to%20pay%20using%20BenefitPay');
                        // Navigator.push(
                        //     context, SlideLeftRoute(page: Navigation(0)));
                      },
                      child: CircleAvatar(
                          radius: 20.0,
                          backgroundImage:
                              AssetImage('assets/images/whatsapp.png')),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
