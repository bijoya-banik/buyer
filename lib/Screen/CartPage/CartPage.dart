import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/Form/LoginForm/LogInPage.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/CheckOut/CheckOut.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:ecommerce_bokkor_dev/model/AddressModel/addressModel.dart';
import 'package:ecommerce_bokkor_dev/model/CartModel/cartModel.dart';
import 'package:ecommerce_bokkor_dev/model/DiscountModel/discountModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  bool _isDiscount = false;
  bool _isAddress = false;
  bool _iscoupon = false;
  bool _cart = false;
  bool _data = false;
  var voucherData;
  double subTotal=0;
  List cartDataNew = [];
  List cart, myCart, newAddList = [];
  TextEditingController voucherController = new TextEditingController();
  var key = 'cart-list',
      cartkey = 'my-cart-list',
      body,
      body1,
      body2,
      userData,
      cartInfo,
      addressList,
      discountDetails,
      token,
      currentDate;
  String voucher = "",
      name = "",
      phone = "",
      price = "",
      quantity = "",
      area = "",
      house = "",
      road = "",
      block = "",
      city = "",
      state = "",
      countrys = "",
      curDate = "";
  int totalPrice = 0,
      grandtotal = 0,
      shippingTotal = 0,
      totalDiscount,
      discount = 0;
  double priceTotal = 0.0,
      allTotal = 0.0,
      shippingCost = 0.0,
      discountCost = 0.0,
      grandTotal = 0.0,
      initPrice = 0.0,
      prices = 0.0,
      userDisc = 0.0,
      newDisc = 0.0;
  bool _isLoggedIn = false;
  bool _isLoading = false;
  bool _isFlashsale = true;
  bool _isApplying = false;
  bool _isValid = false;
  String countryName = "";
   String phoneCodeNum="";
  List contList = [];
  List phnList = [];
  var taxStatus;
  var taxAmount;
  double userDiscount=0.0;
  //double taxFinal =0.0;
  TextEditingController nameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();
  TextEditingController houseController = new TextEditingController();
  TextEditingController roadController = new TextEditingController();
  TextEditingController blockController = new TextEditingController();
  TextEditingController areaController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();

  @override
  void initState() {
    _currentDate();
    _getUserInfo();
  //  _showTax();
    // getcartList(key);
    // getmycartList(cartkey);
    String counName = "";
     String phone = "";
    for (int i = 0; i < country.length; i++) {
      contList.add("${country[i]['name']}");
      phnList.add("${country[i]['phoneCode']}");
      setState(() {
        if (country[i]['name'] == "Bahrain") {
          counName = "${country[i]['name']}";
           phone = "${country[i]['phoneCode']}";
        }
      });
    }

    // print(contList);

    // print("counName");
    // print(counName);

    _dropDownCountryItems = getDropDownCountryItems();
    setState(() {
      countryName = counName;
       phoneCodeNum  = phone;
    });

   // print(countryName);

    super.initState();
  }

  ///////////  get tax
  //   Future<void> _showTax(double price) async {
  // //  var key = 'tax-list';
  // //  await _getLocalBestProductsData(key);

  //   var res = await CallApi().getData('/app/getAllTax?token=$token');
  //   body = json.decode(res.body);

  //   if (res.statusCode == 200) {
  //       setState(() {
  //     taxStatus = body['alltax'][0]['isOn'];
  //     taxAmount = body['alltax'][0]['tax'];
   
  //     _isLoading = false;
  //   });

  //     if(taxStatus==1){
  //   setState(() {
      
  //     taxFinal =   (taxAmount/100)*priceTotal;
  //    grandTotal = price+ shippingCost - discountCost;
  //     print("objectfddddddddddddddddddddddddddddddddddd");
  //     print(taxFinal);
  //     print(priceTotal);

  //   });
  //   }
  //   else{
  //    setState(() {
  //       taxFinal = 0.00;
  //    });
  //   }

 
  //   print(taxAmount);
  //    // _bestProductsState();

  //     // SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     // localStorage.setString(key, json.encode(body));
  //   }
  // }
  //////////////// get  user start ///////////////

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

  _currentDate() {
    var now = new DateTime.now();
    var d1 = DateFormat("yyyy-MM-dd").format(now);
    setState(() {
      curDate = d1;
      currentDate = d1;
    });
  }

  Future<void> _getUserData(var token) async {
    setState(() {
      _isLoading = true;
    });
    var res = await CallApi().getData('/app/userDiscount?token=$token');
    print(res);
    body2 = json.decode(res.body);

    print("body2");
    print(body2);

    if (res.statusCode == 200) {
   
      _newDiscount();
      
    }

    // setState(() {
    //   _isLoading = false;
    // });
  }

  void _newDiscount() {
    var newDiscount = DiscountModel.fromJson(body2);
    if (!mounted) return;
    setState(() {
      discountDetails = newDiscount.user;

      if(discountDetails.discount!=null){
          userDiscount = double.parse(discountDetails.discount);
      }
      else{
        userDiscount = 0.0;
      }
      print("discountDetails.discount");
      print(discountDetails.discount);
    });

    getCartInfo(token);
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    if (userJson != null) {
      //Navigator.push(context, SlideLeftRoute(page: LogInPage("3")));
      var user = json.decode(userJson);
      setState(() {
        _isLoggedIn = true;
        userData = user;
      });
      print(userData);
      token = localStorage.getString('token');
      if (token != null) {
        setState(() {
          _isLoggedIn = true;
          getShippingCost();
          _getUserData(token);
          _showAddresslist(token);
        });
      }
    } else {
      // setState(() {
      //   _isLoggedIn = false;
      // });
    }
  }

  Future<void> _showAddresslist(var token) async {
    var res =
        await CallApi().getData('/app/showAllDeliveryAddress?token=' + token);
    body = json.decode(res.body);

    print(body);

    if (res.statusCode == 200) {
      _newAddresslist();
    }

    // setState(() {
    //   _isLoading = false;
    // });
  }

  void _newAddresslist() {
    var newAddresslist = AddressModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      addressList = newAddresslist.address;

      for (var i = 0; i < addressList.length; i++) {
        newAddList.add({
          "name": addressList[i].name,
          "mobile": addressList[i].mobile,
          "id": addressList[i].id,
          "area": addressList[i].area,
          "house": addressList[i].house,
          "road": addressList[i].road,
          "block": addressList[i].block,
          "city": addressList[i].city,
          "state": addressList[i].state,
          "coun": addressList[i].country,
        });
      }

      if (userData == null) {
        name = '';
        phone = '';
        area = '';
        house = '';
        road = '';
        block = '';
        city = '';
        state = '';
        countrys = '';
      setState(() {
          _isAddress = false;
      });
      } else {
        if (newAddList.length == 0) {
        setState(() {
            _isAddress = false;
        });
        } else {

          setState(() {
          name = addressList[0].name;
          phone =addressList[0].country_code+ addressList[0].mobile;
          area = addressList[0].area;
          house = addressList[0].house;
          road = addressList[0].road;
          block = addressList[0].block;
          city = addressList[0].city;
          state = addressList[0].state;
          countrys = addressList[0].country;
          _isAddress = true;
          });


          print(name);
          
        }
      }

      // area = addressList[0].area;
      // house = addressList[0].house;
      // road = addressList[0].road;
      // block = addressList[0].block;
      // city = addressList[0].city;
      // state = addressList[0].state;
      // countrys = addressList[0].country;
      // _isAddress = true;
    });

    print("newAddList");
    print(newAddList);
  }

  Future<void> getCartInfo(var token) async {
    setState(() {
      _cart ? _isLoading = true : null;
      _data = true;
    });
    var res = await CallApi().getData('/app/showCart?token=$token');
    print(res);
    body = json.decode(res.body);

    print("body");
    print(body);

    if (res.statusCode == 200) {
      _newCartlist();
    }
if (!mounted) return;
    setState(() {
      _isLoading = false;
      _data = false;
    });
  }

  void _newCartlist() {

    double newPrice;
    var newCart = CartModel.fromJson(body);
    print(newCart);
    if (!mounted) return;
    setState(() {
      cartInfo = newCart.cart;
      _isFlashsale = newCart.isFlashsaleOrder;

      for (var d in cartInfo) {
  
        cartDataNew.add(d);
      }

      for (int i = 0; i < cartInfo.length; i++) {
        // cart.add(cartInfo[i]);
        discount = cartInfo[i].product.discount;
        String pr = cartInfo[i].product.price;
        var pri = cartInfo[i].price;
        prices = pri.toDouble();
        // double dis = discount / 100;
        // double pp = pricess.toDouble();
        // prices = (pp * dis);
        // prices = pricess - prices;
        prices *= cartInfo[i].quantity;
        priceTotal += prices;
        subTotal = priceTotal;
      }

      print("priceTotallllllllllllllllllllllllllllllllll");
      print(priceTotal);

      if (discountDetails == null) {
          print("i am herereeeeeeeeeeeeeeeeeeee null");
        String disc = "0.0";
        userDisc = double.parse(disc);
        newDisc = (userDisc / 100) * priceTotal;
        double priceNew = priceTotal - newDisc;
          setState(() {
            newPrice= priceNew;
             subTotal = priceNew;
                    priceTotal = subTotal;
          grandTotal = priceNew + shippingCost - discountCost;
      });
      } else if (discountDetails.discountValidity == null) {
          print("i am herereeeeeeeeeeeeeeeeeeee validity null");
        String disc = "0.0";
        userDisc = double.parse(disc);
        newDisc = (userDisc / 100) * priceTotal;
        double priceNew = priceTotal - newDisc;
   
            setState(() {
                    newPrice= priceNew;
                    print("new");
                    print(priceNew);
                    subTotal = priceNew;
                    priceTotal = subTotal;
          grandTotal = priceNew + shippingCost - discountCost;
      });
    
      } else {

        print("i am herereeeeeeeeeeeeeeeeeeee");
        String date = discountDetails.discountValidity;
        var date2 = DateTime.parse(date);
        var date3 = DateTime.parse(curDate);

        if (_isFlashsale == false) {
          if (date3.isAfter(date2)) {
            print("ok");
            // String disc = userData['discount'];
            // userDisc = double.parse(disc);
            // newDisc = (userDisc / 100) * priceTotal;
            double priceNew = priceTotal - newDisc;
              setState(() {
                      newPrice= priceNew;
                       subTotal = priceNew;
                    priceTotal = subTotal;
          grandTotal = priceNew + shippingCost - discountCost;
      });
            _isValid = false;
          } else {
            print("not ok");
            String disc = discountDetails.discount;
            print("dusc");
            //  print(priceNew);
            userDisc = double.parse(disc);
            newDisc = (userDisc / 100) * priceTotal;
            double priceNew = priceTotal - newDisc;

            print("priceNew");
            print(priceNew);
              setState(() {
                      newPrice= priceNew;
                       subTotal = priceNew;
                    priceTotal = subTotal;
          grandTotal = priceNew + shippingCost - discountCost;
      });
            _isValid = true;
          }
        } else {

          print('_isFlashsale');
          print(_isFlashsale);
          print('priceTotal');
          print(priceTotal);
          print('newDisc');
          print(newDisc);
         
          
          double priceNew = priceTotal - newDisc;
           print('priceNew');
          print(priceNew);
          subTotal = priceNew;
          priceTotal = priceNew;
                      setState(() {
                    newPrice= priceNew;
          grandTotal = priceNew + shippingCost - discountCost;
      });        }

        //print(currentDate.isBefore(date2)); // => true
      }
      // _showTax(newPrice);
    });

    print("cartInfo.length");

    print(cartInfo.length);

      
  }

  void getAddress() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            title: Container(
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 5, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(FlutterI18n.translate(context, "Delivery_Addresses"),),
                          Container()
                        ],
                      )),
                  Divider(
                    height: 0,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
            content: newAddList.length == 0
                ? Center(
                    child: Container(
                    child: Text(FlutterI18n.translate(context, "No_address_yet"),),
                  ))
                : Container(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: 40,
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: List.generate(newAddList.length, (index) {
                              return addressesList(newAddList[index], index);
                            })),
                      ),
                    ),
                  ));
      },
    );
  }

  void addNewAddress() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            title: Container(
              child: Column(
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(top: 5, bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Text(FlutterI18n.translate(context, "Add_New_Address"),),
                        ],
                      )),
                  Divider(
                    height: 0,
                    color: Colors.grey[400],
                  ),
                ],
              ),
            ),
            content: Container(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 2,
                          child: Divider()),

                      editinfo('Address_Name', '', nameController,
                          TextInputType.text, true),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 2,
                          child: Divider()),
