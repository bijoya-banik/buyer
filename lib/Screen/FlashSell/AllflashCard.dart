import 'package:countdown_flutter/countdown_flutter.dart';
import 'package:ecommerce_bokkor_dev/Screen/FlashDetails/flashDetails.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductDetails/FlashProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import '../../NavigationAnimation/routeTransition/routeAnimation.dart';
import '../../main.dart';
import '../ProductDetails/ProductDetails.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class AllFlashSellCard extends StatefulWidget {
  final user;
  final index;

  AllFlashSellCard(this.user, this.index);
  @override
  _PortraitFlashSellCardState createState() => _PortraitFlashSellCardState();
}

class _PortraitFlashSellCardState extends State<AllFlashSellCard> {
  int hours = 0, discout = 0, sold = 0, stock = 0;
  double dSold = 0.0, discount = 0.0, price = 0.0;

  @override
  void initState() {
    setState(() {
      discout = widget.index.discount;
      String pr = widget.index.product.price;
      price = double.parse(pr);
      stock = widget.index.quantity;
      var sale = widget.index.totalsale;
      if (sale == null) {
        sold = 0;
      } else {
        sold = widget.index.totalsale;
      }

      double stockD = stock.toDouble();
      double soldD = sold.toDouble();

      double disc = discout / 100;
      double discountPrice = price * disc;
      discount = price - discountPrice;

      dSold = (soldD / stockD);
      print("dSold");
      print(dSold);
    });

    super.initState();
  }

  var rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width / 1.2,
      child: GestureDetector(
        onLongPress: () {
          print("object");
          // _showpop();
        },
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => FlashProductDetails(widget.index.productId, 1)),
              //  builder: (context) => ProductsDetailsPage(widget.index.productId, 1)),
          );
        },
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          title: Stack(
            children: <Widget>[
              Card(
                elevation: 1.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 0.5,
                        color: Color(0XFF377FA8).withOpacity(0.5),
                        //offset: Offset(6.0, 7.0),
                      ),
                    ],
                  ),
                  //height: 160,
                  width: MediaQuery.of(context).size.width / 1.2,
                  padding: EdgeInsets.only(bottom: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        // height: 80,
                        margin: EdgeInsets.only(right: 12),
                        padding: EdgeInsets.only(left: 8),
                        // width: 80,
                        //color: Colors.red,
                        alignment: Alignment.center,
                        //width: MediaQuery.of(context).size.width / 1.2,
                        child: Image.network(
                          '${widget.index.product.image}',
                          height: 80,
                          width: 80,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 7),
                                padding: EdgeInsets.only(top: 8),
                                child: Text(
                                  widget.index.product.name == null
                                      ? ""
                                      : widget.index.product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'Roboto',
                                      color: Color(0XFF09324B),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 8, left: 7),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        margin: EdgeInsets.only(
                                            right: 0, top: 0, bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                                discout == 0
                                                    ? "${widget.index.product.price} BHD"
                                                    : "${discount.toStringAsFixed(2)} BHD",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 15,
                                                    fontFamily: 'Roboto',
                                                    color: appTealColor,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            discout == 0
                                                ? Container()
                                                : Container(
                                                    margin: EdgeInsets.only(
                                                        left: 3),
                                                    child: Text(
                                                      "${widget.index.product.price} BHD",
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
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
                              Container(
                                //color: Colors.red,
                                margin: EdgeInsets.only(bottom: 5),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.only(left: 0),
                                      child: LinearPercentIndicator(
                                        width: 80,
                                        lineHeight: 5.0,
                                        percent: dSold,
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        backgroundColor: Color(0XFFB1E0FB),
                                        progressColor: Color(0XFFFD68AE),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: Text("$sold% "+FlutterI18n.translate(context, "Sold"),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontSize: 8,
                                              fontFamily: 'Roboto',
                                              color: Color(0XFF09324B),
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                //color: Colors.red,
                margin: EdgeInsets.only(top: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 8, bottom: 8),
                        // padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: discout != 0
                              ? Color(0XFFFD68AE)
                              : Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Text(
                          discout != 0 ? "$discout%" : "",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontFamily: 'Roboto'),
                        )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
