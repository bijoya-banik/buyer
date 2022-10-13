import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/ReviewPage/ReviewDesign.dart';
import 'package:ecommerce_bokkor_dev/Screen/ReviewPage/SendReview.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

class ReviewPage extends StatefulWidget {
  final review;
  ReviewPage(this.review);
  @override
  _ReviewPageState createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  var reviewData;
  bool _isLoading = true;
  var body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          //centerTitle: true,
          titleSpacing: 8,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 35.0,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: appTealColor,
          title: Text(
             FlutterI18n.translate(context,  "Review"),
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        body: widget.review.length == 0
            ? Center(
                child: Container(
                child: Text( FlutterI18n.translate(context,  "No_reviews")),
              ))
            : Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.only(left: 8),
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) => Container(
                    margin: EdgeInsets.only(bottom: 5, top: 0, left: 3),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: ReviewContainer(widget.review[index]),
                  ),
                  itemCount: widget.review.length,
                ),
              ));
  }
}
