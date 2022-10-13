import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductDetails/ProductDetails.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class PortraitFeaturedProductsCard extends StatefulWidget {
  final user;
  final index;
  PortraitFeaturedProductsCard(this.user, this.index);
  @override
  _PortraitFeaturedProductsCardState createState() =>
      _PortraitFeaturedProductsCardState();
}

class _PortraitFeaturedProductsCardState
    extends State<PortraitFeaturedProductsCard> {
  var rating = 0.0, discPrice = 0.0;

  int userDiscount, productDiscount, totalDiscount;

  @override
  void initState() {
    setState(() {
      if (widget.user != null) {
        String userDisc = widget.user['discount'];
        double discUser = double.parse(userDisc);

        userDiscount = discUser.toInt();
        productDiscount = widget.index.discount;
      } else {
        double discUser = 0.0;

        userDiscount = discUser.toInt();
        productDiscount = widget.index.discount;
      }

      if (widget.index.average == null) {
        rating = 0.0;
      } else {
        String ratingProduct = widget.index.average.averageRating;
        rating = double.parse(ratingProduct);
      }
    });

    // if (userDiscount > productDiscount) {
    //   setState(() {
    //     totalDiscount = userDiscount;
    //   });
    // } else {
    setState(() {
      totalDiscount = productDiscount;
    });
    //  }

    String price = widget.index.price;
    double proPrice = double.parse(price);
    double disc = productDiscount / 100;
    double dicount = proPrice * disc;

    discPrice = proPrice - dicount;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      width: MediaQuery.of(context).size.width / 2 - 30,
      child: GestureDetector(
        onLongPress: () {
          print("object");
          // _showpop();
        },
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductsDetailsPage(widget.index.id, 1)),
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
                  height: 190,
                  width: MediaQuery.of(context).size.width / 2 - 35,
                  padding: EdgeInsets.only(bottom: 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Stack(    
                        children: <Widget>[
                          Container(
                           // color:Colors.red,
                            height: 80,
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 2 - 35,
                            child: Image.network(
                              '${widget.index.image}',
                              height: 80,
                              width: 80,// MediaQuery.of(context).size.width / 2 - 35,
                              fit: BoxFit.cover,
                            ),
                          ),
                          productDiscount == 0
                              ? Container()
                              : Container(
                                  padding: EdgeInsets.all(5),
                                  margin: EdgeInsets.only(top: 20),
                                  color: appTealColor,
                                  child: Text(
                                    "$productDiscount% "+FlutterI18n.translate(context, "off"),
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10),
                                  ))
                        ],
                      ),
                      Container(
                        /// color: Colors.red,
                        //padding: EdgeInsets.only(left: 15, right: 15),
                        width: MediaQuery.of(context).size.width / 2 - 35,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                                    "#${widget.index.id}",
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
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                widget.index.name == null
                                    ? ""
                                    : widget.index.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: 'Roboto',
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 8, left: 0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.only(
                                          right: 0, top: 0, bottom: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                              totalDiscount == 0
                                                  ? "${widget.index.price} BHD"
                                                  : "${discPrice.toStringAsFixed(2)} BHD",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontFamily: 'Roboto',
                                                  color: appTealColor,
                                                  fontWeight: FontWeight.bold)),
                                          totalDiscount == 0
                                              ? Container()
                                              : Expanded(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 3),
                                                    child: Text(
                                                      "${widget.index.price} BHD",
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12.0,
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough,
                                                      ),
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
                      )
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
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color:
                              // widget.index % 2 == 0
                              //     ? Color(0XFFFD68AE)
                              //     :
                              Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Text(
                          "",
                          // widget.index % 2 == 0 ? "-80%" : "",
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

  void _showpop() {
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
                      child: new Text("Brand")),
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
                  padding: EdgeInsets.only(
                    bottom: 40,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
