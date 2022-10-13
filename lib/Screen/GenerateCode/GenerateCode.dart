import 'dart:convert';

import 'package:ecommerce_bokkor_dev/Api/registerApi.dart';
import 'package:ecommerce_bokkor_dev/NavigationAnimation/routeTransition/routeAnimation.dart';
import 'package:ecommerce_bokkor_dev/Screen/GenerateCodeWithEmail/GenerateCodeWithEmail.dart';
import 'package:ecommerce_bokkor_dev/Screen/ResetPassword/ResetPassword.dart';
import 'package:ecommerce_bokkor_dev/main.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';

import 'package:pin_code_text_field/pin_code_text_field.dart';

class GenerateCode extends StatefulWidget {

  final type;
  GenerateCode(this.type);

  @override
  _GenerateCodeState createState() => _GenerateCodeState();
}

class _GenerateCodeState extends State<GenerateCode> {
  TextEditingController pinController = TextEditingController();
 bool _isResend = false;
  String mailSucess="";
  bool hasError = false;
  bool _isLoading = false;
  String code = "";
  String errorMessage;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  _showMsg(msg) {
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
    _scaffoldKey.currentState..showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                // Navigator.push(context, SlideLeftRoute(page: Navigation()));
                Navigator.of(context).pop();
              },
            );
          },
        ),
        title: Text(
          FlutterI18n.translate(context, "verification_code"),
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
                              FlutterI18n.translate(context, "verification_code_has_been_sent_to_your_phone"),
                              
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
                      alignment: Alignment.center,
                      //color: Colors.red,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                         crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ///////////////// Pin Textfield  Start///////////////
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              child: PinCodeTextField(
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
                                    MediaQuery.of(context).size.width / 6,
                                pinBoxWidth:
                                    MediaQuery.of(context).size.width / 6,

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
                                pinBoxDecoration: ProvidedPinBoxDecoration
                                    .defaultPinBoxDecoration,
                                pinTextStyle: TextStyle(
                                    fontSize: 30.0, color: appTealColor),
                                pinTextAnimatedSwitcherTransition:
                                    ProvidedPinBoxTextAnimation
                                        .scalingTransition,
                                pinTextAnimatedSwitcherDuration:
                                    Duration(milliseconds: 300),
                              )),

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
                                          text: FlutterI18n.translate(context, "Resend_code_by_email"),
                                          style: TextStyle(
                                              color: appTealColor,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              decoration:
                                                  TextDecoration.underline),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {

                                                Navigator.push(
          context, SlideLeftRoute(page: GenerateCodeWithEmail()));
                                        
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
                        ],
                      ),
                    ),
                    /////////////// Button Section Start ////////////////

                    Container(
                      //color: Colors.red,
                      margin: EdgeInsets.only(left: 20, right: 20, top: 40),
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
                                    _isLoading ? FlutterI18n.translate(context, "Submitting")+"..." : FlutterI18n.translate(context, "Submit"),
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
    );
  }



  void _submitButton() async {
    if (pinController.text.isEmpty) {
      return _showMsg(
        "Code_is_empty",
      );
    }
    setState(() {
      _isLoading = true;
    });

    var data = {
      'code': pinController.text,
    };

    var res;
    if(widget.type=="mobile"){

    res = await CallApi().postData(data, '/app/matchPasswordCode');
    }
    else if(widget.type=="email"){
       res = await CallApi().postData(data, '/app/matchPasswordToken');
    }
    print(data);
   
    var body = json.decode(res.body);
    print(body);
    //print(body['user']['mobile']);

    // if (res.statusCode == 200) {
    if (body['success'] == true) {

    //     setState(() {
    //    mailSucess = "Sent_code_to_your_e-mail";
    //  });

       if(widget.type=="mobile"){

    Navigator.push(
          context, SlideLeftRoute(page: ResetPassword(body['user']['mobile'],"mobile",body['user']['code'])));
    }
    else if(widget.type=="email"){
       Navigator.push(
          context, SlideLeftRoute(page: ResetPassword(body['user']['email'],"email",body['user']['code'])));
    }
     
    } else {
      _showMsg("Code_doesnt_match");
    }

    setState(() {
      _isLoading = false;
    });
  }
}
