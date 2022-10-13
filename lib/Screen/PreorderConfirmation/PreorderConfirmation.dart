import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/Form/LoginForm/LogInPage.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/CartPage/AddedItems.dart';
import 'package:ecommerce_bokkor_dev/Screen/CheckOut/CheckOut.dart';
import 'package:ecommerce_bokkor_dev/Screen/PreorderPage/preorderPage.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:ecommerce_bokkor_dev/model/AddressModel/addressModel.dart';
import 'package:ecommerce_bokkor_dev/model/CartModel/cartModel.dart';
import 'package:ecommerce_bokkor_dev/model/DiscountModel/discountModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class PreorderConfirmation extends StatefulWidget {
  final newPreorder;
  PreorderConfirmation(this.newPreorder);

  @override
  _PreorderConfirmationState createState() => _PreorderConfirmationState();
}

class _PreorderConfirmationState extends State<PreorderConfirmation> {
  bool _isDiscount = false;
  bool _isAddress = false;
  bool _iscoupon = false;
  bool _cart = false;
  bool _data = false;
  bool _isPreordered = false;
  var voucherData;
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
      discount = 0,
      deliveryAddress = 0;
  double priceTotal = 0.0,
      allTotal = 0.0,
      shippingCost = 0.0,
      discountCost = 0.0,
      grandTotal = 0.0,
      initPrice = 0.0,
      prices = 0.0,
      userDisc = 0.0,
      newDisc = 0.0,
      productprice = 0.0;
  bool _isLoggedIn = false;
  bool _isLoading = false;
  bool _isFlashsale = true;
  bool _isApplying = false;
  bool _isValid = false;
  bool preorderDone = false;
  String countryName = "";
  List contList = [];
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
    String pr = widget.newPreorder.product.price;
    productprice = double.parse(pr);
    allTotal = productprice * widget.newPreorder.quantity;
    _currentDate();
    _getUserInfo();

    // getcartList(key);
    // getmycartList(cartkey);
    String counName = "";
    for (int i = 0; i < country.length; i++) {
      contList.add("${country[i]['name']}");

      setState(() {
        if (country[i]['name'] == "Bahrain") {
          counName = "${country[i]['name']}";
        }
      });
    }

    print(contList);

    print("counName");
    print(counName);

    _dropDownCountryItems = getDropDownCountryItems();
    setState(() {
      countryName = counName;
    });

    print(countryName);

