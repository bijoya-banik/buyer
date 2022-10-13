import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductDetails/ProductDetails.dart';
import 'package:ecommerce_bokkor_dev/Screen/SubCategory/SubCategory.dart';
import 'package:ecommerce_bokkor_dev/Screen/SubCategoryProducts/SubCategoryProducts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../main.dart';

class ProductsCard extends StatefulWidget {
  final user;
  final filterList;
  ProductsCard(this.user, this.filterList);
  @override
  _ProductsCardState createState() => _ProductsCardState();
}

class _ProductsCardState extends State<ProductsCard> {
  double price = 0.0, discountPrice = 0.0, rating = 0.0;
  int userDiscount, productDiscount, totalDiscount;
  @override
  void initState() {
    setState(() {
      if (widget.user != null) {
        String userDisc = widget.user['discount'];
        double discUser = double.parse(userDisc);

        userDiscount = discUser.toInt();
        productDiscount = widget.filterList.discount;
      } else {
        double discUser = 0.0;

        userDiscount = discUser.toInt();
        productDiscount = widget.filterList.discount;
      }

      if (widget.filterList.average == null) {
        rating = 0.0;
      } else {
        String ratingProduct = widget.filterList.average.averageRating;
        rating = double.parse(ratingProduct);
      }

      // if (userDiscount > productDiscount) {
      //   setState(() {
      //     totalDiscount = userDiscount;
      //   });
      // } else {
      setState(() {
        totalDiscount = productDiscount;
      });
      // }

      String p = "${widget.filterList.price}";
      price = double.parse(p);
      double disc = totalDiscount / 100;
      double newDisc = price * disc;
      discountPrice = price - newDisc;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GestureDetector(
        onTap: () {
          print("object1");
          Navigator.push(
              context,
              SlideLeftRoute(
                  page: ProductsDetailsPage(widget.filterList.id, 1)));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: 0, top: 5, left: 2.5, right: 2.5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                blurRadius: 1.0,
                color: Colors.black.withOpacity(.5),
              ),
            ],
          ),
          child: GridTile(
            child: Container(
              padding: EdgeInsets.only(bottom: 0),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Container(
                        child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Stack(children: <Widget>[
                        ////// <<<<< Pic start >>>>> //////
                        Center(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            margin: EdgeInsets.only(top: 5),
                            child: Image.network(
                              '${widget.filterList.image}',
                              height: 130,
                              width: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ////// <<<<< Pic end >>>>> //////

                        ////// <<<<< New tag start >>>>> //////
                        Container(
                          margin: EdgeInsets.only(top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.all(5),
                                  color: productDiscount != 0
                                      ? appTealColor
                                      : Colors.transparent,
                                  child: Text(
                                    productDiscount != 0
                                        ? "$productDiscount% "+FlutterI18n.translate(context, "Off")
                                        : "",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 12),
                                  )),
                            ],
                          ),
                        )
                        ////// <<<<< New tag end >>>>> //////
                      ]),
                    )),
                  ),
                  Divider(
                    color: Colors.grey[300],
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                        FlutterI18n.translate(context, "Product_id"),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Roboto',
                              color: appTealColor,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "#${widget.filterList.id}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Roboto',
                              color: appTealColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15, top: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ////// <<<<< Name start >>>>> //////
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Text("${widget.filterList.name}",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500)),
                          ),
                        ),
                        ////// <<<<< Name end >>>>> //////
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  ////// <<<<< Price start >>>>> //////
                  Container(
                    margin: EdgeInsets.only(left: 15, right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  totalDiscount == 0
                                      ? "${widget.filterList.price} BHD"
                                      : "${discountPrice.toStringAsFixed(2)} BHD",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: appTealColor,
                                      fontWeight: FontWeight.bold),
                                ),
                                totalDiscount == 0
                                    ? Container()
                                    : Expanded(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 5),
                                          child: Text(
                                            "${widget.filterList.price} BHD",
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ////// <<<<< Price end >>>>> //////
                  Container(
                    margin: EdgeInsets.only(top: 8, left: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ////// <<<<< Place start >>>>> //////
                        Expanded(
                          child: Container(
                            margin:
                                EdgeInsets.only(right: 8, top: 0, bottom: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // Icon(
                                //   Icons.star,
                                //   size: 13,
                                //   color: Color(0xFFffa900),
                                // ),
                                Container(
                                  alignment: Alignment.center,
                                  //color: Colors.red,
                                  margin: EdgeInsets.only(left: 3, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SmoothStarRating(
                                        //allowHalfRating: true,
                                        rating: rating,
                                        size: 12,
                                        starCount: 5,
                                        spacing: 2.0,
                                        color: Color(0xFFFD68AE),
                                        borderColor: Colors.grey,
                                        onRatingChanged: (value) {
                                          setState(() {
                                            rating = value;
                                          });
                                        },
                                      ),
                                      // Container(
                                      //     margin: EdgeInsets.only(
                                      //       left: 3,
                                      //     ),
                                      //     child: Text("5.0",
                                      //         style: TextStyle(
                                      //             color: Colors.black54,
                                      //             fontFamily: 'Roboto',
                                      //             fontSize: 10))),
                                      // Container(
                                      //     margin: EdgeInsets.only(left: 2),
                                      //     child: Text("(30)",
                                      //         style: TextStyle(
                                      //             color: Colors.black54,
                                      //             fontFamily: 'Roboto',
                                      //             fontSize: 10)))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ////// <<<<< Place end >>>>> //////
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
