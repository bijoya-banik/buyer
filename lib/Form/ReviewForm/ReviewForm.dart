import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/OrderHistory/OrderHistory.dart';
import 'package:ecommerce_bokkor_dev/Screen/ReviewPage/SendReview.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ReviewForm extends StatefulWidget {
  final productId;
  final orderId;
  final image;
  ReviewForm(this.productId, this.orderId, this.image);
  @override
  _ReviewFormState createState() => _ReviewFormState();
}

class _ReviewFormState extends State<ReviewForm> {
  bool _isLoading = false;
  var rating = 0.0;
  TextEditingController reviewController = TextEditingController();
  var userData, token;

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    if (userJson != null) {
      //Navigator.push(context, SlideLeftRoute(page: LogInPage("3")));
      var user = json.decode(userJson);
      setState(() {
        userData = user;
        //_isLoggedIn = true;
      });
      token = localStorage.getString('token');
    } else {
      setState(() {
        //_isLoggedIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          //color: Colors.red,
          child: Column(
            children: <Widget>[
              ///////////Picture///////////
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 20),
                height: MediaQuery.of(context).size.width / 1.5,
                width: MediaQuery.of(context).size.width / 1.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                      image: NetworkImage('${widget.image}'), fit: BoxFit.fill),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[200],
                      //  offset: Offset(5.0, 2.5),
                      blurRadius: 20.0,
                    )
                  ],
                ),
              ),
              /////////picture End////////

              ////////// Item Details /////////
              Container(
                margin: EdgeInsets.only(bottom: 15, left: 5, right: 5, top: 5),
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: <Widget>[
                    /////////////RAting////////

                    Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          //color: Colors.red,
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            FlutterI18n.translate(context, "Please_give_review_for_this_product"),
                            
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 17.0,
                              decoration: TextDecoration.none,
                              fontFamily: 'MyriadPro',
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                        SmoothStarRating(
                          allowHalfRating: false,
                          rating: rating,
                          size: 35,
                          starCount: 5,
                          spacing: 2.0,
                          color: Color(0xFFffa900),
                          borderColor: Color(0xFF343434),
                          onRatingChanged: (value) {
                            setState(() {
                              rating = value;
                            });
                          },
                        ),
                      ],
                    ),

                    ///////Rating end/////////

                    /////////////
                    Container(
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 15, bottom: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            //width: 300,
                            height: 30,
                            margin: EdgeInsets.only(left: 15, top: 15),
                            child: Text(
                              FlutterI18n.translate(context, "Review"),
                              
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Color(0xFF000000),
                                  fontFamily: "sourcesanspro",
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            // height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey[300],
                                    blurRadius: 17,
                                    //offset: Offset(0.0,3.0)
                                  )
                                ],
                                color: Colors.white),
                            //color: Colors.blue,
                            //padding: EdgeInsets.all(10.0),
                            child: new SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              // reverse: true,
                              child: new TextField(
                                cursorColor: Colors.grey,
                                maxLength: 250,
                                maxLines: 4,
                                controller: reviewController,
                                decoration: new InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Color(0xFFFFFFFF))),
                                  enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                      borderSide:
                                          BorderSide(color: Color(0xFFFFFFFF))),
                                  hintText:FlutterI18n.translate(context, "Add_your_review_here"),
                                  hintStyle: TextStyle(
                                      color: Color(0xFF9b9b9b),
                                      fontSize: 15,
                                      fontFamily: "sourcesanspro",
                                      fontWeight: FontWeight.w300),
                                  fillColor: Color(0xFFFFFFFF),
                                  filled: true,
                                  contentPadding: EdgeInsets.only(
                                      left: 20, bottom: 10, top: 12, right: 10),
                                ),
                              ),
                            ),
                          ),

                          ///////////////// Button Section Start///////////////

                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    //padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      FlutterI18n.translate(context, "Back"),
                                    
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18.0,
                                        // decoration: TextDecoration.underline,
                                        fontFamily: 'MyriadPro',
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    //color: Colors.red,
                                  ),
                                ),

                                /////////////////  Button  Start///////////////

                                Container(
                                    decoration: BoxDecoration(
                                      color: _isLoading
                                          ? Colors.grey
                                          : appTealColor.withOpacity(0.9),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                    ),
                                    //width: 150,
                                    height: 45,
                                    child: FlatButton(
                                      onPressed: () {
                                        _isLoading ? null : _submitReview();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          _isLoading
                                              ? FlutterI18n.translate(context, "Submiting")+'...'
                                              : FlutterI18n.translate(context, "Submit"),
                                          textDirection: TextDirection.ltr,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17.0,
                                            decoration: TextDecoration.none,
                                            fontFamily: 'MyriadPro',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      color: Colors.transparent,
                                      // elevation: 4.0,
                                      //splashColor: Colors.blueGrey,
                                      shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(10.0)),
                                    )),

                                /////////////////  Button  End///////////////
                              ],
                            ),
                          )

                          ///////////////// Button Section End///////////////
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ////////// Item Details end/////////
            ],
          ),
        ),
      ),
    );
  }

  void _submitReview() async {
    if (rating == 0.0) {
      return showMsg("Star_rating_is_not_given");
    } else if (reviewController.text.isEmpty) {
      return showMsg("Please_write_your_review_first");
    }

    setState(() {
      _isLoading = true;
    });

    var data = {
      'rating': rating,
      'review': reviewController.text,
      'productId': widget.productId,
      'orderId': widget.orderId,
    };

    print(data);

    var res = await CallApi().postData(data, '/app/addReview?token=$token');
    var body = json.decode(res.body);

    print(body);

    if (body['success'] == true) {
      //_showReviewAlert('Review has been given successfully');
      _showToast();
      setState(() {
        reviewController.text = "";
        rating = 0.0;
      });
    } else {
      _showReviewAlert("Something_went_wrong");
    }

    setState(() {
      _isLoading = false;
    });
  }

  _showToast() {
    Navigator.push(context, SlideLeftRoute(page: OrderHistory()));
    Fluttertoast.showToast(
        msg: FlutterI18n.translate(context, "Review_has_been_given_successfully"),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: appTealColor.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 13.0);
  }

  void showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(FlutterI18n.translate(context, msg),),
      action: SnackBarAction(
        label: FlutterI18n.translate(context, "Close"),
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void _showReviewAlert(String review) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          content: Container(
            //    width: double.maxFinite,
            height: 150,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  //  color: Colors.red,
                  // width: double.maxFinite,
                  margin: EdgeInsets.only(bottom: 30),
                  // height: 40,
                  alignment: Alignment.center,

                  child: Text(
                    review,
                    textAlign: TextAlign.center,
                    //maxLines: 3,
                    style: TextStyle(
                        color: Color(0XFF414042),
                        fontFamily: "SourceSansPro",
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new OutlineButton(
                      borderSide: BorderSide(
                          color: appTealColor,
                          style: BorderStyle.solid,
                          width: 1),
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(50.0)),
                      child: new Text(
                        FlutterI18n.translate(context, "Ok"),
                        style: TextStyle(color: appTealColor),
                      ),
                      onPressed: () {
                        review == "Review has been given successfully"
                            ? Navigator.push(
                                context, SlideLeftRoute(page: OrderHistory()))
                            : Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
