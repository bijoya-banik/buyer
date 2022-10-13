import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/OrderHistory/OrderHistoryCardDetails.dart';
import 'package:ecommerce_bokkor_dev/Screen/OrderHistory/OrderHistoryCheckout.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:ecommerce_bokkor_dev/model/CartModel/cartModel.dart';
import 'package:ecommerce_bokkor_dev/model/OrderModel/orderModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CheckOut extends StatefulWidget {
  final priceTotal;
  final shippingCost;
  final grandTotal;
  final discountCost;
  final cartInfo;
  final phone;
  final area;
  final house;
  final road;
  final block;
  final city;
  final state;
  final country;
  final voucherOb;


  CheckOut(
    this.priceTotal,
    this.shippingCost,
    this.grandTotal,
    this.discountCost,
    this.cartInfo,
    this.phone,
    this.area,
    this.house,
    this.road,
    this.block,
    this.city,
    this.state,
    this.country,
    this.voucherOb,
   
  );
  @override
  _CheckOutState createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var key = 'cart-list', cartkey = 'my-cart-list';
  List contList = [];
  var orderId = "";
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController roadController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  TextEditingController houseController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();

  _showMsg(msg) {
    //
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(FlutterI18n.translate(context, msg),),
      action: SnackBarAction(
        label: FlutterI18n.translate(context, "Close"),
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    ));
    //Scaffold.of(context).showSnackBar(snackBar);
  }

  ////////Radio
  var _queradioValue1 = -1, userData;
  var token, body, cartInfos;
  var order;
  String _ans = "";
  List cart, myCart = [];
  String curDate = "", countryName = "";
  bool _isLoggedIn = false, _isLoading = false, _isOrdered = false;
  int totalPrice = 0,
      grandtotal = 0,
      shippingTotal = 0,
      totalDiscount = 0,
      discount = 0;
  double priceTotal = 0.0,
      allTotal = 0.0,
      shippingCost = 0.0,
      discountCost = 0.0,
      grandTotal = 0.0,
      initPrice = 0.0,
      prices = 0.0;

  List<DropdownMenuItem<String>> _dropDownCountryItems;

  List<DropdownMenuItem<String>> getDropDownCountryItems() {
    List<DropdownMenuItem<String>> items = new List();
    for (String countryList in contList) {
      items.add(new DropdownMenuItem(
          value: countryList,
          child: new Text(
            countryList,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: 16, color: Colors.black),
          )));
    }
    return items;
  }

  @override
  void initState() {
    _getUserInfo();
    _currentDate();
    // getcartList(key);
    // getmycartList(cartkey);

    for (int i = 0; i < widget.cartInfo.length; i++) {
      discount = widget.cartInfo[i].product.discount;
      String pr = widget.cartInfo[i].product.price;
      double pricess = double.parse(pr);    
      double dis = discount / 100;
      double pp = pricess.toDouble();
      prices = (pp * dis);
      prices = pricess - prices;
      //prices *= cartInfos[i].quantity;

     // print(prices);
      priceTotal += prices;
    
    //  print(prices);   
    print("widget.cartInfo[i].type");
    print(widget.cartInfo[i].type);
              
      myCart.add({
        "productId": widget.cartInfo[i].product.id,
        "combinationId": widget.cartInfo[i].combinationId,
        "price": prices,
        "quantity": widget.cartInfo[i].quantity,
        "type": widget.cartInfo[i].type,
      });
    }
    grandTotal = priceTotal + shippingCost - discountCost;

    super.initState();
  }

  void _getUserInfo() async {
  //  print("iufgseiof");
    print(widget.voucherOb);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('loggedin-user');
    if (userJson != null) {
      //Navigator.push(context, SlideLeftRoute(page: LogInPage("3")));
      var user = json.decode(userJson);
      setState(() {
        userData = user;

        fnameController.text = userData['firstName'];
        lnameController.text = userData['lastName'];
        emailController.text = userData['email'];
        phoneController.text = widget.phone;
        houseController.text = widget.house;
        roadController.text = widget.road;
        areaController.text = widget.area;
        cityController.text = widget.city;
        blockController.text = widget.block;
        stateController.text = widget.state;
        // phoneController.text = '${widget.phone}';
        String counName = "";

        print("bhioiho ");
        print(widget.country);
        print(widget.state);
        for (int i = 0; i < country.length; i++) {
          contList.add("${country[i]['name']}");
          if (country[i]['name'] == "${widget.country}") {
            counName = "${country[i]['name']}";
          }
        }

        _dropDownCountryItems = getDropDownCountryItems();
        setState(() {
          countryName = counName;
        });

        print(countryName);
      });
      token = localStorage.getString('token');
      _isLoggedIn = true;
      getCartInfo(token);
    } else {
      setState(() {
        _isLoggedIn = false;
      });
    }

    //  print("efkgeoufigtuobretbv9e t89et ");
    print(countryName);
  }

  Future<void> getCartInfo(var token) async {
    var res = await CallApi().getData('/app/showCart?token=$token');
    body = json.decode(res.body);

    print(body);

    if (res.statusCode == 200) {
      _newCartlist();
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _newCartlist() {
    var newCart = CartModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      cartInfos = newCart.cart;
      print(cartInfos.length);
    });

    print("cartInfos.length");
    print(cartInfos.length);
  }

  void getcartList(key) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var cartList = localStorage.getString(key);
    setState(() {
      if (cartList != null) {
        cart = json.decode(cartList);
        print("cartList");
        print(cart);
        print(cart.length);
      }
    });
  }

  void getmycartList(cartkey) async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var mycartsList = localStorage.getString(cartkey);
    setState(() {
      if (mycartsList != null) {
        myCart = json.decode(mycartsList);
        print("myCart");
        print(myCart);
        print(myCart.length);
      }
    });
  }

  _currentDate() {
    var now = new DateTime.now();
    var d1 = DateFormat("yyyy-MM-dd HH:mm:ss").format(now);
    setState(() {
      curDate = d1;
    });
  }


  /////////////////   bkash process start ///////////////


  ////////////////  bkash process end ///////////////

  ////////////////  order process start ///////////////

  void _showPlaceOrder(var orderDetails) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: SingleChildScrollView(
            child: Container(
              //    width: double.maxFinite,
              //height: 300,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    //  color: Colors.red,
                    // width: double.maxFinite,
                    margin: EdgeInsets.only(bottom: 30),
                    // height: 40,
                    alignment: Alignment.center,

                    child: Text(
                      FlutterI18n.translate(context, "Thank_You_for_your_order")+"\n"+FlutterI18n.translate(context, "We_will_be_able_to_check_your_order_soon"),
                     // "Thank You for your order\nWe'll be able to check your order soon",
                      textAlign: TextAlign.center,
                      //maxLines: 3,
                      style: TextStyle(
                          color: Color(0XFF414042),
                          fontFamily: "SourceSansPro",
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    //  color: Colors.red,
                    // width: double.maxFinite,
                    margin: EdgeInsets.only(bottom: 30),
                    // height: 40,
                    alignment: Alignment.center,

                    child: Text(
                      FlutterI18n.translate(context, "If_you_would_like_to_pay_by_Benefit_Pay_kindly_click_on_one_of_the_logos"),
                      textAlign: TextAlign.center,
                      //maxLines: 3,
                      style: TextStyle(
                          color: Colors.grey,
                          fontFamily: "SourceSansPro",
                          fontSize: 14,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              launch(
                                  'https://wa.me/97339423596?text=Hello%20Order%20orderNo%20$orderId%20totalAmount%20${widget.grandTotal}%20BHD%20and%20would%20like%20to%20pay%20using%20BenefitPay');
                              Navigator.push(
                                  context, SlideLeftRoute(page: Navigation(0)));
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 15),
                              child: Image.asset(
                                'assets/images/benefit_pay.jpg',
                                width: 80,
                                height: 80,
                              ),
                            )),
                        GestureDetector(
                          onTap: () {
                            launch(
                                'https://wa.me/97339423596?text=Hello%20Order%20orderNo%20$orderId%20totalAmount%20${widget.grandTotal}%20BHD%20and%20would%20like%20to%20pay%20using%20BenefitPay');
                            Navigator.push(
                                context, SlideLeftRoute(page: Navigation(0)));
                          },
                          child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  AssetImage('assets/images/whatsapp.png')),
                        ),
                      ],
                    ),
                  ),
                  // Container(
                  //   //  color: Colors.red,
                  //   // width: double.maxFinite,
                  //   margin: EdgeInsets.only(top: 15),
                  //   // height: 40,
                  //   alignment: Alignment.center,

                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: <Widget>[
                  //       Text(
                  //         "Continue with cash on delivery",
                  //         textAlign: TextAlign.center,
                  //         //maxLines: 3,
                  //         style: TextStyle(
                  //             color: Colors.black54,
                  //             fontFamily: "SourceSansPro",
                  //             fontSize: 14,
                  //             fontWeight: FontWeight.w500),
                  //       ),
                  //       Container(
                  //           margin: EdgeInsets.only(left: 3),
                  //           child: Icon(
                  //             Icons.arrow_forward,
                  //             color: Colors.black54,
                  //             size: 14,
                  //           ))
                  //     ],
                  //   ),
                  // ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        // FlatButton(
                        //   shape: new RoundedRectangleBorder(
                        //       borderRadius: new BorderRadius.circular(50.0)),
                        //   child: new Text(
                        //     "Cancel",
                        //     style: TextStyle(color: Colors.grey),
                        //   ),
                        //   onPressed: () {
                        //     print("order");
                        //     print(orderDetails);
                        //     Navigator.pop(context);
                        //   },
                        // ),
                        Expanded(
                          child: Container(
                            child: OutlineButton(
                              borderSide: BorderSide(
                                  color: appTealColor,
                                  style: BorderStyle.solid,
                                  width: 1),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(50.0)),
                              child: new Text(
                                FlutterI18n.translate(context, "Continue_with_cash_on_delivery"),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: appTealColor, fontSize: 12),
                              ),
                              onPressed: () {
                                print("order");
                                print(orderDetails);
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    SlideLeftRoute(
                                        page: OrderHistoryCardDetails(
                                            orderDetails)));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showErrorOrder(msg) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
            //    width: double.maxFinite,
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  //  color: Colors.red,
                  // width: double.maxFinite,
                  margin: EdgeInsets.only(bottom: 30),
                  // height: 40,
                  alignment: Alignment.center,

                  child: Text(
                    FlutterI18n.translate(context, msg),
                   
                    textAlign: TextAlign.center,
                    //maxLines: 3,
                    style: TextStyle(
                        color: Color(0XFF414042),
                        fontFamily: "SourceSansPro",
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new OutlineButton(
                      borderSide: BorderSide(
                          color: appTealColor,
                          style: BorderStyle.solid,
                          width: 1),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0)),
                      child: new Text(
                        FlutterI18n.translate(context, "Ok"),
                        style: TextStyle(color: appTealColor),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //////////////  stock out dialouge////
  
   void _showErrorOrderFlash(name,msg) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
            //    width: double.maxFinite,
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  //  color: Colors.red,
                  // width: double.maxFinite,
                  margin: EdgeInsets.only(bottom: 30),
                  // height: 40,
                  alignment: Alignment.center,

                  child: Text(
                   name+ FlutterI18n.translate(context, msg),
                   
                    textAlign: TextAlign.center,
                    //maxLines: 3,
                    style: TextStyle(
                        color: Color(0XFF414042),
                        fontFamily: "SourceSansPro",
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new OutlineButton(
                      borderSide: BorderSide(
                          color: appTealColor,
                          style: BorderStyle.solid,
                          width: 1),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0)),
                      child: new Text(
                        FlutterI18n.translate(context, "Ok"),
                        style: TextStyle(color: appTealColor),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  

  ////////////////  order process end ///////////////

  Container inputContainer2(String label, String hint, TextInputType type,
      TextEditingController control, bool enab) {
    return Container(
      margin: EdgeInsets.only(
        top: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[200],
                    blurRadius: 17,
                    //offset: Offset(0.0,3.0)
                  )
                ],
                borderRadius: BorderRadius.circular(0),
                color: enab == false
                    ? Colors.grey.withOpacity(0.1)
                    : Colors.white),
            margin: EdgeInsets.only(
              top: 10,
            ),
            padding: EdgeInsets.only(top: 20),
            child: TextField(
              style: TextStyle(color: Color(0xFF000000)),
              cursorColor: Color(0xFF9b9b9b),
              controller: control,
              enabled: enab,
              keyboardType: type,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Color(0xFFFFFF), width: .5)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(0)),
                    borderSide: BorderSide(color: Color(0xFFFFFF), width: .5)),
                hintText: FlutterI18n.translate(context, hint),
                labelText: FlutterI18n.translate(context, label),
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 17,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.normal),
                contentPadding: EdgeInsets.only(left: 20, bottom: 13, top: 0),
                fillColor:
                    enab == false ? Colors.transparent : Color(0xFFFFFFFF),
                filled: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() async {
    Navigator.push(context, SlideRightRoute(page: Navigation(2)));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: new AppBar(
          backgroundColor: appTealColor,
          leading: GestureDetector(
              onTap: () {
                _isOrdered
                    ? Navigator.push(
                        context, SlideLeftRoute(page: Navigation(2)))
                    : Navigator.pop(context);
              },
              child: Container(child: Icon(Icons.arrow_back))),
          title: Text(FlutterI18n.translate(context, "Check_Out")),
        ),

        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              margin: EdgeInsets.only(top: 15, left: 20, right: 20, bottom: 20),
              child: Column(
                children: <Widget>[
                  /////////////////  Textfield  Start///////////////
                  inputContainer2("First_Name", "First_Name", TextInputType.text,
                      fnameController, true),
                  inputContainer2("Last_Name", "Last_Name", TextInputType.text,
                      lnameController, true),
                  inputContainer2("Mobile_Number", "Mobile_Number",
                      TextInputType.phone, phoneController, true),
                  inputContainer2("Email", "Email", TextInputType.emailAddress,
                      emailController, false),
                  inputContainer2("Area", "Area", TextInputType.text,
                      areaController, false),
                  inputContainer2("House", "House", TextInputType.text,
                      houseController, false),
                  inputContainer2("Road", "Road", TextInputType.text,
                      roadController, false),
                  inputContainer2("Block", "Block",
                      TextInputType.number, blockController, false),
                  // inputContainer2(
                  //     "Street", "Street", TextInputType.text, streetController),
                  inputContainer2("City", "City", TextInputType.text,
                      cityController, false),
                  inputContainer2("State", "State", TextInputType.text,
                      stateController, false),
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[200],
                            blurRadius: 17,
                            //offset: Offset(0.0,3.0)
                          )
                        ],
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    margin: EdgeInsets.only(top: 25),
                    padding: EdgeInsets.only(left: 20, top: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          FlutterI18n.translate(context, "Country"),
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Container(
                          child: DropdownButtonHideUnderline(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: DropdownButton(
                                isExpanded: true,
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                                value: countryName,
                                items: _dropDownCountryItems,
                                onChanged: (String value) {
                                  setState(() {
                                    countryName = value;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /////////////////  Textfield  End///////////////

                  /// /////////// Payment Method start /////

                  // Container(
                  //   margin: EdgeInsets.only(left: 5, top: 15),
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       Container(
                  //         alignment: Alignment.centerLeft,
                  //         margin: EdgeInsets.only(left: 10, bottom: 5),
                  //         child: Text(
                  //           "Payment Method",
                  //           style: TextStyle(
                  //               color: Color(0XFF414042),
                  //               fontFamily: "SourceSansPro",
                  //               fontSize: 18,
                  //               fontWeight: FontWeight.w500),
                  //         ),
                  //       ),

                  //       Divider(
                  //         color: appGreyDarkColor,
                  //       ),

                  //       ////// Option 1//////
                  //       Container(
                  //         //  color: Colors.red,
                  //         child: Row(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: <Widget>[
                  //             Radio(
                  //               materialTapTargetSize:
                  //                   MaterialTapTargetSize.shrinkWrap,
                  //               value: 0,
                  //               groupValue: _queradioValue1,
                  //               onChanged: _queRadioValueChange1,
                  //               activeColor: appTealColor,
                  //             ),
                  //             Expanded(
                  //               child: Container(
                  //                 padding: EdgeInsets.only(top: 10, left: 3),
                  //                 child: Text(
                  //                   'Cash on delivery',
                  //                   // textDirection: TextDirection.ltr,
                  //                   style: TextStyle(
                  //                     color: Colors.black,
                  //                     fontSize: 15.0,
                  //                     //decoration: TextDecoration.none,
                  //                     fontFamily: 'SourceSansPro',
                  //                     fontWeight: FontWeight.normal,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       ////// Option 1 end//////

                  //       ////// Option 2//////
                  //       Container(
                  //         //  color: Colors.red,
                  //         child: Row(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: <Widget>[
                  //             Radio(
                  //               materialTapTargetSize:
                  //                   MaterialTapTargetSize.shrinkWrap,
                  //               value: 1,
                  //               groupValue: _queradioValue1,
                  //               onChanged: _queRadioValueChange1,
                  //               activeColor: appTealColor,
                  //             ),
                  //             Expanded(
                  //               child: Container(
                  //                 padding: EdgeInsets.only(top: 10, left: 3),
                  //                 child: Text(
                  //                   'bKash',
                  //                   // textDirection: TextDirection.ltr,
                  //                   style: TextStyle(
                  //                     color: Colors.black,
                  //                     fontSize: 15.0,
                  //                     //decoration: TextDecoration.none,
                  //                     fontFamily: 'SourceSansPro',
                  //                     fontWeight: FontWeight.normal,
                  //                   ),
                  //                 ),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       ////// Option 2 end//////
                  //     ],
                  //   ),
                  // ),

                  /// /////////// Payment Method end /////
                ],
              ),
            ),
          ),
        ),
        ///////////// place order button start ////////

        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: 70,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _isLoading || _isOrdered ? null : 
                      _submitOrder();         
                      //_showPlaceOrder();

                      //     _isLoading ? null : 
                      //  _submitOrder();   


                    },
                    child: Container(
                      margin: EdgeInsets.only(left: 20, right: 20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: _isLoading || _isOrdered
                              ? Colors.grey
                              : appTealColor.withOpacity(0.3),
                          border: Border.all(width: 0.2, color: Colors.grey)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(left: 5),
                              child: _isOrdered
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                            _isOrdered
                                                ?  FlutterI18n.translate(context, "Your_order_has_been_placed")
                                                : _isLoading
                                                    ?FlutterI18n.translate(context, "Please_wait_for_processing_order")+"..."
                                                    : FlutterI18n.translate(context, "Place_Order")  +":",
                                            style: TextStyle(
                                                color: _isLoading || _isOrdered
                                                    ? Colors.white
                                                    : appTealColor,
                                                fontSize: 17)),
                                        _isOrdered
                                            ? Container(
                                                margin: EdgeInsets.only(top: 3),
                                                child: Text(
                                                    "(${widget.grandTotal.toStringAsFixed(2)} BHD)",
                                                    style: TextStyle(
                                                        color: _isLoading ||
                                                                _isOrdered
                                                            ? Colors.white
                                                            : appTealColor,
                                                        fontSize: 13)),
                                              )
                                            : Container(),
                                      ],
                                    )
                                  : Text(
                                      _isOrdered
                                          ? FlutterI18n.translate(context, "Your_order_has_been_placed")
                                          : _isLoading
                                              ? FlutterI18n.translate(context, "Please_wait_for_processing_order")+"..."
                                              : FlutterI18n.translate(context, "Place_Order")  +":",
                                      style: TextStyle(
                                          color: _isLoading || _isOrdered
                                              ? Colors.white
                                              : appTealColor,
                                          fontSize: 17))),
                          _isLoading || _isOrdered
                              ? Container()
                              : Container(
                                  margin: EdgeInsets.only(left: 20, right: 5),
                                  child: Text(
                                    "${widget.grandTotal.toStringAsFixed(2)} BHD",
                                    style: TextStyle(
                                        color: appTealColor,
                                        fontFamily: "SourceSansPro",
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        ///////////// place order button end ////////
      ),
    );
  }

  void _submitOrder() async {
    if (fnameController.text.isEmpty) {
      return _showMsg("First_Name_is_empty");
    } else if (lnameController.text.isEmpty) {
      return _showMsg("Last_Name_is_empty");
    } else if (emailController.text.isEmpty) {
      return _showMsg("Email_is_empty");
    } else if (phoneController.text.isEmpty) {
      return _showMsg("Phone_number_is_empty");
    } else if (houseController.text.isEmpty) {
                    
      return _showMsg("House_field_is_empty");

    } else if (roadController.text.isEmpty) {
      return _showMsg("Road_field_is_empty");
    } else if (blockController.text.isEmpty) {
      return _showMsg("Block_field_is_empty");
    } else if (areaController.text.isEmpty) {
      return _showMsg("Area_field_is_empty");
    }
    var data = {
      'firstName': fnameController.text,
      'lastName': lnameController.text,
      'email': emailController.text,
      'mobile1': phoneController.text,
      'discount': widget.discountCost,
      'subTotal': widget.priceTotal,
      'grandTotal': widget.grandTotal,
      'shippingPrice': widget.shippingCost,
      'house': houseController.text,
      'road': roadController.text, 
      'block': blockController.text,
      'street': '',
      'country': countryName,
      'date': curDate,
      'cartProducts': myCart,
      'driverId': null,
      'paymentType': 'Cash on delivery',
      'area': areaController.text,
      'city': cityController.text,
      'state': stateController.text,
      'voucher': widget.voucherOb,
      
    };   
                        
    print("data"); 
    print(data);                  
   
    
    setState(() {
      _isLoading = true;
    });

  // var res = await CallApi().postData(data, '/app/addOrder?token=$token');
   var res = await CallApi().postData(data, '/app/addOrderUpdated?token=$token');

   var body = json.decode(res.body);   
     print("body");
    print(body);
   // print("2"+body['message']+"2");

    if (body['success'] == true) {
      print(body);
      var newProducts = OrderModel.fromJson(body);
      if (!mounted) return;
      setState(() {
        order = newProducts.order;
      });
      for (int i = 0; i < order.length; i++) {
        orderId = order[i].id.toString();
      }
       //orderId = body['order']['id'].toString();
      Navigator.push(context, SlideLeftRoute(page: Navigation(2)));
      print(orderId);
      _showPlaceOrder(order[0]);
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.remove('cart-list');
      localStorage.remove('my-cart-list');
    } else {

      if(body['message']==" Out of stock!"){
           _showErrorOrderFlash(body['product'],"Out_of_stock");
       
       }
      else{
         _showErrorOrder("Something_went_wrong");
      }

   
    }
                   
     setState(() {
       _isLoading = false;
       _isOrdered = true;                      
     });
  }
}
 