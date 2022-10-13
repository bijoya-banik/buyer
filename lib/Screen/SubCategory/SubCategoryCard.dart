
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/Filter/Filter.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductPage/ProductPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/SubCategory/SubCategory.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../main.dart';

class SubCategoryCard extends StatefulWidget {
  
  @override
  _SubCategoryCardState createState() => _SubCategoryCardState();
}

class _SubCategoryCardState extends State<SubCategoryCard> {
  @override
  Widget build(BuildContext context) {
   return Container(
     padding: EdgeInsets.only(left: 20,right: 20),
                          child: GestureDetector(
                            onTap: () {
                             

                            Navigator.push(
                          context, SlideLeftRoute(page: FilterDialog()));
                            },
                            child: Column(
                              children: <Widget>[
                                Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                        padding: EdgeInsets.only( top:12,bottom: 12),
                                        child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.phone_android,
                                          color: appTealColor,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 8),
                                          child: Text(
                                            FlutterI18n.translate(context,  "Mobile"),
                                            style: TextStyle(color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    )),
                                   Icon(Icons.chevron_right),
                                  ],
                                ),
                                 Divider(),
                              ],
                            ),
                          ),
                        );
  }
}
