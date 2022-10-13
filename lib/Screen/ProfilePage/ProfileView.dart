import 'dart:convert';

import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/ChangePassword/ChangePassword.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProfilePage/ProfileEdit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../BottomNav/BottomNav.dart';
import '../../NavigationAnimation/routeTransition/routeAnimation.dart';
import '../../NavigationAnimation/routeTransition/routeAnimation.dart';
import '../../main.dart';

class ProfileViewPage extends StatefulWidget {
  @override
  _ProfileViewPageState createState() => new _ProfileViewPageState();
}

class _ProfileViewPageState extends State<ProfileViewPage> {
  String result = '';
  var userData;

  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  Container profileInfo(Icon icon, String label, String data) {
    return Container(
        padding: EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            icon,
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Text(
                     FlutterI18n.translate(context, label),
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 8, top: 3),
                      child: Text(
                        data,
                        style: TextStyle(color: Colors.black38, fontSize: 15),
                      ))
                ],
              ),
            ),
          ],
        ));
  }

  Container socialInfo(String img, String label, String data) {
    return Container(
        padding: EdgeInsets.all(15),
        child: Row(
          children: <Widget>[
            Container(
              height: 20,
              width: 20,
              child: Image.asset(img),
            ),
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 8),
                    child: Text(
                      label,
                      style: TextStyle(
                          color: Colors.black87, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 8, top: 3),
                      child: Text(
                        data,
                        style: TextStyle(color: Colors.black38, fontSize: 15),
                      ))
                ],
              ),
            ),
          ],
        ));
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('loggedin-user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
  }

  Future<bool> _onWillPop() async {
    Navigator.push(context, SlideLeftRoute(page: Navigation(3)));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: new Scaffold(
        //backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: appTealColor,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context, SlideLeftRoute(page: Navigation(3)));
            },
            child: Container(
                padding: EdgeInsets.all(15),
                child: Icon(Icons.arrow_back, color: Colors.white)),
          ),
          title: Center(
            child: Container(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(FlutterI18n.translate(context, "My_Profile"),
                        style: TextStyle(fontSize: 20, color: Colors.white)),
                    GestureDetector(
                        onTap: () {
                          editProfile();
                        },
                        child: Container(
                            padding: EdgeInsets.all(5),
                            child: Icon(Icons.edit)))
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context, SlideLeftRoute(page: ChangePassword()));
                },
                child: Container(
                    padding: EdgeInsets.only(right: 13),
                    child: Icon(Icons.vpn_key)))
          ],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: new Container(
                padding: EdgeInsets.all(0.0),
                child: Column(
                  children: <Widget>[
                    ///////////  profile name and picture start ///////////

                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          ///////////  profile  picture start ///////////
                          Container(
                            padding: EdgeInsets.all(1.0),
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundColor: Colors.transparent,
                              backgroundImage: userData == null
                                  ? AssetImage('assets/images/camera.png')
                                  : userData['profilepic'] == null ||
                                          userData['profilepic'] == ''
                                      ? AssetImage('assets/images/camera.png')
                                      : NetworkImage(
                                          '${userData['profilepic']}'),
                            ),
                            decoration: new BoxDecoration(
                              color: Colors.grey, // border color
                              shape: BoxShape.circle,
                            ),
                          ),

                          ///////////  profile picture end ///////////
                          SizedBox(
                            width: 10,
                          ),

                          ///////////  profile name start ///////////
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                FlutterI18n.translate(context, "Hello")+",",
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black38),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    userData != null
                                        ? '${userData['firstName']}'
                                        : '',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  SizedBox(width: 2.0),
                                  Text(
                                    userData != null
                                        ? '${userData['lastName']}'
                                        : '',
                                    style: TextStyle(fontSize: 17),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          ///////////  profile name end ///////////
                        ],
                      ),
                    ),

                    ///////////  profile name and picture end ///////////

                    Container(
                        margin: EdgeInsets.only(top: 20),
                        height: 2,
                        child: Divider()),

                    ///////////  Email ///////////

                    profileInfo(
                        Icon(
                          Icons.mail,
                          color: Colors.grey,
                        ),
                        "Email",
                        userData != null
                            ? userData['email'] != null
                                ? '${userData['email']}'
                                : 'Email'
                            : 'Email'),

                    // Container(
                    //     margin: EdgeInsets.only(top: 0),
                    //     height: 2,
                    //     child: Divider()),

                    // ///////////  Mobile ///////////

                    // profileInfo(
                    //     Icon(
                    //       Icons.mail,
                    //       color: Colors.grey,
                    //     ),
                    //     "Mobile",
                    //     userData != null
                    //         ? userData['mobile'] != null
                    //             ? '${userData['mobile']}'
                    //             : 'Mobile number'
                    //         : 'Mobile number'),

                    // Container(
                    //     margin: EdgeInsets.only(top: 0),
                    //     height: 2,
                    //     child: Divider()),

                    ///////////  Area  ///////////

                    // profileInfo(
                    //     Icon(
                    //       Icons.location_on,
                    //       color: Colors.grey,
                    //     ),
                    //     "Area",
                    //     userData != null
                    //         ? userData['area'] != null
                    //             ? '${userData['area']}'
                    //             : 'Area Name'
                    //         : 'Area Name'),

                    // Container(
                    //     margin: EdgeInsets.only(top: 0),
                    //     height: 2,
                    //     child: Divider()),

                    // ///////////  House ///////////

                    // profileInfo(
                    //     Icon(
                    //       Icons.mail,
                    //       color: Colors.grey,
                    //     ),
                    //     "House",
                    //     userData != null
                    //         ? userData['house'] != null
                    //             ? '${userData['house']}'
                    //             : 'House Name'
                    //         : 'House Name'),

                    // Container(
                    //     margin: EdgeInsets.only(top: 0),
                    //     height: 2,
                    //     child: Divider()),

                    // ///////////  Street ///////////

                    // profileInfo(
                    //     Icon(
                    //       Icons.mail,
                    //       color: Colors.grey,
                    //     ),
                    //     "Street",
                    //     userData != null
                    //         ? userData['street'] != null
                    //             ? '${userData['street']}'
                    //             : 'Street Name'
                    //         : 'street Name'),

                    // Container(
                    //     margin: EdgeInsets.only(top: 0),
                    //     height: 2,
                    //     child: Divider()),

                    // ///////////  Road  ///////////

                    // profileInfo(
                    //     Icon(
                    //       Icons.location_on,
                    //       color: Colors.grey,
                    //     ),
                    //     "Road",
                    //     userData != null
                    //         ? userData['road'] != null
                    //             ? '${userData['road']}'
                    //             : 'Road Name'
                    //         : 'Road Name'),

                    // Container(
                    //     margin: EdgeInsets.only(top: 0),
                    //     height: 2,
                    //     child: Divider()),

                    // ///////////  Block  ///////////

                    // profileInfo(
                    //     Icon(
                    //       Icons.location_on,
                    //       color: Colors.grey,
                    //     ),
                    //     "Block",
                    //     userData != null
                    //         ? userData['block'] != null
                    //             ? '${userData['block']}'
                    //             : 'Block Name'
                    //         : 'Block Name'),

                    // Container(
                    //     margin: EdgeInsets.only(top: 0),
                    //     height: 2,
                    //     child: Divider()),

                    // ///////////  City  ///////////

                    // profileInfo(
                    //     Icon(
                    //       Icons.location_on,
                    //       color: Colors.grey,
                    //     ),
                    //     "City",
                    //     userData != null
                    //         ? userData['city'] != null
                    //             ? '${userData['city']}'
                    //             : 'City Name'
                    //         : 'City Name'),

                    // Container(
                    //     margin: EdgeInsets.only(top: 0),
                    //     height: 2,
                    //     child: Divider()),

                    // ///////////  State   ///////////

                    // profileInfo(
                    //     Icon(
                    //       Icons.home,
                    //       color: Colors.grey,
                    //     ),
                    //     "State",
                    //     userData != null
                    //         ? userData['state'] != null
                    //             ? '${userData['state']}'
                    //             : 'State Name'
                    //         : 'State Name'),

                    // Container(
                    //     margin: EdgeInsets.only(top: 0),
                    //     height: 2,
                    //     child: Divider()),

                    // ///////////  Country   ///////////

                    // profileInfo(
                    //     Icon(
                    //       Icons.home,
                    //       color: Colors.grey,
                    //     ),
                    //     "Country",
                    //     userData != null
                    //         ? userData['country'] != null
                    //             ? '${userData['country']}'
                    //             : 'Country Name'
                    //         : 'Country Name'),

                    // Container(
                    //     margin: EdgeInsets.only(top: 0),
                    //     height: 2,
                    //     child: Divider()),
                  ],
                )),
          ),
        ),
      ),
    );
  }

  void editProfile() {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return new ProfileEditDialog();
        },
        fullscreenDialog: true));
  }
}
