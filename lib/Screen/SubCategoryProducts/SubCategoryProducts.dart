import 'package:ecommerce_bokkor_dev/Screen/SubCategory/SubCategoryCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import '../../main.dart';

class CategorySearchDialog extends StatefulWidget {
  @override
  _CategoryDialogState createState() => new _CategoryDialogState();
}

class _CategoryDialogState extends State<CategorySearchDialog> {
  int _current = 0;
  int _isBack = 0;
  String result = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      //backgroundColor: Colors.black,
      appBar: new AppBar(
        backgroundColor: appTealColor,
        title:Text(FlutterI18n.translate(context,  "Sub_Category")),
      ),
      //body: new Text("It's a Dialog!"),
      body: SafeArea(
        child: SingleChildScrollView(
          physics:BouncingScrollPhysics(),
                  child: new Container(
              margin: EdgeInsets.only(top: 15,bottom: 15),
              //color: Colors.white,
              child: Column(
                children: <Widget>[
              
               
            SubCategoryCard(),
            SubCategoryCard(),
            SubCategoryCard(),
            SubCategoryCard(),
            SubCategoryCard(),
            SubCategoryCard(),
            SubCategoryCard(),
            SubCategoryCard(),
            SubCategoryCard(),
            SubCategoryCard(),
            SubCategoryCard(),
            SubCategoryCard(),
            SubCategoryCard(),
            SubCategoryCard(),
                ],
              )),
        ),
      ),
    );
  }



}