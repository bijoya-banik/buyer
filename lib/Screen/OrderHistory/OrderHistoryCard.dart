import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/OrderHistory/OrderHistoryCardDetails.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductPage/ProductPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/ReviewPage/SendReview.dart';
import 'package:ecommerce_bokkor_dev/Screen/SubCategory/SubCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../main.dart';

class OrderHistoryCard extends StatefulWidget {
  final orderData;
  OrderHistoryCard(this.orderData);
  @override
  _OrderHistoryCardState createState() => _OrderHistoryCardState();
}

class _OrderHistoryCardState extends State<OrderHistoryCard> {
  @override
  void initState() {
    //print(widget.orderData.orderDetails[0].product.image);
    // print("widget.orderData.grandTotal");
    // print(widget.orderData.grandTotal);
    // print(widget.orderData.orderDetails[0].product.image);
    // print(widget.orderData.orderDetails[0].product.image);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            SlideLeftRoute(page: OrderHistoryCardDetails(widget.orderData)));
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Container(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Container(
                        //color: Colors.white,
                        padding: EdgeInsets.only(
                            top: 15, bottom: 15, right: 20, left: 10),
                        margin: EdgeInsets.only(bottom: 10),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(left: 8, bottom: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          FlutterI18n.translate(context, "Order")+' #${widget.orderData.id} - ',
                                          style: TextStyle(
                                              color: appTealColor,
                                              fontSize: 12),
                                        ),
                                        Text(
                                          '${widget.orderData.status}',
                                          style: TextStyle(
                                              color: appTealColor,
                                              fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Container(
                                  //   decoration: BoxDecoration(),
                                  //   child: Text(
                                  //     '${widget.orderData.discount}%',
                                  //     style: TextStyle(
                                  //         color: appColor, fontSize: 12),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                     FlutterI18n.translate(context, "Order_Type")+': ${widget.orderData.orderType}',
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                                           widget.orderData.used_vaoucher==null?Container():  Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              margin:
                                  EdgeInsets.only(left: 7, right: 10, top: 3),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                   FlutterI18n.translate(context, "Coupon")+":" ,
                                    style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: "DINPro",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    "${widget.orderData.used_vaoucher.voucher.code}"+
                                    "( "+widget.orderData.used_vaoucher.voucher.discount.toString()+"% )",
                                    style: TextStyle(
                                        color: appColor,
                                        fontFamily: "DINPro",
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                            Container(
                              margin: EdgeInsets.only(left: 8, top: 2),
                              child: Text(
                                FlutterI18n.translate(context, "Order_Date")+': ${widget.orderData.date}',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: EdgeInsets.only(
                                left: 5,
                                top: 6,
                              ),
                              margin: EdgeInsets.only(top: 10, bottom: 10),
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: <Widget>[
                                  // Container(
                                  //   margin:
                                  //       EdgeInsets.only(bottom: 5, left: 60),
                                  //   child: Divider(
                                  //     color: Colors.grey,
                                  //   ),
                                  // ),
                                   widget.orderData.orderdetails.length ==0?Container(): Container(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                       Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(right: 10.0),
                                          child: ClipOval(
                                              child: Image.network(
                                            '${widget.orderData.orderdetails[0].product.image}',
                                            height: 60,
                                            width: 60,
                                            fit: BoxFit.cover,
                                          )),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Container(
                                                  margin: EdgeInsets.only(
                                                    bottom: 5,
                                                  ),
                                                  child: Text(
                                                    "${widget.orderData.orderdetails[0].totalPrice} BHD",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontFamily: "DINPro",
                                                        fontSize: 13,
                                                        fontWeight:
                                                            FontWeight.normal),
                                                  ),
                                                ),
                                                Container(
                                                  child: Text(
                                                    "${widget.orderData.orderdetails[0].product.name}",
                                                    textDirection:
                                                        TextDirection.ltr,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        color: Colors.black54,
                                                        fontFamily: "DINPro",
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                Container(
                                                    margin:
                                                        EdgeInsets.only(top: 4),
                                                    child: Text(
                                                       FlutterI18n.translate(context,  "Quantity") + ": ${widget.orderData.orderdetails[0].quantity}x",
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                            color: appColor,
                                                            fontFamily:
                                                                "DINPro",
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal))),
                                              ],
                                            ),
                                          ),
                                        ),
                                        widget.orderData.status != "Delivered"
                                            ? Container()
                                            : widget.orderData.orderdetails[0]
                                                        .isReviewed ==
                                                    1
                                                ? Container()
                                                : Container(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: <Widget>[
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 10),
                                                          child: FlatButton(
                                                              disabledColor: Colors
                                                                  .transparent,
                                                              child: Container(
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        appTealColor,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Text(
                                                                  FlutterI18n.translate(context, "Submit_Review"),
                                                                  textDirection:
                                                                      TextDirection
                                                                          .ltr,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        12.0,
                                                                    decoration:
                                                                        TextDecoration
                                                                            .none,
                                                                    fontFamily:
                                                                        'MyriadPro',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ),
                                                              shape: new RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      new BorderRadius
                                                                              .circular(
                                                                          5.0)),
                                                              onPressed: () {
                                                                Navigator.push(
                                                                    context,
                                                                    SlideLeftRoute(
                                                                        page: SendReviewPage(
                                                                            widget.orderData.orderdetails[0].product.id,
                                                                            widget.orderData.orderdetails[0].orderId,
                                                                            widget.orderData.orderdetails[0].product.image)));
                                                              }),
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
                            widget.orderData.orderdetails.length > 1
                                ? Container(
                                    margin: EdgeInsets.only(left: 8, top: 3),
                                    child: Row(
                                      children: <Widget>[
                                        Text(
                                          FlutterI18n.translate(context, "View_more_products"),
                                          style: TextStyle(
                                              color: appTealColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12),
                                        ),
                                        Icon(
                                          Icons.arrow_forward,
                                          color: appTealColor,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                  )
                                : Container(),
                            Container(
                              margin: EdgeInsets.only(left: 8, top: 6),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                     FlutterI18n.translate(context, "Quantity")+":",
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    '${widget.orderData.orderdetails.length}',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 8, top: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                   FlutterI18n.translate(context,"Total_Amount")+":" ,
                                    style: TextStyle(
                                        color: Colors.grey, fontSize: 12),
                                  ),
                                  Text(
                                    '${widget.orderData.grandTotal} BHD',
                                    style: TextStyle(
                                        color: appColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  //Icon(Icons.chevron_right),
                ],
              ),
              // Container(
              //   margin: EdgeInsets.only(bottom: 5, left: 8),
              //   child: Divider(
              //     color: Colors.grey,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
