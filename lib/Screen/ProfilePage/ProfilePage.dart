import 'dart:convert';

import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/Form/LoginForm/LogInPage.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/AddressPage/addressPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/HomePage/HomePage.dart';
import 'package:ecommerce_bokkor_dev/Screen/Language/Language.dart';
import 'package:ecommerce_bokkor_dev/Screen/OrderHistory/OrderHistory.dart';
import 'package:ecommerce_bokkor_dev/Screen/PreorderPage/preorderPage.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProfilePage/ProfileView.dart';
import 'package:ecommerce_bokkor_dev/Screen/Registration/Registration.dart';
import 'package:ecommerce_bokkor_dev/Screen/SlideButton/SlideButton.dart';
//import 'package:ecommerce_bokkor_dev/Screen/SlideButton/SlideButton.dart';
import 'package:ecommerce_bokkor_dev/Screen/SubCategory/SubCategoryCard.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:ecommerce_bokkor_dev/redux/action.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userData;
  bool _isLoggedIn = false;

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
      });
      var token = localStorage.getString('token');
      if (token != null) {
        setState(() {
          _isLoggedIn = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: appTealColor,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Center(
            child: Container(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(FlutterI18n.translate(context, "Profile"),
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: new Container(
              padding: EdgeInsets.all(0.0),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  // Container(
                  //   margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: <Widget>[
                  //       Container(
                  //         //transform: Matrix4.translationValues(0.0, 0.0, 0.0),
                  //         padding: EdgeInsets.all(1.0),
                  //         child: CircleAvatar(
                  //           radius: 30.0,
                  //           backgroundColor: Colors.transparent,
                  //           backgroundImage:
                  //               AssetImage('assets/images/camera.png'),
                  //         ),
                  //         decoration: new BoxDecoration(
                  //           color: Colors.grey, // border color
                  //           shape: BoxShape.circle,
                  //         ),
                  //       ),
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //           Text(
                  //             "Hello,",
                  //             style: TextStyle(
                  //                 fontSize: 13, color: Colors.black38),
                  //           ),
                  //           Row(
                  //             children: <Widget>[
                  //               Text(
                  //                 userData != null
                  //                     ? '${userData['firstName']}'
                  //                     : '',
                  //                 style: TextStyle(fontSize: 17),
                  //               ),
                  //               SizedBox(width: 3),
                  //               Text(
                  //                 userData != null
                  //                     ? '${userData['lastName']}'
                  //                     : '',
                  //                 style: TextStyle(fontSize: 17),
                  //               ),
                  //             ],
                  //           ),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //     margin: EdgeInsets.only(top: 20),
                  //     height: 2,
                  //     child: Divider()),
                  Expanded(
                    child: Container(
                      child: ListView(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              if (_isLoggedIn) {
                                Navigator.push(context,
                                    SlideLeftRoute(page: ProfileViewPage()));
                              } else {
                                Navigator.push(context,
                                    SlideLeftRoute(page: LogInPage("2")));
                              }
                            },
                            child: Container(
                              child: ListTile(
                                title: Container(
                                    child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.account_circle,
                                      color: Colors.black54,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 8),
                                      child: Text(
                                        FlutterI18n.translate(context, "Profile"),
                                        style: TextStyle(color: Colors.black54),
                                      ),
                                    ),
                                  ],
                                )),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),
                          ),
                          Divider(height: 0),
                          GestureDetector(
                            onTap: () {
                              if (_isLoggedIn) {
                                Navigator.push(context,
                                    SlideLeftRoute(page: OrderHistory()));
                              } else {
                                Navigator.push(context,
                                    SlideLeftRoute(page: LogInPage("2")));
                              }
                            },
                            child: ListTile(
                              title: Container(
                                  child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.bookmark_border,
                                    color: Colors.black54,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text(
                                      FlutterI18n.translate(context, "Orders"),
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                ],
                              )),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          ),

                          Divider(
                            height: 0,
                          ),

                          GestureDetector(
                            onTap: () {
                              if (_isLoggedIn) {
                                Navigator.push(context,
                                    SlideLeftRoute(page: PreorderPage()));
                              } else {
                                Navigator.push(context,
                                    SlideLeftRoute(page: LogInPage("2")));
                              }
                            },
                            child: ListTile(
                              title: Container(
                                  child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.bookmark_border,
                                    color: Colors.black54,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text(
                                       FlutterI18n.translate(context, "Pre_orders"),
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                ],
                              )),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          ),

                          Divider(
                            height: 0,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (_isLoggedIn) {
                                Navigator.push(context,
                                    SlideLeftRoute(page: AddressPage()));
                              } else {
                                Navigator.push(context,
                                    SlideLeftRoute(page: LogInPage("2")));
                              }
                            },
                            child: ListTile(
                              title: Container(
                                  child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.location_on,
                                    color: Colors.black54,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text(
                                      FlutterI18n.translate(context, "Delivery_Address"),
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                ],
                              )),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          ),
                           Divider(
                            height: 0,
                          ),
                           GestureDetector(
                            onTap: () {
                              //if (_isLoggedIn) {
                                Navigator.push(context,
                                    SlideLeftRoute(page: LanguagePage()));
                              // } else {
                              //   Navigator.push(context,
                              //       SlideLeftRoute(page: LogInPage("2")));
                              //}
                            },
                            child: ListTile(
                              title: Container(
                                  child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.language,
                                    color: Colors.black54,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 8),
                                    child: Text(
                                      FlutterI18n.translate(context, "Language"),
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  ),
                                ],
                              )),
                              trailing: Icon(Icons.chevron_right),
                            ),
                          ),

                         
                          _isLoggedIn
                              ? GestureDetector(
                                  onTap: () {
                                    _logout();
                                  },
                                  child: ListTile(
                                    title: Center(
                                        child: Container(
                                      margin: EdgeInsets.only(
                                          left: 40, right: 40, top: 50),
                                      child: SliderButton(
                                        action: () {
                                          _logout();
                                        },
                                        label: Text(
                                          FlutterI18n.translate(context, "Slide_left_to_logout"),
                                          style: TextStyle(
                                              color: Color(0xff4a4a4a),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 17),
                                        ),
                                        icon: Padding(
                                          padding: const EdgeInsets.all(13.0),
                                          child: Icon(
                                            Icons.touch_app,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    )),
                                    //trailing: Icon(Icons.chevron_right),
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        SlideLeftRoute(page: LogInPage("2")));
                                  },
                                  child: ListTile(
                                    title: Container(
                                        child: Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.input,
                                          color: Colors.black54,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 8),
                                          child: Text(
                                            FlutterI18n.translate(context, "Login_Sign_Up"),
                                            style: TextStyle(
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    )),
                                    trailing: Icon(Icons.chevron_right),
                                  ),
                                ),

                          ///////////////// logout Button  Start///////////////
                          // Center(
                          //     child: Container(
                          //   margin:
                          //       EdgeInsets.only(left: 40, right: 40, top: 50),
                          //   child: SliderButton(
                          //     action: () {
                          //       _logout();
                          //     },
                          //     label: Text(
                          //       "Slide left to logout",
                          //       style: TextStyle(
                          //           color: Color(0xff4a4a4a),
                          //           fontWeight: FontWeight.w500,
                          //           fontSize: 17),
                          //     ),
                          //     icon: Padding(
                          //       padding: const EdgeInsets.all(13.0),
                          //       child: Icon(
                          //         Icons.touch_app,
                          //         color: Colors.white,
                          //       ),
                          //     ),
                          //   ),
                          // ))
                        ],
                      ),
                    ),
                  )
                ],
              )),
        ));
  }

  Future _logout() async {
    Navigator.of(context).pop();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    localStorage.remove('user');
     store.dispatch(UnseenNotificationAction(0));
     store.dispatch(SeenNotificationAction(0));
    _showToast();
    Navigator.push(context, SlideLeftRoute(page: Navigation(0)));
  }

  _showToast() {
    Fluttertoast.showToast(
        msg: FlutterI18n.translate(context, "You_are_logged_out")+"!" ,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: appTealColor.withOpacity(0.9),
        textColor: Colors.white,
        fontSize: 13.0);
  }
}
