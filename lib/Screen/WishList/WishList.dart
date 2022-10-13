import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/Form/LoginForm/LogInPage.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/CartPage/AddedItems.dart';
import 'package:ecommerce_bokkor_dev/Screen/CheckOut/CheckOut.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductDetails/ProductDetails.dart';
import 'package:ecommerce_bokkor_dev/Screen/WishDetails/wishDetails.dart';
import 'package:ecommerce_bokkor_dev/Screen/WishList/WishAddedItems.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:ecommerce_bokkor_dev/model/BestSellerModel/bestSellerModel.dart';
import 'package:ecommerce_bokkor_dev/model/WishlistModel/wishlistModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WishList extends StatefulWidget {
  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  var newWish;
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
    _showWishlist();
  }

  /////// <<<<< Wishlist start >>>>> ///////

  Future<void> _showWishlist() async {
    var res = await CallApi().getData('/app/showWishlist?token=' + userToken);
    body = json.decode(res.body);

    print(body);

    if (res.statusCode == 200) {
      _newWishlist();
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
  }

  void _newWishlist() {
    var newWishlist = WishlistModel.fromJson(body);
    if (!mounted) return;
    setState(() {
      newWish = newWishlist.status;
      for (int i = 0; i < newWish.length; i++) {
        if (newWish[i].product.average != null) {
          String rate = newWish[i].product.average.averageRating;
          rating = double.parse(rate);
        } else {
          rating = 0.0;
        }
        String rr = rating.toStringAsFixed(1);
        rating = double.parse(rr);
        ratinglist.add(rating);
      }
    });
    //print(newWish.length);
    print(ratinglist);
  }

  ////// <<<<< Wishlist end >>>>> //////

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
                  Text(FlutterI18n.translate(context, "WishList"),
                      style: TextStyle(fontSize: 20, color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
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
                          Text(FlutterI18n.translate(context, "Login_to_your_account")),
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
                                child: Text(FlutterI18n.translate(context,"Login"),
                                    style: TextStyle(color: Colors.white))),
                          )
                        ],
                      ),
                    ))
                  : newWish.length == 0
                      ? Center(
                          child: Container(
                          child: Text(FlutterI18n.translate(context,"No_Wishlist_yet")+"!"),
                        ))
                      : SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(left: 10, right: 10),
                            child: Column(
                              children: List.generate(newWish.length, (index) {
                                discount = newWish[index].product.discount;
                                String pr = newWish[index].product.price;
                                double pricess = double.parse(pr);
                                double dis = discount / 100;
                                double pp = pricess.toDouble();
                                prices = (pp * dis);
                                prices = pricess - prices;
                                return wishDelList.contains(newWish[index].id)
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
                                                            newWish[index]
                                                                .product
                                                                .id,
                                                            1)));
                                          },
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
                                                      bottom: 7),
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
                                                                  Alignment
                                                                      .center,
                                                              margin: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          10.0,
                                                                      left: 10),
                                                              child: ClipOval(
                                                                  child: Image
                                                                      .network(
                                                                '${newWish[index].product.image}',
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
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 8),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    children: <
                                                                        Widget>[
                                                                      Text(
                                                                        FlutterI18n.translate(context,"Product_id "),
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            color:
                                                                                appTealColor,
                                                                            fontWeight:
                                                                                FontWeight.normal),
                                                                      ),
                                                                      Text(
                                                                        "#${newWish[index].product.id}",
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                11,
                                                                            fontFamily:
                                                                                'Roboto',
                                                                            color:
                                                                                appTealColor,
                                                                            fontWeight:
                                                                                FontWeight.bold),
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
                                                                  padding:
                                                                      EdgeInsets
                                                                          .only(
                                                                              top: 5),
                                                                  child: Text(
                                                                    "${newWish[index].product.name}",
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
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.normal),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  child: Row(
                                                                    children: <
                                                                        Widget>[
                                                                      Container(
                                                                        alignment:
                                                                            Alignment.centerLeft,
                                                                        padding: EdgeInsets.only(
                                                                            top:
                                                                                5,
                                                                            bottom:
                                                                                5),
                                                                        child:
                                                                            Text(
                                                                          discount == 0
                                                                              ? "${pricess.toStringAsFixed(2)} BHD"
                                                                              : "${prices.toStringAsFixed(2)} BHD",
                                                                          //  "\$${(d.item.price * d.quantity).toStringAsFixed(2)}",
                                                                          textAlign:
                                                                              TextAlign.left,
                                                                          style: TextStyle(
                                                                              color: appTealColor,
                                                                              fontFamily: "sourcesanspro",
                                                                              fontSize: 13,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                      discount ==
                                                                              0
                                                                          ? Container()
                                                                          : Container(
                                                                              margin: EdgeInsets.only(left: 3),
                                                                              alignment: Alignment.centerLeft,
                                                                              padding: EdgeInsets.only(top: 5, bottom: 5),
                                                                              child: Text(
                                                                                "${pricess.toStringAsFixed(2)} BHD",
                                                                                //  "\$${(d.item.price * d.quantity).toStringAsFixed(2)}",
                                                                                textAlign: TextAlign.left,
                                                                                style: TextStyle(
                                                                                  color: Colors.grey,
                                                                                  fontFamily: "sourcesanspro",
                                                                                  fontSize: 11,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  decoration: TextDecoration.lineThrough,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SmoothStarRating(
                                                                    allowHalfRating:
                                                                        false,
                                                                    onRatingChanged:
                                                                        null,
                                                                    starCount:
                                                                        5,
                                                                    rating:
                                                                        ratinglist[
                                                                            index],
                                                                    size: 14.0,
                                                                    color: Color(
                                                                        0xFFFD68AE),
                                                                    borderColor:
                                                                        Colors
                                                                            .grey,
                                                                    spacing:
                                                                        0.0),
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
                                                                  Icons.cancel,
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
                                        ),
                                      );
                              }),
                            ),
                          ),
                        ),
            ),
    );
  }

  addToCart(newWish) {}

  deleteWishList(id) async {
    setState(() {
      _loading = true;
    });

    var res = await CallApi().getData1('/app/deleteWishlist/$id');

    body1 = json.decode(res.body);

    print(body1['msg']);

    if (body1['msg'] == "success") {
      setState(() {
        wishDelList.add("$id");
        _showWishlist();
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
                    FlutterI18n.translate(context,"Are_you_sure_you_want_to_remove_this_item_from_wishlist")+"?",
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
                        deleteWishList(newWish[index].id);
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
