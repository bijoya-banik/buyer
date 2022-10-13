import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/OrderHistory/OrderHistoryCardDetails.dart';
import 'package:ecommerce_bokkor_dev/Screen/PreorderPage/preorderDetails.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductPage/ProductPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/SubCategory/SubCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../main.dart';

class PreorderCard extends StatefulWidget {
  final newPreorder;
  PreorderCard(this.newPreorder);
  @override
  _PreorderCardState createState() => _PreorderCardState();
}

class _PreorderCardState extends State<PreorderCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Container(
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 8, bottom: 3),
                          child: Text(
                            FlutterI18n.translate(context,"Order_no")+': #${widget.newPreorder.id}',
                            style: TextStyle(color: appTealColor),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          child: Text(
                            '${widget.newPreorder.product.name}',
                            style:
                                TextStyle(color: Colors.black, fontSize: 16),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8, top: 4),
                          child: Row(
                            children: <Widget>[
                              Text(
                                '\$${widget.newPreorder.product.price}',
                                style: TextStyle(color: Colors.black54),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 8, top: 2),
                          child: Text(
                            '${widget.newPreorder.status}',
                            style:
                                TextStyle(color: Colors.grey, fontSize: 13),
                          ),
                        ),
                      ],
                    )),
                Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
