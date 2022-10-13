import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/Screen/OrderHistory/OrderHistoryCard.dart';
import 'package:ecommerce_bokkor_dev/Screen/PreorderConfirmation/PreorderConfirmation.dart';
import 'package:ecommerce_bokkor_dev/Screen/PreorderPage/preorderCard.dart';
import 'package:ecommerce_bokkor_dev/Screen/PreorderPage/preorderDetails.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductDetails/ProductDetails.dart';
import 'package:ecommerce_bokkor_dev/Screen/SubCategory/SubCategoryCard.dart';
import 'package:ecommerce_bokkor_dev/Screen/WishDetails/wishDetails.dart';
import 'package:ecommerce_bokkor_dev/model/OrderModel/orderModel.dart';
import 'package:ecommerce_bokkor_dev/model/PreorderModel/preorderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../BottomNav/BottomNav.dart';
import '../../NavigationAnimation/routeTransition/routeAnimation.dart';
import '../../main.dart';

class PreorderPage extends StatefulWidget {
  @override
  _PreorderPageState createState() => new _PreorderPageState();
}

class _PreorderPageState extends State<PreorderPage> {
  var newPreorder;
  bool _isLoading = true, _isLoggedIn = false;
  var body;
  String userToken = "";
  double price = 0.0, rating = 0.0, prices = 0.0;
  int discount = 0;
  var body1;
  bool _loading = false;
  List<String> wishDelList = [];
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
    _showPreorderlist();
  }

  Future<void> _showPreorderlist() async {
    var res =
        await CallApi().getData('/app/showReservation?token=' + userToken);
    body = json.decode(res.body);

    print(body);

    if (res.statusCode == 200) {
      _getPreorderlist();
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _getPreorderlist() {
    var newOrders = PreorderModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      newPreorder = newOrders.reservation;
      for (int i = 0; i < newPreorder.length; i++) {
        if (newPreorder[i].product.average != null) {
          String rate = newPreorder[i].product.average.averageRating;
          rating = double.parse(rate);
        } else {
          rating = 0.0;
        }
        String rr = rating.toStringAsFixed(1);
        rating = double.parse(rr);
        ratinglist.add(rating);
      }
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
          title:  Text(FlutterI18n.translate(context, "Pre_order"),),
        ),
        //body: new Text("It's a Dialog!"),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : newPreorder.length == 0
                ? Center(
                    child: Container(
                    child: Text(FlutterI18n.translate(context, "No_Pre_orders_yet")+"!"),
                  ))
                : SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: List.generate(newPreorder.length, (index) {
                          discount = newPreorder[index].product.discount;
                          String pr = newPreorder[index].product.price;
                          double pricess = double.parse(pr);
                          double dis = discount / 100;
                          double pp = pricess.toDouble();
                          prices = (pp * dis);
                          prices = pricess - prices;
                          print(newPreorder[index].id);
                          print(wishDelList);
                          int quant = newPreorder[index].quantity;
                          return wishDelList.contains(newPreorder[index].id)
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
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ProductsDetailsPage(
                                                      newPreorder[index]
                                                          .product
                                                          .id,
                                                      newPreorder[index]
                                                          .quantity)));
                                    },
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
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
                                            padding: EdgeInsets.only(bottom: 7),
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
                                                      Container(
                                                        alignment:
                                                            Alignment.center,
                                                        margin: EdgeInsets.only(
                                                            right: 10.0,
                                                            left: 10),
                                                        child: ClipOval(
                                                            child:
                                                                Image.network(
                                                          '${newPreorder[index].product.image}',
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
                                                             FlutterI18n.translate(context, "Pre_Order_Id")+": ${newPreorder[index].product.id}",
                                                              // "${d.quantity}x ${d.item.name}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color: appColor,
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
                                                                    top: 6),
                                                            child: Text(
                                                              "${newPreorder[index].product.name}",
                                                              // "${d.quantity}x ${d.item.name}",
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
                                                              newPreorder[index]
                                                                              .combinationId ==
                                                                          "0" ||
                                                                      newPreorder[index]
                                                                              .combinationId ==
                                                                          "" ||
                                                                      newPreorder[index]
                                                                              .combinationId ==
                                                                          null
                                                                  ?FlutterI18n.translate(context, "No_Combination")
                                                                  : "${newPreorder[index].combinationId} ",
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
                                                                  fontSize: 13,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ),
                                                          newPreorder[index]
                                                                      .status !=
                                                                  "Pending"
                                                              ? Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          left:
                                                                              0,
                                                                          right:
                                                                              5,
                                                                          bottom:
                                                                              5,
                                                                          top:
                                                                              3),
                                                                  child: Text(
                                                                    newPreorder[index].quantity ==
                                                                            0
                                                                        ? ""
                                                                        : FlutterI18n.translate(context, "Quantity")+": ${newPreorder[index].quantity} ",
                                                                    // "${d.quantity}x ${d.item.name}",
                                                                    textAlign:
                                                                        TextAlign
                                                                            .left,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        color: Colors.black.withOpacity(
                                                                            0.3),
                                                                        fontFamily:
                                                                            "sourcesanspro",
                                                                        fontSize:
                                                                            13,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                )
                                                              : Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width /
                                                                      3,
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          top:
                                                                              0,
                                                                          bottom:
                                                                              3),
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            newPreorder[index].quantity--;
                                                                            if (newPreorder[index].quantity <
                                                                                1) {
                                                                              newPreorder[index].quantity = 1;
                                                                            }
                                                                            // updateReservation(newPreorder[index].id,
                                                                            //     newPreorder[index].quantity);
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                            padding: EdgeInsets.all(5),
                                                                            child: Icon(
                                                                              Icons.remove,
                                                                              size: 18,
                                                                              color: Colors.black45,
                                                                            )),
                                                                      ),
                                                                      Container(
                                                                        margin: EdgeInsets.only(
                                                                            left:
                                                                                5,
                                                                            right:
                                                                                5),
                                                                        child:
                                                                            Text(
                                                                          newPreorder[index].quantity == 0
                                                                              ? ""
                                                                              : "${newPreorder[index].quantity} ",
                                                                          // "${d.quantity}x ${d.item.name}",
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          style: TextStyle(
                                                                              color: Colors.grey,
                                                                              fontFamily: "sourcesanspro",
                                                                              fontSize: 13.5,
                                                                              fontWeight: FontWeight.normal),
                                                                        ),
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () {
                                                                          setState(
                                                                              () {
                                                                            newPreorder[index].quantity++;

                                                                            // updateReservation(newPreorder[index].id,
                                                                            //     newPreorder[index].quantity);
                                                                          });
                                                                        },
                                                                        child: Container(
                                                                            padding: EdgeInsets.all(5),
                                                                            child: Icon(
                                                                              Icons.add,
                                                                              size: 18,
                                                                              color: Colors.black45,
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
                                                              newPreorder[index]
                                                                          .status ==
                                                                      ""
                                                                  ? FlutterI18n.translate(context, "Status")+":"+FlutterI18n.translate(context, "NA")
                                                                  : FlutterI18n.translate(context, "Status")+": ${newPreorder[index].status} ",
                                                              // "${d.quantity}x ${d.item.name}",
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                  color:
                                                                      appColor,
                                                                  fontFamily:
                                                                      "sourcesanspro",
                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal),
                                                            ),
                                                          ),
                                                          // Container(
                                                          //   margin:
                                                          //       EdgeInsets.only(
                                                          //           top: 3),
                                                          //   child: SmoothStarRating(
                                                          //       allowHalfRating:
                                                          //           false,
                                                          //       onRatingChanged:
                                                          //           null,
                                                          //       starCount: 5,
                                                          //       rating:
                                                          //           ratinglist[
                                                          //               index],
                                                          //       size: 14.0,
                                                          //       color: Color(
                                                          //           0xFFFD68AE),
                                                          //       borderColor:
                                                          //           Colors.grey,
                                                          //       spacing: 0.0),
                                                          // ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      newPreorder[index]
                                                                  .status ==
                                                              "Pending"
                                                          ? GestureDetector(
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    SlideLeftRoute(
                                                                        page: PreorderConfirmation(
                                                                            newPreorder[index])));
                                                              },
                                                              child: Container(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5),
                                                                  decoration: BoxDecoration(
                                                                      color:
                                                                          appTealColor,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              5)),
                                                                  child: Text(
                                                                    FlutterI18n.translate(context, "Confirm"),
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  )),
                                                            )
                                                          : Container(),
                                                      Container(
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons.delete,
                                                            color: Colors.grey,
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
                                  ),
                                );
                        }),
                      ),
                    ),
                  ),
      ),
    );
  }

  updateReservation(id, quantity) async {
    var data = {
      "quantity": quantity,
    };

    var res = await CallApi()
        .postData(data, '/app/updateReservation/$id?token=$userToken');

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

  deletePreorderList(id) async {
    setState(() {
      _loading = true;
    });

    var res = await CallApi().getData1('/app/deleteReservation/$id');

    body1 = json.decode(res.body);

    print(body1['msg']);

    if (body1['msg'] == "success") {
      setState(() {
        wishDelList.add("$id");
        _showPreorderlist();
      });
    }

    _showToast();

    setState(() {
      _loading = false;
    });
  }

  _showToast() {
    Fluttertoast.showToast(
        msg:FlutterI18n.translate(context, "Deleted_successfully"),
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
                    FlutterI18n.translate(context, "Are_you_sure_you_want_to_remove_this_item_from_pre_order")+"?",
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
                        deletePreorderList(newPreorder[index].id);
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