Container(
  //width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 25, right: 15, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
              Container(
                
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.grey[100],
                    border: Border.all(width: 0.2, color: Colors.grey)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                         FlutterI18n.translate(context, "Code"),
                            
                            style: TextStyle(color: appTealColor, fontSize: 14),
                          ),
                    ),
                        Padding(
                          padding: const EdgeInsets.only(left:8, right:8, top: 0,bottom:16 ),
                          child: Text(
                      phoneCodeNum, 
                      style: TextStyle(color: appTealColor, fontSize: 12),
                    ),
                        ),
                  ],
                ),
              ),
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width/2,
                  margin: EdgeInsets.only(left: 8, top: 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.grey[100],
                      border: Border.all(width: 0.2, color: Colors.grey)),
                  child: TextField(
                    cursorColor: Colors.grey,
                    controller: mobileController,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    enabled: true,
                    style: TextStyle(color: Colors.black54),
                    decoration: InputDecoration(
                      hintText: "",
                      labelText: FlutterI18n.translate(context, "Mobile_Number"),
                      labelStyle: TextStyle(color: appTealColor),
                      contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 15.0),
                      border: InputBorder.none,
                    ),
                  )),
            ),
          ],
        )),
                      // editinfo('Mobile', '', mobileController,
                      //     TextInputType.number, true),

                      Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 2,
                          child: Divider()),

                      editinfo(
                          'Area', '', areaController, TextInputType.text, true),

                      Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 2,
                          child: Divider()),

                      editinfo('House_Building_Flat', '', houseController,
                          TextInputType.text, true),

                      Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 2,
                          child: Divider()),

                      editinfo(
                          'Road', '', roadController, TextInputType.text, true),

                      Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 2,
                          child: Divider()),

                      editinfo('Block', '', blockController, TextInputType.text,
                          true),

                      Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 2,
                          child: Divider()),

                      editinfo(
                          'City', '', cityController, TextInputType.text, true),

                      Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 2,
                          child: Divider()),

                      editinfo('State', '', stateController, TextInputType.text,
                          true),

                      Container(
                        padding: EdgeInsets.only(
                            left: 15, right: 15, top: 20, bottom: 10),
                        child: Container(
                          margin: EdgeInsets.only(left: 8, top: 0),
                          padding: EdgeInsets.only(left: 15, top: 10),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            color: Colors.grey[100],
                            //border: Border.all(width: 0.2, color: Colors.grey)
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                FlutterI18n.translate(context, "Country"),
                                style: TextStyle(
                                    color: appTealColor, fontSize: 12),
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

                                          for(int i=0;i<contList.length;i++){

                                   if (country[i]['name'] == countryName) {
                                     
                                     setState(() {
                                        phoneCodeNum = phnList[i];
                                     });
                                     break;
                                          
                                          }
                                }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      /////////////////   profile editing save start ///////////////

                      GestureDetector(
                        onTap: () {
                          _isLoading ? null : _updateAddress();
                        },
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 25, right: 15, bottom: 20, top: 5),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              color: appTealColor.withOpacity(0.9),
                              border:
                                  Border.all(width: 0.2, color: Colors.grey)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add,
                                size: 20,
                                color: Colors.white,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Text(
                                      _isLoading ? FlutterI18n.translate(context, "Please_wait")+("...") : FlutterI18n.translate(context, "Add"),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17)))
                            ],
                          ),
                        ),
                      ),

                      /////////////////   profile editing save end ///////////////
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }

  Container editinfo(String label, String hint, TextEditingController control,
      TextInputType type, bool enable) {
    return Container(
        padding: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
        child: Container(
            margin: EdgeInsets.only(left: 8, top: 0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                color: Colors.grey[100],
                border: Border.all(width: 0.2, color: Colors.grey)),
            child: TextField(
              cursorColor: Colors.grey,
              controller: control,
              keyboardType: type,
              autofocus: true,
              enabled: enable,
              style: TextStyle(color: Colors.black54),
              decoration: InputDecoration(
                hintText: FlutterI18n.translate(context, hint),
                labelText: FlutterI18n.translate(context, label),
                labelStyle: TextStyle(color: appTealColor),
                contentPadding: EdgeInsets.fromLTRB(15.0, 10.0, 20.0, 15.0),
                border: InputBorder.none,
              ),
            )));
  }

  void _updateAddress() {
    _updateProfile();
  }

  void _updateProfile() async {
    if (nameController.text == "") {
      return _showMsg("Address_name_field_is_empty");
    } else if (mobileController.text == "") {
      return _showMsg("Mobile_field_is_empty");
    } else if (areaController.text == "") {
      return _showMsg("Area_field_is_empty");
    } else if (houseController.text == "") {
      return _showMsg("House_field_is_empty");
    } else if (roadController.text == "") {
      return _showMsg("Road_field_is_empty");
    } else if (blockController.text == "") {
      return _showMsg("Block_field_is_empty");
    }
    // else if (cityController.text == "") {
    //   return _showMsg("City field is empty!");
    // } else if (stateController.text == "") {
    //   return _showMsg("State field is empty!");
    // }

    var data = {
      "name": nameController.text,
      "mobile": mobileController.text,
      "country_code":phoneCodeNum,
      "area": areaController.text,
      "house": houseController.text,
      "road": roadController.text,
      "block": blockController.text,
      "city": cityController.text,
      "state": stateController.text,
      "country": countryName,
    };
    setState(() {
      _isLoading = true;
    });
    print(data);
    var res =
        await CallApi().postData(data, '/app/addDeliveryAddress?token=$token');

    var body = json.decode(res.body);
    print(body);
    if (body['success'] == true) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', token);
      //localStorage.setString('user', json.encode(data));

      setState(() {
        userData['name'] = nameController.text;
        userData['mobile'] = mobileController.text;
        userData['country_code'] = phoneCodeNum;
        userData['area'] = areaController.text;
        userData['house'] = houseController.text;
        userData['road'] = roadController.text;
        userData['block'] = blockController.text;
        userData['city'] = cityController.text;
        userData['state'] = stateController.text;
        userData['country'] = countryName;

        newAddList.add({
          "name": nameController.text,
          "mobile":phoneCodeNum+ mobileController.text,
          "area": areaController.text,
          "house": houseController.text,
          "road": roadController.text,
          "block": blockController.text,
          "city": cityController.text,
          "state": stateController.text,
          "coun": countryName,
        });
        nameController.text = "";
        mobileController.text = "";
        areaController.text = "";
        houseController.text = "";
        roadController.text = "";
        blockController.text = "";
        cityController.text = "";
        stateController.text = "";
      });

      // print("newAddList 1");
      // print(newAddList);

      Navigator.pop(context);

      _showMessage();
    } else if (body['message'].contains('SQLSTATE[23000]')) {
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _showMsg("Something_went_wrong");
        _isLoading = false;
      });
    }

    setState(() {
      print('false');
      _isLoading = false;
    });
  }

  _showMsg(msg) {
    // //
    // final snackBar = SnackBar(
    //   content: Text(msg),
    //   action: SnackBarAction(
    //     label: 'Close',
    //     onPressed: () {
    //       // Some code to undo the change!
    //     },
    //   ),
    // );
    // Scaffold.of(context).showSnackBar(snackBar);

    Fluttertoast.showToast(
        msg: FlutterI18n.translate(context, msg),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.redAccent,
        textColor: Colors.white,
        fontSize: 13.0);
  }

  Container addressesList(var newAddList, int index) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(bottom: 5, top: 0, left: 3),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            Navigator.pop(context);
         
            
              name = "${newAddList['name']}";
              phone = "${newAddList['mobile']}";
              area = "${newAddList['area']}";
              house = "${newAddList['house']}";
              road = "${newAddList['road']}";
              block = "${newAddList['block']}";
              city = "${newAddList['city']}";
              state = "${newAddList['state']}";
              countrys = "${newAddList['coun']}";
                _isAddress = true;
          
          print(phone);
          });
        },
        child: Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[300],
                  blurRadius: 17,
                )
              ],
              color: Colors.white),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: 7, left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      // color: Colors.teal,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.center,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.7,
                                  padding: EdgeInsets.only(top: 8),
                                  child: Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          size: 18,
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child: Text(
                                              FlutterI18n.translate(context, "Address")+":  ${newAddList['name']}",
                                              // "${d.quantity}x ${d.item.name}",
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "sourcesanspro",
                                                  fontSize: 16,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.9,
                                  margin: EdgeInsets.only(left: 25),
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    FlutterI18n.translate(context, "Mobile")+":  ${newAddList['mobile']}",
                                    // "${d.quantity}x ${d.item.name}",
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "sourcesanspro",
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.9,
                                  margin: EdgeInsets.only(left: 25),
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    FlutterI18n.translate(context, "Area")+": ${newAddList['area']}",
                                    // "${d.quantity}x ${d.item.name}",
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "sourcesanspro",
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.9,
                                  margin: EdgeInsets.only(left: 25),
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    FlutterI18n.translate(context, "House")+":${newAddList['house']}",
                                    // "${d.quantity}x ${d.item.name}",
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "sourcesanspro",
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.9,
                                  margin: EdgeInsets.only(left: 25),
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    FlutterI18n.translate(context, "Road")+": ${newAddList['road']}",
                                    // "${d.quantity}x ${d.item.name}",
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "sourcesanspro",
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.9,
                                  margin: EdgeInsets.only(left: 25),
                                  padding: EdgeInsets.only(top: 8),
                                  child: Text(
                                    FlutterI18n.translate(context, "Block")+": ${newAddList['block']}",
                                    // "${d.quantity}x ${d.item.name}",
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontFamily: "sourcesanspro",
                                        fontSize: 13,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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

        for (int i = 0; i < cart.length; i++) {
          String tPrice = cart[i]['totalPrice'];
          double price = double.parse(tPrice);
          priceTotal += price;
        }
      }

      print("priceTotal");
      print(priceTotal);

      //priceTotal = totalPrice.toDouble();
      grandTotal = priceTotal + shippingCost - discountCost;
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

  Future<void> getShippingCost() async {
    var res = await CallApi().getData('/app/getShippingCharges');
    body = json.decode(res.body);

    String price = body['shipping']['price'];
    shippingCost = double.parse(price);

    print(price);
  }

  Future<void> getVoucher(String voucher) async {
    if (voucherController.text == '') {
      _showToast(21);
    } else {
      setState(() {
        _isApplying = true;
      });
    }

    var res =
        await CallApi().getData('/app/showVoucher?code=$voucher&token=$token');
    body1 = json.decode(res.body);

    print(body1);

    setState(() {
      if (body1['message'] == null && body1['voucher'] == null) {
        discountCost = 0.0;
        //_showToast(3);
      } else if (body1['message'] != null && body1['voucher'] == null) {
        if (body1['message'] == "You already used this Promo Code!") {
          _showToast(3);

          print(body1['message']);
        } else if (body1['message'].contains("expired")) {
          _showToast(4);

          print(body1['message']);
        } else if (body1['message'] == "Invalid Promo code!") {
          _showToast(5);

          print(body1['message']);
        } else if (body1['message'].contains('Undefined variable')) {
          _showToast(20);
        }
      } else if (body1['voucher'] != null && body1['message'] == null) {
        totalDiscount = body1['voucher']['discount'];

        // print("voucher body");
        // print(body1['voucher']);

        voucherData = {
          "id": body1['voucher']['id'],
          "code": body1['voucher']['code'],
          "discount": body1['voucher']['discount'],
          "type": body1['voucher']['type'],
          "counter": body1['voucher']['counter'],
          "validity": body1['voucher']['validity'],
        };

        print(voucherData);

        print(totalDiscount);
        _showToast(1);
        if (totalDiscount == 0) {
          discountCost = 0.0;
        } else {
          double dis = totalDiscount.toDouble();
          dis /= 100.0;
          discountCost = priceTotal * dis;
          //discountCost = priceTotal - price;
          print(discountCost);
        }
        // showcart();
        // print("totalPrice");
        // print(grandTotal);
        // print("totalsub");
        // print(priceTotal);
        // print("totalship");
        // print(shippingCost);
        // print("totalcou");
        // print(discountCost);
        //  print("totaluser");
        // print(newDisc);

        grandTotal = priceTotal + shippingCost - discountCost - newDisc;
      }

      _isApplying = false;
    });
  }

  _showToast(int number) {
    Fluttertoast.showToast(
        msg: number == 22
            ? FlutterI18n.translate(context, "Out_of_stock")
            : number == 21
                ? FlutterI18n.translate(context, "Please_add_a_promo_code")
                : number == 20
                    ? FlutterI18n.translate(context, "Something_went_wrong")
                    : number == 1
                        ? FlutterI18n.translate(context, "Promo_code_accepted")
                        : number == 2
                            ? FlutterI18n.translate(context, "Deleted_successfully")
                            : number == 3
                                ? FlutterI18n.translate(context, "You_already_used_this_Promo_Code")
                                : number == 4
                                    ? FlutterI18n.translate(context, "Promo_code_expired")
                                    : number == 5
                                        ? FlutterI18n.translate(context, "Invalid_Promo_code")
                                         
                                        : FlutterI18n.translate(context, "Please_select_an_address"),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: number == 3 ||
                number == 4 ||
                number == 5 ||
                number == 10 ||
                number == 20 ||
                number == 21 ||
                number == 22
            ? Colors.redAccent
            : appTealColor.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 13.0);
  }

  _showMessage() {
    Fluttertoast.showToast(
        msg: FlutterI18n.translate(context, "Address_added_successfully"),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: appTealColor.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 13.0);
  }

  changeCart(List carts) async {
    var key = 'cart-list';
    //await _getCartData(key);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString(key, json.encode(carts));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appTealColor,
        automaticallyImplyLeading: false,
        title: Center(
          child: Container(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(FlutterI18n.translate(context, "Cart"),
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ),
      body: _isLoading == true
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _isLoggedIn == false
              ? Center(
                  child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(FlutterI18n.translate(context, "Login_to_your_account"),),
                      GestureDetector(
                        onTap: () {   
                          Navigator.push(
                              context, SlideLeftRoute(page: LogInPage(3)));
                        },
                        child: Container(
                            margin: EdgeInsets.only(top: 5),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: appTealColor.withOpacity(0.8),
                                borderRadius: BorderRadius.circular(10)),
                            child: Text(FlutterI18n.translate(context, "Login"),
                                style: TextStyle(color: Colors.white))),
                      )
                    ],
                  ),
                ))
              : cartInfo == null || cartInfo.length == 0
                  ? Center(
                      child: Container(
                      child: Text(FlutterI18n.translate(context, "No_products_added_to_cart")),
                    ))
                  : SafeArea(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 20, right: 20, top: 20, bottom: 20),
                          child: Column(
                            children: <Widget>[
                              ////////////   Card Start  ///////////

                              Container(
                                margin: EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey[300],
                                        blurRadius: 17,
                                      ) 
                                    ],
                                    color: Colors.white),
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    ////////////  Cart Details Card start  ///////////

                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                      child: Column(
                                        children: List.generate(cartInfo.length,
                                            (index) {
                                                  // print("inside list");
                                                  // print(cartInfo[index].product.flashProduct.quantity);
                                             // priceTotal = 0;
                                              //////////////price total
        //   double q = (cartDataNew[index].quantity).toDouble();
        // print(q); // *
        // double proDis = cartDataNew[index].product.discount.toDouble();
        // double proPrice = proDis / 100;
        // double p = (double.parse((cartDataNew[index].product.price)) -
        //     (double.parse(cartDataNew[index].product.price)) * proPrice);
        // priceTotal =priceTotal + q * p;

        // print("priceTotal");
        // print(priceTotal);

        // print("proDis");
        // print(proDis);
        // // print(priceTotal);
        // // print(priceTotal);
        // subTotal = priceTotal;

        ///////////////////  price total
                                          discount =
                                              cartInfo[index].product.discount;
                                          String pr =
                                              cartInfo[index].product.price;
                                          var pric = cartInfo[index].price;
                                          prices = pric.toDouble();
                                          // double dis = discount / 100;
                                          // double pp = pricess.toDouble();
                                          // prices = (pp * dis);
                                          // prices = pricess - prices;

                                          //cartInfo[index].price = prices;
                                          prices *= cartInfo[index].quantity;
                                          //cartInfo[index].product.price = "$pp1";
                                          //print(cartInfo[index].price);

                                          return Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 7, 10, 0),
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      bottom: 7),
                                                  decoration: BoxDecoration(
                                                      border: Border(
                                                    top: BorderSide(
                                                      color: index == 0
                                                          ? Colors.white
                                                          : Colors.grey,
                                                      width: 0.5,
                                                    ),
                                                  )),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Row(
                                                          children: <Widget>[
                                                            Container(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                right: 10.0,
                                                              ),
                                                              child: ClipOval(
                                                                  child: Image
                                                                      .network(
                                                                '${cartInfo[index].product.image}',
                                                                height: 50,
                                                                width: 50,
                                                                fit: BoxFit
                                                                    .cover,
                                                              )),
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              7),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                  child: Text(
                                                                    "${cartInfo[index].product.name}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontFamily:
                                                                            "sourcesanspro",
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              7),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                  child: Text(
                                                                    cartInfo[index].allcombination ==
                                                                            null
                                                                        ? FlutterI18n.translate(context, "No_Combination")
                                                                        : "${cartInfo[index].allcombination.combination}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        color: cartInfo[index].combination ==
                                                                                null
                                                                            ? Colors
                                                                                .grey
                                                                            : Colors.black.withOpacity(
                                                                                .8),
                                                                        fontFamily:
                                                                            "sourcesanspro",
                                                                        fontSize:
                                                                            11,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      4,
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              7),
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                  child: cartInfo[index].type=="flash"?
                                                                  
                                                                   Text(cartInfo[index].product.flashProduct == null ?"Out_of_stock":
                                                                            cartInfo[index].product.flashProduct.quantity == 0 || 
                                                                            cartInfo[index].quantity > cartInfo[index].product.flashProduct.quantity
                                                                        ? FlutterI18n.translate(context, "Out_of_stock")
                                                                        : "${cartInfo[index].product.flashProduct.quantity} "+FlutterI18n.translate(context, "Available"),
                                                                    textAlign:TextAlign.left,
                                                                    overflow:TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                        color: cartInfo[index].product.stock == null || cartInfo[index].product.stock == 0 || cartInfo[index].quantity > cartInfo[index].product.stock
                                                                            ? Colors.redAccent: appColor,
                                                                        fontFamily: "sourcesanspro",
                                                                        fontSize:11,
                                                                        fontWeight:FontWeight.normal),
                                                                  ):

                                                                  Text(cartInfo[index].product ==null ||
                                                                            cartInfo[index].product.stock ==0 || 
                                                                            cartInfo[index].quantity > cartInfo[index].product.stock
                                                                        ? FlutterI18n.translate(context, "Out_of_stock")
                                                                        : "${cartInfo[index].product.stock} "+FlutterI18n.translate(context, "Available"),
                                                                    textAlign:TextAlign.left,
                                                                    overflow:TextOverflow.ellipsis,
                                                                    style: TextStyle(
                                                                        color: cartInfo[index].product.stock == null || cartInfo[index].product.stock == 0 || cartInfo[index].quantity > cartInfo[index].product.stock
                                                                            ? Colors.redAccent: appColor,
                                                                        fontFamily: "sourcesanspro",
                                                                        fontSize:11,
                                                                        fontWeight:FontWeight.normal),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              10.0,
                                                                          top:
                                                                              5),
                                                                  decoration: BoxDecoration(
                                                                      //  color: Colors.red
                                                                      // border: Border.all(
                                                                      //   color: Colors.grey,
                                                                      // ),
                                                                      borderRadius: BorderRadius.circular(5)),
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        EdgeInsets
                                                                            .all(3),
                                                                    child: Row(
                                                                      children: <
                                                                          Widget>[
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            setState(() {
                                                                              cartInfo[index].quantity--;
                                                                              if (cartInfo[index].quantity <= 1) {
                                                                                cartInfo[index].quantity = 1;
                                                                              }

                                                                              updateCart(cartInfo[index]);
                                                                            });
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            child:
                                                                                Icon(
                                                                              Icons.remove,
                                                                              color: appTealColor,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Container(
                                                                          margin: EdgeInsets.only(
                                                                              top: 3,
                                                                              left: 10,
                                                                               right: 10),
                                                                          child:                                                                                                                                                                                                      
                                                                              Text(
                                                                            "${cartInfo[index].quantity}",
                                                                            style: TextStyle(
                                                                                 color: Colors.black,
                                                                                fontFamily: "sourcesanspro",
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.bold),
                                                                            ),
                                                                        ),
                                                                        GestureDetector( 
                                                                          onTap:() {

                                                                            if(cartInfo[index].type=="flash"){
                                                                              
                                                                              if(cartInfo[index].quantity == cartInfo[index].product.flashProduct.quantity){
                                                                                 _showToast(22);
                                                                              }
                                                                              else{
                                                                                setState(() {
                                                                                    cartInfo[index].quantity++;
                                                                                });
                                                                              
                                                                              }
                                                                           
                                                                            }
                                                                            else{
                                                                            setState(() {
                                                                              cartInfo[index].quantity++;

                                                                              if (cartInfo[index].allcombination == null) {
                                                                                if (cartInfo[index].quantity > cartInfo[index].product.stock) {
                                                                                  cartInfo[index].quantity = cartInfo[index].product.stock;
                                                                                  _showToast(22);
                                                                                }
                                                                              } else {
                                                                                if (cartInfo[index].quantity > cartInfo[index].allcombination.stock) {
                                                                                  cartInfo[index].quantity = cartInfo[index].allcombination.stock;
                                                                                  _showToast(22);
                                                                                }
                                                                              }

                                                                              updateCart(cartInfo[index]);
                                                                            });
                                                                          }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            child:
                                                                                Icon(
                                                                              Icons.add,
                                                                              color: appTealColor,
                                                                              //size: 14,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                 ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          child: Row(
                                                            children: <Widget>[
                                                              Container(
                                                                child:
                                                                    IconButton(
                                                                  icon: Icon(
                                                                    Icons
                                                                        .delete,
                                                                    color:
                                                                        appTealColor,
                                                                  ),
                                                                  onPressed:
                                                                      () {
                                                                    _showDeleteAlert(
                                                                        index);
                                                                  },
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child:
                                                                    Container(
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 2),
                                                                  child: Text(
                                                                    "${prices.toStringAsFixed(2)} BHD",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    style: TextStyle(
                                                                        color:
                                                                            appTealColor,
                                                                        fontFamily:
                                                                            "sourcesanspro",
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    ////////////  Cart Details Card end  ///////////

                                    /////////////  Subtotal  start ////////////

                                    // _data
                                    //     ? Center(

                                    //         child: Container(
                                    //           child: Padding(
                                    //             padding: const EdgeInsets.all(3.0),
                                    //             child: Text("Please wait..."),
                                    //           )),
                                    //       )
                                    //     : Container(),
                                    Container(
                                      color: Colors.grey[350],
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 5),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              FlutterI18n.translate(context, "Subtotal"),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "sourcesanspro",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                             // "${priceTotal.toStringAsFixed(2)} BHD",
                                              "${subTotal.toStringAsFixed(2)} BHD",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "sourcesanspro",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    /////////////  Subtotal end ////////////

                                    ///////////////User Discount start ////////////

                                    _isFlashsale == true
                                        ? Container()
                                        : Container(
                                            padding: EdgeInsets.only(
                                                left: 20,
                                                right: 20,
                                                top: 10,
                                                bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        FlutterI18n.translate(context, "User_Discount"),
                                                        
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily:
                                                                "sourcesanspro",
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      Text(
                                                        discountDetails == null
                                                            ? " (0%)"
                                                            : _isValid == false
                                                                ? "("+FlutterI18n.translate(context, "Validity_expired")+")"// " ()"
                                                                : " (${discountDetails.discount}%)",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: _isValid ==
                                                                    false
                                                                ? Colors.black54
                                                                : Colors.black,
                                                            fontFamily:
                                                                "sourcesanspro",
                                                            fontSize:
                                                                _isValid ==
                                                                        false
                                                                    ? 10
                                                                    : 14,
                                                            fontWeight:
                                                                _isValid ==
                                                                        false
                                                                    ? FontWeight
                                                                        .normal
                                                                    : FontWeight
                                                                        .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Icon(
                                                        Icons.remove,
                                                        size: 15,
                                                        color: Colors.redAccent,
                                                      ),
                                                      Text(
                                                        "${newDisc.toStringAsFixed(2)} BHD",
                                                        //   "\$${(delifee).toStringAsFixed(2)}",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            color: Colors
                                                                .redAccent,
                                                            fontFamily:
                                                                "sourcesanspro",
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),

                                    /////////////User Discount End////////////

                                    ///////////// Discount Fee  Start ////////////

                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              totalDiscount == null
                                                  ? FlutterI18n.translate(context, "Voucher_Discount")+" (0%)"
                                                  : FlutterI18n.translate(context, "Voucher_Discount")+"($totalDiscount%)",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "sourcesanspro",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.remove,
                                                  size: 15,
                                                  color: Colors.redAccent,
                                                ),
                                                Text(
                                                  "${discountCost.toStringAsFixed(2)} BHD",
                                                  //   "\$${(delifee).toStringAsFixed(2)}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.redAccent,
                                                      fontFamily:
                                                          "sourcesanspro",
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    ///////////// Discount Fee End  ////////////

                                    ///////////////Shipping Cost start ////////////

                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 5,
                                          bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                             FlutterI18n.translate(context, "Shipping_Cost"),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "sourcesanspro",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "+ ${shippingCost.toStringAsFixed(2)} BHD",
                                              //   "\$${(delifee).toStringAsFixed(2)}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "sourcesanspro",
                                                  fontSize: 14,
                                                  fontWeight:
                                                      FontWeight.normal),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    /////////////Shipping Cost End////////////


                                  //    ///////////////Tax Cost start ////////////

                                  //  taxStatus==1? Container(
                                  //     padding: EdgeInsets.only(
                                  //         left: 20,
                                  //         right: 20,
                                  //         top: 5,
                                  //         bottom: 10),
                                  //     child: Row(
                                  //       mainAxisAlignment:
                                  //           MainAxisAlignment.spaceBetween,
                                  //       children: <Widget>[
                                  //         Row(
                                  //            mainAxisAlignment:
                                  //           MainAxisAlignment.start,
                                  //           children: <Widget>[
                                  //             Container(
                                  //               child: Text(
                                  //                 "Tax",
                                  //                 textAlign: TextAlign.center,
                                  //                 style: TextStyle(
                                  //                     color: Colors.black,
                                  //                     fontFamily: "sourcesanspro",
                                  //                     fontSize: 14,
                                  //                     fontWeight: FontWeight.bold),
                                  //               ),
                                  //             ), 
                                  //              Container(
                                  //               child: Text(
                                  //                 taxAmount==null?"(0%)":"("+taxAmount.toString()+" %)",
                                  //                 textAlign: TextAlign.center,
                                  //                 style: TextStyle(
                                  //                     color: Colors.black,
                                  //                     fontFamily: "sourcesanspro",
                                  //                     fontSize: 14,
                                  //                     fontWeight: FontWeight.bold),
                                  //               ),
                                  //             ),
                                  //           ],
                                  //         ),
                                  //         Container(
                                  //           child: Text(
                                  //             "+ ${taxFinal.toStringAsFixed(2)} BHD",
                                  //             //   "\$${(delifee).toStringAsFixed(2)}",
                                  //             textAlign: TextAlign.center,
                                  //             style: TextStyle(
                                  //                 color: Colors.black,
                                  //                 fontFamily: "sourcesanspro",
                                  //                 fontSize: 14,
                                  //                 fontWeight:
                                  //                     FontWeight.normal),
                                  //           ),
                                  //         )
                                  //       ],
                                  //     ),
                                  //   ):Container(),

                                    /////////////Shipping Cost End////////////
                                    ////////////////   Total Start   ////////////

                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          top: 10,
                                          bottom: 10),
                                      decoration: BoxDecoration(
                                          border: Border(
                                        top: BorderSide(
                                          color: Colors.grey,
                                          width: 1.5,
                                        ),
                                      )),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            child: Text(
                                              FlutterI18n.translate(context,"Total"),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "sourcesanspro",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Container(
                                            child: Text(
                                              "${grandTotal.toStringAsFixed(2)} BHD",
                                              // "\$${(totalPrice).toStringAsFixed(2)}",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: "sourcesanspro",
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    /////////////  Total End  ////////////
                                  ],
                                ),
                              ),

                              //////////////   Cards end   ///////////

                              /////////////////   Coupon Text Start ///////////

                              !_isDiscount
                                  ? GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isDiscount = true;
                                          showcart();
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 5,
                                            bottom: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                         FlutterI18n.translate(context,"Do_you_have_any_coupon")+"?",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: appTealColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    )
                                  : Container(),

                              /////////////////   Coupon Text End ///////////

                              /////////////////  Promo Textfield  Start /////////////

                              _isDiscount
                                  ? Container(
                                      //color: Colors.blue,
                                      margin: EdgeInsets.only(bottom: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            //width: 300,
                                            //   height: 30,
                                            margin: EdgeInsets.only(
                                                left: 15, top: 10, bottom: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Text(
                                                  FlutterI18n.translate(context,"Discount_Coupon_Code"),
                                                  
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      color: Color(0xFF000000),
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      _isDiscount = false;
                                                    });
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        right: 10),
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(10),
                                                      child: Text(
                                                        FlutterI18n.translate(context,"Cancel"),
                                                        
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color:
                                                                Colors.black54,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey[300],
                                                  blurRadius: 17,
                                                  //offset: Offset(0.0,3.0)
                                                )
                                              ],
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                Expanded(
                                                  child: TextField(
                                                    controller:
                                                        voucherController,
                                                    style: TextStyle(
                                                        color:
                                                            Color(0xFF000000)),
                                                    cursorColor:
                                                        Color(0xFF9b9b9b),
                                                    decoration: InputDecoration(
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20.0),
                                                              ),
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xFFFFFFFF))),
                                                      enabledBorder:
                                                          UnderlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20.0),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20.0),
                                                              ),
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xFFFFFFFF))),
                                                      hintText:  FlutterI18n.translate(context,"Type_here"),
                                                      hintStyle: TextStyle(
                                                          color:
                                                              Color(0xFF9b9b9b),
                                                          fontSize: 15,
                                                          fontFamily:
                                                              "sourcesanspro",
                                                          fontWeight:
                                                              FontWeight.w300),
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              left: 15,
                                                              bottom: 12,
                                                              top: 12),
                                                      fillColor:
                                                          Color(0xFFFFFFFF),
                                                      filled: true,
                                                    ),
                                                    onChanged: (value) {
                                                      if (voucherController
                                                              .text ==
                                                          "") {
                                                        showcart();
                                                      }
                                                      setState(() {
                                                        voucher = value;
                                                      });
                                                      showcart();
                                                      print(voucher);
                                                    },
                                                  ),
                                                ),
                                                Container(
                                                    decoration: BoxDecoration(
                                                      color: _isApplying
                                                          ? Colors.grey
                                                          : appTealColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          20.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      20.0)),
                                                    ),
                                                    height: 47,
                                                    child: FlatButton(
                                                      onPressed: () {
                                                        _isApplying
                                                            ? null
                                                            : getVoucher(
                                                                voucher);
                                                      },
                                                      child: Text(
                                                        _isApplying
                                                            ? FlutterI18n.translate(context,"Processing")+"..."
                                                            : FlutterI18n.translate(context,"Apply"),
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 17.0,
                                                          decoration:
                                                              TextDecoration
                                                                  .none,
                                                          fontFamily:
                                                              'MyriadPro',
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                      color: Colors.transparent,
                                                      //elevation: 4.0,
                                                      //splashColor: Colors.blueGrey,
                                                      shape: new RoundedRectangleBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  20.0)),
                                                    )),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  : Container(),

                              ///////////////// Promo Textfield end /////////////

                              Container(
                                child: Column(
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          getAddress();
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 5,
                                            bottom: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(right: 3),
                                              child: Text(
                                                FlutterI18n.translate(context,"Click_here_to_select_address"),
                                                
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: appTealColor,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            Icon(Icons.arrow_forward,
                                                color: appTealColor, size: 17)
                                          ],
                                        ),
                                      ),
                                    ),
                                    _isAddress == false
                                        ? Container()
                                        : Container(
                                            margin: EdgeInsets.only(
                                                bottom: 5, top: 0, left: 3),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                            ),
                                            child: GestureDetector(
                                              onTap: () {},
                                              child: Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    0, 0, 0, 0),
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 10, 0, 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey[300],
                                                        blurRadius: 17,
                                                      )
                                                    ],
                                                    color: Colors.white),
                                                child: Column(
                                                  //crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.only(
                                                          bottom: 7, left: 10),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: <Widget>[
                                                          Container(
                                                            // color: Colors.teal,
                                                            child: Row(
                                                              // mainAxisAlignment: MainAxisAlignment.center,
                                                              // crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <
                                                                  Widget>[
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: <
                                                                      Widget>[
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          1.9,
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                      child:
                                                                          Row(
                                                                        children: <
                                                                            Widget>[
                                                                          Icon(
                                                                            Icons.location_on,
                                                                            size:
                                                                                18,
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(left: 5),
                                                                            child:
                                                                                Text(
                                                                            FlutterI18n.translate(context,"Delivery_Address"),
                                                                              // "${d.quantity}x ${d.item.name}",
                                                                              textAlign: TextAlign.left,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(color: Colors.black, fontFamily: "sourcesanspro", fontSize: 16, fontWeight: FontWeight.normal),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          1.9,
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              25),
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                      child:
                                                                          Text(
                                                                        FlutterI18n.translate(context, "Address")+": $name",
                                                                        // "${d.quantity}x ${d.item.name}",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black54,
                                                                            fontFamily:
                                                                                "sourcesanspro",
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          1.9,
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              25),
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                      child:
                                                                          Text(
                                                                        FlutterI18n.translate(context, "Mobile")+": $phone",
                                                                        // "${d.quantity}x ${d.item.name}",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black54,
                                                                            fontFamily:
                                                                                "sourcesanspro",
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          1.9,
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              25),
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                      child:
                                                                          Text(
                                                                        FlutterI18n.translate(context, "Area")+": $area",
                                                                        // "${d.quantity}x ${d.item.name}",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black54,
                                                                            fontFamily:
                                                                                "sourcesanspro",
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          1.9,
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              25),
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                      child:
                                                                          Text(
                                                                        FlutterI18n.translate(context, "House")+": $house",
                                                                        // "${d.quantity}x ${d.item.name}",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black54,
                                                                            fontFamily:
                                                                                "sourcesanspro",
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          1.9,
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              25),
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                      child:
                                                                          Text(
                                                                        FlutterI18n.translate(context, "Road")+": $road",
                                                                        // "${d.quantity}x ${d.item.name}",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black54,
                                                                            fontFamily:
                                                                                "sourcesanspro",
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          1.9,
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              25),
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                      child:
                                                                          Text(
                                                                        FlutterI18n.translate(context, "Block")+": $block",
                                                                        // "${d.quantity}x ${d.item.name}",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black54,
                                                                            fontFamily:
                                                                                "sourcesanspro",
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                    city == null ||
                                                                            city ==
                                                                                ""
                                                                        ? Container()
                                                                        : Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 1.9,
                                                                            margin:
                                                                                EdgeInsets.only(left: 25),
                                                                            padding:
                                                                                EdgeInsets.only(top: 8),
                                                                            child:
                                                                                Text(
                                                                              FlutterI18n.translate(context, "City")+": $city",
                                                                              // "${d.quantity}x ${d.item.name}",
                                                                              textAlign: TextAlign.left,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(color: Colors.black54, fontFamily: "sourcesanspro", fontSize: 13, fontWeight: FontWeight.normal),
                                                                            ),
                                                                          ),
                                                                    state == null ||
                                                                            state ==
                                                                                ""
                                                                        ? Container()
                                                                        : Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width / 1.9,
                                                                            margin:
                                                                                EdgeInsets.only(left: 25),
                                                                            padding:
                                                                                EdgeInsets.only(top: 8),
                                                                            child:
                                                                                Text(
                                                                              FlutterI18n.translate(context, "State")+": $state",
                                                                              // "${d.quantity}x ${d.item.name}",
                                                                              textAlign: TextAlign.left,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: TextStyle(color: Colors.black54, fontFamily: "sourcesanspro", fontSize: 13, fontWeight: FontWeight.normal),
                                                                            ),
                                                                          ),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width /
                                                                          1.9,
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              25),
                                                                      padding: EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                      child:
                                                                          Text(
                                                                        FlutterI18n.translate(context, "State")+": $countrys",
                                                                        // "${d.quantity}x ${d.item.name}",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            color: Colors
                                                                                .black54,
                                                                            fontFamily:
                                                                                "sourcesanspro",
                                                                            fontSize:
                                                                                13,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          addNewAddress();
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 15,
                                            right: 15,
                                            top: 5,
                                            bottom: 15),
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.only(right: 3),
                                              child: Text(
                                                FlutterI18n.translate(context, "Add_your_address_now")+"+",
                                                 
                                                textAlign: TextAlign.left,
                                                style: TextStyle(
                                                    color: appTealColor,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /////////////////  Button Section Start///////////////

                              ///////////////// Back Button start///////////////

                              Container(
                                //color: Colors.yellow,
                                margin: EdgeInsets.only(top: 40),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    GestureDetector(
                                      //onTap: () => Navigator.pop(context),
                                      child: Container(
                                        padding: EdgeInsets.only(left: 20),
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18.0,
                                            //decoration: TextDecoration.underline,
                                            fontFamily: 'MyriadPro',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        color: Colors.transparent,
                                      ),
                                    ),

                                    ///////////////// Back Button end ///////////////

                                    ///////////////// Check out Button Start///////////////

                                    Container(
                                        decoration: BoxDecoration(
                                          color: appTealColor,
                                          //widget.totalItem.length < 1
                                          //     ? Colors.grey
                                          // :

                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20.0)),
                                        ),
                                        //width: 200,
                                        padding: EdgeInsets.only(
                                            left: 15, right: 15),
                                        height: 42,
                                        child: FlatButton(
                                          onPressed: () {
                                            if (_isLoggedIn == false) {
                                              Navigator.push(
                                                  context,
                                                  SlideLeftRoute(
                                                      page: LogInPage("4")));
                                            } else {

                                           
                                              if (name == "" ||
                                                  phone == "" ||
                                                  area == "" ||
                                                  house == "" ||
                                                  road == "" ||
                                                  block == "" ||
                                                //  city == "" ||
                                                  
                                                  countryName == "") {
                                                      // print(_isAddress);
                                                _showToast(10);
                                              }

                                              else if(grandTotal<5){
                                               _showMsg("Your_order_must_be_5BHD_or_more_to_be_able_to_checkout");
                                              }
                                              
                                               else {

                                                 print("check");  
                                                for (var d in  cartInfo) {

                                                  print(d.combinationId);

                                                }
                                                Navigator.push(
                                                    context,
                                                    SlideLeftRoute(
                                                        page: CheckOut(
                                                            subTotal,
                                                            shippingCost,
                                                            grandTotal,
                                                            userDiscount,   
                                                            cartInfo,
                                                            phone,
                                                            area,
                                                            house,
                                                            road,
                                                            block,
                                                            city,
                                                            state,
                                                            countrys,
                                                            voucherData)));
                                              }
                                            }
                                          },
                                          //  widget.totalItem.length < 1 ||
                                          //         _isCheckingOut
                                          //     ? null
                                          //     :  _pay,  //_pay, //_checkOut,
                                          child: Text(
                                             FlutterI18n.translate(context, "Check_Out"),
                                                                              
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0,
                                              decoration: TextDecoration.none,
                                              fontFamily: 'MyriadPro',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          color: Colors.transparent,
                                          //elevation: 4.0,
                                          //splashColor: Colors.blueGrey,
                                          shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      20.0)),
                                        )),

                                    ///////////////// Check out Button End///////////////
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
    );
  }

  showcart() {

   
    setState(() {
      priceTotal = 0;
      grandTotal = 0;
     // cartData = json.decode(localbestProductsData);
      for (int i = 0; i < cartDataNew.length; i++) {
        double q = (cartDataNew[i].quantity).toDouble();
        print("q"); // *
        print(q); // *
      //   double proDis = cartDataNew[i].product.discount.toDouble();
      //   double proPrice = proDis / 100;
      //   double p = (cartDataNew[i].price) -
      //       ((cartDataNew[i].price) * proPrice);

      //       print("(q * p)");
      //       print((q * p));
      //       print("priceTotal1");
      // print(priceTotal);
        priceTotal =priceTotal + (q * cartDataNew[i].price);
          subTotal = priceTotal;
          print("priceTotal2");
      print(priceTotal);
      }

    
    

      print("subtotal");
      print(subTotal);
      print("flash");
      print(_isFlashsale);
      
      grandTotal = priceTotal + shippingCost - discount;

      if (totalDiscount == 0 || totalDiscount == null) {
        discountCost = 0.0;
      } else {
        double dis = totalDiscount.toDouble();
        dis /= 100.0;
        discountCost = priceTotal * dis;
        //discountCost = priceTotal - price;
        print(discountCost);
      }

      grandTotal = priceTotal + shippingCost - discountCost - newDisc;

      if (discountDetails == null) {
        String disc = "0.0";
        userDisc = double.parse(disc);
        newDisc = (userDisc / 100) * priceTotal;
        double priceNew = priceTotal - newDisc;
          setState(() {
          grandTotal = priceNew + shippingCost - discountCost;
      });
      } else if (discountDetails.discountValidity == null) {
          print("i am in discount dis validity null");
     
        String disc = "0.0";
        userDisc = double.parse(disc);
        newDisc = (userDisc / 100) * priceTotal;
        double priceNew = priceTotal - newDisc;
        print(priceNew);
          setState(() {
          grandTotal = priceNew + shippingCost - discountCost;
      });
      } else {

        print("i am in discount dis validity");
        print(_isFlashsale);
        String date = discountDetails.discountValidity;
        var date2 = DateTime.parse(date);
        var date3 = DateTime.parse(curDate);

        if (_isFlashsale == false) {
          if (date3.isAfter(date2)) {
            print("ok");
            // String disc = userData['discount'];
            // userDisc = double.parse(disc);
            // newDisc = (userDisc / 100) * priceTotal;
            double priceNew = priceTotal - newDisc;
              setState(() {
          grandTotal = priceNew + shippingCost - discountCost;
      });
          } else {
            print("not ok");
            String disc = discountDetails.discount;
            print("dusc");
            //  print(priceNew);
            userDisc = double.parse(disc);
            newDisc = (userDisc / 100) * priceTotal;
            double priceNew = priceTotal - newDisc;

            // print("priceNew");
            // print(priceNew);
              setState(() {
          grandTotal = priceNew + shippingCost - discountCost;
      });
          }
        } else {
          print("flashhhhhhhhhhhh");
           print("priceTotal");
              print(priceTotal);
          double priceNew = priceTotal - newDisc;
            setState(() {
              subTotal = priceNew;
              print("subTotal");
              print(subTotal);
              priceTotal = subTotal;
          grandTotal = priceNew + shippingCost - discountCost;
      });
        }

        //print(currentDate.isBefore(date2)); // => true
      }
    });
  }

  updateCart(cartInfo) async {
    var data = {
      "userId": userData['id'],
      "productId": cartInfo.product.id,
      "combinationId": cartInfo.combinationId,
      "combination": cartInfo.combination,
      "quantity": cartInfo.quantity,
      "id": cartInfo.id
    };

    print("cart");
    print(cartInfo.quantity);
    print(cartDataNew);

    showcart();

    print(data);

    var res = await CallApi()
        .postData(data, '/app/updateCart/${cartInfo.id}?token=$token');

    if (res != null) {
      var body = json.decode(res.body);
      print(body);
      priceTotal = 0.0;
      // _newCartlist();
      // getCartInfo(token);
      // priceTotal = 0.0;
    }
  }

  deleteCart(int index) async {
    var id = cartInfo[index].id;
    print("before");
    print(cartDataNew.length);

    var res = await CallApi().getData1('/app/deleteCart/$id');
    print(res);

    if (res != null) {
      var body = json.decode(res.body);
      print(body);

      _cart = true;
      // getCartInfo(token);

      setState(() {
        print("index");
        print(index);
        cartDataNew.removeAt(index);
        cartInfo.removeAt(index);
        print("after");
        print(cartDataNew.length);
        showcart();
      });

      // priceTotal = 0.0;
      _showToast(2);
    }
  }

  void _showDeleteAlert(int index) {
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
                    FlutterI18n.translate(context, "Are_you_sure_you_want_to_remove_this_item_from_cart")+"?",
                    
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
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        deleteCart(index);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 80,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: appTealColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child:
                            Text(FlutterI18n.translate(context, "Yes"), style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.center,
                        width: 80,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: appTealColor),
                            borderRadius:
                                BorderRadius.all(Radius.circular(50))),
                        child:
                            Text(FlutterI18n.translate(context, "No"), style: TextStyle(color: appTealColor)),
                      ),
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
}
