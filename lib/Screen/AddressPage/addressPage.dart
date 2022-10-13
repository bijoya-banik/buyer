import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/Form/LoginForm/LogInPage.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/AddAddressPage/addAddressPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/AddressEditPage/addressEditPage.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:ecommerce_bokkor_dev/model/AddressModel/addressModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressPage extends StatefulWidget {
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  var addressList;
  bool _isLoading = true, _isLoggedIn = false;
  var body;
  String userToken = "";
  double price = 0.0, rating = 0.0, prices = 0.0;
  int discount = 0;
  var body1;
  bool _loading = false;
  List<String> addressDelList = [];
  List<double> ratinglist = [];

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    if (token != null) {
      setState(() {
        userToken = token;
        _isLoggedIn = true;
      });
    }
    print("userToken");
    print(userToken);
    _showAddresslist();
  }

  /////// <<<<< Wishlist start >>>>> ///////

  Future<void> _showAddresslist() async {
    var res = await CallApi()
        .getData('/app/showAllDeliveryAddress?token=' + userToken);
    body = json.decode(res.body);

    print(body);

    if (res.statusCode == 200) {
      _newAddresslist();
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _newAddresslist() {
    var newAddresslist = AddressModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      addressList = newAddresslist.address;
    });
  }

  ////// <<<<< Wishlist end >>>>> //////
  ///
  Future<bool> _onWillPop() async {
    Navigator.push(context, SlideLeftRoute(page: Navigation(3)));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
          title:  Text(FlutterI18n.translate(context, "Saved_Address")),
          actions: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(context, SlideLeftRoute(page: AddAddressPage()));
              },
              child: Container(
                  padding: EdgeInsets.all(15),
                  child: Icon(Icons.add, color: Colors.white)),
            )
          ],
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SafeArea(
                child: _isLoggedIn == false
                    ? Center(
                        child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(FlutterI18n.translate(context, "Login_to_your_account"),),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    SlideLeftRoute(page: LogInPage(3)));
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
                    : addressList.length == 0
                        ? Center(
                            child: Container(
                            child: Text(FlutterI18n.translate(context, "No_address_yet")),
                          ))
                        : SingleChildScrollView(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children:
                                    List.generate(addressList.length, (index) {
                                  return addressDelList
                                          .contains(addressList[index].id)
                                      ? Container()
                                      : Container(
                                          margin: EdgeInsets.only(
                                              bottom: 5, top: 0, left: 3),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.only(
                                                bottomLeft: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                          ),
                                          child: Container(
                                            margin:
                                                EdgeInsets.fromLTRB(0, 7, 0, 0),
                                            padding: EdgeInsets.fromLTRB(
                                                0, 10, 0, 10),
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
                                                              children: <
                                                                  Widget>[
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      1.9,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Icon(
                                                                        Icons
                                                                            .location_on,
                                                                        size:
                                                                            18,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              EdgeInsets.only(left: 5),
                                                                          child:
                                                                              Text(
                                                                           FlutterI18n.translate(context, "Address")+": ${addressList[index].name}",
                                                                            // "${d.quantity}x ${d.item.name}",
                                                                            textAlign:
                                                                                TextAlign.left,
                                                                            overflow:
                                                                                TextOverflow.ellipsis,
                                                                            style: TextStyle(
                                                                                color: Colors.black,
                                                                                fontFamily: "sourcesanspro",
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.normal),
                                                                          ),
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
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                  child: addressList[index].country_code==null?
                                                                  Text(""):
                                                                  Text(
                                                                  
                                                                    FlutterI18n.translate(context, "Mobile")+": ${addressList[index].country_code}"+"${addressList[index].mobile}",
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
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                  child: Text(
                                                                     FlutterI18n.translate(context, "Area")+": ${addressList[index].area}",
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
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                  child: Text(
                                                                   FlutterI18n.translate(context, "House")+": ${addressList[index].house}",
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
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                  child: Text(
                                                                   FlutterI18n.translate(context, "Road")+": ${addressList[index].road}",
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
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                  child: Text(
                                                                    FlutterI18n.translate(context, "Block")+": ${addressList[index].block}",
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
                                                                            FontWeight.normal),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        child: Row(
                                                          children: <Widget>[
                                                            // Container(
                                                            //   child: IconButton(
                                                            //     icon: Icon(
                                                            //       Icons
                                                            //           .shopping_cart,
                                                            //       color:
                                                            //           appTealColor,
                                                            //     ),
                                                            //     onPressed: () {
                                                            //       addToCart(
                                                            //           newWish[
                                                            //               index]);
                                                            //     },
                                                            //   ),
                                                            // ),

                                                            Container(
                                                              child: IconButton(
                                                                icon: Icon(
                                                                  Icons.edit,
                                                                  color:
                                                                      appTealColor,
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              AddressEditPage(addressList[index])));
                                                                },
                                                              ),
                                                            ),
                                                            Container(
                                                              child: IconButton(
                                                                icon: Icon(
                                                                  Icons.delete,
                                                                  color:
                                                                      appTealColor,
                                                                ),
                                                                onPressed: () {
                                                                  _showDeleteAlert(
                                                                      index);
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                }),
                              ),
                            ),
                          ),
              ),
      ),
    );
  }

  deleteAddressList(id) async {
    setState(() {
      _loading = true;
    });

    var res = await CallApi()
        .getData1('/app/deleteDeliveryAddress/$id?token=$userToken');

    body1 = json.decode(res.body);

    print(body1);

    if (body1['success'] == true) {
      setState(() {
        addressDelList.add("$id");
        _showAddresslist();

        print(addressList.length);
      });
    }

    _showToast();

    setState(() {
      _loading = false;
    });
  }

  _showToast() {
    Fluttertoast.showToast(
        msg: FlutterI18n.translate(context, "Deleted_successfully"),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: appTealColor.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 13.0);
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
                    FlutterI18n.translate(context, "Are_you_sure_you_want_to_remove_this_address"),
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
                        deleteAddressList(addressList[index].id);
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