    super.initState();
  }

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

    setState(() {
      _isLoading = false;
    });
  }

  void _newDiscount() {
    var newDiscount = DiscountModel.fromJson(body2);
    if (!mounted) return;
    setState(() {
      discountDetails = newDiscount.user;
      print("discountDetails.discount");
      print(discountDetails.discount);
    });  

    //getCartInfo(token);
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
          //getShippingCost();
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
        area = '';
        house = '';
        road = '';
        block = '';
        city = '';
        state = '';
        countrys = '';
        _isAddress = false;
      } else {
        if (newAddList.length == 0) {
          _isAddress = false;
        } else {
          name = addressList[0].name;
          phone = addressList[0].mobile;
          area = addressList[0].area;
          house = addressList[0].house;
          road = addressList[0].road;
          block = addressList[0].block;
          city = addressList[0].city;
          state = addressList[0].state;
          countrys = addressList[0].country;
          deliveryAddress = addressList[0].id;
          _isAddress = true;
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
                          new Text(FlutterI18n.translate(context,"Delivery_Addresses")),
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
                    child: Text(FlutterI18n.translate(context,"No_address_yet")+"!"),
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
                          new Text(FlutterI18n.translate(context,"Add_New_Address")),
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

                      editinfo('Mobile', '', mobileController,
                          TextInputType.number, true),

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
                                FlutterI18n.translate(context,"Country"),
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
                                      _isLoading ? FlutterI18n.translate(context,"Please wait")+"..." : FlutterI18n.translate(context,"Add"),
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
        userData['area'] = areaController.text;
        userData['house'] = houseController.text;
        userData['road'] = roadController.text;
        userData['block'] = blockController.text;
        userData['city'] = cityController.text;
        userData['state'] = stateController.text;
        userData['country'] = countryName;

        newAddList.add({
          "name": nameController.text,
          "mobile": mobileController.text,
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

      print("newAddList 1");
      print(newAddList);

      Navigator.pop(context);

      _showMessage();
    } else if (body['message'].contains('SQLSTATE[23000]')) {
      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _showMsg("Something went wrong");
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
            print(newAddList);
            setState(() {
              _isAddress = true;
              name = "${newAddList['name']}";
              phone = "${newAddList['mobile']}";
              area = "${newAddList['area']}";
              house = "${newAddList['house']}";
              road = "${newAddList['road']}";
              block = "${newAddList['block']}";   
              city = "${newAddList['city']}";
              state = "${newAddList['state']}";
              countrys = "${newAddList['coun']}";
              deliveryAddress = newAddList['id'];
            });
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
                                              FlutterI18n.translate(context,"Address")+" : ${newAddList['name']}",
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
                                    FlutterI18n.translate(context,"Mobile")+": ${newAddList['mobile']}",
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
                                     FlutterI18n.translate(context,"Area")+": ${newAddList['area']}",
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
                                    FlutterI18n.translate(context,"House")+": ${newAddList['house']}",
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
                                    FlutterI18n.translate(context,"Road")+": ${newAddList['road']}",
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
                                    FlutterI18n.translate(context,"Block")+": ${newAddList['block']}",
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

  _showToast(int number) {
    Fluttertoast.showToast(
        msg: number == 22
            ? "Out of stock"
            : number == 21
                ? "Please add a promo code!"
                : number == 20
                    ? "Something went wrong!"
                    : number == 1
                        ? "Promo code accepted"
                        : number == 2
                            ? "Deleted successfully"
                            : number == 3
                                ? "You already used this Promo Code!"
                                : number == 4
                                    ? "Promo code expired!"
                                    : number == 5
                                        ? "Invalid Promo code!"
                                        : "Please select an address!",
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
        msg: "Address added successfully",
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

  Future<bool> _onWillPop() async {
    Navigator.push(context, SlideRightRoute(page: PreorderPage()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appTealColor,
          automaticallyImplyLeading: false,
          title: Center(
            child: Container(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(FlutterI18n.translate(context,"Confirm Pre-order"),
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
          leading: BackButton(),
        ),
        body: _isLoading == true
            ? Center(
                child: CircularProgressIndicator(),
              )
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
                                margin:
                                    EdgeInsets.only(bottom: 0, top: 0, left: 0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0)),
                                ),
                                child: Container(
                                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(0),
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
                                        padding: EdgeInsets.only(bottom: 7),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Container(
                                              // color: Colors.teal,
                                              child: Row(
                                                // mainAxisAlignment: MainAxisAlignment.center,
                                                // crossAxisAlignment: CrossAxisAlignment.center,
                                                children: <Widget>[
                                                  Container(
                                                    alignment: Alignment.center,
                                                    margin: EdgeInsets.only(
                                                        right: 10.0, left: 10),
                                                    child: ClipOval(
                                                        child: Image.network(
                                                      '${widget.newPreorder.product.image}',
                                                      height: 50,
                                                      width: 50,
                                                      fit: BoxFit.cover,
                                                    )),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 8),
                                                        child: Text(
                                                          "${widget.newPreorder.product.name}",
                                                          // "${d.quantity}x ${d.item.name}",
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  "sourcesanspro",
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5,
                                                                bottom: 3),
                                                        child: Text(
                                                          widget.newPreorder
                                                                          .combinationId ==
                                                                      "0" ||
                                                                  widget.newPreorder
                                                                          .combinationId ==
                                                                      "" ||
                                                                  widget.newPreorder
                                                                          .combinationId ==
                                                                      null
                                                              ? FlutterI18n.translate(context,"No Combination")
                                                              : "${widget.newPreorder.combinationId} ",
                                                          // "${d.quantity}x ${d.item.name}",
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black54,
                                                              fontFamily:
                                                                  "sourcesanspro",
                                                              fontSize: 13,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 0,
                                                                bottom: 3),
                                                        child: Row(
                                                          children: <Widget>[
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  widget
                                                                      .newPreorder
                                                                      .quantity--;
                                                                  if (widget
                                                                          .newPreorder
                                                                          .quantity <
                                                                      1) {
                                                                    widget
                                                                        .newPreorder
                                                                        .quantity = 1;
                                                                  }
                                                                  updateReservation(
                                                                      widget
                                                                          .newPreorder
                                                                          .id,
                                                                      widget
                                                                          .newPreorder
                                                                          .quantity);
                                                                  allTotal = productprice *
                                                                      widget
                                                                          .newPreorder
                                                                          .quantity;
                                                                });
                                                              },
                                                              child: Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child: Icon(
                                                                    Icons
                                                                        .remove,
                                                                    size: 18,
                                                                    color: Colors
                                                                        .black45,
                                                                  )),
                                                            ),
                                                            Container(
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      left: 5,
                                                                      right: 5),
                                                              child: Text(
                                                                widget.newPreorder
                                                                            .quantity ==
                                                                        0
                                                                    ? ""
                                                                    : "${widget.newPreorder.quantity} ",
                                                                // "${d.quantity}x ${d.item.name}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey,
                                                                    fontFamily:
                                                                        "sourcesanspro",
                                                                    fontSize:
                                                                        13.5,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal),
                                                              ),
                                                            ),
                                                            GestureDetector(
                                                              onTap: () {
                                                                setState(() {
                                                                  widget
                                                                      .newPreorder
                                                                      .quantity++;

                                                                  updateReservation(
                                                                      widget
                                                                          .newPreorder
                                                                          .id,
                                                                      widget
                                                                          .newPreorder
                                                                          .quantity);

                                                                  allTotal = productprice *
                                                                      widget
                                                                          .newPreorder
                                                                          .quantity;
                                                                });
                                                              },
                                                              child: Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  child: Icon(
                                                                    Icons.add,
                                                                    size: 18,
                                                                    color: Colors
                                                                        .black45,
                                                                  )),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3,
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 0,
                                                                bottom: 3),
                                                        child: Text(
                                                          widget.newPreorder
                                                                      .status ==
                                                                  ""
                                                              ? FlutterI18n.translate(context,"Status")+FlutterI18n.translate(context,":"+"NA")
                                                              : FlutterI18n.translate(context,"Status")+": ${widget.newPreorder.status} ",
                                                          // "${d.quantity}x ${d.item.name}",
                                                          textAlign:
                                                              TextAlign.left,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: TextStyle(
                                                              color: appColor,
                                                              fontFamily:
                                                                  "sourcesanspro",
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                      ),
                                                      // Container(
                                                      //   margin: EdgeInsets
                                                      //       .only(
                                                      //           top: 3),
                                                      //   child: SmoothStarRating(
                                                      //       allowHalfRating:
                                                      //           false,
                                                      //       onRatingChanged:
                                                      //           null,
                                                      //       starCount:
                                                      //           5,
                                                      //       rating:
                                                      //           ratinglist[
                                                      //               index],
                                                      //       size: 14.0,
                                                      //       color: Color(
                                                      //           0xFFFD68AE),
                                                      //       borderColor:
                                                      //           Colors
                                                      //               .grey,
                                                      //       spacing:
                                                      //           0.0),
                                                      // ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Row(
                                                children: <Widget>[
                                                  Container(
                                                      margin: EdgeInsets.only(
                                                          right: 15),
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Text(
                                                        "${productprice.toStringAsFixed(2)} BHD",
                                                        style: TextStyle(
                                                            color: appTealColor,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              ////////////  Cart Details Card end  ///////////

                              ////////////////   Total Start   ////////////

                              Container(
                                padding: EdgeInsets.only(
                                    left: 20, right: 20, top: 10, bottom: 10),
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
                                      margin: EdgeInsets.only(top: 0),
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
                                      margin: EdgeInsets.only(top: 0),
                                      child: Text(
                                        "${allTotal.toStringAsFixed(2)} BHD",
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
                                      left: 15, right: 15, top: 5, bottom: 15),
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
                                              fontWeight: FontWeight.bold),
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
                                            bottomLeft: Radius.circular(10),
                                            bottomRight: Radius.circular(10)),
                                      ),
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 0, 0),
                                          padding:
                                              EdgeInsets.fromLTRB(0, 10, 0, 10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
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
                                                        children: <Widget>[
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    1.9,
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 8),
                                                                child: Row(
                                                                  children: <
                                                                      Widget>[
                                                                    Icon(
                                                                      Icons
                                                                          .location_on,
                                                                      size: 18,
                                                                    ),
                                                                    Container(
                                                                      margin: EdgeInsets.only(
                                                                          left:
                                                                              5),
                                                                      child:
                                                                          Text(
                                                                        FlutterI18n.translate(context,"Delivery Address"),
                                                                        // "${d.quantity}x ${d.item.name}",
                                                                        textAlign:
                                                                            TextAlign.left,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
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
                                                                  ],
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    1.9,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 8),
                                                                child: Text(
                                                                  FlutterI18n.translate(context,"Address Name")+": $name",
                                                                  // "${d.quantity}x ${d.item.name}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          "sourcesanspro",
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    1.9,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 8),
                                                                child: Text(
                                                                  FlutterI18n.translate(context,"Mobile")+": $phone",
                                                                  // "${d.quantity}x ${d.item.name}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          "sourcesanspro",
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    1.9,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 8),
                                                                child: Text(
                                                                  FlutterI18n.translate(context,"Area")+": $area",
                                                                  // "${d.quantity}x ${d.item.name}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          "sourcesanspro",
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    1.9,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 8),
                                                                child: Text(
                                                                  FlutterI18n.translate(context,"House")+": $house",
                                                                  // "${d.quantity}x ${d.item.name}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          "sourcesanspro",
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    1.9,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 8),
                                                                child: Text(
                                                                  FlutterI18n.translate(context,"Road")+": $road",
                                                                  // "${d.quantity}x ${d.item.name}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          "sourcesanspro",
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    1.9,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 8),
                                                                child: Text(
                                                                  FlutterI18n.translate(context,"Block")+": $block",
                                                                  // "${d.quantity}x ${d.item.name}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          "sourcesanspro",
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
                                                                ),
                                                              ),
                                                              city == null ||
                                                                      city ==
                                                                          "null"
                                                                  ? Container()
                                                                  : Container(
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
                                                                        FlutterI18n.translate(context,"City")+": $city",
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
                                                              state == null ||
                                                                      state ==
                                                                          "null"
                                                                  ? Container()
                                                                  : Container(
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
                                                                       FlutterI18n.translate(context,"State") +": $state",
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
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    1.9,
                                                                margin: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            25),
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        top: 8),
                                                                child: Text(
                                                                  FlutterI18n.translate(context,"Country")+": $countrys",
                                                                  // "${d.quantity}x ${d.item.name}",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .left,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black54,
                                                                      fontFamily:
                                                                          "sourcesanspro",
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal),
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
                                      left: 15, right: 15, top: 5, bottom: 15),
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        margin: EdgeInsets.only(right: 3),
                                        child: Text(
                                          FlutterI18n.translate(context,"Add your address now"+"+"),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: appTealColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                    color: _isPreordered || preorderDone
                                        ? Colors.grey
                                        : appTealColor,
                                    //widget.totalItem.length < 1
                                    //     ? Colors.grey
                                    // :

                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20.0)),
                                  ),
                                  //width: 200,
                                  padding: EdgeInsets.only(left: 15, right: 15),
                                  height: 42,
                                  child: FlatButton(
                                    onPressed: () {
                                      if (_isPreordered == false ||
                                          preorderDone == true) {
                                        if (_isLoggedIn == false) {
                                          Navigator.push(
                                              context,
                                              SlideLeftRoute(
                                                  page: LogInPage("4")));
                                        } else {
                                          if (name == "" || name == null ||
                                              phone == "" || phone == null ||
                                              area == "" || area == null ||
                                              house == "" ||house == null ||
                                              road == "" || road == null ||
                                              block == "" || block == null ||
                                              city == "" ||city == null ||
                                              state == "" ||  state == null ||
                                              country == "" || country == null || 
                                              deliveryAddress == "" || deliveryAddress == null) {
                                            _showToast(10);
                                          } else {
                                            confirmReservation(
                                                widget.newPreorder.id,
                                                widget.newPreorder.quantity);
                                          }
                                        }
                                      }
                                    },
                                    child: Text(
                                      preorderDone == true
                                          ?FlutterI18n.translate(context,"Done") 
                                          : _isPreordered
                                              ? FlutterI18n.translate(context,"Please wait"+"...")
                                              : FlutterI18n.translate(context,"Confirm Pre-order"),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
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
                                            new BorderRadius.circular(20.0)),
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
      ),
    );
  }

  void _showPreorderDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Image.network(
                        '${widget.newPreorder.product.image}',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      )),
                  Expanded(
                    child: Container(
                        child: Text("${widget.newPreorder.product.name}")),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      FlutterI18n.translate(context,"Stock"+":"),
                      style: TextStyle(fontSize: 13, color: Colors.black45),
                    ),
                    Text(
                      "${widget.newPreorder.product.stock}",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      FlutterI18n.translate(context,"Quantity"+":"),
                      style: TextStyle(fontSize: 13, color: Colors.black45),
                    ),
                    Text(
                      "${widget.newPreorder.quantity}",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      FlutterI18n.translate(context,"Total Amount"+":"),
                      style: TextStyle(fontSize: 13, color: Colors.black45),
                    ),
                    Text(
                      "${allTotal.toStringAsFixed(2)}",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey[400],
              ),
              Text(
                FlutterI18n.translate(context,"Your Pre-order has been confirmed successfully"+"!"),
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            Container(
              //color: appTealColor,

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 5),
                    child: FlatButton(
                      //highlightColor: appTealColor,
                      color: appTealColor,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0)),
                      child: new Text(
                        "OK",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                            context, SlideLeftRoute(page: PreorderPage()));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  confirmReservation(id, quantity) async {

    //print("preorder");
    setState(() {
      _isPreordered = true;
    });

    print(quantity);
    print(deliveryAddress);

    var data = {
      "quantity": quantity,
      "deliveryAddId": deliveryAddress,
      "status": "Confirmed",
    };

    print(data);

    var res = await CallApi()
        .postData(data, '/app/updateReservation/$id?token=$token');

    if (res != null) {
      var body = json.decode(res.body);
      print(body);

      if (res.statusCode == 200) {
        //_showPreorderDialog();
        _showDoneToast();
        setState(() {
          print("Done");
          preorderDone = true;
        });
      } else {
        print("Not Done");
      }
  }

    setState(() {
      _isPreordered = false;
    });
  }

  _showDoneToast() {
    Navigator.push(context, SlideLeftRoute(page: PreorderPage()));
    Fluttertoast.showToast(
        msg: "Your Pre-order has been confirmed successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: appTealColor.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 13.0);
  }

  updateReservation(id, quantity) async {
    var data = {
      "quantity": quantity,
    };

    var res = await CallApi()
        .postData(data, '/app/updateReservation/$id?token=$token');

    if (res != null) {
      var body = json.decode(res.body);
      print(body);

      if (res.statusCode == 200) {
        setState(() {
          print("Done");
        });
      } else {
        print("Not Done");
      }
    }
  }

  showcart() {
    setState(() {
      priceTotal = 0;
      grandTotal = 0;
      // cartData = json.decode(localbestProductsData);
      for (int i = 0; i < cartDataNew.length; i++) {
        double q = (cartDataNew[i].quantity).toDouble();
        print(q); // *
        double proDis = cartDataNew[i].product.discount.toDouble();
        double proPrice = proDis / 100;
        double p = (double.parse((cartDataNew[i].product.price)) -
            (double.parse(cartDataNew[i].product.price)) * proPrice);
        priceTotal =
            //  priceTotal + q * double.parse((cartDataNew[i].product.price));
            //  priceTotal + q * double.parse((cartDataNew[i].product.price));
            priceTotal + q * p;
      }

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
        grandTotal = priceNew + shippingCost - discountCost;
      } else if (discountDetails.discountValidity == null) {
        String disc = "0.0";
        userDisc = double.parse(disc);
        newDisc = (userDisc / 100) * priceTotal;
        double priceNew = priceTotal - newDisc;
        grandTotal = priceNew + shippingCost - discountCost;
      } else {
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
            grandTotal = priceNew + shippingCost - discountCost;
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
            grandTotal = priceNew + shippingCost - discountCost;
          }
        } else {
          double priceNew = priceTotal - newDisc;
          grandTotal = priceNew + shippingCost - discountCost;
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
                    FlutterI18n.translate(context,"Are you sure you want to remove this item from cart"+"?"),
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
                            Text(FlutterI18n.translate(context,"Yes"), style: TextStyle(color: Colors.white)),
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
                            Text(FlutterI18n.translate(context,"No"), style: TextStyle(color: appTealColor)),
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
