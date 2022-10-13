import 'package:ecommerce_bokkor_dev/Screen/CategoryPage/CategoryCard.dart';
import 'package:ecommerce_bokkor_dev/Screen/SubCategory/SubCategoryCard.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class SubCategoryPage extends StatefulWidget {
  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends State<SubCategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: new AppBar(
    automaticallyImplyLeading: true,
        backgroundColor: appTealColor,
        title:  Text(FlutterI18n.translate(context,  "Sub_Category")),
      ),

      body: SafeArea(
        child: Container(
                      margin: EdgeInsets.only(
                        left: 0,
                        right: 0,
                      ),
                
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(left: 5, right: 5,top: 4, bottom: 5),
                      child: OrientationBuilder(
                        builder: (context, orientation) {
                          return orientation == Orientation.portrait
                              ////// <<<<< Portrait Card start >>>>> //////
                              ? GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: (MediaQuery.of(context)
                                                .size
                                                .width /
                                            3) /
                                        (MediaQuery.of(context).size.height /
                                            4),
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                            new Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SubCategoryCard(),
                                  ),
                                  itemCount: 20,
                                )
                              ////// <<<<< Portrait Card end >>>>> //////
                              :
                              ////// <<<<< Landscape Card start >>>>> //////
                              GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: (MediaQuery.of(context)
                                                .size
                                                .width /
                                            2) /
                                        (MediaQuery.of(context).size.height /
                                            2.5),
                                  ),
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          new Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: SubCategoryCard(),
                                  ),
                                  itemCount: 20,
                                );
                          ////// <<<<< Landscape Card end >>>>> //////
                        },
                      )),
      ),
      
    );
  }
}