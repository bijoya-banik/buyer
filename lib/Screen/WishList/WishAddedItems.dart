import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductDetails/ProductDetails.dart';
import 'package:ecommerce_bokkor_dev/Screen/WishDetails/wishDetails.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class WishAddedItems extends StatefulWidget {
  final newWish;
  WishAddedItems(this.newWish);
  @override
  _WishAddedItemsState createState() => _WishAddedItemsState();
}

class _WishAddedItemsState extends State<WishAddedItems> {
  double price = 0.0, rating = 0.0;
   var body;
   bool _loading = false;
   List<String> wishDelList = [];

  @override
  void initState() {
    setState(() {
      if (widget.newWish.product.average != null) {
        String rate = widget.newWish.product.average.averageRating;
        rating = double.parse(rate);
      }
      String rr = rating.toStringAsFixed(1);
      rating = double.parse(rr);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, SlideLeftRoute(page: WishDetailsPage(widget.newWish.id)));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
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
              padding: EdgeInsets.only(bottom: 7),
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
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(right: 10.0, left: 10),
                          child: ClipOval(
                              child: Image.asset(
                            'assets/images/product_5.jpg',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width / 3,
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                "${widget.newWish.product.name}",
                                // "${d.quantity}x ${d.item.name}",
                                textAlign: TextAlign.left,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "sourcesanspro",
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              padding: EdgeInsets.only(top: 5, bottom: 5),
                              child: Text(
                                "\$ ${widget.newWish.product.price}",
                                //  "\$${(d.item.price * d.quantity).toStringAsFixed(2)}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: appTealColor,
                                    fontFamily: "sourcesanspro",
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SmoothStarRating(
                                allowHalfRating: false,
                                onRatingChanged: null,
                                starCount: 5,
                                rating: rating,
                                size: 14.0,
                                color: Color(0xFFFD68AE),
                                borderColor: appTealColor,
                                spacing: 0.0),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.shopping_cart,
                              color: appTealColor,
                            ),
                            onPressed: () {
                              // _deleteCart(d);
                            },
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.cancel,
                              color: appTealColor,
                            ),
                            onPressed: () {
                              deleteWishList();
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
  }

  deleteWishList() async {
    setState(() {
      _loading = true;
    });

    var res = await CallApi()
        .getData1('/app/deleteWishlist/${widget.newWish.id}');

    body = json.decode(res.body);

    print(body['msg']);

    if(body['msg'] == "success"){
      wishDelList.add("${widget.newWish.id}");
    }

    print(wishDelList);

    setState(() {
      _loading = false;
    });
  }

  // _showToast(int number) {
  //   Fluttertoast.showToast(
  //       msg: number == 1 ? "Already added" : "Something went wrong!",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIos: 1,
  //       backgroundColor:
  //           number == 1 ? appTealColor.withOpacity(0.9) : Colors.red[400],
  //       textColor: Colors.white,
  //       fontSize: 13.0);
  // }
}
