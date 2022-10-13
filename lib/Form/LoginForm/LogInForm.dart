import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/ConfirmRegistration/ConfirmRegistration.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/CheckOut/CheckOut.dart';
import 'package:ecommerce_bokkor_dev/Screen/ForgetPassword/ForgetPassword.dart';
import 'package:ecommerce_bokkor_dev/Screen/ForgetPassword/VerifyEmail.dart';
import 'package:ecommerce_bokkor_dev/Screen/HomePage/HomePage.dart';
import 'package:ecommerce_bokkor_dev/Screen/ProductDetails/ProductDetails.dart';
import 'package:ecommerce_bokkor_dev/Screen/Registration/Registration.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInForm extends StatefulWidget {
  final page;
  LogInForm(this.page);

  @override
  _LogInFormState createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {


    Future<bool> _inactive(String email) async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            
            content: new Text(FlutterI18n.translate(context, "your_account_is_inactive_please_active_your_account")),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                        Navigator.push(context, SlideLeftRoute(page: ConfirmRegistration(email)));
                },
                child: new Text(FlutterI18n.translate(context, "OK")),
              ),
            
            ],
          ),
        )) ??
        false;
  }
  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(FlutterI18n.translate(context,msg)),
      action: SnackBarAction(
        label: FlutterI18n.translate(context, 'Close'),
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  bool _isLoading = false;

  TextEditingController logInEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  String loginEmail = "", loginPass = "";
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging(); 
  var appToken;

@override
  void initState() {
    _firebaseMessaging.getToken().then((token) async {

      print("Notification app token");
      print(token);
        appToken = token;
      
   });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/introbg2.png"),
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.5), BlendMode.dstATop),
        ),
      ),
      child: AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0))),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        content: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                color: Colors.transparent,
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.only(top: 35),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(top: 25),
                            child: Text(
                              FlutterI18n.translate(context, "Sign_in_to_your_account"),
                              
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontFamily: 'Oswald',
                                  fontWeight: FontWeight.w400),
                            )),

                        ////////////////////////   log in phone start //////////////////

                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.white,
                              border:
                                  Border.all(width: 0.2, color: Colors.grey)),
                          child: TextFormField(
                            autofocus: false,
                            controller: logInEmailController,
                            cursorColor: Colors.grey,
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              icon: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: const Icon(
                                  Icons.phone,
                                  color: Colors.black38,
                                  size: 17,
                                ),
                              ),
                              hintText: FlutterI18n.translate(context,'Phone'),
                              hintStyle: TextStyle(fontSize: 14),
                              //labelText: 'Enter E-mail',
                              contentPadding:
                                  EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 5.0),
                              border: InputBorder.none,
                            ),
                            validator: (val) =>
                                val.isEmpty ? 'Field is empty' : null,
                            onSaved: (val) => loginEmail = val,
                            //validator: _validateEmail,
                          ),
                        ),

                        ////////////////////////   log in phone end //////////////////

                        ////////////////////////   log in password start //////////////////

                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(top: 5),
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              color: Colors.white,
                              border:
                                  Border.all(width: 0.2, color: Colors.grey)),
                          child: TextFormField(
                            cursorColor: Colors.grey,
                            autofocus: false,
                            obscureText: true,
                            controller: loginPasswordController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(fontSize: 14),
                            decoration: InputDecoration(
                              icon: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: const Icon(
                                  Icons.lock,
                                  color: Colors.black38,
                                  size: 17,
                                ),
                              ),
                              hintText: FlutterI18n.translate(context, 'Password'),
                              hintStyle: TextStyle(fontSize: 14),

                              //labelText: 'Enter E-mail',
                              contentPadding:
                                  EdgeInsets.fromLTRB(0.0, 5.0, 20.0, 5.0),
                              border: InputBorder.none,
                            ),
                            validator: (val) =>
                                val.isEmpty ? 'Field is empty' : null,
                            onSaved: (val) => loginPass = val,
                            //validator: _validateEmail,
                          ),
                        ),

                        ////////////////////////   log in password end //////////////////

                        ////////////////////////   log in Button start //////////////////

                        Container(
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    _isLoading ? null : _logInButton();
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(10),
                                      margin: EdgeInsets.only(
                                          left: 0,
                                          right: 0,
                                          top: 10,
                                          bottom: 0),
                                      decoration: BoxDecoration(
                                          color: appTealColor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Text(
                                        _isLoading ? FlutterI18n.translate(context, "Please_wait")+("...") : FlutterI18n.translate(context, "Login"),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontFamily: 'BebasNeue',
                                        ),
                                        textAlign: TextAlign.center,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),

                        ////////////////////////   log in button end //////////////////

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ////////////////////////   skip login start //////////////////
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context, SlideLeftRoute(page: Navigation(0)));
                              }, 
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 15, bottom: 0),
                                  child: Text(
                                    FlutterI18n.translate(context, "Skip"),
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  )),
                            ),

                            ////////////////////////   skip login  end //////////////////

                            //////////////////////   forget password start //////////////////
                            GestureDetector(
                              onTap: () {
                                Navigator.push(context,
                                    SlideLeftRoute(page: ForgetPassword()));
                              },
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: 0, top: 15, bottom: 0),
                                  child: Text(
                                    FlutterI18n.translate(context, "Forget_password")+"?",
                                    style: TextStyle(
                                        color: appTealColor,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  )),
                            ),
                          ],
                        ),

                        ////////////////////////   forget password end //////////////////
                      ],
                    ),
                  ),

                  ////////////////////////   Dont have account start //////////////////
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5)),
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            child: Text(
                              FlutterI18n.translate(context, "Dont_have_an_account")+"?",
                          
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 13,
                              fontWeight: FontWeight.w300),
                        )),

                        ///////////   Sign up from log in start //////////////
                        GestureDetector(
                          onTap: () {
                            //Navigator.of(context).pop();

                            Navigator.push(
                                context, SlideLeftRoute(page: Registration()));
                          },
                          child: Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Text(
                                FlutterI18n.translate(context, "Sign_up"),
                                
                                style: TextStyle(
                                    color: appTealColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400),
                              )),
                        ),

                        ///////////   Sign up from log in end //////////////
                      ],
                    ),
                  ),

                  ////////////////////////   Dont have account end //////////////////
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _logInButton() async {
    if (logInEmailController.text.isEmpty) {
      return _showMsg("Phone_is_empty");
    } else if (loginPasswordController.text.isEmpty) {
      return _showMsg("Password_is_empty");
    }

    setState(() {
      _isLoading = true;
    });

    var data = {
      'mobile': logInEmailController.text,
      'password': loginPasswordController.text,
      'app_token':appToken
    };
     print("data");
    print(data);
    var res = await CallApi().postData(data, '/app/buyerLogin');
    var body = json.decode(res.body);
    print(body);
    print("body");
    if (body['success'] == true) {
      var data1 = {
        "firstName": body['user']['firstName'],
        "lastName": body['user']['lastName'],
        "email": body['user']['email'],
        "mobile": body['user']['mobile'],
        "house": body['user']['house'],
        "street": body['user']['house'],
        "road": body['user']['house'],
        "block": body['user']['house'],
        "area": body['user']['area'],
        "city": body['user']['city'],
        "state": body['user']['city'],
        "country": body['user']['country'],
        "profilepic": body['user']['profilepic'],
      };

      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
      localStorage.setString('pass', loginPasswordController.text);
      localStorage.setString('loggedin-user', json.encode(data1));

      if (widget.page == "3") {
        Navigator.push(context, SlideLeftRoute(page: Navigation(1)));
      } else if (widget.page == "4") {
        Navigator.push(context, SlideLeftRoute(page: Navigation(2)));
      } else {
        Navigator.push(context, SlideLeftRoute(page: Navigation(0)));
      }
    } 
  else if(body['isVarified']==0){
    
     
  
  if(body['user']['userType']=="Buyer"){
     _inactive(body['user']['email']);

  }
  else{
    _showMsg("You_are_not_buyer");
  }
   
    }
     else if(body['isVarified']==2){
    
  
     _showMsg("You_are_not_buyer");
  
   
    }
    else {
      _showMsg("Invalid_Phone_or_Password");
    }

    setState(() {
      _isLoading = false;
    });
  }
}
