import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/BottomNav/BottomNav.dart';
import 'package:ecommerce_bokkor_dev/Form/LoginForm/LogInPage.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:pin_code_text_field/pin_code_text_field.dart';

class ConfirmRegistration extends StatefulWidget {

  final email;
  ConfirmRegistration(this.email);

  @override
  _ConfirmRegistrationState createState() => _ConfirmRegistrationState();
}

class _ConfirmRegistrationState extends State<ConfirmRegistration> {
  TextEditingController pinController = TextEditingController();
  bool _isResend = false;
  bool hasError = false;
  bool _isLoading = false;
  String errorMessage;
  String mailSucess="";
  
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: FlutterI18n.translate(context, "Close"),
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    _scaffoldKey.currentState..showSnackBar(snackBar);
  }
 Future<bool> _onWillPop() async {
      Navigator.push(context, SlideLeftRoute(page: Navigation(0)));
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
       onWillPop: _onWillPop,
      child: Scaffold(
        key: _scaffoldKey,
        //   backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  // bottomNavIndex = 2;
                   Navigator.push(context, SlideLeftRoute(page: Navigation(0)));
                 // Navigator.of(context).pop();
                },
              );
            },
          ),
          title: Text(
           FlutterI18n.translate(context, "Verify_Your_Account"),
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          backgroundColor: appTealColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            // color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                /////////////// Top Part Start ////////////////

                Container(
                  //  color: Colors.red,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2 - 20,
                  padding: EdgeInsets.only(
                    left: 25,
                    right: 25,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(top: 30),
                              child: Text(
                                FlutterI18n.translate(context, "Verification_code_has_been_sent_to_your_phone"),
                                    
                                // overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: appTealColor,
                                    fontFamily: "SourceSansPro",
                                    fontSize: 18,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /////////////// Top part End ////////////////

                      Container(
                        //color: Colors.red,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            ///////////////// Pin Textfield  Start///////////////
                            Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Column(
                                  children: <Widget>[
                                    PinCodeTextField(
                                      autofocus: true,
                                      controller: pinController,
                                      hideCharacter: false,
                                      highlight: true,
                                      highlightColor:
                                         appTealColor.withOpacity(0.3),
                                      defaultBorderColor:
                                          appTealColor.withOpacity(0.3),
                                      hasTextBorderColor: appTealColor,
                                      maxLength: 4,
                                      hasError: hasError,

                                      //maskCharacter: "*",
                                      pinBoxHeight:
                                          MediaQuery.of(context).size.width /
                                              6,
                                      pinBoxWidth:
                                          MediaQuery.of(context).size.width /
                                              6,

                                      // onTextChanged: (text) {
                                      //   setState(() {
                                      //     hasError = false;
                                      //   });
                                      // },
                                      // onDone: (text){
                                      //   print("DONE $text");
                                      // },

                                      // pinCodeTextFieldLayoutType: PinCodeTextFieldLayoutType.AUTO_ADJUST_WIDTH,
                                      wrapAlignment: WrapAlignment.center,
                                      pinBoxDecoration:
                                          ProvidedPinBoxDecoration
                                              .defaultPinBoxDecoration,
                                      pinTextStyle: TextStyle(
                                          fontSize: 30.0,
                                          color: appTealColor),
                                      pinTextAnimatedSwitcherTransition:
                                          ProvidedPinBoxTextAnimation
                                              .scalingTransition,
                                      pinTextAnimatedSwitcherDuration:
                                          Duration(milliseconds: 300),
                                    ),
                                  ],
                                )),
                            ///////////////// Pin Textfield  End///////////////
                          ],
                        ),
                      ),
                      /////////////// Button Section Start ////////////////
      //////////////   code by email 
                  SizedBox(height: 8),
                            Container(
                                alignment: Alignment.topLeft,
                                child: RichText(
                                  text: TextSpan(
                                      text:  FlutterI18n.translate(context, "I_didnt_get_any_sms")+"  ",
                                      style: TextStyle(
                                          color: Colors.grey[700], fontSize: 16),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: _isResend?FlutterI18n.translate(context, "Sending")+"...":FlutterI18n.translate(context, "Resend_code_by_email"),
                                            style: TextStyle(
                                                color: appTealColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                decoration:
                                                    TextDecoration.underline),
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () {
                                               _resendCode();
                                              }),
                                      ]),
                                )),

                                Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  FlutterI18n.translate(context, mailSucess),
                                      
                                      style: TextStyle(
                                          color: Colors.grey[700], fontSize: 16),
                                      ),
                                ),
                      Container(
                        //color: Colors.red,
                        margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                        child: Column(
                          children: <Widget>[
                            /////////////// Submit Button Start ////////////////
                            Container(
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  color: appTealColor,
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: FlatButton(
                                  onPressed: () {
                                    _isLoading ? null : _submitButton();
                                  },

                                  child: Container(
                                    //width: 150,
                                    //color: Colors.grey,
                                    child: Text(
                                      _isLoading
                                          ? 
                                                FlutterI18n.translate(context, "Submitting") +
                                              "...."
                                          :FlutterI18n.translate(context, "Submit"),
                                      textDirection: TextDirection.ltr,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0,
                                        decoration: TextDecoration.none,
                                        fontFamily: 'SourceSansPro',
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  color: Colors.transparent,
                                  //elevation: 4.0,
                                  //splashColor: Colors.blueGrey,
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(10.0)),
                                )),

                            /////////////// SUBMIT Button End ////////////////
                          ],
                        ),
                      ),

                      /////////////// Button Section End ////////////////
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitButton() async {
    if (pinController.text.isEmpty) {
      return _showMsg(
        FlutterI18n.translate(context, "Code_is_empty"),
      );
    }
    setState(() {
      _isLoading = true;
    });

    var data = {
     
      'code': pinController.text,
    };

    var res = await CallApi().postData(data, '/app/accountactivation');
    print(data);
    var body = json.decode(res.body);
    print(body);
    print(res.statusCode);

   if (body['success'] == true) {
      _registrationConfirm();
     

    } else {
      _showMsg(
        FlutterI18n.translate(context, "Code_doesnt_match"),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }


    void _resendCode() async {
  
    setState(() {
      _isResend = true;
     
    });

    var data = {
     
      'email':widget.email
    };

    var res = await CallApi().postData(data, '/app/sendMailToUser');
    print(data);
    var body = json.decode(res.body);
    print(body);
    print(res.statusCode);

   if (res.statusCode==200) {

     setState(() {
       mailSucess = "Sent_code_to_your_e-mail";
     });
     // _registrationConfirm();
     

    } else {
      _showMsg(
        FlutterI18n.translate(context, "Something_went_wrong"),
      );
    }

    setState(() {
      _isResend = false;
    });
  }

  void _registrationConfirm() {
    showDialog(
      context: context,
      //   barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            contentPadding: EdgeInsets.all(5),
            title:  Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(),
                    child: Image.asset(
                      "assets/images/ok.png",
                      height: 80,
                      width: 80,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20),
                    child: Text(
              FlutterI18n.translate(context, "Your_Account_has_been_Activated"),
              textAlign: TextAlign.start,
              style: TextStyle(
                    color: appTealColor,
                    fontFamily: "grapheinpro-black",
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
            ),
                  ),
                  Container(
                     margin: EdgeInsets.only(bottom: 15, right: 10,top: 20),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                       // color: Theme.of(context).primaryColorDark,
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      //  border: Border.all(color:Theme.of(context).primaryColorLight)
                      ),
                       width: MediaQuery.of(context).size.width/3,
                      height: 30,
                     
                      child: OutlineButton(
                         // color: Theme.of(context).primaryColorLight,
                          child: new Text(
                           FlutterI18n.translate(context, "Ok"),
                            style: TextStyle(color: appTealColor),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                            // Navigator.of(context).pop();
                            Navigator.push(
                                context, SlideLeftRoute(page: LogInPage(0)));
                          },
                          borderSide: BorderSide(
                              color: appTealColor, width: 0.5),
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)))),
                ],
              ),
            actions: <Widget>[
             
            ]);
      },
    );
  }
}
