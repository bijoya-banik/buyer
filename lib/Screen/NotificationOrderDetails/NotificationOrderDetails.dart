import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/NotificationPage/NotificationPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/OrderHistory/OrderItems.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductPage/ProductPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/SubCategory/SubCategory.dart';
import 'package:ecommerce_bokkor_dev/model/NotificationOrderModel/NotificationOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import '../../main.dart';

class NotificationOrderDetails extends StatefulWidget {

  final id;
  final token;
  NotificationOrderDetails(this.id, this.token);

  @override
  _NotificationOrderDetailsState createState() =>
      _NotificationOrderDetailsState();
}

class _NotificationOrderDetailsState extends State<NotificationOrderDetails> {
  String isReviewd = "";
  var body;
  var orderData;
  bool _isLoading = true;

  @override
  void initState() {

   // print(_isLoading);
    _goToOrder(widget.id);
   
 
  
    super.initState();
  }

   Future<void> _goToOrder(int id) async {
    
    var key = 'notification-order-$id';
   
    var res = await CallApi().getData('/app/showSingleOrder/$id?token=${widget.token}');
    body = json.decode(res.body);
   // print(body);
    if (res.statusCode == 200) {
    
      _bestProductsState();

      

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString(key, json.encode(body));
    }
  
  }

    void _bestProductsState() {
    var orders = NotificationOrderModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      orderData = orders.order;
      isReviewd = orderData.status;
      _isLoading = false;

    });
      //print(_isLoading);
     
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: appTealColor,
        title: Text(FlutterI18n.translate(context, "Order_Details")),
        leading: IconButton(icon: Icon(Icons.arrow_back), 
        onPressed: (){
          bottomNavIndex = 4;
          Navigator.push(context,
            SlideLeftRoute(page: Navigation(4)));
            }),
      ),
      body: _isLoading?
         Center(
           child: Container(
            
            // color: Colors.red,
                                    child: Text(
                                      FlutterI18n.translate(context, "Please_wait_to_see_details")+"...",
                                      
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: appTealColor,
                                          fontFamily: "DINPro",
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
         ):
      SingleChildScrollView(
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

                    //////// Order Number/////////

                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          orderData.id==null?Container(): Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    FlutterI18n.translate(context, "Order"),
                                   
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
                                  orderData.id==null?"":  "#${orderData.id}",
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
                          orderData.date==null?Container(): Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: 30, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                   FlutterI18n.translate(context, "Order_Date")+": ",
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontFamily: "DINPro",
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                   orderData.date==null?"": "${orderData.date}",
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
                                     FlutterI18n.translate(context, "Order_Type")+": ",
                                  
                                    style: TextStyle(
                                        color: Colors.black45,
                                        fontFamily: "DINPro",
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                   orderData.orderType==null?"": "${orderData.orderType}",
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
                         orderData.used_vaoucher==null?Container(): Container(
                            margin:
                                EdgeInsets.only(left: 0, right: 10, top: 3),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                    FlutterI18n.translate(context,"Coupon")+":",
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "DINPro",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                 Text(
                                    orderData.used_vaoucher.voucher.code==null?"":" ${orderData.used_vaoucher.voucher.code}"+
                                    " ( "+orderData.used_vaoucher.voucher.discount.toString()+"% )",
                                    style: TextStyle(
                                        color: appColor,
                                        fontFamily: "DINPro",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  )
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
                                    FlutterI18n.translate(context, "Status")+": ",
                                
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "DINPro",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    orderData.status==null?"":"${orderData.status}",
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
                        FlutterI18n.translate(context, "Delivery_Address"),
                       
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
                            FlutterI18n.translate(context, "Area")+": ",
                          
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: "DINPro",
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                           orderData.area==null?"": "${orderData.area}",
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
                             FlutterI18n.translate(context, "House")+": ",
                         
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: "DINPro",
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            orderData.house==null?"":"${orderData.house}",
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
                             FlutterI18n.translate(context, "Road")+": ",
                          
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: "DINPro",
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            orderData.road==null?"":"${orderData.road}",
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
                            FlutterI18n.translate(context, "Block")+": ",
                          
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: "DINPro",
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            orderData.block==null?"":"${orderData.block}",
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
                             FlutterI18n.translate(context, "City")+": ",
                           
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: "DINPro",
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            orderData.city==null?"":"${orderData.city}",
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
                             FlutterI18n.translate(context, "State")+": ",
                         
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: "DINPro",
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            orderData.state==null?"":"${orderData.state}",
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
                             FlutterI18n.translate(context, "Country")+": ",
                          
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.grey[600],
                                fontFamily: "DINPro",
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            orderData.country==null?"":"${orderData.country}",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                     FlutterI18n.translate(context, "Subtotal"),
                              
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
                                    orderData.subTotal==null?"0.00 BHD":"${orderData.subTotal} BHD",
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                     FlutterI18n.translate(context, "Shipping_Cost"),
                                
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
                                    orderData.shippingPrice==null?"0.00 BHD":"${orderData.shippingPrice} BHD",
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
                          ///
                          ////////  Discount fee////////
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                     FlutterI18n.translate(context, "User_Discount"),
                                   
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
                                   orderData.discount==null?"0%": "${orderData.discount} %",
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

                          ////// Discount fee end//////

                          /////coupon fee////////
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                     FlutterI18n.translate(context, "Coupon_Discount"),
                                   
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "DINPro",
                                        fontSize: 15,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                               orderData.used_vaoucher==null?Container(): Container(
                                  //color: Colors.red,
                                  // width: 90,
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text(
                                 //  orderData.discount==null?"0%": "${orderData.discount} %",
                                 orderData.used_vaoucher.voucher.discount==null?"0%" :"${orderData.used_vaoucher.voucher.discount.toString()} %",
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

                          //////coupon fee end//////
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
                               FlutterI18n.translate(context, "Total"),
                             
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
                              orderData.grandTotal==null?"0.00 BHD":"${orderData.grandTotal} BHD",
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
                         FlutterI18n.translate(context, "Items"),
                       
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
                            orderData.orderdetails.length, (index) {
                          return OrderItem(
                              orderData.orderdetails[index], isReviewd);
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
      bottomNavigationBar: 
      _isLoading?
         Container(
                                  child: Text(
                                    "",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: appTealColor,
                                        fontFamily: "DINPro",
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ):
      
      orderData.status == "Delivered" ||
              orderData.status == "Cancel"
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
                           FlutterI18n.translate(context, "Click_to_pay_by_BenefitPay"),
                          
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Colors.black),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 3),
                          child: Text(
                             FlutterI18n.translate(context, "Click_on_one_of_the_logos"),
                            
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
                            'https://wa.me/97339423596?text=Hello%20Order%20orderNo%20${orderData.id}%20totalAmount%20${orderData.grandTotal}%20BHD%20and%20would%20like%20to%20pay%20using%20BenefitPay');
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
                          'https://wa.me/97339423596?text=Hello%20Order%20orderNo%20${orderData.id}%20totalAmount%20${orderData.grandTotal}%20BHD%20and%20would%20like%20to%20pay%20using%20BenefitPay');
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
    );
  }
}
